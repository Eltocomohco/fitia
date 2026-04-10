import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/ejercicio.dart';
import '../../data/models/registro_ejercicio_sesion.dart';
import '../../data/models/rutina_ejercicio.dart';
import '../../data/models/rutina_plantilla.dart';
import '../../data/models/serie.dart';
import '../../data/models/sesion_entrenamiento.dart';
import '../../data/services/workout_seed_service.dart';
import 'workout_catalog_provider.dart';

part 'workout_routine_provider.g.dart';

/// Borrador editable de un ejercicio dentro de una rutina.
class WorkoutRoutineDraftExercise {
  /// Crea un [WorkoutRoutineDraftExercise].
  const WorkoutRoutineDraftExercise({
    required this.exercise,
    this.targetSets = 3,
    this.targetRepsMin,
    this.targetRepsMax,
    this.targetWeightKg,
  });

  /// Ejercicio seleccionado en la rutina.
  final Ejercicio exercise;

  /// Número objetivo de series.
  final int targetSets;

  /// Repeticiones mínimas objetivo.
  final int? targetRepsMin;

  /// Repeticiones máximas objetivo.
  final int? targetRepsMax;

  /// Peso objetivo en kilogramos.
  final double? targetWeightKg;

  /// Devuelve una copia con los cambios solicitados.
  WorkoutRoutineDraftExercise copyWith({
    Ejercicio? exercise,
    int? targetSets,
    int? targetRepsMin,
    int? targetRepsMax,
    double? targetWeightKg,
    bool clearTargetRepsMin = false,
    bool clearTargetRepsMax = false,
    bool clearTargetWeightKg = false,
  }) {
    return WorkoutRoutineDraftExercise(
      exercise: exercise ?? this.exercise,
      targetSets: targetSets ?? this.targetSets,
      targetRepsMin: clearTargetRepsMin
          ? null
          : targetRepsMin ?? this.targetRepsMin,
      targetRepsMax: clearTargetRepsMax
          ? null
          : targetRepsMax ?? this.targetRepsMax,
      targetWeightKg: clearTargetWeightKg
          ? null
          : targetWeightKg ?? this.targetWeightKg,
    );
  }
}

/// Resumen histórico de un ejercicio en una sesión completada.
class WorkoutExerciseHistoryEntry {
  /// Crea un [WorkoutExerciseHistoryEntry].
  const WorkoutExerciseHistoryEntry({
    required this.performedAt,
    required this.completedSeries,
    this.weightKg,
    this.reps,
    this.feeling,
  });

  /// Fecha de la sesión completada.
  final DateTime performedAt;

  /// Series completadas para ese ejercicio en la sesión.
  final int completedSeries;

  /// Peso más reciente registrado en la sesión.
  final double? weightKg;

  /// Repeticiones más recientes registradas en la sesión.
  final int? reps;

  /// Sensación general del ejercicio en esa sesión.
  final SensacionEjercicio? feeling;
}

/// Datos precargados para crear o editar una rutina.
class WorkoutRoutineEditorData {
  /// Crea un [WorkoutRoutineEditorData].
  const WorkoutRoutineEditorData({
    required this.availableExercises,
    required this.selectedExercises,
    this.routine,
  });

  /// Rutina existente en modo edición.
  final RutinaPlantilla? routine;

  /// Ejercicios disponibles en catálogo.
  final List<Ejercicio> availableExercises;

  /// Ejercicios actualmente seleccionados y ordenados en la rutina.
  final List<WorkoutRoutineDraftExercise> selectedExercises;
}

/// Progreso más reciente de un ejercicio dentro de una rutina.
class WorkoutRoutineExerciseProgress {
  /// Crea un [WorkoutRoutineExerciseProgress].
  const WorkoutRoutineExerciseProgress({
    required this.exercise,
    required this.order,
    required this.targetSets,
    required this.totalCompletedSessions,
    required this.history,
    this.latestWeightKg,
    this.latestReps,
    this.latestFeeling,
    this.latestCompletedAt,
    this.targetRepsMin,
    this.targetRepsMax,
    this.targetWeightKg,
  });

  /// Ejercicio de la plantilla.
  final Ejercicio exercise;

  /// Orden visual dentro de la rutina.
  final int order;

  /// Series objetivo definidas en la plantilla.
  final int targetSets;

  /// Número total de sesiones completadas con registro de este ejercicio.
  final int totalCompletedSessions;

  /// Historial cronológico del ejercicio en sesiones completadas.
  final List<WorkoutExerciseHistoryEntry> history;

  /// Último peso registrado.
  final double? latestWeightKg;

  /// Últimas repeticiones registradas.
  final int? latestReps;

  /// Última sensación guardada.
  final SensacionEjercicio? latestFeeling;

  /// Fecha del último registro completado.
  final DateTime? latestCompletedAt;

  /// Repeticiones mínimas objetivo.
  final int? targetRepsMin;

  /// Repeticiones máximas objetivo.
  final int? targetRepsMax;

  /// Peso objetivo de referencia.
  final double? targetWeightKg;
}

/// Detalle completo de una rutina con su progreso reciente.
class WorkoutRoutineDetail {
  /// Crea un [WorkoutRoutineDetail].
  const WorkoutRoutineDetail({
    required this.routine,
    required this.exercises,
    required this.completedSessions,
    this.lastCompletedAt,
  });

  /// Rutina consultada.
  final RutinaPlantilla routine;

  /// Ejercicios ordenados con su último progreso.
  final List<WorkoutRoutineExerciseProgress> exercises;

  /// Número de sesiones completadas desde esta rutina.
  final int completedSessions;

  /// Fecha de la última vez que se completó la rutina.
  final DateTime? lastCompletedAt;
}

/// Carga datos base para crear o editar una rutina de entrenamiento.
@riverpod
Future<WorkoutRoutineEditorData> workoutRoutineEditorData(
  Ref ref,
  int? routineId,
) async {
  final isar = ref.read(workoutIsarProvider);
  await WorkoutSeedService.seedExercisesIfEmpty(isar);

  final availableExercises = await isar.ejercicios.where().findAll();
  availableExercises.sort((a, b) {
    final groupCompare = a.grupoMuscular.compareTo(b.grupoMuscular);
    if (groupCompare != 0) {
      return groupCompare;
    }
    return a.nombre.compareTo(b.nombre);
  });

  if (routineId == null) {
    return WorkoutRoutineEditorData(
      availableExercises: availableExercises,
      selectedExercises: const [],
    );
  }

  final routine = await isar.rutinasPlantilla.get(routineId);
  if (routine == null) {
    return WorkoutRoutineEditorData(
      availableExercises: availableExercises,
      selectedExercises: const [],
    );
  }

  final relations = await isar.rutinasEjercicio.where().findAll();
  final selectedExercises = <WorkoutRoutineDraftExercise>[];
  final filtered = <RutinaEjercicio>[];
  for (final relation in relations) {
    await relation.rutina.load();
    if (relation.rutina.value?.id != routineId) {
      continue;
    }
    await relation.ejercicio.load();
    filtered.add(relation);
  }

  filtered.sort((a, b) => a.orden.compareTo(b.orden));
  for (final relation in filtered) {
    final exercise = relation.ejercicio.value;
    if (exercise != null) {
      selectedExercises.add(
        WorkoutRoutineDraftExercise(
          exercise: exercise,
          targetSets: relation.seriesObjetivo,
          targetRepsMin: relation.repeticionesMinimasObjetivo,
          targetRepsMax: relation.repeticionesMaximasObjetivo,
          targetWeightKg: relation.pesoObjetivoKg,
        ),
      );
    }
  }

  return WorkoutRoutineEditorData(
    routine: routine,
    availableExercises: availableExercises,
    selectedExercises: selectedExercises,
  );
}

/// Carga el detalle de una rutina con el progreso acumulado por ejercicio.
@riverpod
Future<WorkoutRoutineDetail?> workoutRoutineDetail(Ref ref, int routineId) async {
  final isar = ref.read(workoutIsarProvider);
  final routine = await isar.rutinasPlantilla.get(routineId);
  if (routine == null) {
    return null;
  }

  final relations = await isar.rutinasEjercicio.where().findAll();
  final routineRelations = <RutinaEjercicio>[];
  for (final relation in relations) {
    await relation.rutina.load();
    if (relation.rutina.value?.id != routineId) {
      continue;
    }
    await relation.ejercicio.load();
    routineRelations.add(relation);
  }
  routineRelations.sort((a, b) => a.orden.compareTo(b.orden));

  final sessions = await isar.sesionesEntrenamiento.where().findAll();
  final completedSessions = <SesionEntrenamiento>[];
  for (final session in sessions) {
    if (session.estado != EstadoSesionEntrenamiento.completada ||
        session.rutinaPlantillaId != routineId) {
      continue;
    }
    completedSessions.add(session);
  }

  completedSessions.sort((a, b) {
    final left = a.fechaFin ?? a.fechaInicio;
    final right = b.fechaFin ?? b.fechaInicio;
    return right.compareTo(left);
  });

  final sessionDates = <int, DateTime>{
    for (final session in completedSessions)
      session.id: session.fechaFin ?? session.fechaInicio,
  };

  final logs = await isar.registrosEjercicioSesion.where().findAll();
  final feelingBySessionAndExercise = <String, RegistroEjercicioSesion>{};
  for (final log in logs) {
    await log.sesion.load();
    final sessionId = log.sesion.value?.id;
    if (sessionId == null || !sessionDates.containsKey(sessionId)) {
      continue;
    }

    await log.ejercicio.load();
    final exerciseId = log.ejercicio.value?.id;
    if (exerciseId == null) {
      continue;
    }

    feelingBySessionAndExercise['$sessionId:$exerciseId'] = log;
  }

  final series = await isar.series.where().findAll();
  final seriesBySessionAndExercise = <String, List<Serie>>{};
  for (final serie in series) {
    if (!serie.completada) {
      continue;
    }

    await serie.sesion.load();
    final sessionId = serie.sesion.value?.id;
    if (sessionId == null || !sessionDates.containsKey(sessionId)) {
      continue;
    }

    await serie.ejercicio.load();
    final exerciseId = serie.ejercicio.value?.id;
    if (exerciseId == null) {
      continue;
    }

    final key = '$sessionId:$exerciseId';
    seriesBySessionAndExercise.putIfAbsent(key, () => <Serie>[]).add(serie);
  }

  final progressItems = <WorkoutRoutineExerciseProgress>[];
  for (final relation in routineRelations) {
    final exercise = relation.ejercicio.value;
    if (exercise == null) {
      continue;
    }

    final history = <WorkoutExerciseHistoryEntry>[];
    for (final session in completedSessions) {
      final key = '${session.id}:${exercise.id}';
      final completedSeries = [...(seriesBySessionAndExercise[key] ?? const <Serie>[])];
      completedSeries.sort((a, b) => a.id.compareTo(b.id));
      final latestSerie = completedSeries.isEmpty ? null : completedSeries.last;
      final feeling = feelingBySessionAndExercise[key]?.sensacion;
      if (latestSerie == null && feeling == null) {
        continue;
      }

      history.add(
        WorkoutExerciseHistoryEntry(
          performedAt: sessionDates[session.id]!,
          completedSeries: completedSeries.length,
          weightKg: latestSerie?.pesoKg,
          reps: latestSerie?.repeticiones,
          feeling: feeling,
        ),
      );
    }

    final latestHistory = history.isEmpty ? null : history.first;

    progressItems.add(
      WorkoutRoutineExerciseProgress(
        exercise: exercise,
        order: relation.orden,
        targetSets: relation.seriesObjetivo,
        totalCompletedSessions: history.length,
        history: history,
        latestWeightKg: latestHistory?.weightKg,
        latestReps: latestHistory?.reps,
        latestFeeling: latestHistory?.feeling,
        latestCompletedAt: latestHistory?.performedAt,
        targetRepsMin: relation.repeticionesMinimasObjetivo,
        targetRepsMax: relation.repeticionesMaximasObjetivo,
        targetWeightKg: relation.pesoObjetivoKg,
      ),
    );
  }

  return WorkoutRoutineDetail(
    routine: routine,
    exercises: progressItems,
    completedSessions: completedSessions.length,
    lastCompletedAt: completedSessions.isEmpty
        ? null
        : completedSessions.first.fechaFin ?? completedSessions.first.fechaInicio,
  );
}

/// Controlador de alta, edición y borrado de rutinas de entrenamiento.
@Riverpod(keepAlive: true)
class WorkoutRoutineController extends _$WorkoutRoutineController {
  @override
  AsyncValue<int?> build() => const AsyncData(null);

  /// Crea o actualiza una rutina y devuelve su identificador persistido.
  Future<int?> saveRoutine({
    int? routineId,
    required String name,
    required List<WorkoutRoutineDraftExercise> exercises,
  }) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final normalizedName = name.trim();
      if (normalizedName.isEmpty) {
        throw ArgumentError('La rutina necesita un nombre.');
      }

      final orderedExercises = <WorkoutRoutineDraftExercise>[];
      for (final exercise in exercises) {
        if (!orderedExercises.any((item) => item.exercise.id == exercise.exercise.id)) {
          orderedExercises.add(exercise);
        }
      }

      if (orderedExercises.isEmpty) {
        throw ArgumentError('La rutina necesita al menos un ejercicio.');
      }

      final isar = ref.read(workoutIsarProvider);
      final routine = routineId == null
          ? RutinaPlantilla(nombre: normalizedName)
          : await isar.rutinasPlantilla.get(routineId) ??
                RutinaPlantilla(id: routineId, nombre: normalizedName);

      final allRelations = await isar.rutinasEjercicio.where().findAll();
      final existingRelations = <RutinaEjercicio>[];
      for (final relation in allRelations) {
        await relation.rutina.load();
        if (relation.rutina.value?.id == routine.id) {
          existingRelations.add(relation);
        }
      }

      await isar.writeTxn(() async {
        routine.nombre = normalizedName;
        routine.id = await isar.rutinasPlantilla.put(routine);

        if (existingRelations.isNotEmpty) {
          await isar.rutinasEjercicio.deleteAll(
            existingRelations.map((relation) => relation.id).toList(growable: false),
          );
        }

        for (var index = 0; index < orderedExercises.length; index++) {
          final draft = orderedExercises[index];
          final exercise = await isar.ejercicios.get(draft.exercise.id);
          if (exercise == null) {
            continue;
          }

          final relation = RutinaEjercicio(
            orden: index,
            seriesObjetivo: draft.targetSets < 1 ? 1 : draft.targetSets,
            repeticionesMinimasObjetivo: draft.targetRepsMin,
            repeticionesMaximasObjetivo: draft.targetRepsMax,
            pesoObjetivoKg: draft.targetWeightKg,
          );
          relation.rutina.value = routine;
          relation.ejercicio.value = exercise;
          relation.id = await isar.rutinasEjercicio.put(relation);
          await relation.rutina.save();
          await relation.ejercicio.save();
        }
      });

      ref.invalidate(workoutCatalogProvider);
      ref.invalidate(workoutRoutineEditorDataProvider(routineId));
      ref.invalidate(workoutRoutineDetailProvider(routine.id));
      return routine.id;
    });

    state = result;
    return result.asData?.value;
  }

  /// Elimina una rutina y sus relaciones de ejercicios.
  Future<void> deleteRoutine(int routineId) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final isar = ref.read(workoutIsarProvider);
      final allRelations = await isar.rutinasEjercicio.where().findAll();
      final relationIds = <int>[];
      for (final relation in allRelations) {
        await relation.rutina.load();
        if (relation.rutina.value?.id == routineId) {
          relationIds.add(relation.id);
        }
      }

      await isar.writeTxn(() async {
        if (relationIds.isNotEmpty) {
          await isar.rutinasEjercicio.deleteAll(relationIds);
        }
        await isar.rutinasPlantilla.delete(routineId);
      });

      ref.invalidate(workoutCatalogProvider);
      ref.invalidate(workoutRoutineDetailProvider(routineId));
      ref.invalidate(workoutRoutineEditorDataProvider(routineId));
      return routineId;
    });

    state = result;
  }

  /// Duplica una rutina con sus ejercicios y objetivos actuales.
  Future<int?> duplicateRoutine(int routineId) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final isar = ref.read(workoutIsarProvider);
      final routine = await isar.rutinasPlantilla.get(routineId);
      if (routine == null) {
        throw ArgumentError('La rutina no existe.');
      }

      final relations = await isar.rutinasEjercicio.where().findAll();
      final selectedExercises = <WorkoutRoutineDraftExercise>[];
      final filtered = <RutinaEjercicio>[];
      for (final relation in relations) {
        await relation.rutina.load();
        if (relation.rutina.value?.id != routineId) {
          continue;
        }
        await relation.ejercicio.load();
        filtered.add(relation);
      }
      filtered.sort((a, b) => a.orden.compareTo(b.orden));

      for (final relation in filtered) {
        final exercise = relation.ejercicio.value;
        if (exercise == null) {
          continue;
        }
        selectedExercises.add(
          WorkoutRoutineDraftExercise(
            exercise: exercise,
            targetSets: relation.seriesObjetivo,
            targetRepsMin: relation.repeticionesMinimasObjetivo,
            targetRepsMax: relation.repeticionesMaximasObjetivo,
            targetWeightKg: relation.pesoObjetivoKg,
          ),
        );
      }

      return saveRoutine(
        name: '${routine.nombre} copia',
        exercises: selectedExercises,
      );
    });

    state = result;
    return result.asData?.value;
  }

  /// Persiste un nuevo orden de ejercicios para una rutina existente.
  Future<void> reorderRoutineExercises({
    required int routineId,
    required List<WorkoutRoutineDraftExercise> exercises,
  }) async {
    final isar = ref.read(workoutIsarProvider);
    final relations = await isar.rutinasEjercicio.where().findAll();
    final relationByExerciseId = <int, RutinaEjercicio>{};

    for (final relation in relations) {
      await relation.rutina.load();
      if (relation.rutina.value?.id != routineId) {
        continue;
      }
      await relation.ejercicio.load();
      final exerciseId = relation.ejercicio.value?.id;
      if (exerciseId != null) {
        relationByExerciseId[exerciseId] = relation;
      }
    }

    await isar.writeTxn(() async {
      for (var index = 0; index < exercises.length; index++) {
        final relation = relationByExerciseId[exercises[index].exercise.id];
        if (relation == null) {
          continue;
        }
        relation.orden = index;
        await isar.rutinasEjercicio.put(relation);
      }
    });

    ref.invalidate(workoutRoutineDetailProvider(routineId));
    ref.invalidate(workoutRoutineEditorDataProvider(routineId));
    ref.invalidate(workoutCatalogProvider);
  }
}