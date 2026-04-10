import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../data/models/sesion_ayuno.dart';

part 'fasting_provider.g.dart';

/// Estado calculado del motor de ayuno intermitente.
class FastingState {
  /// Crea un [FastingState].
  const FastingState({required this.sesion, required this.now});

  /// Sesión persistida en Isar.
  final SesionAyuno sesion;

  /// Hora actual usada para recalcular progreso sin saturar la UI.
  final DateTime now;

  /// Tiempo transcurrido desde el inicio.
  Duration get elapsed => now.difference(sesion.fechaInicio);

  /// Duración objetivo configurada.
  Duration get target => Duration(hours: sesion.horasObjetivo);

  /// Tiempo restante para alcanzar el objetivo.
  Duration get remaining {
    final left = target - elapsed;
    return left.isNegative ? Duration.zero : left;
  }

  /// Progreso normalizado entre 0 y 1.
  double get progress {
    if (!sesion.activa || target.inMinutes <= 0) {
      return 0;
    }
    return (elapsed.inSeconds / target.inSeconds).clamp(0, 1).toDouble();
  }

  /// Indica si ya se alcanzó el objetivo del ayuno.
  bool get isCompleted => sesion.activa && !remaining.isNegative && remaining == Duration.zero;

  /// Copia el estado con cambios puntuales.
  FastingState copyWith({SesionAyuno? sesion, DateTime? now}) {
    return FastingState(sesion: sesion ?? this.sesion, now: now ?? this.now);
  }
}

/// Proveedor del motor de ayuno intermitente con refresco cada minuto.
@Riverpod(keepAlive: true)
class Fasting extends _$Fasting {
  Timer? _ticker;

  @override
  Future<FastingState> build() async {
    ref.onDispose(() => _ticker?.cancel());
    final isar = ref.read(inventoryIsarProvider);
    final sesion = await isar.sesionesAyuno.get(1) ?? SesionAyuno.inactive();

    _ticker ??= Timer.periodic(const Duration(minutes: 1), (_) {
      final current = state.asData?.value;
      if (current != null) {
        state = AsyncData(current.copyWith(now: DateTime.now()));
      }
    });

    return FastingState(sesion: sesion, now: DateTime.now());
  }

  /// Inicia un nuevo ayuno con las horas objetivo seleccionadas.
  Future<void> startFasting(int hours) async {
    final isar = ref.read(inventoryIsarProvider);
    final sesion = SesionAyuno(
      id: 1,
      fechaInicio: DateTime.now(),
      horasObjetivo: hours < 1 ? 1 : hours,
      activa: true,
    );

    await isar.writeTxn(() async {
      await isar.sesionesAyuno.put(sesion);
    });

    state = AsyncData(FastingState(sesion: sesion, now: DateTime.now()));
  }

  /// Finaliza el ayuno actual y conserva la última configuración de horas.
  Future<void> stopFasting() async {
    final current = await future;
    final isar = ref.read(inventoryIsarProvider);
    final sesion = current.sesion
      ..activa = false;

    await isar.writeTxn(() async {
      await isar.sesionesAyuno.put(sesion);
    });

    state = AsyncData(FastingState(sesion: sesion, now: DateTime.now()));
  }
}