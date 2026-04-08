// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier que persiste el perfil corporal en Isar (singleton id=1).

@ProviderFor(BodyProfile)
final bodyProfileProvider = BodyProfileProvider._();

/// Notifier que persiste el perfil corporal en Isar (singleton id=1).
final class BodyProfileProvider
    extends $AsyncNotifierProvider<BodyProfile, BodyProfileState> {
  /// Notifier que persiste el perfil corporal en Isar (singleton id=1).
  BodyProfileProvider._()
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

String _$bodyProfileHash() => r'f563643533d5625cc2740b363ca05893219954c6';

/// Notifier que persiste el perfil corporal en Isar (singleton id=1).

abstract class _$BodyProfile extends $AsyncNotifier<BodyProfileState> {
  FutureOr<BodyProfileState> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
