// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fecha seleccionada en el planificador de calendario.

@ProviderFor(SelectedDateNotifier)
final selectedDateProvider = SelectedDateNotifierProvider._();

/// Fecha seleccionada en el planificador de calendario.
final class SelectedDateNotifierProvider
    extends $NotifierProvider<SelectedDateNotifier, DateTime> {
  /// Fecha seleccionada en el planificador de calendario.
  SelectedDateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDateNotifierHash();

  @$internal
  @override
  SelectedDateNotifier create() => SelectedDateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDateNotifierHash() =>
    r'00f0f13c457594edc09e9d421f17febd6347da5c';

/// Fecha seleccionada en el planificador de calendario.

abstract class _$SelectedDateNotifier extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Registros diarios de la fecha seleccionada.

@ProviderFor(DailyLogsNotifier)
final dailyLogsProvider = DailyLogsNotifierProvider._();

/// Registros diarios de la fecha seleccionada.
final class DailyLogsNotifierProvider
    extends $AsyncNotifierProvider<DailyLogsNotifier, List<RegistroDiario>> {
  /// Registros diarios de la fecha seleccionada.
  DailyLogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyLogsNotifierHash();

  @$internal
  @override
  DailyLogsNotifier create() => DailyLogsNotifier();
}

String _$dailyLogsNotifierHash() => r'e68c26ddee378d3a83e983304f4b56673b36aff4';

/// Registros diarios de la fecha seleccionada.

abstract class _$DailyLogsNotifier
    extends $AsyncNotifier<List<RegistroDiario>> {
  FutureOr<List<RegistroDiario>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<RegistroDiario>>, List<RegistroDiario>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RegistroDiario>>,
                List<RegistroDiario>
              >,
              AsyncValue<List<RegistroDiario>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Días marcados como entrenamiento.

@ProviderFor(TrainingDays)
final trainingDaysProvider = TrainingDaysProvider._();

/// Días marcados como entrenamiento.
final class TrainingDaysProvider
    extends $AsyncNotifierProvider<TrainingDays, Set<int>> {
  /// Días marcados como entrenamiento.
  TrainingDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainingDaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainingDaysHash();

  @$internal
  @override
  TrainingDays create() => TrainingDays();
}

String _$trainingDaysHash() => r'c3bda1cc9786476d99ca04be9163c62ac47d3459';

/// Días marcados como entrenamiento.

abstract class _$TrainingDays extends $AsyncNotifier<Set<int>> {
  FutureOr<Set<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Set<int>>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<int>>, Set<int>>,
              AsyncValue<Set<int>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Días con cumplimiento de comida (al menos un registro diario).

@ProviderFor(mealCompletionDays)
final mealCompletionDaysProvider = MealCompletionDaysProvider._();

/// Días con cumplimiento de comida (al menos un registro diario).

final class MealCompletionDaysProvider
    extends
        $FunctionalProvider<AsyncValue<Set<int>>, Set<int>, FutureOr<Set<int>>>
    with $FutureModifier<Set<int>>, $FutureProvider<Set<int>> {
  /// Días con cumplimiento de comida (al menos un registro diario).
  MealCompletionDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealCompletionDaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealCompletionDaysHash();

  @$internal
  @override
  $FutureProviderElement<Set<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Set<int>> create(Ref ref) {
    return mealCompletionDays(ref);
  }
}

String _$mealCompletionDaysHash() =>
    r'4c0f0fde6901b91237622b5ac3af32d53d667c0f';
