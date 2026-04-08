import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../dashboard/presentation/providers/daily_macros_provider.dart';
import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../../progress/data/models/dia_entrenamiento.dart';

part 'calendar_provider.g.dart';

/// Fecha seleccionada en el planificador de calendario.
@riverpod
class SelectedDateNotifier extends _$SelectedDateNotifier {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Cambia la fecha activa del planificador.
  void changeDate(DateTime newDate) {
    state = DateTime(newDate.year, newDate.month, newDate.day);
  }
}

/// Registros diarios de la fecha seleccionada.
@riverpod
class DailyLogsNotifier extends _$DailyLogsNotifier {
  @override
  Future<List<RegistroDiario>> build() async {
    final isar = ref.read(inventoryIsarProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final end = start
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    return isar.registrosDiarios.filter().fechaBetween(start, end).findAll();
  }

  /// Añade una nueva entrada al calendario y sincroniza módulos dependientes.
  Future<void> addLogEntry(
    DateTime fecha,
    TipoComida tipo,
    int itemId,
    bool esReceta,
    double cantidad,
  ) async {
    final isar = ref.read(inventoryIsarProvider);

    await isar.writeTxn(() async {
      await isar.registrosDiarios.put(
        RegistroDiario(
          fecha: fecha,
          tipoComida: tipo,
          esReceta: esReceta,
          itemId: itemId,
          cantidadConsumidaGramos: cantidad,
        ),
      );
    });

    ref.invalidate(dailyMacrosProvider);
    ref.invalidate(mealCompletionDaysProvider);
    ref.invalidateSelf();
    state = AsyncData(await build());
  }

  /// Elimina un registro puntual del día.
  Future<void> deleteLogEntry(int logId) async {
    final isar = ref.read(inventoryIsarProvider);

    await isar.writeTxn(() async {
      await isar.registrosDiarios.delete(logId);
    });

    ref.invalidate(dailyMacrosProvider);
    ref.invalidate(mealCompletionDaysProvider);
    state = AsyncData(await build());
  }

  /// Elimina todos los registros de la fecha seleccionada.
  Future<void> clearSelectedDay() async {
    final isar = ref.read(inventoryIsarProvider);
    final selectedDate = ref.read(selectedDateProvider);

    final start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final end = start
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final logs = await isar.registrosDiarios
        .filter()
        .fechaBetween(start, end)
        .findAll();

    if (logs.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.registrosDiarios.deleteAll(logs.map((e) => e.id).toList());
    });

    ref.invalidate(dailyMacrosProvider);
    ref.invalidate(mealCompletionDaysProvider);
    state = AsyncData(await build());
  }
}

/// Días marcados como entrenamiento.
@riverpod
class TrainingDays extends _$TrainingDays {
  @override
  Future<Set<int>> build() async {
    final isar = ref.read(inventoryIsarProvider);
    final items = await isar.diasEntrenamiento.where().findAll();
    return items.map((e) => _dayKey(e.fecha)).toSet();
  }

  /// Marca o desmarca una fecha como día de entrenamiento.
  Future<void> toggle(DateTime date) async {
    final isar = ref.read(inventoryIsarProvider);
    final targetKey = _dayKey(date);

    final all = await isar.diasEntrenamiento.where().findAll();
    DiaEntrenamiento? existing;
    for (final item in all) {
      if (_dayKey(item.fecha) == targetKey) {
        existing = item;
        break;
      }
    }

    await isar.writeTxn(() async {
      if (existing != null) {
        await isar.diasEntrenamiento.delete(existing.id);
      } else {
        await isar.diasEntrenamiento.put(
          DiaEntrenamiento(fecha: DateTime(date.year, date.month, date.day)),
        );
      }
    });

    state = AsyncData(await build());
  }

  /// Indica si una fecha está marcada como entrenamiento.
  bool isTrained(DateTime date) {
    final set = state.asData?.value ?? <int>{};
    return set.contains(_dayKey(date));
  }
}

int _dayKey(DateTime date) => date.year * 10000 + date.month * 100 + date.day;

/// Días con cumplimiento de comida (al menos un registro diario).
@riverpod
Future<Set<int>> mealCompletionDays(Ref ref) async {
  final isar = ref.read(inventoryIsarProvider);
  final allLogs = await isar.registrosDiarios.where().findAll();
  return allLogs.map((e) => _dayKey(e.fecha)).toSet();
}
