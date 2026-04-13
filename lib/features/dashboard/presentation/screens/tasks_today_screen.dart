import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/tarea_hoy.dart';
import '../providers/today_hub_provider.dart';

class TasksTodayScreen extends ConsumerWidget {
  const TasksTodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayHubAsync = ref.watch(todayHubProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tareas de hoy')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context, ref),
        icon: const Icon(Icons.add_task_outlined),
        label: const Text('Nueva tarea'),
      ),
      body: todayHubAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(
          child: Text('No se pudieron cargar las tareas de hoy.'),
        ),
        data: (snapshot) {
          if (snapshot.tasks.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No hay tareas para hoy. Crea una y usa esta pantalla como tablero de ejecucion diaria.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  title: const Text('Estado del dia'),
                  subtitle: Text(
                    '${snapshot.pendingTaskCount} pendientes · ${snapshot.completedTaskCount} completadas',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...snapshot.tasks.map(
                (task) => _TaskTile(
                  task: task,
                  onToggle: () =>
                      ref.read(todayHubProvider.notifier).toggleTask(task.id),
                  onDelete: () =>
                      ref.read(todayHubProvider.notifier).deleteTask(task.id),
                ),
              ),
              const SizedBox(height: 96),
            ],
          );
        },
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final TareaHoy task;
  final Future<void> Function() onToggle;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(value: task.completada, onChanged: (_) => onToggle()),
        title: Text(
          task.titulo,
          style: task.completada
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(task.completada ? 'Completada' : 'Pendiente'),
        trailing: IconButton(
          tooltip: 'Eliminar',
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}

Future<void> _showAddTaskDialog(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Nueva tarea de hoy'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Que no se te puede escapar hoy',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );

  if (shouldSave == true) {
    await ref.read(todayHubProvider.notifier).addTask(controller.text);
  }
  controller.dispose();
}
