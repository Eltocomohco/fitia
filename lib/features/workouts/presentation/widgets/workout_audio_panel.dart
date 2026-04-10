import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/audio_player_service.dart';
import '../providers/audio_provider.dart';

class WorkoutAudioPanel extends ConsumerWidget {
  const WorkoutAudioPanel({
    this.compact = false,
    this.showLibraryButton = true,
    this.showModeChips = false,
    super.key,
  });

  final bool compact;
  final bool showLibraryButton;
  final bool showModeChips;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(workoutAudioProvider);
    final duration = audioState.duration;
    final progressValue = duration != null && duration > Duration.zero
        ? (audioState.position.inMilliseconds / duration.inMilliseconds)
              .clamp(0.0, 1.0)
              .toDouble()
        : null;

    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          14,
          compact ? 12 : 18,
          14,
          compact ? 12 : 18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: compact ? 42 : 52,
                  height: compact ? 42 : 52,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.graphic_eq_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audioState.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: compact
                            ? Theme.of(context).textTheme.titleSmall
                            : Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        audioState.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (showLibraryButton)
                  IconButton(
                    tooltip: 'Importar MP3 a mi carpeta',
                    onPressed: () {
                      ref.read(workoutAudioProvider.notifier).loadLocalFiles();
                    },
                    icon: const Icon(Icons.folder_open_outlined),
                  ),
              ],
            ),
            if (showModeChips) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    selected: audioState.mode == WorkoutAudioMode.radio,
                    label: const Text('Radio'),
                    onSelected: (_) {
                      ref.read(workoutAudioProvider.notifier).playRadioMode();
                    },
                  ),
                  ChoiceChip(
                    selected: audioState.mode != WorkoutAudioMode.radio,
                    label: const Text('Mi musica'),
                    onSelected: (_) {
                      ref.read(workoutAudioProvider.notifier).playLibrary();
                    },
                  ),
                  FilterChip(
                    selected: audioState.isShuffleEnabled,
                    label: const Text('Aleatorio'),
                    onSelected: (_) {
                      ref.read(workoutAudioProvider.notifier).toggleShuffle();
                    },
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Anterior',
                  onPressed:
                      audioState.hasPrevious ||
                          audioState.position > const Duration(seconds: 2)
                      ? () {
                          ref
                              .read(workoutAudioProvider.notifier)
                              .skipToPrevious();
                        }
                      : null,
                  icon: const Icon(Icons.skip_previous_outlined),
                ),
                IconButton.filledTonal(
                  tooltip: audioState.isPlaying ? 'Pausar' : 'Reproducir',
                  onPressed: () {
                    ref.read(workoutAudioProvider.notifier).togglePlayback();
                  },
                  icon: Icon(
                    audioState.isPlaying
                        ? Icons.pause_circle_filled_outlined
                        : Icons.play_circle_fill_outlined,
                  ),
                ),
                IconButton(
                  tooltip: 'Siguiente',
                  onPressed: audioState.hasNext
                      ? () {
                          ref.read(workoutAudioProvider.notifier).skipToNext();
                        }
                      : null,
                  icon: const Icon(Icons.skip_next_outlined),
                ),
                IconButton(
                  tooltip: audioState.isShuffleEnabled
                      ? 'Desactivar aleatorio'
                      : 'Activar aleatorio',
                  onPressed: () {
                    ref.read(workoutAudioProvider.notifier).toggleShuffle();
                  },
                  icon: Icon(
                    audioState.isShuffleEnabled
                        ? Icons.shuffle_on_outlined
                        : Icons.shuffle_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: compact ? 6 : 8,
                value: progressValue,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              audioState.isLive
                  ? (audioState.isPlaying
                        ? 'Emisión en directo o stream sin duración fija'
                        : 'Listo para reproducir radio o archivos locales')
                  : '${_formatDuration(audioState.position)} / ${_formatDuration(duration ?? Duration.zero)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }
}
