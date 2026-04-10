// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Indica si el proveedor está reconstruyendo una sesión persistida.

@ProviderFor(ActiveWorkoutRestoring)
const activeWorkoutRestoringProvider = ActiveWorkoutRestoringProvider._();

/// Indica si el proveedor está reconstruyendo una sesión persistida.
final class ActiveWorkoutRestoringProvider
    extends $NotifierProvider<ActiveWorkoutRestoring, bool> {
  /// Indica si el proveedor está reconstruyendo una sesión persistida.
  const ActiveWorkoutRestoringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkoutRestoringProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutRestoringHash();

  @$internal
  @override
  ActiveWorkoutRestoring create() => ActiveWorkoutRestoring();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$activeWorkoutRestoringHash() =>
    r'c87fd346bbdd242bd64e67c21598d5a006da0bab';

/// Indica si el proveedor está reconstruyendo una sesión persistida.

abstract class _$ActiveWorkoutRestoring extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Gestor de la sesión de entrenamiento actualmente abierta.

@ProviderFor(ActiveWorkout)
const activeWorkoutProvider = ActiveWorkoutProvider._();

/// Gestor de la sesión de entrenamiento actualmente abierta.
final class ActiveWorkoutProvider
    extends $NotifierProvider<ActiveWorkout, ActiveWorkoutState?> {
  /// Gestor de la sesión de entrenamiento actualmente abierta.
  const ActiveWorkoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkoutProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutHash();

  @$internal
  @override
  ActiveWorkout create() => ActiveWorkout();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveWorkoutState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveWorkoutState?>(value),
    );
  }
}

String _$activeWorkoutHash() => r'bf32c51ac3a1bcaff82e8091b527fbf6e63c7c2f';

/// Gestor de la sesión de entrenamiento actualmente abierta.

abstract class _$ActiveWorkout extends $Notifier<ActiveWorkoutState?> {
  ActiveWorkoutState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ActiveWorkoutState?, ActiveWorkoutState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveWorkoutState?, ActiveWorkoutState?>,
              ActiveWorkoutState?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
