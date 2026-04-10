import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/active_workout_provider.dart';
import '../providers/workout_catalog_provider.dart';

/// Catálogo principal de rutinas y punto de entrada al módulo Workouts.
class WorkoutCatalogScreen extends ConsumerWidget {
  /// Crea un [WorkoutCatalogScreen].
  const WorkoutCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(workoutCatalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            tooltip: 'Historial',
            onPressed: () => context.push('/workouts/history'),
            icon: const Icon(Icons.history_outlined),
          ),
          IconButton(
            tooltip: 'Nueva rutina',
            onPressed: () => context.push('/workouts/new'),
            icon: const Icon(Icons.add_task_outlined),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref
              .read(activeWorkoutProvider.notifier)
              .iniciarEntrenamientoVacio();
          if (!context.mounted) {
            return;
          }
          context.push('/workouts/active');
        },
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('Iniciar Entrenamiento Vacío'),
      ),
      body: routinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Error al cargar rutinas')),
        data: (routines) {
          if (routines.isEmpty) {
            return const _WorkoutCatalogEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 104),
            itemCount: routines.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = routines[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  onTap: () => context.push('/workouts/routine/${item.rutina.id}'),
                  leading: const CircleAvatar(
                    child: Icon(Icons.sports_gymnastics_outlined),
                  ),
                  title: Text(item.rutina.nombre),
                  subtitle: Text(
                    '${item.totalEjercicios} ejercicios · ${item.totalSesionesCompletadas} sesiones',
                  ),
                  trailing: FilledButton.icon(
                    onPressed: () async {
                      await ref
                          .read(activeWorkoutProvider.notifier)
                          .iniciarDesdeRutina(item.rutina.id);
                      if (!context.mounted) {
                        return;
                      }
                      context.push('/workouts/active');
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Entrenar'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _WorkoutCatalogEmptyState extends StatelessWidget {
  const _WorkoutCatalogEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_gymnastics_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'No hay rutinas guardadas todavía',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Puedes arrancar un entrenamiento vacío desde el botón flotante y construir la sesión sobre la marcha.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}