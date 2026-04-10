import '../../data/models/ejercicio.dart';

/// Origen de cada bloque dentro del plan automático de entrenamiento.
enum WorkoutAutomationOrigin {
  /// Bloque elegido explícitamente por el usuario.
  selected,

  /// Bloque añadido como activación o movilidad inicial.
  warmup,

  /// Bloque añadido como vuelta a la calma o estiramiento final.
  cooldown,
}

/// Bloque lineal ya resuelto por el motor de automatización.
class AutomatedWorkoutBlock {
  const AutomatedWorkoutBlock({
    required this.exercise,
    required this.seriesCount,
    required this.origin,
  });

  final Ejercicio exercise;
  final int seriesCount;
  final WorkoutAutomationOrigin origin;
}

/// Motor que inyecta movilidad y estiramientos según el grupo muscular trabajado.
abstract final class WorkoutAutomationService {
  static const _shoulderWarmupName = 'Dislocaciones de hombro';
  static const _legWarmupName = 'Aperturas de cadera 90-90';
  static const _backWarmupName = 'Gato-Camello';
  static const _chestCooldownName = 'Pectoral en puerta';
  static const _legCooldownName = 'Isquiotibiales con banda';
  static const _backCooldownName = 'Cobra';

  /// Construye un plan de sesión con inyecciones automáticas.
  static List<AutomatedWorkoutBlock> buildAutomatedSession({
    required List<Ejercicio> selectedExercises,
    required Map<int, int> selectedSeriesCount,
    required List<Ejercicio> catalog,
  }) {
    if (selectedExercises.isEmpty) {
      return const [];
    }

    final normalizedGroups = selectedExercises
        .map((exercise) => exercise.grupoMuscular.trim().toLowerCase())
        .toSet();
    final byName = <String, Ejercicio>{
      for (final exercise in catalog)
        exercise.nombre.trim().toLowerCase(): exercise,
    };
    final plan = <AutomatedWorkoutBlock>[];

    void addWarmup(String exerciseName) {
      final exercise = byName[exerciseName.toLowerCase()];
      if (exercise == null) {
        return;
      }
      plan.add(
        AutomatedWorkoutBlock(
          exercise: exercise,
          seriesCount: 2,
          origin: WorkoutAutomationOrigin.warmup,
        ),
      );
    }

    void addCooldown(String exerciseName) {
      final exercise = byName[exerciseName.toLowerCase()];
      if (exercise == null) {
        return;
      }
      plan.add(
        AutomatedWorkoutBlock(
          exercise: exercise,
          seriesCount: 1,
          origin: WorkoutAutomationOrigin.cooldown,
        ),
      );
    }

    final hasShoulderOrChest =
        normalizedGroups.contains('pecho') ||
        normalizedGroups.contains('hombro');
    final hasLeg = normalizedGroups.contains('pierna');
    final hasBack = normalizedGroups.contains('espalda');

    if (hasShoulderOrChest) {
      addWarmup(_shoulderWarmupName);
    }
    if (hasLeg) {
      addWarmup(_legWarmupName);
    }
    if (hasBack) {
      addWarmup(_backWarmupName);
    }

    for (final exercise in selectedExercises) {
      final seriesCount = selectedSeriesCount[exercise.id] ?? 1;
      plan.add(
        AutomatedWorkoutBlock(
          exercise: exercise,
          seriesCount: seriesCount < 1 ? 1 : seriesCount,
          origin: WorkoutAutomationOrigin.selected,
        ),
      );
    }

    if (hasShoulderOrChest) {
      addCooldown(_chestCooldownName);
    }
    if (hasLeg) {
      addCooldown(_legCooldownName);
    }
    if (hasBack) {
      addCooldown(_backCooldownName);
    }

    return plan;
  }
}
