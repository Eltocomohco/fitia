import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../progress/data/models/metrica_corporal.dart';

part 'tracking_provider.g.dart';

/// Notifier para el histórico de métricas corporales.
@riverpod
class BodyTrackingNotifier extends _$BodyTrackingNotifier {
  @override
  Future<List<MetricaCorporal>> build() async {
    final isar = ref.read(inventoryIsarProvider);
    final items = await isar.metricasCorporales.where().findAll();
    if (items.isEmpty) {
      final seed = MetricaCorporal(
        fecha: DateTime.now(),
        peso: 83,
      );
      seed.id = await isar.writeTxn(() async {
        return isar.metricasCorporales.put(seed);
      });
      return [seed];
    }
    items.sort((a, b) => a.fecha.compareTo(b.fecha));
    return items;
  }

  /// Registra una nueva métrica corporal y actualiza el estado local.
  Future<void> addMetric(double peso, double? porcentajeGrasa) async {
    final isar = ref.read(inventoryIsarProvider);

    final nueva = MetricaCorporal(
      fecha: DateTime.now(),
      peso: peso,
      porcentajeGrasa: porcentajeGrasa,
    );

    final id = await isar.writeTxn(() async {
      return isar.metricasCorporales.put(nueva);
    });
    nueva.id = id;

    final current = state.asData?.value ?? <MetricaCorporal>[];
    final updated = [...current, nueva]
      ..sort((a, b) => a.fecha.compareTo(b.fecha));
    state = AsyncData(updated);
  }

  /// Elimina una métrica corporal.
  Future<void> deleteMetric(int id) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.metricasCorporales.delete(id);
    });

    final current =
        (state.asData?.value ?? <MetricaCorporal>[])
            .where((e) => e.id != id)
            .toList()
          ..sort((a, b) => a.fecha.compareTo(b.fecha));
    state = AsyncData(current);
  }
}
