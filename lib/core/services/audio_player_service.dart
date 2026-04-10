import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import 'home_widget_service.dart';

enum WorkoutAudioMode { radio, library, playlist }

/// Inicializador centralizado del handler de audio para sesiones de entrenamiento.
abstract final class WorkoutAudioService {
  static WorkoutAudioHandler? _instance;

  static WorkoutAudioHandler get instance {
    final handler = _instance;
    if (handler == null) {
      throw StateError('WorkoutAudioService no ha sido inicializado.');
    }
    return handler;
  }

  static Future<WorkoutAudioHandler> ensureInitialized() async {
    final existing = _instance;
    if (existing != null) {
      return existing;
    }

    final handler = await AudioService.init<WorkoutAudioHandler>(
      builder: WorkoutAudioHandler.new,
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.fitora.workout_audio',
        androidNotificationChannelName: 'Fitora Workout Audio',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
    _instance = handler;
    return handler;
  }
}

/// Handler de audio en segundo plano para reproducir radios de entrenamiento.
class WorkoutAudioHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  WorkoutAudioHandler() {
    _player.positionStream.listen((position) {
      _currentPositionController.add(position);
      _broadcastPlaybackState();
    });
    _player.durationStream.listen((duration) {
      _durationController.add(duration);
    });
    _player.shuffleModeEnabledStream.listen((enabled) {
      _shuffleEnabledController.add(enabled);
    });
    _player.playerStateStream.listen((_) {
      _broadcastPlaybackState();
      unawaited(_syncMusicWidget());
    });
    _player.currentIndexStream.listen((index) {
      if (index == null || index < 0 || index >= _queueItems.length) {
        return;
      }
      mediaItem.add(_queueItems[index]);
      unawaited(_syncMusicWidget());
    });
    unawaited(_initializePlaylist());
    unawaited(_initializeLibraryDirectory());
  }

  final AudioPlayer _player = AudioPlayer();
  final StreamController<Duration> _currentPositionController =
      StreamController<Duration>.broadcast();
  final StreamController<Duration?> _durationController =
      StreamController<Duration?>.broadcast();
  final StreamController<WorkoutAudioMode> _modeController =
      StreamController<WorkoutAudioMode>.broadcast();
  final StreamController<String> _libraryPathController =
      StreamController<String>.broadcast();
  final StreamController<bool> _shuffleEnabledController =
      StreamController<bool>.broadcast();
  late ConcatenatingAudioSource _playlistSource;
  List<MediaItem> _queueItems = List<MediaItem>.unmodifiable(
    _defaultPlaylistItems,
  );
  List<MediaItem> _libraryItems = const <MediaItem>[];
  WorkoutAudioMode _mode = WorkoutAudioMode.radio;
  Directory? _libraryDirectory;

  static final List<MediaItem> _defaultPlaylistItems = <MediaItem>[
    MediaItem(
      id: 'https://ice1.somafm.com/groovesalad-128-mp3',
      title: 'Groove Salad',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Lofi / Ambient',
      artUri: Uri.parse('https://somafm.com/img/groovesalad120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/defcon-128-mp3',
      title: 'DEF CON Radio',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Electronic',
      artUri: Uri.parse('https://somafm.com/img/defcon120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/dronezone-128-mp3',
      title: 'Drone Zone',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Deep Focus',
      artUri: Uri.parse('https://somafm.com/img/dronezone120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/cliqhop-128-mp3',
      title: 'cliqhop idm',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'IDM / Beats',
      artUri: Uri.parse('https://somafm.com/img/cliqhop120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/u80s-128-mp3',
      title: 'Underground 80s',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'New Wave / 80s',
      artUri: Uri.parse('https://somafm.com/img/u80s120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/missioncontrol-128-mp3',
      title: 'Mission Control',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Space / Electronic',
      artUri: Uri.parse('https://somafm.com/img/missioncontrol120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/lush-128-mp3',
      title: 'Lush',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Vocal / Chill',
      artUri: Uri.parse('https://somafm.com/img/lush120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/beatblender-128-mp3',
      title: 'Beat Blender',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Beatmix / House',
      artUri: Uri.parse('https://somafm.com/img/beatblender120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/secretagent-128-mp3',
      title: 'Secret Agent',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'Groove / Lounge',
      artUri: Uri.parse('https://somafm.com/img/secretagent120.png'),
    ),
    MediaItem(
      id: 'https://ice1.somafm.com/suburbsofgoa-128-mp3',
      title: 'Suburbs of Goa',
      album: 'Workout Radio',
      artist: 'SomaFM',
      genre: 'World / Bass',
      artUri: Uri.parse('https://somafm.com/img/suburbsofgoa120.png'),
    ),
  ];

  Stream<Duration> get currentPosition => _currentPositionController.stream;

  Stream<Duration?> get duration => _durationController.stream;

  Stream<WorkoutAudioMode> get modeStream => _modeController.stream;

  Stream<String> get libraryPathStream => _libraryPathController.stream;

  Stream<bool> get shuffleEnabledStream => _shuffleEnabledController.stream;

  bool get hasPrevious => _player.hasPrevious;

  bool get hasNext => _player.hasNext;

  bool get isShuffleEnabled => _player.shuffleModeEnabled;

  WorkoutAudioMode get mode => _mode;

  String? get libraryPath => _libraryDirectory?.path;

  List<MediaItem> get libraryItems =>
      List<MediaItem>.unmodifiable(_libraryItems);

  Future<void> _initializePlaylist() async {
    _playlistSource = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: _defaultPlaylistItems
          .map((item) => AudioSource.uri(Uri.parse(item.id), tag: item))
          .toList(growable: false),
    );

    await _replaceQueue(
      items: _defaultPlaylistItems,
      source: _playlistSource,
      autoplay: false,
      mode: WorkoutAudioMode.radio,
      shuffle: false,
    );
    await _syncMusicWidget();
  }

  Future<void> loadLocalFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) {
      return;
    }

    final selectedPaths = result.files
        .map((file) => file.path)
        .whereType<String>()
        .where((path) => path.trim().isNotEmpty)
        .toList(growable: false);
    if (selectedPaths.isEmpty) {
      return;
    }

    final directory = await _initializeLibraryDirectory();
    final importedPaths = <String>[];
    for (final path in selectedPaths) {
      final source = File(path);
      if (!await source.exists()) {
        continue;
      }

      final targetFile = await _resolveUniqueTargetFile(
        directory,
        _fileNameFromPath(path),
      );
      await source.copy(targetFile.path);
      importedPaths.add(targetFile.path);
    }

    await refreshLibraryTracks();
    if (importedPaths.isEmpty) {
      return;
    }

    await playLibrary(
      trackPaths: importedPaths,
      title: 'Importados',
      shuffle: false,
      mode: WorkoutAudioMode.library,
    );
  }

  Future<void> loadRadioMode() async {
    final source = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: _defaultPlaylistItems
          .map((item) => AudioSource.uri(Uri.parse(item.id), tag: item))
          .toList(growable: false),
    );

    await _replaceQueue(
      items: _defaultPlaylistItems,
      source: source,
      autoplay: true,
      mode: WorkoutAudioMode.radio,
      shuffle: false,
    );
  }

  Future<void> _syncMusicWidget() async {
    final current = mediaItem.value;
    await HomeWidgetService.updateMusicWidget(
      title: current?.title ?? 'Workout Radio',
      subtitle: current?.artist ?? current?.album ?? 'Selecciona una emisora',
      modeLabel: switch (_mode) {
        WorkoutAudioMode.radio => 'Radio',
        WorkoutAudioMode.library => 'Biblioteca',
        WorkoutAudioMode.playlist => 'Playlist',
      },
      isPlaying: _player.playing,
    );
  }

  Future<String> ensureLibraryDirectoryPath() async {
    final directory = await _initializeLibraryDirectory();
    return directory.path;
  }

  Future<List<MediaItem>> refreshLibraryTracks() async {
    final directory = await _initializeLibraryDirectory();
    final audioFiles =
        directory
            .listSync(followLinks: false)
            .whereType<File>()
            .where((file) => _isSupportedAudioFile(file.path))
            .toList(growable: false)
          ..sort(
            (a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()),
          );

    _libraryItems = audioFiles
        .map(
          (file) => MediaItem(
            id: file.path,
            title: _fileNameFromPath(file.path),
            album: 'Mi carpeta de musica',
            artist: 'Local',
            genre: 'MP3',
          ),
        )
        .toList(growable: false);

    return List<MediaItem>.unmodifiable(_libraryItems);
  }

  Future<void> playLibrary({
    List<String>? trackPaths,
    String? title,
    bool shuffle = false,
    WorkoutAudioMode mode = WorkoutAudioMode.library,
  }) async {
    final items = trackPaths == null
        ? await refreshLibraryTracks()
        : trackPaths
              .where((path) => path.trim().isNotEmpty)
              .map(
                (path) => MediaItem(
                  id: path,
                  title: _fileNameFromPath(path),
                  album: title ?? 'Mi carpeta de musica',
                  artist: mode == WorkoutAudioMode.playlist
                      ? 'Playlist'
                      : 'Local',
                  genre: 'MP3',
                ),
              )
              .toList(growable: false);

    if (items.isEmpty) {
      return;
    }

    final localSource = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: [
        for (final item in items) AudioSource.file(item.id, tag: item),
      ],
    );

    await _replaceQueue(
      items: items,
      source: localSource,
      autoplay: true,
      mode: mode,
      shuffle: shuffle,
    );
  }

  @override
  Future<void> play() async {
    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero, index: _player.currentIndex ?? 0);
    }
    await _player.play();
    _broadcastPlaybackState();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    _broadcastPlaybackState();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
    _broadcastPlaybackState();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
      if (!_player.playing) {
        await _player.play();
      }
      _broadcastPlaybackState();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
      if (!_player.playing) {
        await _player.play();
      }
      _broadcastPlaybackState();
      return;
    }

    if (_player.position > const Duration(seconds: 2)) {
      await _player.seek(Duration.zero);
      _broadcastPlaybackState();
    }
  }

  Future<void> toggleShuffle() async {
    final enabled = !_player.shuffleModeEnabled;
    if (enabled) {
      await _player.setShuffleModeEnabled(true);
      await _player.shuffle();
    } else {
      await _player.setShuffleModeEnabled(false);
    }
    _shuffleEnabledController.add(_player.shuffleModeEnabled);
    _broadcastPlaybackState();
  }

  Future<void> _replaceQueue({
    required List<MediaItem> items,
    required ConcatenatingAudioSource source,
    required bool autoplay,
    required WorkoutAudioMode mode,
    required bool shuffle,
  }) async {
    _queueItems = List<MediaItem>.unmodifiable(items);
    _playlistSource = source;
    _mode = mode;
    _modeController.add(mode);
    queue.add(_queueItems);
    mediaItem.add(_queueItems.first);
    await _player.setAudioSource(_playlistSource, initialIndex: 0);
    if (shuffle && items.length > 1) {
      await _player.setShuffleModeEnabled(true);
      await _player.shuffle();
    } else {
      await _player.setShuffleModeEnabled(false);
    }
    _shuffleEnabledController.add(_player.shuffleModeEnabled);
    _broadcastPlaybackState();
    if (autoplay) {
      await play();
    }
  }

  void _broadcastPlaybackState() {
    playbackState.add(
      PlaybackState(
        controls: <MediaControl>[
          MediaControl.skipToPrevious,
          if (_player.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const <MediaAction>{
          MediaAction.play,
          MediaAction.pause,
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.skipToNext,
          MediaAction.skipToPrevious,
        },
        androidCompactActionIndices: const <int>[0, 1, 2],
        processingState: _mapProcessingState(_player.processingState),
        playing: _player.playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }

  AudioProcessingState _mapProcessingState(ProcessingState state) {
    return switch (state) {
      ProcessingState.idle => AudioProcessingState.idle,
      ProcessingState.loading => AudioProcessingState.loading,
      ProcessingState.buffering => AudioProcessingState.buffering,
      ProcessingState.ready => AudioProcessingState.ready,
      ProcessingState.completed => AudioProcessingState.completed,
    };
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
  }

  Future<Directory> _initializeLibraryDirectory() async {
    final existing = _libraryDirectory;
    if (existing != null) {
      _libraryPathController.add(existing.path);
      return existing;
    }

    final baseDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory('${baseDirectory.path}/fitora_music');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    _libraryDirectory = directory;
    _libraryPathController.add(directory.path);
    await refreshLibraryTracks();
    return directory;
  }

  Future<File> _resolveUniqueTargetFile(
    Directory directory,
    String filename,
  ) async {
    final dotIndex = filename.lastIndexOf('.');
    final baseName = dotIndex <= 0 ? filename : filename.substring(0, dotIndex);
    final extension = dotIndex <= 0 ? '' : filename.substring(dotIndex);
    var attempt = 0;

    while (true) {
      final suffix = attempt == 0 ? '' : '_$attempt';
      final target = File('${directory.path}/$baseName$suffix$extension');
      if (!await target.exists()) {
        return target;
      }
      attempt++;
    }
  }

  bool _isSupportedAudioFile(String path) {
    final normalized = path.toLowerCase();
    return normalized.endsWith('.mp3') ||
        normalized.endsWith('.m4a') ||
        normalized.endsWith('.aac') ||
        normalized.endsWith('.wav') ||
        normalized.endsWith('.ogg');
  }

  String _fileNameFromPath(String path) {
    final normalized = path.replaceAll('\\', '/');
    return normalized.split('/').last;
  }
}
