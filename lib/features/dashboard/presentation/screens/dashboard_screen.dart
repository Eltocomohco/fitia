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

/// Índice de la pestaña interna del Dashboard.
enum _DashTab { macros, tareas, mente }

/// Pantalla principal rediseñada: hero de calorías + pestañas internas.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  _DashTab _activeTab = _DashTab.macros;

  @override
  Widget build(BuildContext context) {
    final macrosAsync = ref.watch(dailyMacrosProvider);
    final waterAsync = ref.watch(waterIntakeProvider);
    final todayHubAsync = ref.watch(todayHubProvider);
    final metabolicSuggestion = ref.watch(metabolicAdjustmentSuggestionProvider);
    final theme = Theme.of(context);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buenos días',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${_weekdayLabel(now.weekday)} ${now.day} · Semana ${_weekNumber(now)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
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
        padding: EdgeInsets.zero,
        children: [
          // ── Alerta metabólica ─────────────────────────────────────────
          if (metabolicSuggestion != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _MetabolicAlertCard(suggestion: metabolicSuggestion),
            ),

          // ── Hero de calorías ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: macrosAsync.when(
              loading: () => const _HeroSkeleton(),
              error: (_, _) => const SizedBox.shrink(),
              data: (macros) => _CaloriesHeroCard(macros: macros),
            ),
          ),

          // ── Pestañas internas ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: _InternalTabBar(
              active: _activeTab,
              todayHubAsync: todayHubAsync,
              onChanged: (tab) => setState(() => _activeTab = tab),
            ),
          ),

          const SizedBox(height: 12),

          // ── Contenido según pestaña ───────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: switch (_activeTab) {
              _DashTab.macros => _MacrosTab(
                  key: const ValueKey('macros'),
                  macrosAsync: macrosAsync,
                  waterAsync: waterAsync,
                ),
              _DashTab.tareas => _TareasTab(
                  key: const ValueKey('tareas'),
                  todayHubAsync: todayHubAsync,
                ),
              _DashTab.mente => _MenteTab(
                  key: const ValueKey('mente'),
                  todayHubAsync: todayHubAsync,
                ),
            },
          ),

          // ── Accesos rápidos ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: const _QuickActions(),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hero card de calorías
// ─────────────────────────────────────────────────────────────────────────────

class _CaloriesHeroCard extends StatelessWidget {
  const _CaloriesHeroCard({required this.macros});

  final DailyMacrosState macros;

  @override
  Widget build(BuildContext context) {
    final consumed = macros.kcalConsumidas;
    final goal = macros.kcalObjetivo;
    final remaining = (goal - consumed).clamp(0.0, double.infinity);
    final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;
    final pct = goal > 0 ? ((consumed / goal) * 100).clamp(0, 999) : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE5C043),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CALORÍAS HOY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF7A6200),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                consumed.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2A2000),
                  height: 1,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '/ ${goal.toStringAsFixed(0)} kcal',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7A6200),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Quedan ${remaining.toStringAsFixed(0)} kcal · ${pct.toStringAsFixed(0)}% completado',
            style: const TextStyle(fontSize: 12, color: Color(0xFF7A6200)),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0x33000000),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF2A2000)),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1, end: 0);
  }
}

class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Barra de pestañas interna
// ─────────────────────────────────────────────────────────────────────────────

class _InternalTabBar extends StatelessWidget {
  const _InternalTabBar({
    required this.active,
    required this.todayHubAsync,
    required this.onChanged,
  });

  final _DashTab active;
  final AsyncValue<TodayHubSnapshot> todayHubAsync;
  final ValueChanged<_DashTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final pending = todayHubAsync.asData?.value.pendingTaskCount ?? 0;
    final checkIn = todayHubAsync.asData?.value.latestCheckIn;

    return Row(
      children: [
        _TabPill(
          label: 'Macros',
          active: active == _DashTab.macros,
          onTap: () => onChanged(_DashTab.macros),
        ),
        const SizedBox(width: 8),
        _TabPill(
          label: 'Tareas',
          badge: pending > 0 ? '$pending' : null,
          active: active == _DashTab.tareas,
          onTap: () => onChanged(_DashTab.tareas),
        ),
        const SizedBox(width: 8),
        _TabPill(
          label: 'Mente',
          badge: checkIn == null ? '!' : null,
          active: active == _DashTab.mente,
          onTap: () => onChanged(_DashTab.mente),
        ),
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.active,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? theme.colorScheme.onSurface
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: active
                    ? const Color(0xFFE5C043)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFE5C043)
                      : theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  badge!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: active ? const Color(0xFF2A2000) : Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pestaña: Macros
// ─────────────────────────────────────────────────────────────────────────────

class _MacrosTab extends ConsumerWidget {
  const _MacrosTab({
    super.key,
    required this.macrosAsync,
    required this.waterAsync,
  });

  final AsyncValue<DailyMacrosState> macrosAsync;
  final AsyncValue<List<dynamic>> waterAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: macrosAsync.when(
        loading: () => const _MacrosSkeleton(),
        error: (_, _) =>
            const _InlineError(message: 'Error al cargar macros'),
        data: (macros) {
          final waterMl = waterAsync.asData?.value
                  .fold<int>(
                      0, (sum, item) => sum + (item.mililitros as int))
                  .toDouble() ??
              0;

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _MacroMiniCard(
                      label: 'Proteína',
                      value: macros.proteinasGramos,
                      goal: macros.proteinasObjetivo,
                      unit: 'g',
                      color: const Color(0xFF7F77DD),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MacroMiniCard(
                      label: 'Carbos',
                      value: macros.carbohidratosGramos,
                      goal: macros.carbohidratosObjetivo,
                      unit: 'g',
                      color: const Color(0xFF5DCAA5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MacroMiniCard(
                      label: 'Grasas',
                      value: macros.grasasGramos,
                      goal: macros.grasasObjetivo,
                      unit: 'g',
                      color: const Color(0xFFD85A30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _WaterCard(
                waterMl: waterMl,
                goalMl: macros.aguaObjetivoMl,
                onAdd: (ml) =>
                    ref.read(waterIntakeProvider.notifier).addIntake(ml),
                onClear: () =>
                    ref.read(waterIntakeProvider.notifier).clearToday(),
              ),
              const SizedBox(height: 12),
              const HealthConnectCard(),
              const SizedBox(height: 4),
            ],
          );
        },
      ),
    );
  }
}

class _MacroMiniCard extends StatelessWidget {
  const _MacroMiniCard({
    required this.label,
    required this.value,
    required this.goal,
    required this.unit,
    required this.color,
  });

  final String label;
  final double value;
  final double goal;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = goal > 0 ? (value / goal).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${value.toStringAsFixed(0)}$unit',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            'de ${goal.toStringAsFixed(0)}$unit',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.45),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: color.withValues(alpha: 0.18),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.15, end: 0);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de agua con gotitas
// ─────────────────────────────────────────────────────────────────────────────

class _WaterCard extends StatelessWidget {
  const _WaterCard({
    required this.waterMl,
    required this.goalMl,
    required this.onAdd,
    required this.onClear,
  });

  final double waterMl;
  final double goalMl;
  final Future<void> Function(int ml) onAdd;
  final Future<void> Function() onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filledDrops =
        goalMl > 0 ? ((waterMl / goalMl) * 10).round().clamp(0, 10) : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F4FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.water_drop_outlined,
                  size: 18, color: Color(0xFF1A5080)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Agua — ${(waterMl / 1000).toStringAsFixed(1)} L de ${(goalMl / 1000).toStringAsFixed(1)} L',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF1A5080),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.delete_sweep_outlined,
                    size: 18, color: Color(0xFF5A9EC0)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(10, (i) {
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _Drop(filled: i < filledDrops),
              );
            }),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _WaterBtn(label: '200 ml', onTap: () => onAdd(200)),
              const SizedBox(width: 8),
              _WaterBtn(label: '400 ml', onTap: () => onAdd(400)),
              const SizedBox(width: 8),
              _WaterBtn(label: '500 ml', onTap: () => onAdd(500)),
              const SizedBox(width: 8),
              _WaterBtn(label: '1 L', onTap: () => onAdd(1000)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Drop extends StatelessWidget {
  const _Drop({required this.filled});
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(18, 24),
      painter: _DropPainter(filled: filled),
    );
  }
}

class _DropPainter extends CustomPainter {
  const _DropPainter({required this.filled});
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          filled ? const Color(0xFF378ADD) : const Color(0x33378ADD)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w / 2, 0)
      ..cubicTo(w * 0.1, h * 0.35, 0, h * 0.6, 0, h * 0.72)
      ..arcToPoint(Offset(w, h * 0.72),
          radius: Radius.circular(w), clockwise: false)
      ..cubicTo(w, h * 0.6, w * 0.9, h * 0.35, w / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DropPainter old) => old.filled != filled;
}

class _WaterBtn extends StatelessWidget {
  const _WaterBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF378ADD).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A5080),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pestaña: Tareas
// ─────────────────────────────────────────────────────────────────────────────

class _TareasTab extends ConsumerWidget {
  const _TareasTab({super.key, required this.todayHubAsync});

  final AsyncValue<TodayHubSnapshot> todayHubAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: todayHubAsync.when(
        loading: () => const _CardSkeleton(height: 180),
        error: (_, _) =>
            const _InlineError(message: 'No se pudo cargar las tareas'),
        data: (snapshot) => Column(
          children: [
            _PulsoCard(snapshot: snapshot),
            const SizedBox(height: 10),
            _TaskListCard(
              tasks: snapshot.tasks,
              pending: snapshot.pendingTaskCount,
              completed: snapshot.completedTaskCount,
              onAdd: () => _showAddTaskDialog(context, ref),
              onToggle: (id) =>
                  ref.read(todayHubProvider.notifier).toggleTask(id),
              onDelete: (id) =>
                  ref.read(todayHubProvider.notifier).deleteTask(id),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsoCard extends StatelessWidget {
  const _PulsoCard({required this.snapshot});
  final TodayHubSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final total = snapshot.tasks.length;
    final progress = total > 0 ? snapshot.completedTaskCount / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pulso del día',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '${snapshot.pendingTaskCount} pendientes · ${snapshot.completedTaskCount} hechas · ${snapshot.completedWorkoutCount} entrenos',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.55),
                  ),
                ),
                if (total > 0) ...[
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFE5C043)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (total > 0) ...[
            const SizedBox(width: 16),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFFE5C043),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TaskListCard extends StatelessWidget {
  const _TaskListCard({
    required this.tasks,
    required this.pending,
    required this.completed,
    required this.onAdd,
    required this.onToggle,
    required this.onDelete,
  });

  final List<TareaHoy> tasks;
  final int pending;
  final int completed;
  final VoidCallback onAdd;
  final Future<void> Function(int) onToggle;
  final Future<void> Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child:
                    Text('Foco del día', style: theme.textTheme.titleSmall),
              ),
              FilledButton.tonalIcon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_task_outlined, size: 16),
                label: const Text('Nueva'),
                style: FilledButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Sin tareas definidas. Añade algo que no puedas olvidar hoy.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            )
          else
            for (final task in tasks.take(6))
              _TaskRow(
                task: task,
                onToggle: () => onToggle(task.id),
                onDelete: () => onDelete(task.id),
              ),
          if (tasks.length > 6)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '${tasks.length - 6} tareas más guardadas.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final TareaHoy task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Checkbox(
              value: task.completada,
              onChanged: (_) => onToggle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Expanded(
            child: Text(
              task.titulo,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: task.completada
                    ? TextDecoration.lineThrough
                    : null,
                color: task.completada
                    ? Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.4)
                    : null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18),
            onPressed: onDelete,
            tooltip: 'Eliminar',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pestaña: Mente
// ─────────────────────────────────────────────────────────────────────────────

class _MenteTab extends ConsumerWidget {
  const _MenteTab({super.key, required this.todayHubAsync});

  final AsyncValue<TodayHubSnapshot> todayHubAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: todayHubAsync.when(
        loading: () => const _CardSkeleton(height: 160),
        error: (_, _) => const _InlineError(message: 'Error al cargar'),
        data: (snapshot) => _MoodCard(
          checkIn: snapshot.latestCheckIn,
          onOpen: () => _showMoodCheckInDialog(
              context, ref, snapshot.latestCheckIn),
        ),
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.checkIn, required this.onOpen});

  final CheckinAnimo? checkIn;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Check-in mental',
                    style: theme.textTheme.titleSmall),
              ),
              OutlinedButton.icon(
                onPressed: onOpen,
                icon: const Icon(Icons.psychology_alt_outlined, size: 16),
                label:
                    Text(checkIn == null ? 'Registrar' : 'Actualizar'),
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (checkIn == null)
            Text(
              'Sin registro hoy. Tomarte un momento para saber cómo llegas al día marca la diferencia.',
              style: theme.textTheme.bodySmall?.copyWith(
                color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            )
          else ...[
            Row(
              children: [
                _MoodBubble(
                  emoji: _moodEmoji(checkIn!.estado),
                  label: _moodLabel(checkIn!.estado),
                ),
                const SizedBox(width: 12),
                _EnergyBubble(energy: checkIn!.energia),
              ],
            ),
            if ((checkIn!.nota ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '"${checkIn!.nota!}"',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _MoodBubble extends StatelessWidget {
  const _MoodBubble({required this.emoji, required this.label});
  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _EnergyBubble extends StatelessWidget {
  const _EnergyBubble({required this.energy});
  final int energy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$energy/5',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE5C043),
            ),
          ),
          const SizedBox(height: 4),
          Text('Energía',
              style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Accesos rápidos — scroll horizontal fijo
// ─────────────────────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  static const _actions = <_Action>[
    _Action(
        label: 'Comida',
        icon: Icons.restaurant_menu_outlined,
        route: '/food'),
    _Action(
        label: 'Entreno',
        icon: Icons.sports_gymnastics_outlined,
        route: '/training'),
    _Action(
        label: 'Boss',
        icon: Icons.smart_toy_outlined,
        route: '/ai-chat?agent=boss'),
    _Action(
        label: 'Música',
        icon: Icons.library_music_outlined,
        route: '/player'),
    _Action(
        label: 'Tareas',
        icon: Icons.checklist_outlined,
        route: '/tasks'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accesos rápidos',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _actions.map((action) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _QuickTile(action: action),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({required this.action});
  final _Action action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push(action.route),
      child: Ink(
        width: 88,
        padding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(action.icon, size: 22),
            const SizedBox(height: 8),
            Text(
              action.label,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _Action {
  const _Action({
    required this.label,
    required this.icon,
    required this.route,
  });
  final String label;
  final IconData icon;
  final String route;
}

// ─────────────────────────────────────────────────────────────────────────────
// Alerta metabólica
// ─────────────────────────────────────────────────────────────────────────────

class _MetabolicAlertCard extends StatelessWidget {
  const _MetabolicAlertCard({required this.suggestion});
  final dynamic suggestion;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context)
          .colorScheme
          .primary
          .withValues(alpha: 0.12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.insights_outlined, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sugerencia metabólica',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 3),
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

// ─────────────────────────────────────────────────────────────────────────────
// Helpers de UI
// ─────────────────────────────────────────────────────────────────────────────

class _MacrosSkeleton extends StatelessWidget {
  const _MacrosSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (_) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat())
                    .shimmer(duration: 1200.ms),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
        ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms),
      ],
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms);
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});
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

// ─────────────────────────────────────────────────────────────────────────────
// Diálogos
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _showAddTaskDialog(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Nueva tarea de hoy'),
      content: TextField(
        controller: controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: 'Qué no se te puede escapar hoy',
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
    ),
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
  final noteController =
      TextEditingController(text: current?.nota ?? '');

  final shouldSave = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Check-in de hoy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<EstadoAnimo>(
                value: selectedMood,
                decoration:
                    const InputDecoration(labelText: 'Cómo llegas'),
                items: EstadoAnimo.values
                    .map((mood) => DropdownMenuItem(
                          value: mood,
                          child: Text(_moodLabel(mood)),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedMood = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              Text('Energía ${energy.round()}/5'),
              Slider(
                value: energy,
                min: 1,
                max: 5,
                divisions: 4,
                label: '${energy.round()}',
                onChanged: (value) =>
                    setState(() => energy = value),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Nota rápida',
                  hintText:
                      'Qué te está drenando o qué te mantiene fino',
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
      ),
    ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Utilidades de texto
// ─────────────────────────────────────────────────────────────────────────────

String _weekdayLabel(int weekday) => switch (weekday) {
      DateTime.monday => 'Lunes',
      DateTime.tuesday => 'Martes',
      DateTime.wednesday => 'Miércoles',
      DateTime.thursday => 'Jueves',
      DateTime.friday => 'Viernes',
      DateTime.saturday => 'Sábado',
      DateTime.sunday => 'Domingo',
      _ => 'Día',
    };

int _weekNumber(DateTime date) {
  final dayOfYear =
      date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  return ((dayOfYear - date.weekday + 10) / 7).floor();
}

String _moodLabel(EstadoAnimo mood) => switch (mood) {
      EstadoAnimo.hundido => 'Hundido',
      EstadoAnimo.bajo => 'Bajo',
      EstadoAnimo.estable => 'Estable',
      EstadoAnimo.bien => 'Bien',
      EstadoAnimo.fuerte => 'Fuerte',
    };

String _moodEmoji(EstadoAnimo mood) => switch (mood) {
      EstadoAnimo.hundido => '😔',
      EstadoAnimo.bajo => '😕',
      EstadoAnimo.estable => '😌',
      EstadoAnimo.bien => '🙂',
      EstadoAnimo.fuerte => '💪',
    };