// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor del motor de ayuno intermitente con refresco cada minuto.

@ProviderFor(Fasting)
const fastingProvider = FastingProvider._();

/// Proveedor del motor de ayuno intermitente con refresco cada minuto.
final class FastingProvider
    extends $AsyncNotifierProvider<Fasting, FastingState> {
  /// Proveedor del motor de ayuno intermitente con refresco cada minuto.
  const FastingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fastingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fastingHash();

  @$internal
  @override
  Fasting create() => Fasting();
}

String _$fastingHash() => r'48ddb0881f643ae00f179d0695804a53bd82b59b';

/// Proveedor del motor de ayuno intermitente con refresco cada minuto.

abstract class _$Fasting extends $AsyncNotifier<FastingState> {
  FutureOr<FastingState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FastingState>, FastingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FastingState>, FastingState>,
              AsyncValue<FastingState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
