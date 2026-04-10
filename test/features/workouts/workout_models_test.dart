import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/ejercicio.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/registro_ejercicio_sesion.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/rutina_ejercicio.dart';
import 'package:nutrition_offline_app/features/workouts/presentation/providers/workout_routine_provider.dart';

void main() {
  group('WorkoutRoutineDraftExercise', () {
    test('copyWith preserves and clears optional targets correctly', () {
      final draft = WorkoutRoutineDraftExercise(
        exercise: Ejercicio(
          nombre: 'Press banca',
          grupoMuscular: 'Pecho',
          tiempoDescansoBaseSegundos: 90,
        ),
        targetSets: 4,
        targetRepsMin: 6,
        targetRepsMax: 8,
        targetWeightKg: 80,
      );

      final updated = draft.copyWith(
        targetSets: 5,
        clearTargetRepsMin: true,
        clearTargetWeightKg: true,
      );

      expect(updated.targetSets, 5);
      expect(updated.targetRepsMin, isNull);
      expect(updated.targetRepsMax, 8);
      expect(updated.targetWeightKg, isNull);
      expect(updated.exercise.nombre, 'Press banca');
    });
  });

  group('Workout entities defaults', () {
    test('RutinaEjercicio starts with sensible default targets', () {
      final relation = RutinaEjercicio(orden: 2);

      expect(relation.orden, 2);
      expect(relation.seriesObjetivo, 3);
      expect(relation.repeticionesMinimasObjetivo, isNull);
      expect(relation.repeticionesMaximasObjetivo, isNull);
      expect(relation.pesoObjetivoKg, isNull);
    });

    test('RegistroEjercicioSesion starts with neutral feeling', () {
      final registro = RegistroEjercicioSesion(orden: 0);

      expect(registro.orden, 0);
      expect(registro.sensacion, SensacionEjercicio.normal);
    });
  });
}
