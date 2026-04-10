import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/registro_ejercicio_sesion.dart';
import '../providers/active_workout_provider.dart';
import '../providers/workout_routine_provider.dart';

/// Pantalla de detalle de una rutina con progreso reciente por ejercicio.
class WorkoutRoutineDetailScreen extends ConsumerWidget {
  /// Crea un [WorkoutRoutineDetailScreen].
  const WorkoutRoutineDetailScreen({
    required this.routineId,
    super.key,
  });

  /// Identificador de la rutina a mostrar.
  final int routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(workoutRoutineDetailProvider(routineId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de rutina'),
        actions: [
          PopupMenuButton<_RoutineAction>(
            onSelected: (action) async {
              switch (action) {
                case _RoutineAction.edit:
                  context.push('/workouts/routine/$routineId/edit');
                case _RoutineAction.duplicate:
                  final newId = await ref
                      .read(workoutRoutineControllerProvider.notifier)
                      .duplicateRoutine(routineId);
                  if (!context.mounted || newId == null) {
                    return;
                  }
                  context.push('/workouts/routine/$newId');
                case _RoutineAction.delete:
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Eliminar rutina'),
                      content: const Text(
                        'Se eliminará la plantilla y sus objetivos. El historial de sesiones seguirá guardado.',
                      ),
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
                  if (confirmed != true) {
                    return;
                  }
                  await ref
                      .read(workoutRoutineControllerProvider.notifier)
                      .deleteRoutine(routineId);
                  if (!context.mounted) {
                    return;
                  }
                  context.go('/workouts');
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _RoutineAction.edit,
                child: Text('Editar rutina'),
              ),
              PopupMenuItem(
                value: _RoutineAction.duplicate,
                child: Text('Duplicar rutina'),
              ),
              PopupMenuItem(
                value: _RoutineAction.delete,
                child: Text('Eliminar rutina'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No se pudo cargar la rutina')),
        data: (detail) {
          if (detail == null) {
            return const Center(child: Text('La rutina ya no existe.'));
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.routine.nombre,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${detail.exercises.length} ejercicios · ${detail.completedSessions} sesiones completadas',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        detail.lastCompletedAt == null
                            ? 'Aún no has completado esta rutina.'
                            : 'Última vez: ${_formatDate(detail.lastCompletedAt!)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Progreso por ejercicio',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...detail.exercises.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            CircleAvatar(child: Text('${item.order + 1}')),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.exercise.nombre,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(item.exercise.grupoMuscular),
                                ],
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_formatTargets(item)),
                              const SizedBox(height: 4),
                              Text(
                                item.latestCompletedAt == null
                                    ? 'Todavía no hay registros guardados para este ejercicio.'
                                    : 'Último registro: ${_formatSeries(item.latestWeightKg, item.latestReps)} · ${_formatDate(item.latestCompletedAt!)}',
                              ),
                              const SizedBox(height: 4),
                              Text('Sesiones registradas: ${item.totalCompletedSessions}'),
                              if (item.latestFeeling != null) ...[
                                const SizedBox(height: 8),
                                _FeelingBadge(feeling: item.latestFeeling!),
                              ],
                            ],
                          ),
                        ),
                        children: [
                          const Divider(height: 24),
                          if (item.history.length >= 2) ...[
                            SizedBox(
                              height: 180,
                              child: _RoutineProgressChart(history: item.history),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Historial',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (item.history.isEmpty)
                            const Text('Aún no hay sesiones completadas para este ejercicio.')
                          else
                            ...item.history.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _formatDate(entry.performedAt),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                            if (entry.feeling != null)
                                              _FeelingBadge(feeling: entry.feeling!),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(_formatSeries(entry.weightKg, entry.reps)),
                                        const SizedBox(height: 4),
                                        Text('Series completadas: ${entry.completedSeries}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: FilledButton.icon(
          onPressed: () async {
            await ref.read(activeWorkoutProvider.notifier).iniciarDesdeRutina(routineId);
            if (!context.mounted) {
              return;
            }
            context.push('/workouts/active');
          },
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Iniciar esta rutina'),
        ),
      ),
    );
  }
}

enum _RoutineAction {
  edit,
  duplicate,
  delete,
}

class _RoutineProgressChart extends StatelessWidget {
  const _RoutineProgressChart({required this.history});

  final List<WorkoutExerciseHistoryEntry> history;

  @override
  Widget build(BuildContext context) {
    final reversed = history.reversed.toList(growable: false);
    final weightSpots = <FlSpot>[];
    final repsSpots = <FlSpot>[];

    for (var index = 0; index < reversed.length; index++) {
      final entry = reversed[index];
      if (entry.weightKg != null) {
        weightSpots.add(FlSpot(index.toDouble(), entry.weightKg!));
      }
      if (entry.reps != null) {
        repsSpots.add(FlSpot(index.toDouble(), entry.reps!.toDouble()));
      }
    }

    if (weightSpots.length < 2 && repsSpots.length < 2) {
      return const Center(child: Text('Necesitas al menos 2 registros para ver la gráfica.'));
    }

    final values = [
      ...weightSpots.map((spot) => spot.y),
      ...repsSpots.map((spot) => spot.y),
    ];
    final minY = values.reduce((a, b) => a < b ? a : b) - 1;
    final maxY = values.reduce((a, b) => a > b ? a : b) + 1;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (reversed.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: ((maxY - minY) / 4).clamp(1, double.infinity),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(0),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= reversed.length) {
                  return const SizedBox.shrink();
                }
                final date = reversed[index].performedAt;
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    '${date.day}/${date.month}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots.map((spot) {
              final date = reversed[spot.x.toInt()].performedAt;
              return LineTooltipItem(
                '${spot.bar.color == Theme.of(context).colorScheme.primary ? 'Peso' : 'Reps'}: ${spot.y.toStringAsFixed(spot.y.truncateToDouble() == spot.y ? 0 : 1)}\n${_formatDate(date)}',
                Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ) ??
                    const TextStyle(color: Colors.white),
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          if (weightSpots.length >= 2)
            LineChartBarData(
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 3,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
              ),
              spots: weightSpots,
            ),
          if (repsSpots.length >= 2)
            LineChartBarData(
              isCurved: true,
              color: Theme.of(context).colorScheme.secondary,
              barWidth: 3,
              dotData: FlDotData(show: true),
              spots: repsSpots,
            ),
        ],
      ),
    );
  }
}

String _formatTargets(WorkoutRoutineExerciseProgress item) {
  final parts = <String>['${item.targetSets} series'];
  if (item.targetRepsMin != null || item.targetRepsMax != null) {
    if (item.targetRepsMin != null && item.targetRepsMax != null) {
      parts.add('${item.targetRepsMin}-${item.targetRepsMax} reps');
    } else if (item.targetRepsMin != null) {
      parts.add('desde ${item.targetRepsMin} reps');
    } else if (item.targetRepsMax != null) {
      parts.add('hasta ${item.targetRepsMax} reps');
    }
  }
  if (item.targetWeightKg != null) {
    final weight = item.targetWeightKg!;
    parts.add(
      weight.truncateToDouble() == weight
          ? '${weight.toStringAsFixed(0)} kg objetivo'
          : '${weight.toStringAsFixed(1)} kg objetivo',
    );
  }
  return parts.join(' · ');
}

class _FeelingBadge extends StatelessWidget {
  const _FeelingBadge({required this.feeling});

  final SensacionEjercicio feeling;

  @override
  Widget build(BuildContext context) {
    final config = _feelingUi(feeling);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(config.icon, size: 18, color: config.color),
            const SizedBox(width: 8),
            Text(config.label),
          ],
        ),
      ),
    );
  }
}

String _formatSeries(double? weightKg, int? reps) {
  if (weightKg == null && reps == null) {
    return 'Sin series completadas';
  }

  final weightText = weightKg == null
      ? '--'
      : weightKg.truncateToDouble() == weightKg
          ? '${weightKg.toStringAsFixed(0)} kg'
          : '${weightKg.toStringAsFixed(1)} kg';
  final repsText = reps == null ? '-- reps' : '$reps reps';
  return '$weightText · $repsText';
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  return '$day/$month/$year';
}

_FeelingUiConfig _feelingUi(SensacionEjercicio feeling) {
  return switch (feeling) {
    SensacionEjercicio.muyMala => const _FeelingUiConfig(
      label: 'Muy mala',
      icon: Icons.sentiment_very_dissatisfied_outlined,
      color: Colors.red,
    ),
    SensacionEjercicio.mala => const _FeelingUiConfig(
      label: 'Mala',
      icon: Icons.sentiment_dissatisfied_outlined,
      color: Colors.deepOrange,
    ),
    SensacionEjercicio.normal => const _FeelingUiConfig(
      label: 'Normal',
      icon: Icons.sentiment_neutral_outlined,
      color: Colors.amber,
    ),
    SensacionEjercicio.buena => const _FeelingUiConfig(
      label: 'Buena',
      icon: Icons.sentiment_satisfied_alt_outlined,
      color: Colors.lightGreen,
    ),
    SensacionEjercicio.excelente => const _FeelingUiConfig(
      label: 'Excelente',
      icon: Icons.sentiment_very_satisfied_outlined,
      color: Colors.green,
    ),
  };
}

class _FeelingUiConfig {
  const _FeelingUiConfig({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}