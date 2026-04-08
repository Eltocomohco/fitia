import 'package:flutter/material.dart';

/// Tarjeta compacta con indicador circular para una métrica de macro.
class MacroProgressCard extends StatelessWidget {
  /// Crea una [MacroProgressCard].
  const MacroProgressCard({
    required this.label,
    required this.value,
    required this.goal,
    required this.unit,
    required this.color,
    super.key,
  });

  /// Etiqueta del macro.
  final String label;

  /// Valor actual consumido.
  final double value;

  /// Objetivo diario.
  final double goal;

  /// Unidad visual (kcal, g).
  final String unit;

  /// Color principal del indicador.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = goal <= 0 ? 0.0 : (value / goal).clamp(0.0, 1.0);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: theme.textTheme.titleSmall),
            const SizedBox(height: 10),
            SizedBox(
              height: 72,
              width: 72,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: color.withValues(alpha: 0.15),
                    color: color,
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).round()}%',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${value.toStringAsFixed(0)} $unit',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Meta ${goal.toStringAsFixed(0)} $unit',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
