import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/services/audio_player_service.dart';

/// Estado reactivo del mini-player de entrenamientos.
class WorkoutAudioState {
  const WorkoutAudioState({
    this.title = 'Workout Radio',
    this.subtitle = 'Selecciona una emisora',
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration,
    this.mode = WorkoutAudioMode.radio,
    this.isShuffleEnabled = false,
    this.hasPrevious = false,
    this.hasNext = false,
    this.libraryPath,
    this.processingState = AudioProcessingState.idle,
  });

  final String title;
  final String subtitle;
  final bool isPlaying;
  final Duration position;
  final Duration? duration;
  final WorkoutAudioMode mode;
  final bool isShuffleEnabled;
  final bool hasPrevious;
  final bool hasNext;
  final String? libraryPath;
  final AudioProcessingState processingState;

  bool get isLive => duration == null || duration == Duration.zero;

  WorkoutAudioState copyWith({
    String? title,
    String? subtitle,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    WorkoutAudioMode? mode,
    bool? isShuffleEnabled,
    bool? hasPrevious,
    bool? hasNext,
    String? libraryPath,
    bool clearLibraryPath = false,
    bool clearDuration = false,
    AudioProcessingState? processingState,
  }) {
    return WorkoutAudioState(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: clearDuration ? null : duration ?? this.duration,
      mode: mode ?? this.mode,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      hasNext: hasNext ?? this.hasNext,
      libraryPath: clearLibraryPath ? null : libraryPath ?? this.libraryPath,
      processingState: processingState ?? this.processingState,
    );
  }
}

final workoutAudioHandlerProvider = Provider<WorkoutAudioHandler>((ref) {
  return WorkoutAudioService.instance;
});

final workoutAudioProvider =
    StateNotifierProvider<WorkoutAudioController, WorkoutAudioState>((ref) {
      return WorkoutAudioController(ref.watch(workoutAudioHandlerProvider));
    });

/// Controlador Riverpod que hidrata la UI con el estado del handler nativo.
class WorkoutAudioController extends StateNotifier<WorkoutAudioState> {
  WorkoutAudioController(this._handler) : super(const WorkoutAudioState()) {
    _subscriptions = <StreamSubscription<dynamic>>[
      _handler.mediaItem.listen(_onMediaItem),
      _handler.playbackState.listen(_onPlaybackState),
      _handler.currentPosition.listen(_onPosition),
      _handler.duration.listen(_onDuration),
      _handler.modeStream.listen(_onModeChanged),
      _handler.libraryPathStream.listen(_onLibraryPathChanged),
      _handler.shuffleEnabledStream.listen(_onShuffleChanged),
    ];
  }

  final WorkoutAudioHandler _handler;
  late final List<StreamSubscription<dynamic>> _subscriptions;

  Future<void> togglePlayback() async {
    if (state.isPlaying) {
      await _handler.pause();
      return;
    }
    await _handler.play();
  }

  Future<void> skipToNext() => _handler.skipToNext();

  Future<void> skipToPrevious() => _handler.skipToPrevious();

  Future<void> loadLocalFiles() => _handler.loadLocalFiles();

  Future<void> playRadioMode() => _handler.loadRadioMode();

  Future<void> playLibrary({bool shuffle = false}) =>
      _handler.playLibrary(shuffle: shuffle);

  Future<void> playPlaylist(
    String name,
    List<String> songPaths, {
    bool shuffle = false,
  }) => _handler.playLibrary(
    trackPaths: songPaths,
    title: name,
    shuffle: shuffle,
    mode: WorkoutAudioMode.playlist,
  );

  Future<void> toggleShuffle() => _handler.toggleShuffle();

  void _onMediaItem(MediaItem? item) {
    if (item == null) {
      return;
    }

    state = state.copyWith(
      title: item.title,
      subtitle: item.artist ?? item.album ?? 'Workout Radio',
      hasPrevious: _handler.hasPrevious,
      hasNext: _handler.hasNext,
    );
  }

  void _onPlaybackState(PlaybackState playbackState) {
    state = state.copyWith(
      isPlaying: playbackState.playing,
      processingState: playbackState.processingState,
      position: playbackState.updatePosition,
      hasPrevious: _handler.hasPrevious,
      hasNext: _handler.hasNext,
    );
  }

  void _onPosition(Duration position) {
    state = state.copyWith(position: position);
  }

  void _onDuration(Duration? duration) {
    state = state.copyWith(duration: duration, clearDuration: duration == null);
  }

  void _onModeChanged(WorkoutAudioMode mode) {
    state = state.copyWith(mode: mode);
  }

  void _onLibraryPathChanged(String path) {
    state = state.copyWith(libraryPath: path);
  }

  void _onShuffleChanged(bool enabled) {
    state = state.copyWith(isShuffleEnabled: enabled);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    super.dispose();
  }
}
