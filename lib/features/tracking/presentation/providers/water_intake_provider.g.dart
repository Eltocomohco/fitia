// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_intake_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier para seguimiento de tomas de agua del día.

@ProviderFor(WaterIntake)
final waterIntakeProvider = WaterIntakeProvider._();

/// Notifier para seguimiento de tomas de agua del día.
final class WaterIntakeProvider
    extends $AsyncNotifierProvider<WaterIntake, List<RegistroAgua>> {
  /// Notifier para seguimiento de tomas de agua del día.
  WaterIntakeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waterIntakeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waterIntakeHash();

  @$internal
  @override
  WaterIntake create() => WaterIntake();
}

String _$waterIntakeHash() => r'87d9d0df36df7d89b957d2c7f8172a70e8c82cd5';

/// Notifier para seguimiento de tomas de agua del día.

abstract class _$WaterIntake extends $AsyncNotifier<List<RegistroAgua>> {
  FutureOr<List<RegistroAgua>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RegistroAgua>>, List<RegistroAgua>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RegistroAgua>>, List<RegistroAgua>>,
              AsyncValue<List<RegistroAgua>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
