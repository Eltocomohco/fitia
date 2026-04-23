import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../workouts/presentation/providers/active_workout_provider.dart';
import '../../../workouts/presentation/providers/audio_provider.dart';
import '../../../workouts/presentation/providers/workout_history_provider.dart';
import '../../../workouts/data/models/sesion_entrenamiento.dart';

/// Hub rediseñado del área de entrenamiento.
/// Tabs: Hoy / Rutinas / Historial
class TrainingHubScreen extends ConsumerStatefulWidget {
  const TrainingHubScreen({super.key});

  @override
  ConsumerState<TrainingHubScreen> createState() => _TrainingHubScreenState();
}

class _TrainingHubScreenState extends ConsumerState<TrainingHubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entreno'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Hoy'),
            Tab(text: 'Rutinas'),
            Tab(text: 'Historial'),
          ],
          indicatorColor: const Color(0xFFE5C043),
          labelColor: theme.colorScheme.onSurface,
          unselectedLabelColor:
              theme.colorScheme.onSurface.withValues(alpha: 0.45),
          labelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            tooltip: 'Calendario',
            onPressed: () => context.push('/calendar'),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            tooltip: 'Perfil',
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _TodayTab(),
          _RoutinesTab(),
          _HistoryTab(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Hoy
// ─────────────────────────────────────────────────────────────────────────────

class _TodayTab extends StatelessWidget {
  const _TodayTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _StartSessionCard(),
        const SizedBox(height: 12),
        _SectionLabel(label: 'Más opciones'),
        const SizedBox(height: 8),
        _LinkCard(
          title: 'Hablar con Fiti sobre entreno',
          subtitle: 'Pregúntale por progresión, dudas o qué toca hoy',
          icon: Icons.smart_toy_outlined,
          onTap: () => context.push('/ai-chat?agent=workout'),
        ),
        _LinkCard(
          title: 'Calendario',
          subtitle: 'Revisa qué entrenos tienes planificados',
          icon: Icons.calendar_month_outlined,
          onTap: () => context.push('/calendar'),
        ),
        _LinkCard(
          title: 'Tracking corporal',
          subtitle: 'Peso, métricas y progreso físico',
          icon: Icons.monitor_weight_outlined,
          onTap: () => context.push('/body-tracking'),
        ),
      ],
    );
  }
}

// ── Tarjeta sesión activa ────────────────────────────────────────────────────

class _ActiveSessionCard extends StatelessWidget {
  const _ActiveSessionCard({required this.session});
  final SesionEntrenamiento session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.push('/workouts/active'),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF2A3441),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5C043),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'EN CURSO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2A2000),
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right,
                    color: Color(0xFFE5C043), size: 20),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Sesión activa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Iniciada a las ${_formatTime(session.fechaInicio)}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0x99FFFFFF),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE5C043),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Continuar sesión →',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2A2000),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

// ── CTA sin sesión activa ────────────────────────────────────────────────────

class _StartSessionCard extends StatelessWidget {
  const _StartSessionCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/workouts'),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF2A3441),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sin sesión activa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Elige una rutina y empieza',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE5C043),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Entrenar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2A2000),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

// ── Métricas de la semana ────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.weekCount,
    required this.monthCount,
    required this.streak,
  });
  final int weekCount;
  final int monthCount;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '$weekCount',
            label: 'Esta semana',
            icon: Icons.fitness_center_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            value: '$monthCount',
            label: 'Este mes',
            icon: Icons.calendar_today_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            value: streak > 0 ? '🔥 $streak' : '—',
            label: 'Racha días',
            icon: null,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          if (icon != null)
            Icon(icon, size: 18,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.45)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Card de audio ────────────────────────────────────────────────────────────

class _AudioCard extends StatelessWidget {
  const _AudioCard({required this.audioState});
  final WorkoutAudioState audioState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2A3441),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                audioState.isPlaying
                    ? Icons.pause_outlined
                    : Icons.play_arrow_outlined,
                color: const Color(0xFFE5C043),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audioState.isPlaying ? 'Suena ahora' : 'Audio listo',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  Text(
                    audioState.title,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18,
                color: Color(0xFFBBBBBB)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Rutinas
// ─────────────────────────────────────────────────────────────────────────────

class _RoutinesTab extends StatelessWidget {
  const _RoutinesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionLabel(label: 'Mis rutinas'),
        const SizedBox(height: 8),
        _LinkCard(
          title: 'Ver todas las rutinas',
          subtitle: 'Catálogo completo de rutinas guardadas',
          icon: Icons.fitness_center_outlined,
          onTap: () => context.push('/workouts'),
        ),
        _LinkCard(
          title: 'Nueva rutina',
          subtitle: 'Crea una rutina personalizada desde cero',
          icon: Icons.add_task_outlined,
          onTap: () => context.push('/workouts/new'),
        ),
        const SizedBox(height: 8),
        _SectionLabel(label: 'Herramientas'),
        const SizedBox(height: 8),
        _LinkCard(
          title: 'Informes',
          subtitle: 'Resumen de actividad diario, semanal y mensual',
          icon: Icons.insights_outlined,
          onTap: () => context.push('/reports'),
        ),
        _LinkCard(
          title: 'Notificaciones',
          subtitle: 'Configura recordatorios para mantener consistencia',
          icon: Icons.notifications_active_outlined,
          onTap: () => context.push('/notification-settings'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab: Historial
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutSessionHistoryProvider);

    return historyAsync.when(
      loading: () => const _TabLoadingIndicator(),
      error: (_, _) => const _InlineError(
          message: 'No se pudo cargar el historial.'),
      data: (sessions) {
        if (sessions.isEmpty) {
          return _EmptyHistoryCard(
              onStart: () => context.push('/workouts'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final session = sessions[i];
            return _HistorySessionCard(
              session: session,
              onTap: () => context
                  .push('/workouts/history/${session.sessionId}'),
            );
          },
        );
      },
    );
  }
}

class _HistorySessionCard extends StatelessWidget {
  const _HistorySessionCard(
      {required this.session, required this.onTap});
  final WorkoutSessionHistoryItem session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration =
        session.finishedAt.difference(session.startedAt);
    final minutes = duration.inMinutes;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fecha
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  Text(
                    '${session.startedAt.day}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _shortMonth(session.startedAt.month),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(session.routineName,
                      style: theme.textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      _MiniChip(label: '$minutes min'),
                      _MiniChip(
                          label:
                              '${session.totalExercises} ejercicios'),
                      _MiniChip(
                          label:
                              '${session.totalCompletedSeries} series'),
                      if (session.totalTonnageKg > 0)
                        _MiniChip(
                            label:
                                '${session.totalTonnageKg.toStringAsFixed(0)} kg'),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 18, color: Color(0xFFBBBBBB)),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 250.ms);
  }

  String _shortMonth(int month) => switch (month) {
        1 => 'ene',
        2 => 'feb',
        3 => 'mar',
        4 => 'abr',
        5 => 'may',
        6 => 'jun',
        7 => 'jul',
        8 => 'ago',
        9 => 'sep',
        10 => 'oct',
        11 => 'nov',
        12 => 'dic',
        _ => '---',
      };
}

class _EmptyHistoryCard extends StatelessWidget {
  const _EmptyHistoryCard({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center_outlined,
                size: 48,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.2)),
            const SizedBox(height: 16),
            Text(
              'Sin sesiones completadas',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow_rounded, size: 16),
              label: const Text('Empezar primer entreno'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets compartidos
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context)
            .colorScheme
            .onSurface
            .withValues(alpha: 0.55),
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  const _LinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style:
                            Theme.of(context).textTheme.titleSmall),
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  size: 18, color: Color(0xFFBBBBBB)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onSurface
            .withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: 0.65),
        ),
      ),
    );
  }
}

class _TabLoadingIndicator extends StatelessWidget {
  const _TabLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            )),
      ),
    );
  }
}