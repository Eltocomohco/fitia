// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Historial global de sesiones completadas de Workouts.

@ProviderFor(workoutSessionHistory)
const workoutSessionHistoryProvider = WorkoutSessionHistoryProvider._();

/// Historial global de sesiones completadas de Workouts.

final class WorkoutSessionHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutSessionHistoryItem>>,
          List<WorkoutSessionHistoryItem>,
          FutureOr<List<WorkoutSessionHistoryItem>>
        >
    with
        $FutureModifier<List<WorkoutSessionHistoryItem>>,
        $FutureProvider<List<WorkoutSessionHistoryItem>> {
  /// Historial global de sesiones completadas de Workouts.
  const WorkoutSessionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutSessionHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutSessionHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<WorkoutSessionHistoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutSessionHistoryItem>> create(Ref ref) {
    return workoutSessionHistory(ref);
  }
}

String _$workoutSessionHistoryHash() =>
    r'3fac3a90d4a48b7f84e20dc53f863eae70a03c64';
