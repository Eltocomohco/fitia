import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../tracking/presentation/providers/water_intake_provider.dart';
import '../providers/daily_macros_provider.dart';

/// Pantalla principal con resumen diario de nutrición y comidas registradas.
class DashboardScreen extends ConsumerWidget {
  /// Crea un [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final macrosAsync = ref.watch(dailyMacrosProvider);
    final waterAsync = ref.watch(waterIntakeProvider);

    return macrosAsync.when(
      loading: () => const _DashboardLoadingSkeleton(),
      error: (_, _) => const Center(child: Text('Error al cargar datos')),
      data: (macros) {
        final theme = Theme.of(context);
        final now = DateTime.now();
        final formattedDate =
            '${_weekdayLabel(now.weekday)}, ${now.day.toString().padLeft(2, '0')}/'
            '${now.month.toString().padLeft(2, '0')}/${now.year}';

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

        return Scaffold(
          appBar: AppBar(title: const Text('Hoy')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Hoy · $formattedDate', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
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
                      await ref.read(waterIntakeProvider.notifier).clearToday();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
    return ListView(
      padding: const EdgeInsets.all(16),
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
