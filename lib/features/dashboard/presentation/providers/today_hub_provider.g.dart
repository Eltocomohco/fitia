// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_hub_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodayHub)
const todayHubProvider = TodayHubProvider._();

final class TodayHubProvider
    extends $AsyncNotifierProvider<TodayHub, TodayHubSnapshot> {
  const TodayHubProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayHubProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayHubHash();

  @$internal
  @override
  TodayHub create() => TodayHub();
}

String _$todayHubHash() => r'3ddeb563b5c26036b6f5389f8b15890a11a62629';

abstract class _$TodayHub extends $AsyncNotifier<TodayHubSnapshot> {
  FutureOr<TodayHubSnapshot> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<TodayHubSnapshot>, TodayHubSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TodayHubSnapshot>, TodayHubSnapshot>,
              AsyncValue<TodayHubSnapshot>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
