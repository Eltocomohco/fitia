import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/checkin_animo.dart';
import '../../data/models/tarea_hoy.dart';
import '../../../tracking/presentation/providers/water_intake_provider.dart';
import '../providers/daily_macros_provider.dart';
import '../providers/metabolic_adjustment_provider.dart';
import '../providers/today_hub_provider.dart';
import '../widgets/health_connect_card.dart';
import '../../../workouts/presentation/providers/audio_library_provider.dart';
import '../../../workouts/presentation/providers/audio_provider.dart';

/// Pantalla principal con resumen diario de nutrición y comidas registradas.
class DashboardScreen extends ConsumerWidget {
  /// Crea un [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final macrosAsync = ref.watch(dailyMacrosProvider);
    final waterAsync = ref.watch(waterIntakeProvider);
    final todayHubAsync = ref.watch(todayHubProvider);
    final audioState = ref.watch(workoutAudioProvider);
    final audioLibraryAsync = ref.watch(audioLibraryProvider);
    final metabolicSuggestion = ref.watch(
      metabolicAdjustmentSuggestionProvider,
    );
    final theme = Theme.of(context);
    final now = DateTime.now();
    final formattedDate =
        '${_weekdayLabel(now.weekday)}, ${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/${now.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoy'),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Reproductor',
            onPressed: () => context.push('/player'),
            icon: const Icon(Icons.library_music_outlined),
          ),
          IconButton(
            tooltip: 'Perfil y ajustes',
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${_weekdayLabel(now.weekday)} · Macros',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(formattedDate, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          if (metabolicSuggestion != null) ...[
            _MetabolicAlertCard(suggestion: metabolicSuggestion),
            const SizedBox(height: 12),
          ],
          const _TodayQuickActions(),
          const SizedBox(height: 16),
          todayHubAsync.when(
            loading: () => const _TodayHubLoadingCard(),
            error: (_, _) => const _InlineErrorCard(
              message: 'No se pudo cargar el foco diario.',
            ),
            data: (snapshot) {
              final playlistCount =
                  audioLibraryAsync.asData?.value.playlists.length ?? 0;
              return Column(
                children: [
                  _TodayPulseCard(
                    pendingTasks: snapshot.pendingTaskCount,
                    completedTasks: snapshot.completedTaskCount,
                    completedWorkouts: snapshot.completedWorkoutCount,
                    hasActiveWorkout: snapshot.hasActiveWorkout,
                    playlistCount: playlistCount,
                    audioTitle: audioState.title,
                    isAudioPlaying: audioState.isPlaying,
                  ),
                  const SizedBox(height: 12),
                  _TodayTasksCard(
                    tasks: snapshot.tasks,
                    pendingTasks: snapshot.pendingTaskCount,
                    completedTasks: snapshot.completedTaskCount,
                    onAddTask: () => _showAddTaskDialog(context, ref),
                    onToggleTask: (taskId) => ref
                        .read(todayHubProvider.notifier)
                        .toggleTask(taskId),
                    onDeleteTask: (taskId) => ref
                        .read(todayHubProvider.notifier)
                        .deleteTask(taskId),
                  ),
                  const SizedBox(height: 12),
                  _MoodCheckInCard(
                    latestCheckIn: snapshot.latestCheckIn,
                    onOpenCheckIn: () =>
                        _showMoodCheckInDialog(context, ref, snapshot.latestCheckIn),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          macrosAsync.when(
            loading: () => const _DashboardLoadingSkeleton(),
            error: (_, _) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('Error al cargar datos')),
            ),
            data: (macros) {
              final kcalProgress = _safeProgress(
                macros.kcalConsumidas,
                macros.kcalObjetivo,
              );
              final proteinasProgress = _safeProgress(
                macros.proteinasGramos,
                macros.proteinasObjetivo,
              );
              final carbohidratosProgress = _safeProgress(
                macros.carbohidratosGramos,
                macros.carbohidratosObjetivo,
              );
              final grasasProgress = _safeProgress(
                macros.grasasGramos,
                macros.grasasObjetivo,
              );
              final waterMl =
                  waterAsync.asData?.value
                      .fold<int>(0, (sum, item) => sum + item.mililitros)
                      .toDouble() ??
                  0;
              final waterGoal = macros.aguaObjetivoMl;
              final waterProgress = _safeProgress(waterMl, waterGoal);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumen diario de macronutrientes',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.82,
                    children: [
                      _MacroIndicator(
                        label: 'Calorías',
                        value: macros.kcalConsumidas,
                        objective: macros.kcalObjetivo,
                        unit: 'kcal',
                        progress: kcalProgress,
                        color: theme.colorScheme.primary,
                      ),
                      _MacroIndicator(
                        label: 'Proteínas',
                        value: macros.proteinasGramos,
                        objective: macros.proteinasObjetivo,
                        unit: 'g',
                        progress: proteinasProgress,
                        color: theme.colorScheme.secondary,
                      ),
                      _MacroIndicator(
                        label: 'Carbohidratos',
                        value: macros.carbohidratosGramos,
                        objective: macros.carbohidratosObjetivo,
                        unit: 'g',
                        progress: carbohidratosProgress,
                        color: theme.colorScheme.tertiary,
                      ),
                      _MacroIndicator(
                        label: 'Grasas',
                        value: macros.grasasGramos,
                        objective: macros.grasasObjetivo,
                        unit: 'g',
                        progress: grasasProgress,
                        color: theme.colorScheme.error,
                      ),
                      _MacroIndicator(
                        label: 'Agua',
                        value: waterMl,
                        objective: waterGoal,
                        unit: 'ml',
                        progress: waterProgress,
                        color: Colors.lightBlue,
                      ),
                      _WaterQuickAddCard(
                        onAdd: (ml) async {
                          await ref
                              .read(waterIntakeProvider.notifier)
                              .addIntake(ml);
                        },
                        onClearToday: () async {
                          await ref
                              .read(waterIntakeProvider.notifier)
                              .clearToday();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const HealthConnectCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MacroIndicator extends StatelessWidget {
  const _MacroIndicator({
    required this.label,
    required this.value,
    required this.objective,
    required this.unit,
    required this.progress,
    required this.color,
  });

  final String label;
  final double value;
  final double objective;
  final String unit;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = _rawPercent(value, objective);
    final cardColor = color.withValues(alpha: 0.85);
    final textColor = Colors.white;

    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 68,
              width: 68,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    color: Colors.white,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                  ),
                  Center(
                    child: FittedBox(
                      child: Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                '${value.toStringAsFixed(0)} $unit',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            FittedBox(
              child: Text(
                'Meta ${objective.toStringAsFixed(0)} $unit',
                style: theme.textTheme.bodySmall?.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: 0.2, end: 0);
  }
}

class _WaterQuickAddCard extends StatelessWidget {
  const _WaterQuickAddCard({required this.onAdd, required this.onClearToday});

  final Future<void> Function(int ml) onAdd;
  final Future<void> Function() onClearToday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Añadir agua', style: theme.textTheme.titleSmall),
                ),
                IconButton(
                  onPressed: onClearToday,
                  icon: const Icon(Icons.delete_sweep_outlined),
                  iconSize: 20,
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Vaciar agua de hoy',
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: _WaterQuickButton(
                    label: '200 ml',
                    onTap: () => onAdd(200),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _WaterQuickButton(
                    label: '400 ml',
                    onTap: () => onAdd(400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: _WaterQuickButton(
                    label: '500 ml',
                    onTap: () => onAdd(500),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _WaterQuickButton(
                    label: '1L',
                    onTap: () => onAdd(1000),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardLoadingSkeleton extends StatelessWidget {
  const _DashboardLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
              height: 22,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1100.ms),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.82,
          children: List.generate(6, (_) {
            return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1300.ms);
          }),
        ),
      ],
    );
  }
}

class _TodayQuickActions extends StatelessWidget {
  const _TodayQuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ahora mismo', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _QuickActionTile(
              label: 'Comida',
              subtitle: 'Plan y diario',
              icon: Icons.restaurant_menu_outlined,
              route: '/food',
            ),
            _QuickActionTile(
              label: 'Entreno',
              subtitle: 'Rutinas y sesion',
              icon: Icons.sports_gymnastics_outlined,
              route: '/training',
            ),
            _QuickActionTile(
              label: 'Boss',
              subtitle: 'Decide que toca',
              icon: Icons.smart_toy_outlined,
              route: '/ai-chat?agent=boss',
            ),
            _QuickActionTile(
              label: 'Musica',
              subtitle: 'Abrir player',
              icon: Icons.library_music_outlined,
              route: '/player',
            ),
            _QuickActionTile(
              label: 'Tareas',
              subtitle: 'Plan de ejecucion',
              icon: Icons.checklist_outlined,
              route: '/tasks',
            ),
            _QuickActionTile(
              label: 'Mente',
              subtitle: 'Check-in y energia',
              icon: Icons.self_improvement_outlined,
              route: '/mental-checkin',
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.push(route),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 12),
              Text(label, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayPulseCard extends StatelessWidget {
  const _TodayPulseCard({
    required this.pendingTasks,
    required this.completedTasks,
    required this.completedWorkouts,
    required this.hasActiveWorkout,
    required this.playlistCount,
    required this.audioTitle,
    required this.isAudioPlaying,
  });

  final int pendingTasks;
  final int completedTasks;
  final int completedWorkouts;
  final bool hasActiveWorkout;
  final int playlistCount;
  final String audioTitle;
  final bool isAudioPlaying;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pulso del dia', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _PulseChip(
                  label: '$pendingTasks pendientes',
                  icon: Icons.flag_outlined,
                ),
                _PulseChip(
                  label: '$completedTasks hechas',
                  icon: Icons.task_alt_outlined,
                ),
                _PulseChip(
                  label: '$completedWorkouts entrenos',
                  icon: Icons.fitness_center_outlined,
                ),
                _PulseChip(
                  label: hasActiveWorkout ? 'Sesion activa' : 'Sin sesion activa',
                  icon: hasActiveWorkout
                      ? Icons.play_circle_outline
                      : Icons.pause_circle_outline,
                ),
                _PulseChip(
                  label: '$playlistCount playlists',
                  icon: Icons.queue_music_outlined,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              isAudioPlaying ? 'Suena ahora' : 'Audio listo',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(audioTitle, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _PulseChip extends StatelessWidget {
  const _PulseChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Icon(icon, size: 18), label: Text(label));
  }
}

class _TodayTasksCard extends StatelessWidget {
  const _TodayTasksCard({
    required this.tasks,
    required this.pendingTasks,
    required this.completedTasks,
    required this.onAddTask,
    required this.onToggleTask,
    required this.onDeleteTask,
  });

  final List<TareaHoy> tasks;
  final int pendingTasks;
  final int completedTasks;
  final VoidCallback onAddTask;
  final Future<void> Function(int taskId) onToggleTask;
  final Future<void> Function(int taskId) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Foco del dia', style: theme.textTheme.titleMedium),
                ),
                FilledButton.tonalIcon(
                  onPressed: onAddTask,
                  icon: const Icon(Icons.add_task_outlined),
                  label: const Text('Nueva'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '$pendingTasks pendientes · $completedTasks completadas',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            if (tasks.isEmpty)
              const Text(
                'Todavia no has definido nada para hoy. Si quieres abrir la app mas, aqui tiene que vivir lo que no puedes olvidar.',
              )
            else
              for (final task in tasks.take(5))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: task.completada,
                    onChanged: (_) => onToggleTask(task.id),
                  ),
                  title: Text(
                    task.titulo,
                    style: task.completada
                        ? const TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  trailing: IconButton(
                    tooltip: 'Eliminar',
                    onPressed: () => onDeleteTask(task.id),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
            if (tasks.length > 5)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Hay ${tasks.length - 5} tareas mas guardadas para hoy.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MoodCheckInCard extends StatelessWidget {
  const _MoodCheckInCard({
    required this.latestCheckIn,
    required this.onOpenCheckIn,
  });

  final CheckinAnimo? latestCheckIn;
  final VoidCallback onOpenCheckIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    'Check-in mental',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: onOpenCheckIn,
                  icon: const Icon(Icons.psychology_alt_outlined),
                  label: Text(latestCheckIn == null ? 'Registrar' : 'Actualizar'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (latestCheckIn == null)
              const Text(
                'Sin registro hoy. Si quieres que Fitia sea tu app central, tambien tiene que medir como llegas al dia.',
              )
            else ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _PulseChip(
                    label: _moodLabel(latestCheckIn!.estado),
                    icon: _moodIcon(latestCheckIn!.estado),
                  ),
                  _PulseChip(
                    label: 'Energia ${latestCheckIn!.energia}/5',
                    icon: Icons.bolt_outlined,
                  ),
                ],
              ),
              if ((latestCheckIn!.nota ?? '').isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(latestCheckIn!.nota!, style: theme.textTheme.bodyMedium),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _TodayHubLoadingCard extends StatelessWidget {
  const _TodayHubLoadingCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Expanded(child: Text('Cargando foco diario...')),
          ],
        ),
      ),
    );
  }
}

class _InlineErrorCard extends StatelessWidget {
  const _InlineErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message),
      ),
    );
  }
}

class _MetabolicAlertCard extends StatelessWidget {
  const _MetabolicAlertCard({required this.suggestion});

  final dynamic suggestion;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.insights_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sugerencia metabólica',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(suggestion.message as String),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaterQuickButton extends StatelessWidget {
  const _WaterQuickButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        minimumSize: const Size(52, 52),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: FittedBox(child: Text(label, textAlign: TextAlign.center)),
    );
  }
}

double _safeProgress(double consumed, double objective) {
  if (objective <= 0) {
    return 0;
  }
  return (consumed / objective).clamp(0.0, 1.0);
}

double _rawPercent(double consumed, double objective) {
  if (objective <= 0) {
    return 0;
  }
  return (consumed / objective) * 100;
}

String _weekdayLabel(int weekday) {
  return switch (weekday) {
    DateTime.monday => 'Lunes',
    DateTime.tuesday => 'Martes',
    DateTime.wednesday => 'Miércoles',
    DateTime.thursday => 'Jueves',
    DateTime.friday => 'Viernes',
    DateTime.saturday => 'Sábado',
    DateTime.sunday => 'Domingo',
    _ => 'Día',
  };
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

Future<void> _showMoodCheckInDialog(
  BuildContext context,
  WidgetRef ref,
  CheckinAnimo? current,
) async {
  var selectedMood = current?.estado ?? EstadoAnimo.estable;
  var energy = (current?.energia ?? 3).toDouble();
  final noteController = TextEditingController(text: current?.nota ?? '');

  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Check-in de hoy'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<EstadoAnimo>(
                    initialValue: selectedMood,
                    decoration: const InputDecoration(labelText: 'Como llegas'),
                    items: EstadoAnimo.values
                        .map(
                          (mood) => DropdownMenuItem<EstadoAnimo>(
                            value: mood,
                            child: Text(_moodLabel(mood)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedMood = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Energia ${energy.round()}/5'),
                  Slider(
                    value: energy,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '${energy.round()}',
                    onChanged: (value) {
                      setState(() {
                        energy = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Nota rapida',
                      hintText: 'Que te esta drenando o que te mantiene fino',
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
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );

  if (shouldSave == true) {
    await ref.read(todayHubProvider.notifier).saveMood(
      estado: selectedMood,
      energia: energy.round(),
      note: noteController.text,
    );
  }
  noteController.dispose();
}

String _moodLabel(EstadoAnimo mood) {
  return switch (mood) {
    EstadoAnimo.hundido => 'Hundido',
    EstadoAnimo.bajo => 'Bajo',
    EstadoAnimo.estable => 'Estable',
    EstadoAnimo.bien => 'Bien',
    EstadoAnimo.fuerte => 'Fuerte',
  };
}

IconData _moodIcon(EstadoAnimo mood) {
  return switch (mood) {
    EstadoAnimo.hundido => Icons.sentiment_very_dissatisfied_outlined,
    EstadoAnimo.bajo => Icons.sentiment_dissatisfied_outlined,
    EstadoAnimo.estable => Icons.sentiment_neutral_outlined,
    EstadoAnimo.bien => Icons.sentiment_satisfied_alt_outlined,
    EstadoAnimo.fuerte => Icons.sentiment_very_satisfied_outlined,
  };
}
