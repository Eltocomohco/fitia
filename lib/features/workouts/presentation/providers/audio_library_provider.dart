import 'package:audio_service/audio_service.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_config.dart';
import '../../data/models/audio_playlist.dart';
import 'audio_provider.dart';

part 'audio_library_provider.g.dart';

class AudioLibraryState {
  const AudioLibraryState({
    required this.libraryPath,
    required this.tracks,
    required this.playlists,
  });

  final String libraryPath;
  final List<MediaItem> tracks;
  final List<AudioPlaylist> playlists;
}

@riverpod
class AudioLibrary extends _$AudioLibrary {
  @override
  Future<AudioLibraryState> build() async {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _load());
  }

  Future<void> importTracks() async {
    await ref.read(workoutAudioProvider.notifier).loadLocalFiles();
    state = AsyncData(await _load());
  }

  Future<void> playRadio() async {
    await ref.read(workoutAudioProvider.notifier).playRadioMode();
  }

  Future<void> playLibrary({bool shuffle = false}) async {
    await ref.read(workoutAudioProvider.notifier).playLibrary(shuffle: shuffle);
    state = AsyncData(await _load());
  }

  Future<void> playPlaylist(
    AudioPlaylist playlist, {
    bool shuffle = false,
  }) async {
    await ref
        .read(workoutAudioProvider.notifier)
        .playPlaylist(
          playlist.nombre,
          playlist.rutasCanciones,
          shuffle: shuffle,
        );
  }

  Future<void> savePlaylist({
    int? id,
    required String nombre,
    required List<String> rutasCanciones,
  }) async {
    final trimmedName = nombre.trim();
    if (trimmedName.isEmpty || rutasCanciones.isEmpty) {
      return;
    }

    final isar = await IsarConfig.ensureInitialized();
    final now = DateTime.now();
    final playlist = AudioPlaylist(
      id: id ?? Isar.autoIncrement,
      nombre: trimmedName,
      rutasCanciones: rutasCanciones,
      initialCreadoEn: now,
      initialActualizadoEn: now,
    );

    if (id != null) {
      final existing = await isar.audioPlaylists.get(id);
      if (existing != null) {
        playlist.creadoEn = existing.creadoEn;
      }
    }

    await isar.writeTxn(() async {
      await isar.audioPlaylists.put(playlist);
    });

    state = AsyncData(await _load());
  }

  Future<void> deletePlaylist(int id) async {
    final isar = await IsarConfig.ensureInitialized();
    await isar.writeTxn(() async {
      await isar.audioPlaylists.delete(id);
    });
    state = AsyncData(await _load());
  }

  Future<AudioLibraryState> _load() async {
    final handler = ref.read(workoutAudioHandlerProvider);
    final path = await handler.ensureLibraryDirectoryPath();
    final tracks = await handler.refreshLibraryTracks();
    final isar = await IsarConfig.ensureInitialized();
    final playlists = await isar.audioPlaylists.where().findAll();
    playlists.sort((a, b) => b.actualizadoEn.compareTo(a.actualizadoEn));

    return AudioLibraryState(
      libraryPath: path,
      tracks: tracks,
      playlists: playlists,
    );
  }
}
