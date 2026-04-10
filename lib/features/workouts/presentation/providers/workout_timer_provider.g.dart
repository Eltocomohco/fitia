// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Duración base del temporizador activo para cálculo de progreso.

@ProviderFor(WorkoutTimerTotal)
const workoutTimerTotalProvider = WorkoutTimerTotalProvider._();

/// Duración base del temporizador activo para cálculo de progreso.
final class WorkoutTimerTotalProvider
    extends $NotifierProvider<WorkoutTimerTotal, int> {
  /// Duración base del temporizador activo para cálculo de progreso.
  const WorkoutTimerTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutTimerTotalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutTimerTotalHash();

  @$internal
  @override
  WorkoutTimerTotal create() => WorkoutTimerTotal();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$workoutTimerTotalHash() => r'2261bb06c179821828b6e016ab1c4b94d01c44af';

/// Duración base del temporizador activo para cálculo de progreso.

abstract class _$WorkoutTimerTotal extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Gestor global del cronómetro de descanso entre series.

@ProviderFor(WorkoutTimer)
const workoutTimerProvider = WorkoutTimerProvider._();

/// Gestor global del cronómetro de descanso entre series.
final class WorkoutTimerProvider extends $NotifierProvider<WorkoutTimer, int> {
  /// Gestor global del cronómetro de descanso entre series.
  const WorkoutTimerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutTimerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutTimerHash();

  @$internal
  @override
  WorkoutTimer create() => WorkoutTimer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$workoutTimerHash() => r'c733556278aa5466ac43e4eaa2c9928d24a88c9e';

/// Gestor global del cronómetro de descanso entre series.

abstract class _$WorkoutTimer extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
