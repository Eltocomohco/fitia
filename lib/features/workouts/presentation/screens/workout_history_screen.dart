import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/registro_ejercicio_sesion.dart';
import '../providers/workout_history_provider.dart';

/// Historial global de sesiones completadas del módulo Workouts.
class WorkoutHistoryScreen extends ConsumerWidget {
  /// Crea un [WorkoutHistoryScreen].
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutSessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de entrenos')),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('No se pudo cargar el historial')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Todavía no hay entrenamientos finalizados. Cuando cierres una sesión aparecerá aquí.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  title: Text(item.routineName),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_formatDate(item.finishedAt)),
                        const SizedBox(height: 4),
                        Text(
                          '${item.totalExercises} ejercicios · ${item.totalCompletedSeries} series completadas',
                        ),
                        const SizedBox(height: 4),
                        _MetricBadge(
                          label:
                              'Tonelaje total ${_formatWeight(item.totalTonnageKg)} kg',
                        ),
                      ],
                    ),
                  ),
                  children: [
                    for (final exercise in item.exercises)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHigh,
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
                                        exercise.exerciseName,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                    ),
                                    if (exercise.feeling != null)
                                      _HistoryFeelingChip(
                                        feeling: exercise.feeling!,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _formatSeries(
                                    exercise.latestWeightKg,
                                    exercise.latestReps,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Series completadas: ${exercise.completedSeries}',
                                ),
                                if (exercise.estimatedOneRepMaxKg != null) ...[
                                  const SizedBox(height: 8),
                                  _MetricBadge(
                                    label:
                                        '1RM estimado ${_formatWeight(exercise.estimatedOneRepMaxKg!)} kg',
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HistoryFeelingChip extends StatelessWidget {
  const _HistoryFeelingChip({required this.feeling});

  final SensacionEjercicio feeling;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (feeling) {
      SensacionEjercicio.muyMala => (
        Icons.sentiment_very_dissatisfied_outlined,
        Colors.red,
      ),
      SensacionEjercicio.mala => (
        Icons.sentiment_dissatisfied_outlined,
        Colors.deepOrange,
      ),
      SensacionEjercicio.normal => (
        Icons.sentiment_neutral_outlined,
        Colors.amber,
      ),
      SensacionEjercicio.buena => (
        Icons.sentiment_satisfied_alt_outlined,
        Colors.lightGreen,
      ),
      SensacionEjercicio.excelente => (
        Icons.sentiment_very_satisfied_outlined,
        Colors.green,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$day/$month/$year · $hour:$minute';
}

String _formatSeries(double? weightKg, int? reps) {
  if (weightKg == null && reps == null) {
    return 'Sin series registradas';
  }

  final weightText = weightKg == null
      ? '--'
      : weightKg.truncateToDouble() == weightKg
      ? '${weightKg.toStringAsFixed(0)} kg'
      : '${weightKg.toStringAsFixed(1)} kg';
  final repsText = reps == null ? '-- reps' : '$reps reps';
  return '$weightText · $repsText';
}

String _formatWeight(double value) {
  return value.truncateToDouble() == value
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}
