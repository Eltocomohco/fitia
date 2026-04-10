// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_macros_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de estado para la agregación diaria de macronutrientes.

@ProviderFor(DailyMacros)
const dailyMacrosProvider = DailyMacrosProvider._();

/// Controlador de estado para la agregación diaria de macronutrientes.
final class DailyMacrosProvider
    extends $AsyncNotifierProvider<DailyMacros, DailyMacrosState> {
  /// Controlador de estado para la agregación diaria de macronutrientes.
  const DailyMacrosProvider._()
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

String _$dailyMacrosHash() => r'a006b5f386cf16fa65e19a67e04566e9e1516be7';

/// Controlador de estado para la agregación diaria de macronutrientes.

abstract class _$DailyMacros extends $AsyncNotifier<DailyMacrosState> {
  FutureOr<DailyMacrosState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
    element.handleValue(ref, created);
  }
}
