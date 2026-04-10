// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_routine_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Carga datos base para crear o editar una rutina de entrenamiento.

@ProviderFor(workoutRoutineEditorData)
const workoutRoutineEditorDataProvider = WorkoutRoutineEditorDataFamily._();

/// Carga datos base para crear o editar una rutina de entrenamiento.

final class WorkoutRoutineEditorDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutRoutineEditorData>,
          WorkoutRoutineEditorData,
          FutureOr<WorkoutRoutineEditorData>
        >
    with
        $FutureModifier<WorkoutRoutineEditorData>,
        $FutureProvider<WorkoutRoutineEditorData> {
  /// Carga datos base para crear o editar una rutina de entrenamiento.
  const WorkoutRoutineEditorDataProvider._({
    required WorkoutRoutineEditorDataFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'workoutRoutineEditorDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutRoutineEditorDataHash();

  @override
  String toString() {
    return r'workoutRoutineEditorDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WorkoutRoutineEditorData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WorkoutRoutineEditorData> create(Ref ref) {
    final argument = this.argument as int?;
    return workoutRoutineEditorData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutRoutineEditorDataProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutRoutineEditorDataHash() =>
    r'29f60434bf1811d17c6b59d11aa1a27c7f0f7cbe';

/// Carga datos base para crear o editar una rutina de entrenamiento.

final class WorkoutRoutineEditorDataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WorkoutRoutineEditorData>, int?> {
  const WorkoutRoutineEditorDataFamily._()
    : super(
        retry: null,
        name: r'workoutRoutineEditorDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Carga datos base para crear o editar una rutina de entrenamiento.

  WorkoutRoutineEditorDataProvider call(int? routineId) =>
      WorkoutRoutineEditorDataProvider._(argument: routineId, from: this);

  @override
  String toString() => r'workoutRoutineEditorDataProvider';
}

/// Carga el detalle de una rutina con el progreso acumulado por ejercicio.

@ProviderFor(workoutRoutineDetail)
const workoutRoutineDetailProvider = WorkoutRoutineDetailFamily._();

/// Carga el detalle de una rutina con el progreso acumulado por ejercicio.

final class WorkoutRoutineDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutRoutineDetail?>,
          WorkoutRoutineDetail?,
          FutureOr<WorkoutRoutineDetail?>
        >
    with
        $FutureModifier<WorkoutRoutineDetail?>,
        $FutureProvider<WorkoutRoutineDetail?> {
  /// Carga el detalle de una rutina con el progreso acumulado por ejercicio.
  const WorkoutRoutineDetailProvider._({
    required WorkoutRoutineDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'workoutRoutineDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutRoutineDetailHash();

  @override
  String toString() {
    return r'workoutRoutineDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WorkoutRoutineDetail?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WorkoutRoutineDetail?> create(Ref ref) {
    final argument = this.argument as int;
    return workoutRoutineDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutRoutineDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutRoutineDetailHash() =>
    r'948f44ab21d9af8f64d3ed95fc566a9366535d5a';

/// Carga el detalle de una rutina con el progreso acumulado por ejercicio.

final class WorkoutRoutineDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WorkoutRoutineDetail?>, int> {
  const WorkoutRoutineDetailFamily._()
    : super(
        retry: null,
        name: r'workoutRoutineDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Carga el detalle de una rutina con el progreso acumulado por ejercicio.

  WorkoutRoutineDetailProvider call(int routineId) =>
      WorkoutRoutineDetailProvider._(argument: routineId, from: this);

  @override
  String toString() => r'workoutRoutineDetailProvider';
}

/// Controlador de alta, edición y borrado de rutinas de entrenamiento.

@ProviderFor(WorkoutRoutineController)
const workoutRoutineControllerProvider = WorkoutRoutineControllerProvider._();

/// Controlador de alta, edición y borrado de rutinas de entrenamiento.
final class WorkoutRoutineControllerProvider
    extends $NotifierProvider<WorkoutRoutineController, AsyncValue<int?>> {
  /// Controlador de alta, edición y borrado de rutinas de entrenamiento.
  const WorkoutRoutineControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutRoutineControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutRoutineControllerHash();

  @$internal
  @override
  WorkoutRoutineController create() => WorkoutRoutineController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<int?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<int?>>(value),
    );
  }
}

String _$workoutRoutineControllerHash() =>
    r'1cadc2369680c00a9a83c6261dd274805ca29a8c';

/// Controlador de alta, edición y borrado de rutinas de entrenamiento.

abstract class _$WorkoutRoutineController extends $Notifier<AsyncValue<int?>> {
  AsyncValue<int?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<int?>, AsyncValue<int?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int?>, AsyncValue<int?>>,
              AsyncValue<int?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
