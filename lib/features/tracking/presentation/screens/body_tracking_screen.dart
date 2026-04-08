import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/body_profile_provider.dart';
import '../providers/tracking_provider.dart';
import '../providers/water_intake_provider.dart';

/// Panel de seguimiento corporal y evolución de métricas.
class BodyTrackingScreen extends ConsumerWidget {
  /// Crea un [BodyTrackingScreen].
  const BodyTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingAsync = ref.watch(bodyTrackingProvider);
    final profileAsync = ref.watch(bodyProfileProvider);
    final profile = profileAsync.asData?.value ?? const BodyProfileState();
    final waterAsync = ref.watch(waterIntakeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento corporal')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddMetricDialog(context, ref),
        icon: const Icon(Icons.monitor_weight_outlined),
        label: const Text('Registrar métrica'),
      ),
      body: trackingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Error al cargar métricas')),
        data: (metrics) {
          final latest = metrics.isEmpty ? null : metrics.last;
          final bmi = latest == null
              ? null
              : latest.peso /
                    ((profile.alturaCm / 100) * (profile.alturaCm / 100));
          final bmiLabel = bmi == null ? '-' : _bmiLabel(bmi);
          final latestFat = latest?.porcentajeGrasa;
          final totalWater =
              waterAsync.asData?.value.fold<int>(
                0,
                (sum, item) => sum + item.mililitros,
              ) ??
              0;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Último registro'),
                      const SizedBox(height: 8),
                      Text(
                        latest == null
                            ? 'Sin datos aún'
                            : '${latest.peso.toStringAsFixed(1)} kg',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        latest == null
                            ? 'Actualización: -'
                            : 'Actualización: ${_formatDate(latest.fecha)}',
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Edad: ${profile.edad} · Altura: ${profile.alturaCm.toStringAsFixed(0)} cm',
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () =>
                              _openProfileDialog(context, ref, profile),
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Editar perfil'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _MetricSummaryCard(
                      title: 'IMC',
                      value: bmi == null ? '-' : bmi.toStringAsFixed(1),
                      subtitle: bmiLabel,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MetricSummaryCard(
                      title: 'Grasa corporal',
                      value: latestFat == null
                          ? '-'
                          : '${latestFat.toStringAsFixed(1)}%',
                      subtitle: latestFat == null ? 'Sin dato' : 'Último valor',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 180,
                    child: metrics.length < 2
                        ? const Center(
                            child: Text(
                              'Añade 2+ registros para ver la gráfica',
                            ),
                          )
                        : LineChart(
                            LineChartData(
                              minX: metrics.first.fecha.millisecondsSinceEpoch
                                  .toDouble(),
                              maxX: metrics.last.fecha.millisecondsSinceEpoch
                                  .toDouble(),
                              minY:
                                  metrics
                                      .map<double>((m) => m.peso)
                                      .reduce((a, b) => a < b ? a : b) -
                                  1,
                              maxY:
                                  metrics
                                      .map<double>((m) => m.peso)
                                      .reduce((a, b) => a > b ? a : b) +
                                  1,
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 1,
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                              ),
                              titlesData: FlTitlesData(
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) => Text(
                                      value.toStringAsFixed(0),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval:
                                        ((metrics
                                                        .last
                                                        .fecha
                                                        .millisecondsSinceEpoch -
                                                    metrics
                                                        .first
                                                        .fecha
                                                        .millisecondsSinceEpoch) /
                                                ((metrics.length - 1).clamp(
                                                  1,
                                                  6,
                                                )))
                                            .toDouble(),
                                    getTitlesWidget: (value, meta) {
                                      final date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                            value.toInt(),
                                          );
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          '${date.day}/${date.month}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  getTooltipItems: (spots) => spots
                                      .map(
                                        (spot) => LineTooltipItem(
                                          '${spot.y.toStringAsFixed(1)} kg\n${_formatDate(DateTime.fromMillisecondsSinceEpoch(spot.x.toInt()))}',
                                          Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onInverseSurface,
                                              ) ??
                                              const TextStyle(
                                                color: Colors.white,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  color: Theme.of(context).colorScheme.primary,
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.12),
                                  ),
                                  spots: metrics
                                      .map(
                                        (metric) => FlSpot(
                                          metric.fecha.millisecondsSinceEpoch
                                              .toDouble(),
                                          metric.peso,
                                        ),
                                      )
                                      .toList(growable: false),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agua de hoy: $totalWater ml / 2000 ml',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => ref
                                .read(waterIntakeProvider.notifier)
                                .addIntake(250),
                            child: const Text('+250 ml'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => ref
                                .read(waterIntakeProvider.notifier)
                                .addIntake(500),
                            child: const Text('+500 ml'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Vaciar agua del día'),
                                  content: const Text(
                                    '¿Eliminar todas las tomas de agua de hoy?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(
                                        dialogContext,
                                      ).pop(false),
                                      child: const Text('Cancelar'),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.of(dialogContext).pop(true),
                                      child: const Text('Vaciar'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await ref
                                    .read(waterIntakeProvider.notifier)
                                    .clearToday();
                              }
                            },
                            icon: const Icon(Icons.delete_sweep_outlined),
                            label: const Text('Vaciar hoy'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      waterAsync.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ),
                        error: (_, _) => const Text('Error al cargar agua'),
                        data: (entries) {
                          if (entries.isEmpty) {
                            return const Text('Sin tomas de agua registradas');
                          }
                          return Column(
                            children: entries
                                .map(
                                  (entry) => ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text('${entry.mililitros} ml'),
                                    subtitle: Text(
                                      '${entry.fecha.hour.toString().padLeft(2, '0')}:${entry.fecha.minute.toString().padLeft(2, '0')}',
                                    ),
                                    trailing: IconButton(
                                      onPressed: () => ref
                                          .read(waterIntakeProvider.notifier)
                                          .deleteIntake(entry.id),
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text('Histórico', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              ...metrics.asMap().entries.map((entry) {
                final index = entry.key;
                final current = entry.value;
                final previous = index == 0 ? null : metrics[index - 1];
                final diff = previous == null
                    ? null
                    : current.peso - previous.peso;

                return Card(
                  child: ListTile(
                    title: Text('${current.peso.toStringAsFixed(1)} kg'),
                    subtitle: Text(_formatDate(current.fecha)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          diff == null
                              ? '—'
                              : '${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(1)} kg',
                        ),
                        IconButton(
                          onPressed: () => ref
                              .read(bodyTrackingProvider.notifier)
                              .deleteMetric(current.id),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (metrics.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Aún no hay registros corporales'),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openAddMetricDialog(BuildContext context, WidgetRef ref) async {
    final pesoCtrl = TextEditingController();
    final grasaCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Nueva métrica'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: pesoCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Peso (kg)'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: grasaCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: '% Grasa (opcional)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final peso = double.tryParse(
                  pesoCtrl.text.trim().replaceAll(',', '.'),
                );
                final grasaTxt = grasaCtrl.text.trim();
                final grasa = grasaTxt.isEmpty
                    ? null
                    : double.tryParse(grasaTxt.replaceAll(',', '.'));

                if (peso == null || peso <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Introduce un peso válido')),
                  );
                  return;
                }

                try {
                  await ref
                      .read(bodyTrackingProvider.notifier)
                      .addMetric(peso, grasa);
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No se pudo guardar la métrica'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openProfileDialog(
    BuildContext context,
    WidgetRef ref,
    BodyProfileState profile,
  ) async {
    final edadCtrl = TextEditingController(text: profile.edad.toString());
    final alturaCtrl = TextEditingController(
      text: profile.alturaCm.toStringAsFixed(0),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Perfil corporal'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: edadCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: alturaCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Altura (cm)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final edad = int.tryParse(edadCtrl.text.trim());
              final altura = double.tryParse(
                alturaCtrl.text.trim().replaceAll(',', '.'),
              );
              if (edad == null || altura == null || edad <= 0 || altura <= 0) {
                return;
              }
              await ref
                  .read(bodyProfileProvider.notifier)
                  .saveProfile(edad: edad, alturaCm: altura);
              if (!dialogContext.mounted) {
                return;
              }
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String _bmiLabel(double bmi) {
  if (bmi < 18.5) {
    return 'Bajo peso';
  }
  if (bmi < 25) {
    return 'Normal';
  }
  if (bmi < 30) {
    return 'Sobrepeso';
  }
  return 'Obesidad';
}

class _MetricSummaryCard extends StatelessWidget {
  const _MetricSummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 2),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
