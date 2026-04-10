// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier que persiste el perfil corporal en Isar (singleton id=1).

@ProviderFor(BodyProfile)
const bodyProfileProvider = BodyProfileProvider._();

/// Notifier que persiste el perfil corporal en Isar (singleton id=1).
final class BodyProfileProvider
    extends $AsyncNotifierProvider<BodyProfile, BodyProfileState> {
  /// Notifier que persiste el perfil corporal en Isar (singleton id=1).
  const BodyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyProfileHash();

  @$internal
  @override
  BodyProfile create() => BodyProfile();
}

String _$bodyProfileHash() => r'3ba4c2245bf47c511ddf036d8b049d28998c189e';

/// Notifier que persiste el perfil corporal en Isar (singleton id=1).

abstract class _$BodyProfile extends $AsyncNotifier<BodyProfileState> {
  FutureOr<BodyProfileState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<BodyProfileState>, BodyProfileState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BodyProfileState>, BodyProfileState>,
              AsyncValue<BodyProfileState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
