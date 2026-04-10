// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AudioLibrary)
const audioLibraryProvider = AudioLibraryProvider._();

final class AudioLibraryProvider
    extends $AsyncNotifierProvider<AudioLibrary, AudioLibraryState> {
  const AudioLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioLibraryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioLibraryHash();

  @$internal
  @override
  AudioLibrary create() => AudioLibrary();
}

String _$audioLibraryHash() => r'64d493445e3596790ed2b0f1a7a44e89731735bd';

abstract class _$AudioLibrary extends $AsyncNotifier<AudioLibraryState> {
  FutureOr<AudioLibraryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<AudioLibraryState>, AudioLibraryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AudioLibraryState>, AudioLibraryState>,
              AsyncValue<AudioLibraryState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
