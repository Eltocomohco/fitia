import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/audio_player_service.dart';
import '../../data/models/audio_playlist.dart';
import '../providers/audio_library_provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/workout_audio_panel.dart';

class WorkoutAudioScreen extends ConsumerWidget {
  const WorkoutAudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryAsync = ref.watch(audioLibraryProvider);
    final audioState = ref.watch(workoutAudioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reproductor')),
      body: libraryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(
          child: Text('No se pudo cargar la biblioteca de audio.'),
        ),
        data: (library) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const WorkoutAudioPanel(showModeChips: true),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mi carpeta de musica',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ruta interna creada por la app para tus MP3:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      library.libraryPath,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            ref
                                .read(audioLibraryProvider.notifier)
                                .importTracks();
                          },
                          icon: const Icon(Icons.folder_open_outlined),
                          label: const Text('Importar MP3'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            ref.read(audioLibraryProvider.notifier).refresh();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refrescar carpeta'),
                        ),
                        OutlinedButton.icon(
                          onPressed: library.tracks.isEmpty
                              ? null
                              : () {
                                  ref
                                      .read(audioLibraryProvider.notifier)
                                      .playLibrary();
                                },
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('Reproducir carpeta'),
                        ),
                        OutlinedButton.icon(
                          onPressed: library.tracks.isEmpty
                              ? null
                              : () {
                                  ref
                                      .read(audioLibraryProvider.notifier)
                                      .playLibrary(shuffle: true);
                                },
                          icon: const Icon(Icons.shuffle_outlined),
                          label: const Text('Aleatorio'),
                        ),
                        if (audioState.mode != WorkoutAudioMode.radio)
                          OutlinedButton.icon(
                            onPressed: () {
                              ref
                                  .read(audioLibraryProvider.notifier)
                                  .playRadio();
                            },
                            icon: const Icon(Icons.radio_outlined),
                            label: const Text('Volver a radio'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Canciones en carpeta',
              action: TextButton.icon(
                onPressed: library.tracks.isEmpty
                    ? null
                    : () => _openCreatePlaylistDialog(context, ref, library),
                icon: const Icon(Icons.playlist_add_outlined),
                label: const Text('Nueva playlist'),
              ),
              child: library.tracks.isEmpty
                  ? const Text(
                      'Todavia no hay MP3 en la carpeta. Importa archivos o copia tus canciones a la ruta mostrada arriba.',
                    )
                  : Column(
                      children: [
                        for (final track in library.tracks)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.music_note_outlined),
                            title: Text(track.title),
                            subtitle: Text(
                              track.album ?? 'Mi carpeta de musica',
                            ),
                            trailing: IconButton(
                              tooltip: 'Reproducir desde aqui',
                              onPressed: () {
                                ref
                                    .read(workoutAudioProvider.notifier)
                                    .playPlaylist(track.title, [track.id]);
                              },
                              icon: const Icon(Icons.play_arrow_outlined),
                            ),
                          ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Playlists',
              child: library.playlists.isEmpty
                  ? const Text(
                      'Crea listas con canciones concretas de tu carpeta para tener modos tipo Spotify dentro de tu biblioteca local.',
                    )
                  : Column(
                      children: [
                        for (final playlist in library.playlists)
                          _PlaylistTile(
                            playlist: playlist,
                            trackLookup: {
                              for (final track in library.tracks)
                                track.id: track,
                            },
                            onEdit: () => _openPlaylistEditorDialog(
                              context,
                              ref,
                              library,
                              playlist: playlist,
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCreatePlaylistDialog(
    BuildContext context,
    WidgetRef ref,
    AudioLibraryState library,
  ) async {
    await _openPlaylistEditorDialog(context, ref, library);
  }

  Future<void> _openPlaylistEditorDialog(
    BuildContext context,
    WidgetRef ref,
    AudioLibraryState library, {
    AudioPlaylist? playlist,
  }) async {
    final nameController = TextEditingController(text: playlist?.nombre ?? '');
    final selectedPaths = <String>[
      ...(playlist?.rutasCanciones ?? const <String>[]),
    ];
    final availableLookup = {
      for (final track in library.tracks) track.id: track,
    };

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final canSave =
                selectedPaths.isNotEmpty &&
                nameController.text.trim().isNotEmpty;

            void toggleTrack(String path, bool shouldInclude) {
              setState(() {
                if (shouldInclude) {
                  if (!selectedPaths.contains(path)) {
                    selectedPaths.add(path);
                  }
                  return;
                }
                selectedPaths.remove(path);
              });
            }

            return AlertDialog(
              title: Text(
                playlist == null ? 'Nueva playlist' : 'Editar playlist',
              ),
              content: SizedBox(
                width: 520,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la playlist',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Orden actual',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 180,
                      child: selectedPaths.isEmpty
                          ? const Center(
                              child: Text(
                                'Añade canciones desde la biblioteca.',
                              ),
                            )
                          : ReorderableListView.builder(
                              shrinkWrap: true,
                              itemCount: selectedPaths.length,
                              onReorder: (oldIndex, newIndex) {
                                setState(() {
                                  if (newIndex > oldIndex) {
                                    newIndex -= 1;
                                  }
                                  final item = selectedPaths.removeAt(oldIndex);
                                  selectedPaths.insert(newIndex, item);
                                });
                              },
                              itemBuilder: (context, index) {
                                final path = selectedPaths[index];
                                final track = availableLookup[path];
                                return ListTile(
                                  key: ValueKey(path),
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.drag_handle),
                                  title: Text(
                                    track?.title ?? _fileNameFromPath(path),
                                  ),
                                  subtitle: Text(path),
                                  trailing: IconButton(
                                    tooltip: 'Quitar de la playlist',
                                    onPressed: () => toggleTrack(path, false),
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Canciones disponibles',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final track in library.tracks)
                            CheckboxListTile(
                              value: selectedPaths.contains(track.id),
                              contentPadding: EdgeInsets.zero,
                              title: Text(track.title),
                              subtitle: Text(track.id),
                              onChanged: (value) {
                                toggleTrack(track.id, value == true);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: canSave
                      ? () => Navigator.of(dialogContext).pop(true)
                      : null,
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed == true) {
      await ref
          .read(audioLibraryProvider.notifier)
          .savePlaylist(
            id: playlist?.id,
            nombre: nameController.text,
            rutasCanciones: selectedPaths.toList(growable: false),
          );
    }
    nameController.dispose();
  }

  String _fileNameFromPath(String path) {
    final normalized = path.replaceAll('\\', '/');
    return normalized.split('/').last;
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (action != null) action!,
              ],
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _PlaylistTile extends ConsumerWidget {
  const _PlaylistTile({
    required this.playlist,
    required this.trackLookup,
    required this.onEdit,
  });

  final AudioPlaylist playlist;
  final Map<String, MediaItem> trackLookup;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewTitles = playlist.rutasCanciones
        .take(3)
        .map((path) => trackLookup[path]?.title ?? _fileNameFromPath(path))
        .join(' · ');

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.queue_music_outlined),
      title: Text(playlist.nombre),
      subtitle: Text(
        '${playlist.rutasCanciones.length} canciones${previewTitles.isEmpty ? '' : ' · $previewTitles'}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Wrap(
        spacing: 4,
        children: [
          IconButton(
            tooltip: 'Reproducir playlist',
            onPressed: () {
              ref.read(audioLibraryProvider.notifier).playPlaylist(playlist);
            },
            icon: const Icon(Icons.play_arrow_outlined),
          ),
          IconButton(
            tooltip: 'Aleatorio',
            onPressed: () {
              ref
                  .read(audioLibraryProvider.notifier)
                  .playPlaylist(playlist, shuffle: true);
            },
            icon: const Icon(Icons.shuffle_outlined),
          ),
          IconButton(
            tooltip: 'Editar playlist',
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Eliminar playlist',
            onPressed: () {
              ref
                  .read(audioLibraryProvider.notifier)
                  .deletePlaylist(playlist.id);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }

  String _fileNameFromPath(String path) {
    final normalized = path.replaceAll('\\', '/');
    return normalized.split('/').last;
  }
}
