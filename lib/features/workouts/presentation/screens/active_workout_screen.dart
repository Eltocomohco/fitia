import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../data/models/ejercicio.dart';
import '../../data/models/registro_ejercicio_sesion.dart';
import '../../data/models/serie.dart';
import '../../data/models/sesion_entrenamiento.dart';
import '../providers/active_workout_provider.dart';
import '../providers/workout_catalog_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../widgets/workout_audio_panel.dart';

/// Consola operativa para ejecutar la sesión de entrenamiento activa.
class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  /// Crea un [ActiveWorkoutScreen].
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  final Map<int, TextEditingController> _weightControllers = {};
  final Map<int, TextEditingController> _repsControllers = {};
  bool? _wakelockEnabled;

  @override
  void dispose() {
    for (final controller in _weightControllers.values) {
      controller.dispose();
    }
    for (final controller in _repsControllers.values) {
      controller.dispose();
    }
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workout = ref.watch(activeWorkoutProvider);
    final restoring = ref.watch(activeWorkoutRestoringProvider);
    final remaining = ref.watch(workoutTimerProvider);
    final progress = ref.watch(workoutTimerProgressProvider);
    _syncWakelock(workout?.sesion.estado == EstadoSesionEntrenamiento.activa);

    if (workout == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Entrenamiento activo')),
        body: restoring
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'No hay una sesión activa disponible.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () => context.go('/workouts'),
                        child: const Text('Volver al catálogo'),
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    _syncControllers(workout);
    final items = _buildItems(workout.grupos);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento activo'),
        actions: [
          IconButton(
            tooltip: 'Añadir ejercicio',
            onPressed: () => _openExercisePicker(),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'La sesión está vacía. Añade ejercicios desde el botón superior para comenzar.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _openExercisePicker,
                      icon: const Icon(Icons.playlist_add_outlined),
                      label: const Text('Añadir ejercicio'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return switch (item) {
                  _WorkoutHeaderItem() => _WorkoutHeaderTile(
                    item: item,
                    onAddSerie: () {
                      ref
                          .read(activeWorkoutProvider.notifier)
                          .agregarSerie(item.ejercicio.id);
                    },
                    onGuidedSerieCompleted: (serie) async {
                      await ref
                          .read(activeWorkoutProvider.notifier)
                          .marcarSerie(serie.id, 0, 0);
                    },
                    onFeelingChanged: (feeling) {
                      ref
                          .read(activeWorkoutProvider.notifier)
                          .actualizarSensacion(item.ejercicio.id, feeling);
                    },
                  ),
                  _WorkoutSerieItem() => _WorkoutSerieTile(
                    ejercicio: item.ejercicio,
                    serie: item.serie,
                    weightController: _weightControllers[item.serie.id]!,
                    repsController: _repsControllers[item.serie.id]!,
                    onWeightChanged: (value) async {
                      final parsed = value.trim().isEmpty
                          ? 0.0
                          : double.tryParse(value.trim());
                      if (parsed == null) {
                        return;
                      }
                      await ref
                          .read(activeWorkoutProvider.notifier)
                          .actualizarSerieDraft(item.serie.id, pesoKg: parsed);
                    },
                    onRepsChanged: (value) async {
                      final parsed = value.trim().isEmpty
                          ? 0
                          : int.tryParse(value.trim());
                      if (parsed == null) {
                        return;
                      }
                      await ref
                          .read(activeWorkoutProvider.notifier)
                          .actualizarSerieDraft(
                            item.serie.id,
                            repeticiones: parsed,
                          );
                    },
                    onCompleted: () async {
                      final peso =
                          double.tryParse(
                            _weightControllers[item.serie.id]!.text.trim(),
                          ) ??
                          0;
                      final reps =
                          int.tryParse(
                            _repsControllers[item.serie.id]!.text.trim(),
                          ) ??
                          0;
                      await ref
                          .read(activeWorkoutProvider.notifier)
                          .marcarSerie(item.serie.id, peso, reps);
                    },
                  ),
                };
              },
            ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: WorkoutAudioPanel(compact: true),
            ),
            if (remaining > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _WorkoutTimerBar(
                  remaining: remaining,
                  progress: progress,
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  await ref
                      .read(activeWorkoutProvider.notifier)
                      .finalizarSesion();
                  if (!context.mounted) {
                    return;
                  }
                  context.go('/workouts');
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Finalizar Entrenamiento'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openExercisePicker() async {
    final ejercicio = await showModalBottomSheet<Ejercicio>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _ExercisePickerSheet(),
    );

    if (ejercicio == null) {
      return;
    }

    await ref
        .read(activeWorkoutProvider.notifier)
        .agregarEjercicio(ejercicio.id);
  }

  void _syncControllers(ActiveWorkoutState workout) {
    final activeIds = <int>{
      for (final group in workout.grupos)
        for (final serie in group.series) serie.id,
    };

    final weightToRemove = _weightControllers.keys
        .where((id) => !activeIds.contains(id))
        .toList(growable: false);
    for (final id in weightToRemove) {
      _weightControllers.remove(id)?.dispose();
      _repsControllers.remove(id)?.dispose();
    }

    for (final group in workout.grupos) {
      for (final serie in group.series) {
        _weightControllers.putIfAbsent(
          serie.id,
          () => TextEditingController(text: _formatWeight(serie.pesoKg)),
        );
        _repsControllers.putIfAbsent(
          serie.id,
          () => TextEditingController(text: '${serie.repeticiones}'),
        );
      }
    }
  }

  List<_WorkoutListItem> _buildItems(List<WorkoutExerciseGroup> groups) {
    final items = <_WorkoutListItem>[];
    for (final group in groups) {
      items.add(
        _WorkoutHeaderItem(group.ejercicio, group.series, group.registro),
      );
      if (_isGuidedExercise(group.ejercicio.tipoEjercicio)) {
        continue;
      }
      for (final serie in group.series) {
        items.add(_WorkoutSerieItem(group.ejercicio, serie));
      }
    }
    return items;
  }

  String _formatWeight(double value) {
    if (value == 0) {
      return '';
    }
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  void _syncWakelock(bool shouldEnable) {
    if (_wakelockEnabled == shouldEnable) {
      return;
    }

    _wakelockEnabled = shouldEnable;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (shouldEnable) {
        WakelockPlus.enable();
      } else {
        WakelockPlus.disable();
      }
    });
  }

  bool _isGuidedExercise(TipoEjercicio tipoEjercicio) {
    return tipoEjercicio == TipoEjercicio.movilidad ||
        tipoEjercicio == TipoEjercicio.estiramiento;
  }
}

sealed class _WorkoutListItem {
  const _WorkoutListItem();
}

class _WorkoutHeaderItem extends _WorkoutListItem {
  const _WorkoutHeaderItem(this.ejercicio, this.series, this.registro);

  final Ejercicio ejercicio;
  final List<Serie> series;
  final RegistroEjercicioSesion registro;
}

class _WorkoutSerieItem extends _WorkoutListItem {
  const _WorkoutSerieItem(this.ejercicio, this.serie);

  final Ejercicio ejercicio;
  final Serie serie;
}

class _WorkoutHeaderTile extends StatelessWidget {
  const _WorkoutHeaderTile({
    required this.item,
    required this.onAddSerie,
    required this.onGuidedSerieCompleted,
    required this.onFeelingChanged,
  });

  final _WorkoutHeaderItem item;
  final VoidCallback onAddSerie;
  final Future<void> Function(Serie serie) onGuidedSerieCompleted;
  final ValueChanged<SensacionEjercicio> onFeelingChanged;

  @override
  Widget build(BuildContext context) {
    final completed = item.series.where((serie) => serie.completada).length;
    final isGuided = _isGuidedExercise(item.ejercicio.tipoEjercicio);

    if (isGuided) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Text(
              item.ejercicio.nombre,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${item.ejercicio.grupoMuscular} · ${_tipoEjercicioLabel(item.ejercicio.tipoEjercicio)} · $completed/${item.series.length} repeticiones completadas',
              ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.ejercicio.descripcionBreve?.trim().isNotEmpty == true
                      ? item.ejercicio.descripcionBreve!
                      : 'Ejercicio guiado para preparar o soltar la zona trabajada.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.series.length == 1
                      ? 'Repetir 1 vez'
                      : 'Repetir ${item.series.length} veces',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var index = 0; index < item.series.length; index++)
                    FilterChip(
                      selected: item.series[index].completada,
                      label: Text('Vez ${index + 1}'),
                      avatar: Icon(
                        item.series[index].completada
                            ? Icons.check_circle_outline
                            : Icons.fitness_center_outlined,
                        size: 18,
                      ),
                      onSelected: item.series[index].completada
                          ? null
                          : (_) => onGuidedSerieCompleted(item.series[index]),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.ejercicio.nombre,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.ejercicio.grupoMuscular} · ${_tipoEjercicioLabel(item.ejercicio.tipoEjercicio)} · $completed/${item.series.length} series completas',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: onAddSerie,
                    icon: const Icon(Icons.add),
                    label: const Text('Serie'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _FeelingSelector(
                value: item.registro.sensacion,
                onChanged: onFeelingChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _tipoEjercicioLabel(TipoEjercicio tipoEjercicio) {
    return switch (tipoEjercicio) {
      TipoEjercicio.movilidad => 'movilidad',
      TipoEjercicio.fuerza => 'fuerza',
      TipoEjercicio.estiramiento => 'estiramiento',
    };
  }

  static bool _isGuidedExercise(TipoEjercicio tipoEjercicio) {
    return tipoEjercicio == TipoEjercicio.movilidad ||
        tipoEjercicio == TipoEjercicio.estiramiento;
  }
}

class _FeelingSelector extends StatelessWidget {
  const _FeelingSelector({required this.value, required this.onChanged});

  final SensacionEjercicio value;
  final ValueChanged<SensacionEjercicio> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cómo te has sentido hoy',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final entry in _feelingEntries)
              ChoiceChip(
                selected: value == entry.feeling,
                onSelected: (_) => onChanged(entry.feeling),
                avatar: Icon(entry.icon, size: 18),
                label: Text(entry.label),
              ),
          ],
        ),
      ],
    );
  }
}

const _feelingEntries = <_FeelingEntry>[
  _FeelingEntry(
    feeling: SensacionEjercicio.muyMala,
    label: 'Muy mala',
    icon: Icons.sentiment_very_dissatisfied_outlined,
  ),
  _FeelingEntry(
    feeling: SensacionEjercicio.mala,
    label: 'Mala',
    icon: Icons.sentiment_dissatisfied_outlined,
  ),
  _FeelingEntry(
    feeling: SensacionEjercicio.normal,
    label: 'Normal',
    icon: Icons.sentiment_neutral_outlined,
  ),
  _FeelingEntry(
    feeling: SensacionEjercicio.buena,
    label: 'Buena',
    icon: Icons.sentiment_satisfied_alt_outlined,
  ),
  _FeelingEntry(
    feeling: SensacionEjercicio.excelente,
    label: 'Excelente',
    icon: Icons.sentiment_very_satisfied_outlined,
  ),
];

class _FeelingEntry {
  const _FeelingEntry({
    required this.feeling,
    required this.label,
    required this.icon,
  });

  final SensacionEjercicio feeling;
  final String label;
  final IconData icon;
}

class _WorkoutSerieTile extends StatelessWidget {
  const _WorkoutSerieTile({
    required this.ejercicio,
    required this.serie,
    required this.weightController,
    required this.repsController,
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onCompleted,
  });

  final Ejercicio ejercicio;
  final Serie serie;
  final TextEditingController weightController;
  final TextEditingController repsController;
  final ValueChanged<String> onWeightChanged;
  final ValueChanged<String> onRepsChanged;
  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 52,
                child: Text(
                  'Serie',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: weightController,
                  enabled: !serie.completada,
                  onChanged: onWeightChanged,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Kg',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: repsController,
                  enabled: !serie.completada,
                  onChanged: onRepsChanged,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Reps',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Transform.scale(
                scale: 1.35,
                child: Checkbox(
                  value: serie.completada,
                  semanticLabel:
                      ejercicio.tipoEjercicio == TipoEjercicio.movilidad
                      ? 'Completar serie de movilidad con descanso corto'
                      : 'Completar serie',
                  onChanged: serie.completada
                      ? null
                      : (value) async {
                          if (value != true) {
                            return;
                          }
                          await onCompleted();
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutTimerBar extends StatelessWidget {
  const _WorkoutTimerBar({required this.remaining, required this.progress});

  final int remaining;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SizedBox(
            height: 72,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 72,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHigh,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descanso en curso',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '$minutes:$seconds',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExercisePickerSheet extends ConsumerStatefulWidget {
  const _ExercisePickerSheet();

  @override
  ConsumerState<_ExercisePickerSheet> createState() =>
      _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends ConsumerState<_ExercisePickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(workoutExercisesProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar ejercicio',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) =>
                  setState(() => _query = value.trim().toLowerCase()),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: exercisesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) =>
                    const Center(child: Text('Error al cargar ejercicios')),
                data: (items) {
                  final filtered = items
                      .where((exercise) {
                        if (_query.isEmpty) {
                          return true;
                        }
                        return exercise.nombre.toLowerCase().contains(_query) ||
                            exercise.grupoMuscular.toLowerCase().contains(
                              _query,
                            );
                      })
                      .toList(growable: false);

                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text('No hay ejercicios para ese filtro'),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final exercise = filtered[index];
                      return ListTile(
                        title: Text(exercise.nombre),
                        subtitle: Text(
                          '${exercise.grupoMuscular} · ${_WorkoutHeaderTile._tipoEjercicioLabel(exercise.tipoEjercicio)} · descanso base ${exercise.tiempoDescansoBaseSegundos}s',
                        ),
                        onTap: () => Navigator.of(context).pop(exercise),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
