import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/notifications/local_notification_service.dart';

part 'workout_timer_provider.g.dart';

/// Duración base del temporizador activo para cálculo de progreso.
@Riverpod(keepAlive: true)
class WorkoutTimerTotal extends _$WorkoutTimerTotal {
  @override
  int build() => 0;

  /// Actualiza la duración total del descanso activo.
  void setTotal(int value) {
    state = value < 0 ? 0 : value;
  }

  /// Limpia la duración total almacenada.
  void reset() {
    state = 0;
  }
}

/// Progreso normalizado del temporizador de descanso activo.
final workoutTimerProgressProvider = Provider<double>((ref) {
  final remaining = ref.watch(workoutTimerProvider);
  final total = ref.watch(workoutTimerTotalProvider);
  if (remaining <= 0 || total <= 0) {
    return 0;
  }
  return (remaining / total).clamp(0, 1).toDouble();
});

/// Gestor global del cronómetro de descanso entre series.
@Riverpod(keepAlive: true)
class WorkoutTimer extends _$WorkoutTimer {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(_disposeTimer);
    return 0;
  }

  /// Inicia una nueva cuenta atrás en segundos.
  void startTimer(int seconds) {
    final sanitized = seconds < 0 ? 0 : seconds;
    _disposeTimer();
    ref.read(workoutTimerTotalProvider.notifier).setTotal(sanitized);
    state = sanitized;

    if (sanitized == 0) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        timer.cancel();
        ref.read(workoutTimerTotalProvider.notifier).reset();
        state = 0;
        unawaited(LocalNotificationService.showTimerCompleteNotification());
        return;
      }

      state = state - 1;
    });
  }

  /// Detiene el temporizador manteniendo el tiempo restante actual.
  void stop() {
    _disposeTimer();
  }

  /// Reinicia completamente el temporizador a cero.
  void reset() {
    _disposeTimer();
    ref.read(workoutTimerTotalProvider.notifier).reset();
    state = 0;
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }
}