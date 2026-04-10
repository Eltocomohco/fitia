// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Catálogo de rutinas visibles en la pantalla principal de entrenamientos.

@ProviderFor(workoutCatalog)
const workoutCatalogProvider = WorkoutCatalogProvider._();

/// Catálogo de rutinas visibles en la pantalla principal de entrenamientos.

final class WorkoutCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutCatalogRoutine>>,
          List<WorkoutCatalogRoutine>,
          FutureOr<List<WorkoutCatalogRoutine>>
        >
    with
        $FutureModifier<List<WorkoutCatalogRoutine>>,
        $FutureProvider<List<WorkoutCatalogRoutine>> {
  /// Catálogo de rutinas visibles en la pantalla principal de entrenamientos.
  const WorkoutCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutCatalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutCatalogHash();

  @$internal
  @override
  $FutureProviderElement<List<WorkoutCatalogRoutine>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutCatalogRoutine>> create(Ref ref) {
    return workoutCatalog(ref);
  }
}

String _$workoutCatalogHash() => r'6640e1a4bba0d257ead5b21714ed908108e3fefd';

/// Listado completo de ejercicios disponibles para construir sesiones vacías.

@ProviderFor(workoutExercises)
const workoutExercisesProvider = WorkoutExercisesProvider._();

/// Listado completo de ejercicios disponibles para construir sesiones vacías.

final class WorkoutExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ejercicio>>,
          List<Ejercicio>,
          FutureOr<List<Ejercicio>>
        >
    with $FutureModifier<List<Ejercicio>>, $FutureProvider<List<Ejercicio>> {
  /// Listado completo de ejercicios disponibles para construir sesiones vacías.
  const WorkoutExercisesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutExercisesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutExercisesHash();

  @$internal
  @override
  $FutureProviderElement<List<Ejercicio>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Ejercicio>> create(Ref ref) {
    return workoutExercises(ref);
  }
}

String _$workoutExercisesHash() => r'a0bf9ace6693040392302b88c46e8953ce816196';
