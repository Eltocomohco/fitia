import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../progress/data/models/registro_agua.dart';

part 'water_intake_provider.g.dart';

/// Notifier para seguimiento de tomas de agua del día.
@riverpod
class WaterIntake extends _$WaterIntake {
  @override
  Future<List<RegistroAgua>> build() async {
    return _loadToday();
  }

  Future<List<RegistroAgua>> _loadToday() async {
    final isar = ref.read(inventoryIsarProvider);
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final list = await isar.registrosAgua.where().findAll();
    list.removeWhere((e) => e.fecha.isBefore(start) || e.fecha.isAfter(end));
    list.sort((a, b) => a.fecha.compareTo(b.fecha));
    return list;
  }

  /// Agrega una toma de agua en ml.
  Future<void> addIntake(int ml) async {
    if (ml <= 0) {
      return;
    }
    final isar = ref.read(inventoryIsarProvider);

    final intake = RegistroAgua(fecha: DateTime.now(), mililitros: ml);
    final id = await isar.writeTxn(() async => isar.registrosAgua.put(intake));
    intake.id = id;

    final current = [...(state.asData?.value ?? <RegistroAgua>[])];
    current.add(intake);
    current.sort((a, b) => a.fecha.compareTo(b.fecha));
    state = AsyncData(current);
  }

  /// Elimina una toma de agua.
  Future<void> deleteIntake(int id) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.registrosAgua.delete(id);
    });

    final current = (state.asData?.value ?? <RegistroAgua>[])
        .where((e) => e.id != id)
        .toList();
    state = AsyncData(current);
  }

  /// Vacía las tomas del día actual.
  Future<void> clearToday() async {
    final isar = ref.read(inventoryIsarProvider);
    final current = state.asData?.value ?? <RegistroAgua>[];
    if (current.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.registrosAgua.deleteAll(current.map((e) => e.id).toList());
    });

    state = const AsyncData(<RegistroAgua>[]);
  }
}
