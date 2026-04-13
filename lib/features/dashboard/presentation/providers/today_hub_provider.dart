import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../data/models/checkin_animo.dart';
import '../../data/models/tarea_hoy.dart';
import '../../../workouts/data/models/sesion_entrenamiento.dart';

part 'today_hub_provider.g.dart';

class TodayHubSnapshot {
  const TodayHubSnapshot({
    required this.tasks,
    required this.latestCheckIn,
    required this.completedTaskCount,
    required this.pendingTaskCount,
    required this.completedWorkoutCount,
    required this.hasActiveWorkout,
  });

  final List<TareaHoy> tasks;
  final CheckinAnimo? latestCheckIn;
  final int completedTaskCount;
  final int pendingTaskCount;
  final int completedWorkoutCount;
  final bool hasActiveWorkout;
}

@riverpod
class TodayHub extends _$TodayHub {
  @override
  Future<TodayHubSnapshot> build() async {
    return _load();
  }

  Future<void> addTask(String title) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return;
    }

    final isar = ref.read(inventoryIsarProvider);
    final now = DateTime.now();
    final start = _startOfDay(now);

    await isar.writeTxn(() async {
      await isar.tareasHoy.put(
        TareaHoy(fecha: start, titulo: trimmedTitle, initialCreadaEn: now),
      );
    });

    state = AsyncData(await _load());
  }

  Future<void> toggleTask(int taskId) async {
    final isar = ref.read(inventoryIsarProvider);
    final task = await isar.tareasHoy.get(taskId);
    if (task == null) {
      return;
    }

    task.completada = !task.completada;
    task.completadaEn = task.completada ? DateTime.now() : null;

    await isar.writeTxn(() async {
      await isar.tareasHoy.put(task);
    });

    state = AsyncData(await _load());
  }

  Future<void> deleteTask(int taskId) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.tareasHoy.delete(taskId);
    });

    state = AsyncData(await _load());
  }

  Future<void> saveMood({
    required EstadoAnimo estado,
    required int energia,
    String? note,
  }) async {
    final boundedEnergy = energia.clamp(1, 5);
    final isar = ref.read(inventoryIsarProvider);
    final now = DateTime.now();
    final start = _startOfDay(now);
    final end = _endOfDay(now);

    final existing = await isar.checkinsAnimo.where().findAll();
    existing.removeWhere(
      (entry) => entry.fecha.isBefore(start) || entry.fecha.isAfter(end),
    );
    existing.sort((a, b) => b.fecha.compareTo(a.fecha));

    final target = existing.isNotEmpty
        ? existing.first
        : CheckinAnimo(
            fecha: now,
            estado: estado,
            energia: boundedEnergy,
            nota: note?.trim().isEmpty ?? true ? null : note!.trim(),
          );

    target.fecha = now;
    target.estado = estado;
    target.energia = boundedEnergy;
    target.nota = note?.trim().isEmpty ?? true ? null : note!.trim();

    await isar.writeTxn(() async {
      await isar.checkinsAnimo.put(target);
    });

    state = AsyncData(await _load());
  }

  Future<TodayHubSnapshot> _load() async {
    final isar = ref.read(inventoryIsarProvider);
    final now = DateTime.now();
    final start = _startOfDay(now);
    final end = _endOfDay(now);

    final tasks = await isar.tareasHoy.where().findAll();
    tasks.removeWhere(
      (task) => task.fecha.isBefore(start) || task.fecha.isAfter(end),
    );
    tasks.sort((a, b) {
      if (a.completada != b.completada) {
        return a.completada ? 1 : -1;
      }
      return a.creadaEn.compareTo(b.creadaEn);
    });

    final moodEntries = await isar.checkinsAnimo.where().findAll();
    moodEntries.removeWhere(
      (entry) => entry.fecha.isBefore(start) || entry.fecha.isAfter(end),
    );
    moodEntries.sort((a, b) => b.fecha.compareTo(a.fecha));

    final sessions = await isar.sesionesEntrenamiento.where().findAll();
    sessions.removeWhere(
      (session) =>
          session.fechaInicio.isBefore(start) || session.fechaInicio.isAfter(end),
    );

    final completedTaskCount = tasks.where((task) => task.completada).length;
    final completedWorkoutCount = sessions
        .where((session) => session.estado == EstadoSesionEntrenamiento.completada)
        .length;
    final hasActiveWorkout = sessions.any(
      (session) => session.estado == EstadoSesionEntrenamiento.activa,
    );

    return TodayHubSnapshot(
      tasks: tasks,
      latestCheckIn: moodEntries.isEmpty ? null : moodEntries.first,
      completedTaskCount: completedTaskCount,
      pendingTaskCount: tasks.length - completedTaskCount,
      completedWorkoutCount: completedWorkoutCount,
      hasActiveWorkout: hasActiveWorkout,
    );
  }
}

DateTime _startOfDay(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

DateTime _endOfDay(DateTime value) {
  return _startOfDay(value)
      .add(const Duration(days: 1))
      .subtract(const Duration(microseconds: 1));
}