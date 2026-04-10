import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/ejercicio.dart';
import '../../data/models/rutina_ejercicio.dart';
import '../../data/models/rutina_plantilla.dart';
import '../../data/models/sesion_entrenamiento.dart';
import '../../data/services/workout_seed_service.dart';

part 'workout_catalog_provider.g.dart';

/// Instancia activa de Isar accesible desde el módulo Workouts.
final workoutIsarProvider = Provider<Isar>((ref) {
  final instance = Isar.instanceNames.isNotEmpty
      ? Isar.getInstance(Isar.instanceNames.first)
      : null;

  if (instance == null) {
    throw StateError('No existe una instancia de Isar activa para Workouts.');
  }

  return instance;
});

/// Resumen lineal de una rutina disponible en catálogo.
class WorkoutCatalogRoutine {
  /// Crea un [WorkoutCatalogRoutine].
  const WorkoutCatalogRoutine({
    required this.rutina,
    required this.totalEjercicios,
    required this.totalSesionesCompletadas,
  });

  /// Rutina persistida.
  final RutinaPlantilla rutina;

  /// Número de ejercicios vinculados.
  final int totalEjercicios;

  /// Número de veces que la rutina fue completada.
  final int totalSesionesCompletadas;
}

/// Catálogo de rutinas visibles en la pantalla principal de entrenamientos.
@riverpod
Future<List<WorkoutCatalogRoutine>> workoutCatalog(Ref ref) async {
  final isar = ref.read(workoutIsarProvider);
  await WorkoutSeedService.seedExercisesIfEmpty(isar);

  final routines = await isar.rutinasPlantilla.where().findAll();
  routines.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));

  final relations = await isar.rutinasEjercicio.where().findAll();
  final counters = <int, int>{};
  for (final relation in relations) {
    await relation.rutina.load();
    final rutinaId = relation.rutina.value?.id;
    if (rutinaId == null) {
      continue;
    }
    counters.update(rutinaId, (value) => value + 1, ifAbsent: () => 1);
  }

  final sessions = await isar.sesionesEntrenamiento.where().findAll();
  final completedCounters = <int, int>{};
  for (final session in sessions) {
    final routineId = session.rutinaPlantillaId;
    if (session.estado != EstadoSesionEntrenamiento.completada || routineId == null) {
      continue;
    }
    completedCounters.update(routineId, (value) => value + 1, ifAbsent: () => 1);
  }

  return routines
      .map(
        (routine) => WorkoutCatalogRoutine(
          rutina: routine,
          totalEjercicios: counters[routine.id] ?? 0,
          totalSesionesCompletadas: completedCounters[routine.id] ?? 0,
        ),
      )
      .toList(growable: false);
}

/// Listado completo de ejercicios disponibles para construir sesiones vacías.
@riverpod
Future<List<Ejercicio>> workoutExercises(Ref ref) async {
  final isar = ref.read(workoutIsarProvider);
  await WorkoutSeedService.seedExercisesIfEmpty(isar);
  final ejercicios = await isar.ejercicios.where().findAll();
  ejercicios.sort((a, b) {
    final groupCompare = a.grupoMuscular.compareTo(b.grupoMuscular);
    if (groupCompare != 0) {
      return groupCompare;
    }
    return a.nombre.compareTo(b.nombre);
  });
  return ejercicios;
}