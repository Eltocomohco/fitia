import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../progress/data/models/registro_agua.dart';

/// Pantalla de informes con resúmenes de día, semana y mes.
class ReportsScreen extends ConsumerWidget {
  /// Crea un [ReportsScreen].
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informes')),
      body: FutureBuilder<_ReportsData>(
        future: _loadReports(ref),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ReportCard(title: 'Hoy', report: data.day),
              const SizedBox(height: 10),
              _ReportCard(title: 'Semana', report: data.week),
              const SizedBox(height: 10),
              _ReportCard(title: 'Mes', report: data.month),
            ],
          );
        },
      ),
    );
  }

  Future<_ReportsData> _loadReports(WidgetRef ref) async {
    final now = DateTime.now();

    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final weekStart = dayStart.subtract(Duration(days: dayStart.weekday - 1));
    final weekEnd = weekStart
        .add(const Duration(days: 7))
        .subtract(const Duration(microseconds: 1));

    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(microseconds: 1));

    return _ReportsData(
      day: await _buildPeriodReport(ref, dayStart, dayEnd),
      week: await _buildPeriodReport(ref, weekStart, weekEnd),
      month: await _buildPeriodReport(ref, monthStart, monthEnd),
    );
  }

  Future<_PeriodReport> _buildPeriodReport(
    WidgetRef ref,
    DateTime start,
    DateTime end,
  ) async {
    final isar = ref.read(inventoryIsarProvider);

    final logs = await isar.registrosDiarios
        .filter()
        .fechaBetween(start, end)
        .findAll();

    var kcal = 0.0;
    for (final log in logs) {
      if (!log.esReceta) {
        final food = await isar.alimentos.get(log.itemId);
        if (food == null || food.porcionBaseGramos <= 0) {
          continue;
        }
        final factor = log.cantidadConsumidaGramos / food.porcionBaseGramos;
        kcal += food.kcal * factor;
      } else {
        final recipe = await isar.recetas.get(log.itemId);
        if (recipe == null) {
          continue;
        }
        await recipe.ingredientes.load();

        var totalWeight = 0.0;
        var totalKcal = 0.0;
        for (final ing in recipe.ingredientes) {
          await ing.alimento.load();
          final food = ing.alimento.value;
          if (food == null || food.porcionBaseGramos <= 0) {
            continue;
          }
          final factor = ing.cantidadGramos / food.porcionBaseGramos;
          totalWeight += ing.cantidadGramos;
          totalKcal += food.kcal * factor;
        }

        if (totalWeight <= 0) {
          continue;
        }
        kcal += totalKcal * (log.cantidadConsumidaGramos / totalWeight);
      }
    }

    final waters = await isar.registrosAgua
        .filter()
        .fechaBetween(start, end)
        .findAll();
    final waterMl = waters.fold<int>(0, (sum, e) => sum + e.mililitros);

    return _PeriodReport(registros: logs.length, kcal: kcal, waterMl: waterMl);
  }
}

class _ReportsData {
  const _ReportsData({
    required this.day,
    required this.week,
    required this.month,
  });

  final _PeriodReport day;
  final _PeriodReport week;
  final _PeriodReport month;
}

class _PeriodReport {
  const _PeriodReport({
    required this.registros,
    required this.kcal,
    required this.waterMl,
  });

  final int registros;
  final double kcal;
  final int waterMl;
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.title, required this.report});

  final String title;
  final _PeriodReport report;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Registros: ${report.registros}'),
            Text('Calorías: ${report.kcal.toStringAsFixed(0)} kcal'),
            Text('Agua: ${report.waterMl} ml'),
          ],
        ),
      ),
    );
  }
}
