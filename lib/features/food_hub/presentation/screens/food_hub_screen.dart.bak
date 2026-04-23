import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../shopping/presentation/providers/shopping_provider.dart';

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
          if (byMeal != 0) {
            return byMeal;
          }
          return a.fecha.compareTo(b.fecha);
        });

        final entries = <_FoodDayEntry>[];
        var kcal = 0.0;
        var proteins = 0.0;
        var carbs = 0.0;
        var fats = 0.0;

        for (final log in logs) {
          final name = await _resolveFoodLogName(isar, log);
          final macros = await _resolveFoodLogMacros(isar, log);
          kcal += macros.kcal;
          proteins += macros.proteins;
          carbs += macros.carbs;
          fats += macros.fats;

          entries.add(
            _FoodDayEntry(
              mealType: log.tipoComida,
              name: name,
              grams: log.cantidadConsumidaGramos,
            ),
          );
        }

        summaries.add(
          _FoodWeekDaySummary(
            date: dayStart,
            entries: entries,
            macros: _FoodMacroTotals(
              kcal: kcal,
              proteins: proteins,
              carbs: carbs,
              fats: fats,
            ),
          ),
        );
      }

      return summaries;
    });

/// Hub principal del área de comida.
class FoodHubScreen extends StatefulWidget {
  /// Crea una [FoodHubScreen].
  const FoodHubScreen({super.key});

  @override
  State<FoodHubScreen> createState() => _FoodHubScreenState();
}

class _FoodHubScreenState extends State<FoodHubScreen>
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comida'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Resumen'),
            Tab(text: 'Diario'),
            Tab(text: 'Biblioteca'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Perfil y ajustes',
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _FoodSummaryTab(),
          _FoodDailyTab(),
          _FoodLibraryTab(),
        ],
      ),
    );
  }
}

class _FoodSummaryTab extends ConsumerWidget {
  const _FoodSummaryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(shoppingRangeProvider);
    final shoppingAsync = ref.watch(
      shoppingListProvider(range.start, range.end),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HubIntroCard(
          title: 'Comida organizada por semana y por día',
          subtitle:
              'Aquí verás el menú, la lista de la compra activa y el acceso rápido a lo que toca hoy.',
          icon: Icons.restaurant_menu_outlined,
        ),
        const SizedBox(height: 12),
        const _SectionTitle(title: 'Vista general'),
        const SizedBox(height: 8),
        const _PrimaryFoodActions(),
        const SizedBox(height: 16),
        const _SectionTitle(title: 'Semana activa'),
        const SizedBox(height: 8),
        _ShoppingPreviewCard(
          range: range,
          shoppingAsync: shoppingAsync,
        ),
        const _HubLinkCard(
          title: 'Calendario semanal',
          subtitle: 'Revisa el menú que vas a comer y detecta huecos en la semana',
          icon: Icons.calendar_month_outlined,
          route: '/calendar',
        ),
      ],
    );
  }
}

class _FoodDailyTab extends ConsumerWidget {
  const _FoodDailyTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(shoppingRangeProvider);
    final weekAsync = ref.watch(_foodWeekPreviewProvider(range.start));
    final shoppingAsync = ref.watch(
      shoppingListProvider(range.start, range.end),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle(title: 'Diario y semana completa'),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Semana activa: ${_formatShortDate(range.start)} - ${_formatShortDate(range.end)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Aquí ves cada día de la semana con sus comidas ya asignadas y la suma de macros del día.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        weekAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No se pudo cargar la planificación semanal.'),
            ),
          ),
          data: (days) => Column(
            children: [
              for (final day in days)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _WeekDayPlanCard(
                    summary: day,
                    onTap: () => context.push(
                      '/calendar?date=${day.date.toIso8601String().split('T').first}',
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _ShoppingPreviewCard(
          range: range,
          shoppingAsync: shoppingAsync,
          title: 'Lista pendiente',
          subtitle: 'Lo que queda por comprar en la semana activa.',
        ),
        const SizedBox(height: 16),
        const _SectionTitle(title: 'Crear o ampliar lista'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _FoodActionPanel(
                title: 'Desde recetas',
                subtitle: 'Usa recetas guardadas',
                icon: Icons.menu_book_outlined,
                onTap: () => context.push('/recipes'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FoodActionPanel(
                title: 'Desde alimentos',
                subtitle: 'Añade de tu biblioteca',
                icon: Icons.food_bank_outlined,
                onTap: () => context.push('/inventory'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _HubLinkCard(
          title: 'Añadir alimento nuevo',
          subtitle: 'Alta manual o por código de barras y luego lo sumas a la lista activa',
          icon: Icons.qr_code_scanner_outlined,
          route: '/inventory/new-food',
        ),
      ],
    );
  }
}

class _FoodLibraryTab extends StatelessWidget {
  const _FoodLibraryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SectionTitle(title: 'Biblioteca'),
        SizedBox(height: 8),
        _HubLinkCard(
          title: 'Alimentos',
          subtitle: 'Tu biblioteca de alimentos, edición y altas nuevas',
          icon: Icons.food_bank_outlined,
          route: '/inventory',
        ),
        _HubLinkCard(
          title: 'Recetas',
          subtitle: 'Catálogo y edición de recetas guardadas',
          icon: Icons.menu_book_outlined,
          route: '/recipes',
        ),
        _HubLinkCard(
          title: 'Importar JSON',
          subtitle: 'Carga alimentos y recetas desde archivos de apoyo',
          icon: Icons.file_upload_outlined,
          route: '/import-json',
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _ShoppingPreviewCard extends StatelessWidget {
  const _ShoppingPreviewCard({
    required this.range,
    required this.shoppingAsync,
    this.title = 'Lista de la compra activa',
    this.subtitle = 'Revisa lo pendiente de esta semana y añade compras manuales si hace falta.',
  });

  final DateTimeRange range;
  final AsyncValue<List<ShoppingListItem>> shoppingAsync;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/shopping-list'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.shopping_basket_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${_formatShortDate(range.start)} - ${_formatShortDate(range.end)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              shoppingAsync.when(
                loading: () => const LinearProgressIndicator(minHeight: 2),
                error: (_, _) => const Text('No se pudo cargar la lista activa.'),
                data: (items) {
                  if (items.isEmpty) {
                    return const Text('No tienes nada pendiente en la lista activa.');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${items.length} pendientes'),
                      const SizedBox(height: 6),
                      ...items.take(3).map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${item.name} · ${item.missingGrams.toStringAsFixed(0)} g',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryFoodActions extends StatelessWidget {
  const _PrimaryFoodActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FoodActionPanel(
            title: 'Compra activa',
            subtitle: 'Semana actual',
            icon: Icons.shopping_basket_outlined,
            onTap: () => context.push('/shopping-list'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _FoodActionPanel(
            title: 'Hoy y mañana',
            subtitle: 'Ver plan',
            icon: Icons.calendar_month_outlined,
            onTap: () => context.push('/calendar'),
          ),
        ),
      ],
    );
  }
}

class _FoodActionPanel extends StatelessWidget {
  const _FoodActionPanel({
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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _HubIntroCard extends StatelessWidget {
  const _HubIntroCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HubLinkCard extends StatelessWidget {
  const _HubLinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }
}

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

class _WeekDayPlanCard extends StatelessWidget {
  const _WeekDayPlanCard({required this.summary, required this.onTap});

  final _FoodWeekDaySummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isToday = _normalizeDay(summary.date) == _normalizeDay(DateTime.now());

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(isToday ? Icons.wb_sunny_outlined : Icons.event_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_weekdayLabel(summary.date)}${isToday ? ' · Hoy' : ''}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatLongDate(summary.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MacroPill(
                    label: '${summary.macros.kcal.toStringAsFixed(0)} kcal',
                  ),
                  _MacroPill(
                    label: 'P ${summary.macros.proteins.toStringAsFixed(0)} g',
                  ),
                  _MacroPill(
                    label: 'C ${summary.macros.carbs.toStringAsFixed(0)} g',
                  ),
                  _MacroPill(
                    label: 'G ${summary.macros.fats.toStringAsFixed(0)} g',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (summary.entries.isEmpty)
                const Text('No hay comida planificada para este día.')
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: summary.entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${_mealTypeLabel(entry.mealType)} · ${entry.name} · ${entry.grams.toStringAsFixed(0)} g',
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.edit_calendar_outlined),
                  label: const Text('Editar día'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MacroPill extends StatelessWidget {
  const _MacroPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

Future<String> _resolveFoodLogName(Isar isar, RegistroDiario log) async {
  if (log.esReceta) {
    final recipe = await isar.recetas.get(log.itemId);
    return recipe?.nombre ?? 'Receta desconocida';
  }

  final food = await isar.alimentos.get(log.itemId);
  return food?.nombre ?? 'Alimento desconocido';
}

Future<_FoodMacroTotals> _resolveFoodLogMacros(Isar isar, RegistroDiario log) async {
  if (log.esReceta) {
    final recipe = await isar.recetas.get(log.itemId);
    if (recipe == null) {
      return const _FoodMacroTotals();
    }

    await recipe.ingredientes.load();
    if (recipe.ingredientes.isEmpty) {
      return const _FoodMacroTotals();
    }

    var totalWeight = 0.0;
    var kcal = 0.0;
    var proteins = 0.0;
    var carbs = 0.0;
    var fats = 0.0;

    for (final ingredient in recipe.ingredientes) {
      await ingredient.alimento.load();
      final food = ingredient.alimento.value;
      if (food == null) {
        continue;
      }

      final factor = food.porcionBaseGramos <= 0
          ? 0.0
          : ingredient.cantidadGramos / food.porcionBaseGramos;
      kcal += food.kcal * factor;
      proteins += food.proteinas * factor;
      carbs += food.carbohidratos * factor;
      fats += food.grasas * factor;
      totalWeight += ingredient.cantidadGramos;
    }

    final consumedFactor = totalWeight <= 0
        ? 0.0
        : log.cantidadConsumidaGramos / totalWeight;
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

DateTime _normalizeDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String _mealTypeLabel(TipoComida mealType) {
  return switch (mealType) {
    TipoComida.desayuno => 'Desayuno',
    TipoComida.comida => 'Comida',
    TipoComida.cena => 'Cena',
    TipoComida.snack => 'Snack',
  };
}

String _formatShortDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
}

String _formatLongDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String _weekdayLabel(DateTime date) {
  return switch (date.weekday) {
    DateTime.monday => 'Lunes',
    DateTime.tuesday => 'Martes',
    DateTime.wednesday => 'Miércoles',
    DateTime.thursday => 'Jueves',
    DateTime.friday => 'Viernes',
    DateTime.saturday => 'Sábado',
    DateTime.sunday => 'Domingo',
    _ => 'Día',
  };
}