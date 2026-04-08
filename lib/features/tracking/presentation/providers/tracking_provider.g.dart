// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier para el histórico de métricas corporales.

@ProviderFor(BodyTrackingNotifier)
final bodyTrackingProvider = BodyTrackingNotifierProvider._();

/// Notifier para el histórico de métricas corporales.
final class BodyTrackingNotifierProvider
    extends
        $AsyncNotifierProvider<BodyTrackingNotifier, List<MetricaCorporal>> {
  /// Notifier para el histórico de métricas corporales.
  BodyTrackingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyTrackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyTrackingNotifierHash();

  @$internal
  @override
  BodyTrackingNotifier create() => BodyTrackingNotifier();
}

String _$bodyTrackingNotifierHash() =>
    r'71d2676d42166a7d3e358ae014042c0182fa4ea1';

/// Notifier para el histórico de métricas corporales.

abstract class _$BodyTrackingNotifier
    extends $AsyncNotifier<List<MetricaCorporal>> {
  FutureOr<List<MetricaCorporal>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MetricaCorporal>>, List<MetricaCorporal>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MetricaCorporal>>,
                List<MetricaCorporal>
              >,
              AsyncValue<List<MetricaCorporal>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
