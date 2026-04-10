import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../shopping/presentation/providers/shopping_provider.dart';

final _foodDayPreviewProvider = FutureProvider.family
    .autoDispose<List<_FoodDayEntry>, DateTime>((ref, date) async {
      final isar = ref.read(inventoryIsarProvider);
      final start = DateTime(date.year, date.month, date.day);
      final end = start
          .add(const Duration(days: 1))
          .subtract(const Duration(microseconds: 1));
      final logs = await isar.registrosDiarios
          .filter()
          .fechaBetween(start, end)
          .findAll();
      logs.sort((a, b) {
        final byMeal = a.tipoComida.index.compareTo(b.tipoComida.index);
        if (byMeal != 0) {
          return byMeal;
        }
        return a.fecha.compareTo(b.fecha);
      });

      final entries = <_FoodDayEntry>[];
      for (final log in logs) {
        final name = await _resolveFoodLogName(isar, log);
        entries.add(
          _FoodDayEntry(
            mealType: log.tipoComida,
            name: name,
            grams: log.cantidadConsumidaGramos,
          ),
        );
      }
      return entries;
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
    final today = _normalizeDay(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));
    final todayAsync = ref.watch(_foodDayPreviewProvider(today));
    final tomorrowAsync = ref.watch(_foodDayPreviewProvider(tomorrow));
    final range = ref.watch(shoppingRangeProvider);
    final shoppingAsync = ref.watch(
      shoppingListProvider(range.start, range.end),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionTitle(title: 'Diario y planificación corta'),
        const SizedBox(height: 8),
        _DayPlanCard(
          title: 'Hoy',
          subtitle: 'Lo que toca comer y lo que puedes ajustar ahora',
          emptyText: 'No hay comida planificada para hoy.',
          icon: Icons.wb_sunny_outlined,
          entriesAsync: todayAsync,
          onTap: () => context.push('/meals'),
        ),
        _DayPlanCard(
          title: 'Mañana',
          subtitle: 'Anticipa huecos y cambia lo que no te encaje.',
          emptyText: 'No hay comida planificada para mañana.',
          icon: Icons.event_outlined,
          entriesAsync: tomorrowAsync,
          onTap: () => context.push('/calendar'),
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

class _DayPlanCard extends StatelessWidget {
  const _DayPlanCard({
    required this.title,
    required this.subtitle,
    required this.emptyText,
    required this.icon,
    required this.entriesAsync,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String emptyText;
  final IconData icon;
  final AsyncValue<List<_FoodDayEntry>> entriesAsync;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                  Icon(icon),
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
              entriesAsync.when(
                loading: () => const LinearProgressIndicator(minHeight: 2),
                error: (_, _) => const Text('No se pudo cargar este plan.'),
                data: (entries) {
                  if (entries.isEmpty) {
                    return Text(emptyText);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entries
                        .take(4)
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '${_mealTypeLabel(entry.mealType)} · ${entry.name} · ${entry.grams.toStringAsFixed(0)} g',
                            ),
                          ),
                        )
                        .toList(growable: false),
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

Future<String> _resolveFoodLogName(Isar isar, RegistroDiario log) async {
  if (log.esReceta) {
    final recipe = await isar.recetas.get(log.itemId);
    return recipe?.nombre ?? 'Receta desconocida';
  }

  final food = await isar.alimentos.get(log.itemId);
  return food?.nombre ?? 'Alimento desconocido';
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