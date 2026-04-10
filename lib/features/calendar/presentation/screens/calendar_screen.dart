import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../recipes/presentation/providers/recipe_provider.dart';
import '../providers/calendar_provider.dart';

/// Gestor del planificador semanal de ingestas.
class CalendarScreen extends ConsumerStatefulWidget {
  /// Crea un [CalendarScreen].
  const CalendarScreen({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  bool _showMonthView = false;
  DateTime? _lastAppliedInitialDate;

  @override
  void initState() {
    super.initState();
    _applyInitialDate();
  }

  @override
  void didUpdateWidget(covariant CalendarScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyInitialDate();
  }

  void _applyInitialDate() {
    final initialDate = widget.initialDate;
    if (initialDate == null) {
      return;
    }

    final normalized = DateTime(initialDate.year, initialDate.month, initialDate.day);
    if (_lastAppliedInitialDate == normalized) {
      return;
    }

    _lastAppliedInitialDate = normalized;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(selectedDateProvider.notifier).changeDate(normalized);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final logsAsync = ref.watch(dailyLogsProvider);
    final trainingAsync = ref.watch(trainingDaysProvider);
    final mealDaysAsync = ref.watch(mealCompletionDaysProvider);
    final weekStart = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );
    final trainingDays = trainingAsync.asData?.value ?? <int>{};
    final mealDays = mealDaysAsync.asData?.value ?? <int>{};
    final selectedDayKey =
        selectedDate.year * 10000 + selectedDate.month * 100 + selectedDate.day;
    final isSelectedDayTrained = trainingDays.contains(selectedDayKey);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        actions: [
          IconButton(
            onPressed: () => setState(() => _showMonthView = !_showMonthView),
            icon: Icon(
              _showMonthView
                  ? Icons.view_week_outlined
                  : Icons.calendar_view_month_outlined,
            ),
            tooltip: _showMonthView ? 'Ver semana' : 'Ver mes completo',
          ),
          IconButton(
            onPressed: () async {
              await ref
                  .read(trainingDaysProvider.notifier)
                  .toggle(selectedDate);
            },
            icon: Icon(
              isSelectedDayTrained
                  ? Icons.fitness_center
                  : Icons.fitness_center_outlined,
            ),
            tooltip: isSelectedDayTrained
                ? 'Quitar entreno del día'
                : 'Marcar día entrenado',
          ),
          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Vaciar día completo'),
                  content: const Text(
                    'Se eliminarán todos los registros del día seleccionado. ¿Continuar?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('Vaciar'),
                    ),
                  ],
                ),
              );

              if (confirm != true || !context.mounted) {
                return;
              }

              await ref.read(dailyLogsProvider.notifier).clearSelectedDay();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Día vaciado correctamente')),
                );
              }
            },
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Vaciar día',
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showMonthView)
            _MonthCalendar(
              selectedDate: selectedDate,
              trainingDays: trainingDays,
              mealDays: mealDays,
              onSelectDate: (date) =>
                  ref.read(selectedDateProvider.notifier).changeDate(date),
            )
          else
            Row(
              children: [
                IconButton(
                  onPressed: () => ref
                      .read(selectedDateProvider.notifier)
                      .changeDate(weekStart.subtract(const Duration(days: 7))),
                  icon: const Icon(Icons.chevron_left_rounded),
                  tooltip: 'Semana anterior',
                ),
                Expanded(
                  child: _WeekStrip(
                    weekStart: weekStart,
                    selectedDate: selectedDate,
                    trainingDays: trainingDays,
                    mealDays: mealDays,
                    onSelectDate: (date) => ref
                        .read(selectedDateProvider.notifier)
                        .changeDate(date),
                  ),
                ),
                IconButton(
                  onPressed: () => ref
                      .read(selectedDateProvider.notifier)
                      .changeDate(weekStart.add(const Duration(days: 7))),
                  icon: const Icon(Icons.chevron_right_rounded),
                  tooltip: 'Semana siguiente',
                ),
              ],
            ),
          if (isSelectedDayTrained)
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('✅ Día marcado como entrenado'),
            ),
          if (!isSelectedDayTrained)
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('ℹ️ Marca el día como entrenado desde el icono 💪'),
            ),
          Expanded(
            child: logsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Error al cargar registros')),
              data: (logs) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _MealBlockCard(
                      title: 'Desayuno',
                      tipo: TipoComida.desayuno,
                      logs: logs,
                      onAdd: () => _openAddEntryModal(
                        context: context,
                        ref: ref,
                        selectedDate: selectedDate,
                        tipo: TipoComida.desayuno,
                      ),
                    ),
                    _MealBlockCard(
                      title: 'Comida',
                      tipo: TipoComida.comida,
                      logs: logs,
                      onAdd: () => _openAddEntryModal(
                        context: context,
                        ref: ref,
                        selectedDate: selectedDate,
                        tipo: TipoComida.comida,
                      ),
                    ),
                    _MealBlockCard(
                      title: 'Cena',
                      tipo: TipoComida.cena,
                      logs: logs,
                      onAdd: () => _openAddEntryModal(
                        context: context,
                        ref: ref,
                        selectedDate: selectedDate,
                        tipo: TipoComida.cena,
                      ),
                    ),
                    _MealBlockCard(
                      title: 'Snacks',
                      tipo: TipoComida.snack,
                      logs: logs,
                      onAdd: () => _openAddEntryModal(
                        context: context,
                        ref: ref,
                        selectedDate: selectedDate,
                        tipo: TipoComida.snack,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAddEntryModal({
    required BuildContext context,
    required WidgetRef ref,
    required DateTime selectedDate,
    required TipoComida tipo,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AddEntryModal(selectedDate: selectedDate, tipo: tipo),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({
    required this.weekStart,
    required this.selectedDate,
    required this.trainingDays,
    required this.mealDays,
    required this.onSelectDate,
  });

  final DateTime weekStart;
  final DateTime selectedDate;
  final Set<int> trainingDays;
  final Set<int> mealDays;
  final ValueChanged<DateTime> onSelectDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = weekStart.add(Duration(days: index));
          final isSelected = _isSameDay(date, selectedDate);
          final theme = Theme.of(context);
          final key = date.year * 10000 + date.month * 100 + date.day;
          final isTrained = trainingDays.contains(key);
          final hasMeals = mealDays.contains(key);
          final status = _statusForDay(
            hasMeals: hasMeals,
            isTrained: isTrained,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => onSelectDate(date),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                width: 74,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primaryContainer
                      : _dayBgColor(status),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : _dayBorderColor(status),
                    width: status == _DayStatus.both && !isSelected ? 1.8 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _weekdayShort(date.weekday),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${date.day}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    required this.selectedDate,
    required this.trainingDays,
    required this.mealDays,
    required this.onSelectDate,
  });

  final DateTime selectedDate;
  final Set<int> trainingDays;
  final Set<int> mealDays;
  final ValueChanged<DateTime> onSelectDate;

  @override
  Widget build(BuildContext context) {
    final monthStart = DateTime(selectedDate.year, selectedDate.month, 1);
    final firstGridDay = monthStart.subtract(
      Duration(days: monthStart.weekday - 1),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => onSelectDate(
                  DateTime(selectedDate.year, selectedDate.month - 1, 1),
                ),
                icon: const Icon(Icons.chevron_left_rounded),
                tooltip: 'Mes anterior',
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: Text(
                  '${_monthLabel(selectedDate.month)} ${selectedDate.year}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: () => onSelectDate(
                  DateTime(selectedDate.year, selectedDate.month + 1, 1),
                ),
                icon: const Icon(Icons.chevron_right_rounded),
                tooltip: 'Mes siguiente',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 4),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final date = firstGridDay.add(Duration(days: index));
              final inMonth = date.month == selectedDate.month;
              final isSelected = _isSameDay(date, selectedDate);
              final key = date.year * 10000 + date.month * 100 + date.day;
              final isTrained = trainingDays.contains(key);
              final hasMeals = mealDays.contains(key);
              final status = _statusForDay(
                hasMeals: hasMeals,
                isTrained: isTrained,
              );
              final theme = Theme.of(context);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primaryContainer
                      : inMonth
                      ? _dayBgColor(status)
                      : _dayBgColor(
                          status,
                        ).withAlpha((_dayBgColor(status).a * 128).round()),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : _dayBorderColor(status),
                    width: status == _DayStatus.both && !isSelected ? 1.5 : 0.8,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onSelectDate(date),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 12,
                        color: !inMonth
                            ? theme.colorScheme.onSurface.withValues(
                                alpha: 0.35,
                              )
                            : null,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MealBlockCard extends StatelessWidget {
  const _MealBlockCard({
    required this.title,
    required this.tipo,
    required this.logs,
    required this.onAdd,
  });

  final String title;
  final TipoComida tipo;
  final List<RegistroDiario> logs;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final filtered = logs.where((e) => e.tipoComida == tipo).toList();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                TextButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir'),
                ),
              ],
            ),
            if (filtered.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Sin registros'),
              )
            else
              ...filtered.map((log) => _LogEntryTile(log: log)),
          ],
        ),
      ),
    );
  }
}

class _LogEntryTile extends ConsumerWidget {
  const _LogEntryTile({required this.log});

  final RegistroDiario log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.read(inventoryIsarProvider);
    return FutureBuilder<_LogDetail>(
      future: _resolveLogDetail(isar, log),
      builder: (context, snapshot) {
        final detail = snapshot.data;
        final title = detail?.name ?? 'Cargando...';
        final subtitle = detail == null
            ? 'Calculando macros...'
            : '${log.cantidadConsumidaGramos.toStringAsFixed(1)} g · '
                  'Kcal ${detail.kcal.toStringAsFixed(0)} · '
                  'P ${detail.proteinas.toStringAsFixed(1)}g · '
                  'C ${detail.carbohidratos.toStringAsFixed(1)}g · '
                  'G ${detail.grasas.toStringAsFixed(1)}g';

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Eliminar registro'),
                  content: const Text('¿Quieres eliminar este registro?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );

              if (confirm != true) {
                return;
              }

              await ref.read(dailyLogsProvider.notifier).deleteLogEntry(log.id);
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar registro',
          ),
        );
      },
    );
  }
}

class _AddEntryModal extends ConsumerWidget {
  const _AddEntryModal({required this.selectedDate, required this.tipo});

  final DateTime selectedDate;
  final TipoComida tipo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryProvider);
    final recipesAsync = ref.watch(recipeListProvider);

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Alimentos'),
                  Tab(text: 'Recetas'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    inventoryAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, _) => const Center(
                        child: Text('Error al cargar alimentos'),
                      ),
                      data: (foods) => ListView.builder(
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return ListTile(
                            title: Text(food.nombre),
                            subtitle: Text(
                              'Kcal ${food.kcal.toStringAsFixed(0)} · '
                              'P ${food.proteinas.toStringAsFixed(1)}g · '
                              'C ${food.carbohidratos.toStringAsFixed(1)}g · '
                              'G ${food.grasas.toStringAsFixed(1)}g',
                            ),
                            onTap: () async {
                              final qty = await _askQuantity(
                                context,
                                title: 'Cantidad (gramos)',
                              );
                              if (qty == null) {
                                return;
                              }

                              await ref
                                  .read(dailyLogsProvider.notifier)
                                  .addLogEntry(
                                    selectedDate,
                                    tipo,
                                    food.id,
                                    false,
                                    qty,
                                  );

                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    recipesAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, _) =>
                          const Center(child: Text('Error al cargar recetas')),
                      data: (recipes) => ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return ListTile(
                            title: Text(recipe.nombre),
                            subtitle: Text(
                              'Raciones: ${recipe.numeroRaciones}',
                            ),
                            onTap: () async {
                              final portions = await _askQuantity(
                                context,
                                title: 'Nº raciones',
                              );
                              if (portions == null) {
                                return;
                              }

                              await recipe.ingredientes.load();
                              var totalWeight = 0.0;
                              for (final ing in recipe.ingredientes) {
                                totalWeight += ing.cantidadGramos;
                              }

                              final gramsPerPortion = recipe.numeroRaciones <= 0
                                  ? 0.0
                                  : totalWeight / recipe.numeroRaciones;
                              final consumedGrams = gramsPerPortion * portions;

                              await ref
                                  .read(dailyLogsProvider.notifier)
                                  .addLogEntry(
                                    selectedDate,
                                    tipo,
                                    recipe.id,
                                    true,
                                    consumedGrams,
                                  );

                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<double?> _askQuantity(
  BuildContext context, {
  required String title,
}) async {
  final controller = TextEditingController();
  final result = await showDialog<double>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Ej. 100'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final parsed = double.tryParse(
              controller.text.trim().replaceAll(',', '.'),
            );
            if (parsed == null || parsed <= 0) {
              return;
            }
            Navigator.of(context).pop(parsed);
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
  return result;
}

Future<_LogDetail> _resolveLogDetail(Isar isar, RegistroDiario log) async {
  if (!log.esReceta) {
    final food = await isar.alimentos.get(log.itemId);
    if (food == null || food.porcionBaseGramos <= 0) {
      return const _LogDetail(name: 'Alimento desconocido');
    }

    final factor = log.cantidadConsumidaGramos / food.porcionBaseGramos;
    return _LogDetail(
      name: food.nombre,
      kcal: food.kcal * factor,
      proteinas: food.proteinas * factor,
      carbohidratos: food.carbohidratos * factor,
      grasas: food.grasas * factor,
    );
  }

  final recipe = await isar.recetas.get(log.itemId);
  if (recipe == null) {
    return const _LogDetail(name: 'Receta desconocida');
  }

  await recipe.ingredientes.load();

  var recipeKcal = 0.0;
  var recipeProteinas = 0.0;
  var recipeCarbohidratos = 0.0;
  var recipeGrasas = 0.0;
  var totalWeight = 0.0;

  for (final ing in recipe.ingredientes) {
    await ing.alimento.load();
    final food = ing.alimento.value;
    if (food == null || food.porcionBaseGramos <= 0) {
      continue;
    }

    final factor = ing.cantidadGramos / food.porcionBaseGramos;
    recipeKcal += food.kcal * factor;
    recipeProteinas += food.proteinas * factor;
    recipeCarbohidratos += food.carbohidratos * factor;
    recipeGrasas += food.grasas * factor;
    totalWeight += ing.cantidadGramos;
  }

  final consumptionFactor = totalWeight <= 0
      ? 0.0
      : log.cantidadConsumidaGramos / totalWeight;

  return _LogDetail(
    name: recipe.nombre,
    kcal: recipeKcal * consumptionFactor,
    proteinas: recipeProteinas * consumptionFactor,
    carbohidratos: recipeCarbohidratos * consumptionFactor,
    grasas: recipeGrasas * consumptionFactor,
  );
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _weekdayShort(int weekday) {
  return switch (weekday) {
    DateTime.monday => 'Lun',
    DateTime.tuesday => 'Mar',
    DateTime.wednesday => 'Mié',
    DateTime.thursday => 'Jue',
    DateTime.friday => 'Vie',
    DateTime.saturday => 'Sáb',
    DateTime.sunday => 'Dom',
    _ => 'Día',
  };
}

String _monthLabel(int month) {
  return switch (month) {
    1 => 'Enero',
    2 => 'Febrero',
    3 => 'Marzo',
    4 => 'Abril',
    5 => 'Mayo',
    6 => 'Junio',
    7 => 'Julio',
    8 => 'Agosto',
    9 => 'Septiembre',
    10 => 'Octubre',
    11 => 'Noviembre',
    12 => 'Diciembre',
    _ => 'Mes',
  };
}

class _LogDetail {
  const _LogDetail({
    required this.name,
    this.kcal = 0,
    this.proteinas = 0,
    this.carbohidratos = 0,
    this.grasas = 0,
  });

  final String name;
  final double kcal;
  final double proteinas;
  final double carbohidratos;
  final double grasas;
}

enum _DayStatus { none, mealOnly, exerciseOnly, both }

_DayStatus _statusForDay({required bool hasMeals, required bool isTrained}) {
  if (hasMeals && isTrained) {
    return _DayStatus.both;
  }
  if (hasMeals) {
    return _DayStatus.mealOnly;
  }
  if (isTrained) {
    return _DayStatus.exerciseOnly;
  }
  return _DayStatus.none;
}

/// Fondo del día según su estado de actividad.
Color _dayBgColor(_DayStatus status) => switch (status) {
  _DayStatus.none => Colors.transparent,
  _DayStatus.exerciseOnly => const Color(0xFF42A5F5).withAlpha(55),
  _DayStatus.mealOnly => const Color(0xFF66BB6A).withAlpha(80),
  _DayStatus.both => const Color(0xFFFFB300).withAlpha(105),
};

/// Borde del día según su estado de actividad.
Color _dayBorderColor(_DayStatus status) => switch (status) {
  _DayStatus.none => const Color(0xFF9E9E9E).withAlpha(40),
  _DayStatus.exerciseOnly => const Color(0xFF42A5F5).withAlpha(140),
  _DayStatus.mealOnly => const Color(0xFF43A047).withAlpha(170),
  _DayStatus.both => const Color(0xFFFFB300).withAlpha(220),
};
