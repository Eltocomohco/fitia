import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/ejercicio.dart';
import '../providers/workout_routine_provider.dart';

/// Pantalla para crear o editar una rutina con nombre y ejercicios ordenados.
class WorkoutRoutineEditorScreen extends ConsumerStatefulWidget {
  /// Crea un [WorkoutRoutineEditorScreen].
  const WorkoutRoutineEditorScreen({
    super.key,
    this.routineId,
  });

  /// Identificador de la rutina a editar, si existe.
  final int? routineId;

  @override
  ConsumerState<WorkoutRoutineEditorScreen> createState() =>
      _WorkoutRoutineEditorScreenState();
}

class _WorkoutRoutineEditorScreenState
    extends ConsumerState<WorkoutRoutineEditorScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _initialized = false;
  List<WorkoutRoutineDraftExercise> _selectedExercises = const [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataAsync = ref.watch(workoutRoutineEditorDataProvider(widget.routineId));
    final saveState = ref.watch(workoutRoutineControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routineId == null ? 'Nueva rutina' : 'Editar rutina'),
      ),
      body: dataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No se pudo cargar la rutina')),
        data: (data) {
          _bootstrap(data);

          return ReorderableListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            buildDefaultDragHandles: false,
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la rutina',
                    hintText: 'Ejemplo: Pecho y espalda',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Ejercicios de la rutina',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _pickExercise(data.availableExercises),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('Añadir'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
            onReorder: _selectedExercises.length < 2 ? (_, __) {} : _onReorder,
            children: [
              if (_selectedExercises.isEmpty)
                const Card(
                  key: ValueKey('empty-routine-state'),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Añade los ejercicios que quieras ejecutar en esta rutina. Podrás iniciarla luego desde el catálogo.',
                    ),
                  ),
                )
              else
                for (final entry in _selectedExercises.asMap().entries)
                  _RoutineExerciseCard(
                    key: ValueKey(entry.value.exercise.id),
                    index: entry.key,
                    draft: entry.value,
                    onRemove: () => _removeExercise(entry.key),
                    onChanged: (draft) => _updateDraft(entry.key, draft),
                  ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: FilledButton.icon(
          onPressed: saveState.isLoading ? null : _saveRoutine,
          icon: saveState.isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save_outlined),
          label: Text(widget.routineId == null ? 'Crear rutina' : 'Guardar cambios'),
        ),
      ),
    );
  }

  void _bootstrap(WorkoutRoutineEditorData data) {
    if (_initialized) {
      return;
    }

    _initialized = true;
    _nameController.text = data.routine?.nombre ?? '';
    _selectedExercises = [...data.selectedExercises];
  }

  Future<void> _pickExercise(List<Ejercicio> exercises) async {
    final exercise = await showModalBottomSheet<Ejercicio>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _RoutineExercisePickerSheet(exercises: exercises),
    );

    if (exercise == null) {
      return;
    }

    if (_selectedExercises.any((item) => item.exercise.id == exercise.id)) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese ejercicio ya forma parte de la rutina.')),
      );
      return;
    }

    setState(() {
      _selectedExercises = [
        ..._selectedExercises,
        WorkoutRoutineDraftExercise(exercise: exercise),
      ];
    });
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final updated = [..._selectedExercises];
    final item = updated.removeAt(oldIndex);
    updated.insert(targetIndex, item);
    setState(() {
      _selectedExercises = updated;
    });

    final routineId = widget.routineId;
    if (routineId == null) {
      return;
    }

    await ref
        .read(workoutRoutineControllerProvider.notifier)
        .reorderRoutineExercises(routineId: routineId, exercises: updated);
  }

  void _removeExercise(int index) {
    final updated = [..._selectedExercises]..removeAt(index);
    setState(() {
      _selectedExercises = updated;
    });
  }

  Future<void> _saveRoutine() async {
    final savedId = await ref.read(workoutRoutineControllerProvider.notifier).saveRoutine(
          routineId: widget.routineId,
          name: _nameController.text,
          exercises: _selectedExercises,
        );

    if (!mounted) {
      return;
    }

    final state = ref.read(workoutRoutineControllerProvider);
    if (state.hasError) {
      final error = state.error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ArgumentError
                ? error.message.toString()
                : 'No se pudo guardar la rutina.',
          ),
        ),
      );
      return;
    }

    if (savedId == null) {
      return;
    }

    context.go('/workouts/routine/$savedId');
  }

  void _updateDraft(int index, WorkoutRoutineDraftExercise draft) {
    final updated = [..._selectedExercises];
    updated[index] = draft;
    setState(() {
      _selectedExercises = updated;
    });
  }
}

class _RoutineExerciseCard extends StatelessWidget {
  const _RoutineExerciseCard({
    required super.key,
    required this.index,
    required this.draft,
    required this.onRemove,
    required this.onChanged,
  });

  final int index;
  final WorkoutRoutineDraftExercise draft;
  final VoidCallback onRemove;
  final ValueChanged<WorkoutRoutineDraftExercise> onChanged;

  @override
  Widget build(BuildContext context) {
    final exercise = draft.exercise;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text('${index + 1}')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.nombre,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(exercise.grupoMuscular),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          tooltip: 'Eliminar',
                          onPressed: onRemove,
                          icon: const Icon(Icons.delete_outline),
                        ),
                        ReorderableDragStartListener(
                          index: index,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.drag_handle_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '${draft.targetSets}',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Series objetivo',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => onChanged(
                        draft.copyWith(
                          targetSets: int.tryParse(value.trim()) ?? draft.targetSets,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: draft.targetWeightKg == null
                          ? ''
                          : _formatCardWeight(draft.targetWeightKg!),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Peso objetivo',
                        suffixText: 'kg',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => onChanged(
                        draft.copyWith(
                          targetWeightKg: double.tryParse(
                            value.trim().replaceAll(',', '.'),
                          ),
                          clearTargetWeightKg: value.trim().isEmpty,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: draft.targetRepsMin?.toString() ?? '',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Reps mín.',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => onChanged(
                        draft.copyWith(
                          targetRepsMin: int.tryParse(value.trim()),
                          clearTargetRepsMin: value.trim().isEmpty,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: draft.targetRepsMax?.toString() ?? '',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Reps máx.',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => onChanged(
                        draft.copyWith(
                          targetRepsMax: int.tryParse(value.trim()),
                          clearTargetRepsMax: value.trim().isEmpty,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatCardWeight(double value) {
  return value.truncateToDouble() == value
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}

class _RoutineExercisePickerSheet extends StatefulWidget {
  const _RoutineExercisePickerSheet({required this.exercises});

  final List<Ejercicio> exercises;

  @override
  State<_RoutineExercisePickerSheet> createState() =>
      _RoutineExercisePickerSheetState();
}

class _RoutineExercisePickerSheetState extends State<_RoutineExercisePickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.exercises.where((exercise) {
      if (_query.isEmpty) {
        return true;
      }
      return exercise.nombre.toLowerCase().contains(_query) ||
          exercise.grupoMuscular.toLowerCase().contains(_query);
    }).toList(growable: false);

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
              onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: filtered.isEmpty
                  ? const Center(child: Text('No hay ejercicios para ese filtro'))
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final exercise = filtered[index];
                        return ListTile(
                          title: Text(exercise.nombre),
                          subtitle: Text(exercise.grupoMuscular),
                          onTap: () => Navigator.of(context).pop(exercise),
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