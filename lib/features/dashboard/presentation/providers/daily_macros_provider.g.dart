// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_macros_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de estado para la agregación diaria de macronutrientes.

@ProviderFor(DailyMacros)
final dailyMacrosProvider = DailyMacrosProvider._();

/// Controlador de estado para la agregación diaria de macronutrientes.
final class DailyMacrosProvider
    extends $AsyncNotifierProvider<DailyMacros, DailyMacrosState> {
  /// Controlador de estado para la agregación diaria de macronutrientes.
  DailyMacrosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyMacrosProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyMacrosHash();

  @$internal
  @override
  DailyMacros create() => DailyMacros();
}

String _$dailyMacrosHash() => r'54ac54c14a74a8819ef38ece15506922fb3fab43';

/// Controlador de estado para la agregación diaria de macronutrientes.

abstract class _$DailyMacros extends $AsyncNotifier<DailyMacrosState> {
  FutureOr<DailyMacrosState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<DailyMacrosState>, DailyMacrosState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DailyMacrosState>, DailyMacrosState>,
              AsyncValue<DailyMacrosState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
