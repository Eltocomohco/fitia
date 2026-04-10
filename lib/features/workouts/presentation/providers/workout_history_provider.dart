import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/registro_ejercicio_sesion.dart';
import '../../data/models/rutina_plantilla.dart';
import '../../data/models/serie.dart';
import '../../data/models/sesion_entrenamiento.dart';
import '../../domain/services/biomechanics_calculator.dart';
import 'workout_catalog_provider.dart';

part 'workout_history_provider.g.dart';

/// Resumen de un ejercicio dentro de una sesión completada.
class WorkoutSessionExerciseSummary {
  /// Crea un [WorkoutSessionExerciseSummary].
  const WorkoutSessionExerciseSummary({
    required this.exerciseName,
    required this.completedSeries,
    this.latestWeightKg,
    this.latestReps,
    this.feeling,
    this.estimatedOneRepMaxKg,
  });

  /// Nombre del ejercicio.
  final String exerciseName;

  /// Series completadas en la sesión.
  final int completedSeries;

  /// Último peso registrado para el ejercicio en la sesión.
  final double? latestWeightKg;

  /// Últimas repeticiones registradas para el ejercicio en la sesión.
  final int? latestReps;

  /// Sensación registrada para el ejercicio.
  final SensacionEjercicio? feeling;

  /// 1RM estimado usando la serie más pesada del ejercicio.
  final double? estimatedOneRepMaxKg;
}

/// Resumen completo de una sesión de entrenamiento finalizada.
class WorkoutSessionHistoryItem {
  /// Crea un [WorkoutSessionHistoryItem].
  const WorkoutSessionHistoryItem({
    required this.sessionId,
    required this.startedAt,
    required this.finishedAt,
    required this.routineName,
    required this.totalExercises,
    required this.totalCompletedSeries,
    required this.totalTonnageKg,
    required this.exercises,
  });

  /// Identificador persistido de la sesión.
  final int sessionId;

  /// Fecha de inicio.
  final DateTime startedAt;

  /// Fecha de finalización.
  final DateTime finishedAt;

  /// Nombre visible de la rutina o descripción de sesión libre.
  final String routineName;

  /// Número de ejercicios con actividad en la sesión.
  final int totalExercises;

  /// Número total de series completadas.
  final int totalCompletedSeries;

  /// Tonelaje total de la sesión completada.
  final double totalTonnageKg;

  /// Desglose por ejercicio.
  final List<WorkoutSessionExerciseSummary> exercises;
}

/// Historial global de sesiones completadas de Workouts.
@riverpod
Future<List<WorkoutSessionHistoryItem>> workoutSessionHistory(Ref ref) async {
  final isar = ref.read(workoutIsarProvider);

  final routines = await isar.rutinasPlantilla.where().findAll();
  final routineNames = <int, String>{
    for (final routine in routines) routine.id: routine.nombre,
  };

  final sessions = await isar.sesionesEntrenamiento.where().findAll();
  final completedSessions =
      sessions
          .where(
            (session) => session.estado == EstadoSesionEntrenamiento.completada,
          )
          .toList(growable: false)
        ..sort((a, b) {
          final left = a.fechaFin ?? a.fechaInicio;
          final right = b.fechaFin ?? b.fechaInicio;
          return right.compareTo(left);
        });

  final allSeries = await isar.series.where().findAll();
  final completedSeriesBySession = <int, List<Serie>>{};
  for (final serie in allSeries) {
    if (!serie.completada) {
      continue;
    }

    await serie.sesion.load();
    final sessionId = serie.sesion.value?.id;
    if (sessionId == null) {
      continue;
    }
    await serie.ejercicio.load();
    completedSeriesBySession.putIfAbsent(sessionId, () => <Serie>[]).add(serie);
  }

  final allLogs = await isar.registrosEjercicioSesion.where().findAll();
  final feelingBySessionAndExercise = <String, SensacionEjercicio>{};
  for (final log in allLogs) {
    await log.sesion.load();
    await log.ejercicio.load();
    final sessionId = log.sesion.value?.id;
    final exerciseId = log.ejercicio.value?.id;
    if (sessionId == null || exerciseId == null) {
      continue;
    }

    feelingBySessionAndExercise['$sessionId:$exerciseId'] = log.sensacion;
  }

  return [
    for (final session in completedSessions)
      _buildHistoryItem(
        session,
        routineNames,
        completedSeriesBySession[session.id] ?? const <Serie>[],
        feelingBySessionAndExercise,
      ),
  ];
}

WorkoutSessionHistoryItem _buildHistoryItem(
  SesionEntrenamiento session,
  Map<int, String> routineNames,
  List<Serie> completedSeries,
  Map<String, SensacionEjercicio> feelingBySessionAndExercise,
) {
  final exerciseNames = <int, String>{};
  final seriesByExercise = <int, List<Serie>>{};

  for (final serie in completedSeries) {
    final exercise = serie.ejercicio.value;
    if (exercise == null) {
      continue;
    }
    exerciseNames[exercise.id] = exercise.nombre;
    seriesByExercise.putIfAbsent(exercise.id, () => <Serie>[]).add(serie);
  }

  final summaries = <WorkoutSessionExerciseSummary>[];
  for (final entry in seriesByExercise.entries) {
    final orderedSeries = [...entry.value]
      ..sort((a, b) => a.id.compareTo(b.id));
    final latest = orderedSeries.last;
    summaries.add(
      WorkoutSessionExerciseSummary(
        exerciseName: exerciseNames[entry.key] ?? 'Ejercicio',
        completedSeries: orderedSeries.length,
        latestWeightKg: latest.pesoKg,
        latestReps: latest.repeticiones,
        feeling: feelingBySessionAndExercise['${session.id}:${entry.key}'],
        estimatedOneRepMaxKg: _estimateOneRepMax(orderedSeries),
      ),
    );
  }

  summaries.sort((a, b) => a.exerciseName.compareTo(b.exerciseName));

  return WorkoutSessionHistoryItem(
    sessionId: session.id,
    startedAt: session.fechaInicio,
    finishedAt: session.fechaFin ?? session.fechaInicio,
    routineName: session.rutinaPlantillaId == null
        ? 'Entrenamiento libre'
        : routineNames[session.rutinaPlantillaId!] ?? 'Rutina eliminada',
    totalExercises: summaries.length,
    totalCompletedSeries: summaries.fold<int>(
      0,
      (value, summary) => value + summary.completedSeries,
    ),
    totalTonnageKg: BiomechanicsCalculator.calculateTonnage(completedSeries),
    exercises: summaries,
  );
}

double? _estimateOneRepMax(List<Serie> series) {
  if (series.isEmpty) {
    return null;
  }

  final heaviest = [...series]
    ..sort((a, b) {
      final left = a.pesoKg == b.pesoKg
          ? a.repeticiones.compareTo(b.repeticiones)
          : a.pesoKg.compareTo(b.pesoKg);
      return left;
    });

  final serie = heaviest.last;
  final estimated = BiomechanicsCalculator.calculate1RM(
    serie.pesoKg,
    serie.repeticiones,
  );
  return estimated <= 0 ? null : estimated;
}
