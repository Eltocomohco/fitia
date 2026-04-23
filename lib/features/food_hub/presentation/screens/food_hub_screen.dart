import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../shopping/presentation/providers/shopping_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Provider interno: resumen semanal de comidas
// ─────────────────────────────────────────────────────────────────────────────

final _foodWeekPreviewProvider = FutureProvider.family
    .autoDispose<List<_FoodWeekDaySummary>, DateTime>((ref, startDate) async {
  final isar = ref.read(inventoryIsarProvider);
  final normalizedStart = _normalizeDay(startDate);
  final summaries = <_FoodWeekDaySummary>[];

  for (var offset = 0; offset < 7; offset++) {
    final date = normalizedStart.add(Duration(days: offset));
    final dayStart = _normalizeDay(date);
    final dayEnd = dayStart
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final logs = await isar.registrosDiarios
        .filter()
        .fechaBetween(dayStart, dayEnd)
        .findAll();
    logs.sort((a, b) {
      final byMeal = a.tipoComida.index.compareTo(b.tipoComida.index);
      return byMeal != 0 ? byMeal : a.fecha.compareTo(b.fecha);
    });

    var kcal = 0.0;
    var proteins = 0.0;
    var carbs = 0.0;
    var fats = 0.0;
    final entries = <_FoodDayEntry>[];

    for (final log in logs) {
      final name = await _resolveFoodLogName(isar, log);
      final macros = await _resolveFoodLogMacros(isar, log);
      kcal += macros.kcal;
      proteins += macros.proteins;
      carbs += macros.carbs;
      fats += macros.fats;
      entries.add(_FoodDayEntry(
        mealType: log.tipoComida,
        name: name,
        grams: log.cantidadConsumidaGramos,
      ));
    }

    summaries.add(_FoodWeekDaySummary(
      date: dayStart,
      entries: entries,
      macros: _FoodMacroTotals(
          kcal: kcal, proteins: proteins, carbs: carbs, fats: fats),
    ));
  }

  return summaries;
});

// ─────────────────────────────────────────────────────────────────────────────
// Pantalla principal de Comida
// ─────────────────────────────────────────────────────────────────────────────

/// Hub rediseñado del área de comida con tabs Hoy / Semana / Compra.
class FoodHubScreen extends ConsumerStatefulWidget {
  const FoodHubScreen({super.key});

  @override
  ConsumerState<FoodHubScreen> createState() => _FoodHubScreenState();
}

class _FoodHubScreenState extends ConsumerState<FoodHubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final range = ref.watch(shoppingRangeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comida'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Hoy'),
            Tab(text: 'Semana'),
            Tab(text: 'Compra'),
          ],
          indicatorColor: const Color(0xFFE5C043),
          labelColor: theme.colorScheme.onSurface,
          unselectedLabelColor:
              theme.colorScheme.onSurface.withValues(alpha: 0.45),
          labelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Perfil',
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TodayTab(range: range),
          _WeekTab(range: range),
          _ShoppingTab(range: range),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Hoy
// ─────────────────────────────────────────────────────────────────────────────

class _TodayTab extends ConsumerWidget {
  const _TodayTab({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekAsync = ref.watch(_foodWeekPreviewProvider(range.start));

    return weekAsync.when(
      loading: () => const _TabLoadingIndicator(),
      error: (_, _) =>
          const _InlineError(message: 'No se pudo cargar el plan de hoy.'),
      data: (days) {
        final today = days.firstWhere(
          (d) => _normalizeDay(d.date) == _normalizeDay(DateTime.now()),
          orElse: () => _FoodWeekDaySummary(
            date: DateTime.now(),
            entries: [],
            macros: const _FoodMacroTotals(),
          ),
        );

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Resumen de macros del día
            if (today.macros.kcal > 0) ...[
              _TodayMacroBar(macros: today.macros),
              const SizedBox(height: 14),
            ],

            // Comidas del día agrupadas por tipo
            ..._buildMealGroups(context, today.entries),

            // Acciones de biblioteca
            const SizedBox(height: 8),
            _SectionLabel(label: 'Añadir al diario'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _ActionTile(
                    label: 'Desde alimentos',
                    icon: Icons.food_bank_outlined,
                    onTap: () => context.push('/inventory'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionTile(
                    label: 'Desde recetas',
                    icon: Icons.menu_book_outlined,
                    onTap: () => context.push('/recipes'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionTile(
                    label: 'Escanear',
                    icon: Icons.qr_code_scanner_outlined,
                    onTap: () => context.push('/inventory/new-food'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildMealGroups(
      BuildContext context, List<_FoodDayEntry> entries) {
    if (entries.isEmpty) {
      return [
        _EmptyDayCard(
          onAddFood: () => context.push('/inventory'),
          onAddRecipe: () => context.push('/recipes'),
        ),
      ];
    }

    final groups = <TipoComida, List<_FoodDayEntry>>{};
    for (final e in entries) {
      groups.putIfAbsent(e.mealType, () => []).add(e);
    }

    final result = <Widget>[];
    for (final mealType in TipoComida.values) {
      final group = groups[mealType];
      if (group == null) {
        // Slot vacío
        result.add(_EmptyMealSlot(
          mealType: mealType,
          onAdd: () => context.push('/inventory'),
        ));
      } else {
        result.add(_MealGroupCard(mealType: mealType, entries: group));
      }
      result.add(const SizedBox(height: 10));
    }
    return result;
  }
}

class _TodayMacroBar extends StatelessWidget {
  const _TodayMacroBar({required this.macros});
  final _FoodMacroTotals macros;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE5C043).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5C043).withValues(alpha: 0.4),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MacroPill(
              label: 'kcal',
              value: macros.kcal.toStringAsFixed(0),
              color: const Color(0xFFE5C043)),
          _MacroPill(
              label: 'Prot',
              value: '${macros.proteins.toStringAsFixed(0)}g',
              color: const Color(0xFF7F77DD)),
          _MacroPill(
              label: 'Carb',
              value: '${macros.carbs.toStringAsFixed(0)}g',
              color: const Color(0xFF5DCAA5)),
          _MacroPill(
              label: 'Gras',
              value: '${macros.fats.toStringAsFixed(0)}g',
              color: const Color(0xFFD85A30)),
        ],
      ),
    );
  }
}

class _MacroPill extends StatelessWidget {
  const _MacroPill(
      {required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _MealGroupCard extends StatelessWidget {
  const _MealGroupCard(
      {required this.mealType, required this.entries});
  final TipoComida mealType;
  final List<_FoodDayEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Row(
              children: [
                Icon(_mealIcon(mealType), size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55)),
                const SizedBox(width: 6),
                Text(
                  _mealTypeLabel(mealType),
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 14, endIndent: 14),
          for (final entry in entries)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(entry.name,
                        style: theme.textTheme.bodyMedium),
                  ),
                  Text(
                    '${entry.grams.toStringAsFixed(0)} g',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.1, end: 0);
  }
}

class _EmptyMealSlot extends StatelessWidget {
  const _EmptyMealSlot({required this.mealType, required this.onAdd});
  final TipoComida mealType;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(_mealIcon(mealType), size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            const SizedBox(width: 8),
            Text(
              _mealTypeLabel(mealType),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
              ),
            ),
            const Spacer(),
            Icon(Icons.add, size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}

class _EmptyDayCard extends StatelessWidget {
  const _EmptyDayCard({required this.onAddFood, required this.onAddRecipe});
  final VoidCallback onAddFood;
  final VoidCallback onAddRecipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(Icons.restaurant_menu_outlined,
              size: 36,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.25)),
          const SizedBox(height: 12),
          Text(
            'Hoy no tienes nada registrado',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.55),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onAddFood,
                  icon: const Icon(Icons.food_bank_outlined, size: 16),
                  label: const Text('Alimentos'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onAddRecipe,
                  icon: const Icon(Icons.menu_book_outlined, size: 16),
                  label: const Text('Recetas'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Semana
// ─────────────────────────────────────────────────────────────────────────────

class _WeekTab extends ConsumerWidget {
  const _WeekTab({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekAsync = ref.watch(_foodWeekPreviewProvider(range.start));

    return weekAsync.when(
      loading: () => const _TabLoadingIndicator(),
      error: (_, _) =>
          const _InlineError(message: 'No se pudo cargar la semana.'),
      data: (days) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Barra semanal compacta
          _WeekBar(days: days),
          const SizedBox(height: 16),

          // Cards expandibles por día
          for (final day in days) ...[
            _WeekDayCard(summary: day, onTap: () {
              context.push(
                '/calendar?date=${day.date.toIso8601String().split('T').first}',
              );
            }),
            const SizedBox(height: 8),
          ],

          // Acciones de planificación
          const SizedBox(height: 4),
          _SectionLabel(label: 'Planificar'),
          const SizedBox(height: 8),
          _LinkCard(
            title: 'Abrir planificador',
            subtitle: 'Edita el menú día a día en el calendario semanal',
            icon: Icons.edit_calendar_outlined,
            onTap: () => context.push('/calendar'),
          ),
          _LinkCard(
            title: 'Recetas guardadas',
            subtitle: 'Añade recetas a los días que tengas vacíos',
            icon: Icons.menu_book_outlined,
            onTap: () => context.push('/recipes'),
          ),
        ],
      ),
    );
  }
}

class _WeekBar extends StatelessWidget {
  const _WeekBar({required this.days});
  final List<_FoodWeekDaySummary> days;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = _normalizeDay(DateTime.now());
    const dayLetters = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

    return Row(
      children: List.generate(days.length, (i) {
        final day = days[i];
        final isToday = _normalizeDay(day.date) == today;
        final hasFood = day.entries.isNotEmpty;
        final maxKcal = days.fold<double>(
            0, (m, d) => d.macros.kcal > m ? d.macros.kcal : m);
        final barFraction =
            maxKcal > 0 ? (day.macros.kcal / maxKcal).clamp(0.0, 1.0) : 0.0;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < days.length - 1 ? 6 : 0),
            child: Column(
              children: [
                // Barra de kcal proporcional
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: isToday
                        ? const Color(0xFFE5C043)
                        : hasFood
                            ? theme.colorScheme.surface
                            : theme.colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: isToday
                        ? null
                        : Border.all(
                            color: hasFood
                                ? theme.colorScheme.onSurface
                                    .withValues(alpha: 0.12)
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.06),
                            width: 0.5,
                          ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: barFraction > 0 ? barFraction : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isToday
                              ? const Color(0x552A2000)
                              : hasFood
                                  ? const Color(0xFFE5C043)
                                      .withValues(alpha: 0.5)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dayLetters[i],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                    color: isToday
                        ? const Color(0xFFB08A00)
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _WeekDayCard extends StatelessWidget {
  const _WeekDayCard({required this.summary, required this.onTap});
  final _FoodWeekDaySummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday =
        _normalizeDay(summary.date) == _normalizeDay(DateTime.now());
    final isEmpty = summary.entries.isEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isToday
              ? const Color(0xFFE5C043).withValues(alpha: 0.08)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: isToday
              ? Border.all(
                  color: const Color(0xFFE5C043).withValues(alpha: 0.4),
                  width: 1)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Día
            SizedBox(
              width: 44,
              child: Column(
                children: [
                  Text(
                    _shortWeekdayLabel(summary.date),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isToday
                          ? const Color(0xFFB08A00)
                          : theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                    ),
                  ),
                  Text(
                    '${summary.date.day}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isToday
                          ? const Color(0xFF2A2000)
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Contenido
            Expanded(
              child: isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Sin planificar',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.35),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Chips de macros
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _MiniChip(
                                label:
                                    '${summary.macros.kcal.toStringAsFixed(0)} kcal'),
                            _MiniChip(
                                label:
                                    'P ${summary.macros.proteins.toStringAsFixed(0)}g'),
                            _MiniChip(
                                label:
                                    'C ${summary.macros.carbs.toStringAsFixed(0)}g'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Primeras entradas
                        for (final entry in summary.entries.take(3))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              '${_mealTypeLabel(entry.mealType)} · ${entry.name}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.65),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (summary.entries.length > 3)
                          Text(
                            '+${summary.entries.length - 3} más',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                      ],
                    ),
            ),
            const Icon(Icons.chevron_right, size: 18,
                color: Color(0xFFBBBBBB)),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 260.ms);
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: 0.65),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Compra
// ─────────────────────────────────────────────────────────────────────────────

class _ShoppingTab extends ConsumerWidget {
  const _ShoppingTab({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingAsync =
        ref.watch(shoppingListProvider(range.start, range.end));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Rango activo
        _WeekRangeHeader(range: range),
        const SizedBox(height: 14),

        // Lista de la compra
        shoppingAsync.when(
          loading: () => const _TabLoadingIndicator(),
          error: (_, _) =>
              const _InlineError(message: 'Error al cargar la lista.'),
          data: (items) => items.isEmpty
              ? _EmptyShoppingCard(
                  onOpenCalendar: () => context.push('/calendar'),
                )
              : _ShoppingList(items: items),
        ),

        const SizedBox(height: 14),

        // Acciones
        _SectionLabel(label: 'Gestionar lista'),
        const SizedBox(height: 8),
        _LinkCard(
          title: 'Lista completa',
          subtitle: 'Ver todos los productos, gestionar despensa y comprar',
          icon: Icons.shopping_basket_outlined,
          onTap: () => context.push('/shopping-list'),
        ),
        _LinkCard(
          title: 'Alimentos',
          subtitle: 'Añade alimentos nuevos por nombre o código de barras',
          icon: Icons.qr_code_scanner_outlined,
          onTap: () => context.push('/inventory/new-food'),
        ),
        _LinkCard(
          title: 'Biblioteca',
          subtitle: 'Tus alimentos y recetas guardadas',
          icon: Icons.food_bank_outlined,
          onTap: () => context.push('/inventory'),
        ),
      ],
    );
  }
}

class _WeekRangeHeader extends StatelessWidget {
  const _WeekRangeHeader({required this.range});
  final DateTimeRange range;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.date_range_outlined, size: 16),
        const SizedBox(width: 8),
        Text(
          'Semana ${_formatShortDate(range.start)} – ${_formatShortDate(range.end)}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}

class _ShoppingList extends StatelessWidget {
  const _ShoppingList({required this.items});
  final List<ShoppingListItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Text('${items.length} pendientes',
                    style: theme.textTheme.titleSmall),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  child: const Text('Ver todo'),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          for (var i = 0; i < items.take(6).length; i++) ...[
            _ShoppingRow(item: items[i]),
            if (i < items.take(6).length - 1)
              const Divider(height: 1, indent: 16, endIndent: 16),
          ],
          if (items.length > 6)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'y ${items.length - 6} productos más...',
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.45),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _ShoppingRow extends StatelessWidget {
  const _ShoppingRow({required this.item});
  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(item.name, style: theme.textTheme.bodyMedium),
          ),
          Text(
            '${item.missingGrams.toStringAsFixed(0)} g',
            style: theme.textTheme.bodySmall?.copyWith(
              color:
                  theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyShoppingCard extends StatelessWidget {
  const _EmptyShoppingCard({required this.onOpenCalendar});
  final VoidCallback onOpenCalendar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(Icons.shopping_basket_outlined,
              size: 36,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.25)),
          const SizedBox(height: 12),
          Text(
            'Lista vacía esta semana',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Planifica comidas en el calendario y la lista se generará automáticamente.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onOpenCalendar,
            icon: const Icon(Icons.edit_calendar_outlined, size: 16),
            label: const Text('Abrir planificador'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets compartidos
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context)
            .colorScheme
            .onSurface
            .withValues(alpha: 0.55),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile(
      {required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  const _LinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleSmall),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                        )),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 18,
                  color: Color(0xFFBBBBBB)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabLoadingIndicator extends StatelessWidget {
  const _TabLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.5),
          )),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Modelos internos
// ─────────────────────────────────────────────────────────────────────────────

class _FoodDayEntry {
  const _FoodDayEntry({
    required this.mealType,
    required this.name,
    required this.grams,
  });
  final TipoComida mealType;
  final String name;
  final double grams;
}

class _FoodWeekDaySummary {
  const _FoodWeekDaySummary({
    required this.date,
    required this.entries,
    required this.macros,
  });
  final DateTime date;
  final List<_FoodDayEntry> entries;
  final _FoodMacroTotals macros;
}

class _FoodMacroTotals {
  const _FoodMacroTotals({
    this.kcal = 0,
    this.proteins = 0,
    this.carbs = 0,
    this.fats = 0,
  });
  final double kcal;
  final double proteins;
  final double carbs;
  final double fats;
}

// ─────────────────────────────────────────────────────────────────────────────
// Utilidades
// ─────────────────────────────────────────────────────────────────────────────

Future<String> _resolveFoodLogName(Isar isar, RegistroDiario log) async {
  if (log.esReceta) {
    final recipe = await isar.recetas.get(log.itemId);
    return recipe?.nombre ?? 'Receta desconocida';
  }
  final food = await isar.alimentos.get(log.itemId);
  return food?.nombre ?? 'Alimento desconocido';
}

Future<_FoodMacroTotals> _resolveFoodLogMacros(
    Isar isar, RegistroDiario log) async {
  if (log.esReceta) {
    final recipe = await isar.recetas.get(log.itemId);
    if (recipe == null) return const _FoodMacroTotals();
    await recipe.ingredientes.load();
    if (recipe.ingredientes.isEmpty) return const _FoodMacroTotals();

    var totalWeight = 0.0;
    var kcal = 0.0;
    var proteins = 0.0;
    var carbs = 0.0;
    var fats = 0.0;

    for (final ingredient in recipe.ingredientes) {
      await ingredient.alimento.load();
      final food = ingredient.alimento.value;
      if (food == null) continue;
      final factor = food.porcionBaseGramos <= 0
          ? 0.0
          : ingredient.cantidadGramos / food.porcionBaseGramos;
      kcal += food.kcal * factor;
      proteins += food.proteinas * factor;
      carbs += food.carbohidratos * factor;
      fats += food.grasas * factor;
      totalWeight += ingredient.cantidadGramos;
    }

    final consumedFactor =
        totalWeight <= 0 ? 0.0 : log.cantidadConsumidaGramos / totalWeight;
    return _FoodMacroTotals(
      kcal: kcal * consumedFactor,
      proteins: proteins * consumedFactor,
      carbs: carbs * consumedFactor,
      fats: fats * consumedFactor,
    );
  }

  final food = await isar.alimentos.get(log.itemId);
  if (food == null || food.porcionBaseGramos <= 0) {
    return const _FoodMacroTotals();
  }
  final factor = log.cantidadConsumidaGramos / food.porcionBaseGramos;
  return _FoodMacroTotals(
    kcal: food.kcal * factor,
    proteins: food.proteinas * factor,
    carbs: food.carbohidratos * factor,
    fats: food.grasas * factor,
  );
}

DateTime _normalizeDay(DateTime date) =>
    DateTime(date.year, date.month, date.day);

String _formatShortDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';

String _mealTypeLabel(TipoComida mealType) => switch (mealType) {
      TipoComida.desayuno => 'Desayuno',
      TipoComida.comida => 'Comida',
      TipoComida.cena => 'Cena',
      TipoComida.snack => 'Snack',
    };

IconData _mealIcon(TipoComida mealType) => switch (mealType) {
      TipoComida.desayuno => Icons.wb_sunny_outlined,
      TipoComida.comida => Icons.restaurant_outlined,
      TipoComida.cena => Icons.nightlight_outlined,
      TipoComida.snack => Icons.apple_outlined,
    };

String _shortWeekdayLabel(DateTime date) => switch (date.weekday) {
      DateTime.monday => 'Lun',
      DateTime.tuesday => 'Mar',
      DateTime.wednesday => 'Mié',
      DateTime.thursday => 'Jue',
      DateTime.friday => 'Vie',
      DateTime.saturday => 'Sáb',
      DateTime.sunday => 'Dom',
      _ => '---',
    };
