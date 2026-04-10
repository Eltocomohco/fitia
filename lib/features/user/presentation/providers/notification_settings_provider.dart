import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/isar_config.dart';
import '../../../../core/notifications/local_notification_service.dart';
import '../../data/models/notification_preferences.dart';

part 'notification_settings_provider.g.dart';

/// Tipos de recordatorios configurables en la app.
enum ReminderType {
  /// Recordatorios periodicos de hidratacion.
  water,

  /// Recordatorio para pensar la cena del dia siguiente.
  dinnerPlanning,

  /// Recordatorio para preparar comida con antelacion.
  mealPrep,

  /// Recordatorio para registrar comidas.
  mealLogging,

  /// Recordatorio para entrenar.
  workout,

  /// Recordatorio para revisar la compra o despensa.
  shopping,

  /// Recordatorio para revisar objetivos del dia siguiente.
  goalsReview,
}

/// Notifier que carga, persiste y reprograma los recordatorios del usuario.
@riverpod
class NotificationSettings extends _$NotificationSettings {
  static const int _singletonId = 1;

  @override
  Future<NotificationPreferences> build() async {
    final isar = await IsarConfig.ensureInitialized();
    final stored = await isar.notificationPreferences.get(_singletonId);
    final preferences = stored ?? NotificationPreferences(id: _singletonId);
    if (stored == null) {
      await isar.writeTxn(() async {
        await isar.notificationPreferences.put(preferences);
      });
    }
    await LocalNotificationService.instance.initialize();
    return preferences;
  }

  /// Solicita permiso y activa el sistema global si el permiso se concede.
  Future<bool> enableNotifications() async {
    final current = await future;
    final granted = await LocalNotificationService.instance.requestPermissions();
    if (!granted) {
      return false;
    }

    await _persist(current.copyWith(notificationsEnabled: true));
    return true;
  }

  /// Activa o desactiva todo el sistema de recordatorios.
  Future<void> setGlobalEnabled(bool enabled) async {
    final current = await future;
    await _persist(current.copyWith(notificationsEnabled: enabled));
  }

  /// Actualiza la ventana de silencio nocturno.
  Future<void> setQuietHours({
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    final current = await future;
    await _persist(
      current.copyWith(
        quietHoursStartMinutes: start.hour * 60 + start.minute,
        quietHoursEndMinutes: end.hour * 60 + end.minute,
      ),
    );
  }

  /// Activa o desactiva un recordatorio concreto.
  Future<void> setReminderEnabled(ReminderType type, bool enabled) async {
    final current = await future;
    switch (type) {
      case ReminderType.water:
        await _persist(current.copyWith(waterEnabled: enabled));
        return;
      case ReminderType.dinnerPlanning:
        await _persist(current.copyWith(dinnerPlanningEnabled: enabled));
        return;
      case ReminderType.mealPrep:
        await _persist(current.copyWith(mealPrepEnabled: enabled));
        return;
      case ReminderType.mealLogging:
        await _persist(current.copyWith(mealLoggingEnabled: enabled));
        return;
      case ReminderType.workout:
        await _persist(current.copyWith(workoutEnabled: enabled));
        return;
      case ReminderType.shopping:
        await _persist(current.copyWith(shoppingEnabled: enabled));
        return;
      case ReminderType.goalsReview:
        await _persist(current.copyWith(goalsReviewEnabled: enabled));
        return;
    }
  }

  /// Actualiza el intervalo de recordatorio de agua.
  Future<void> setWaterIntervalHours(int hours) async {
    final current = await future;
    await _persist(current.copyWith(waterIntervalHours: hours.clamp(1, 12)));
  }

  /// Actualiza la hora de un recordatorio diario.
  Future<void> setReminderTime(ReminderType type, TimeOfDay time) async {
    final current = await future;
    final minutes = time.hour * 60 + time.minute;
    switch (type) {
      case ReminderType.water:
        return;
      case ReminderType.dinnerPlanning:
        await _persist(current.copyWith(dinnerPlanningMinutes: minutes));
        return;
      case ReminderType.mealPrep:
        await _persist(current.copyWith(mealPrepMinutes: minutes));
        return;
      case ReminderType.mealLogging:
        await _persist(current.copyWith(mealLoggingMinutes: minutes));
        return;
      case ReminderType.workout:
        await _persist(current.copyWith(workoutMinutes: minutes));
        return;
      case ReminderType.shopping:
        await _persist(current.copyWith(shoppingMinutes: minutes));
        return;
      case ReminderType.goalsReview:
        await _persist(current.copyWith(goalsReviewMinutes: minutes));
        return;
    }
  }

  Future<void> _persist(NotificationPreferences preferences) async {
    final isar = await IsarConfig.ensureInitialized();
    await isar.writeTxn(() async {
      await isar.notificationPreferences.put(preferences);
    });
    await LocalNotificationService.instance.rescheduleAll(preferences);
    state = AsyncData(preferences.copyWith());
  }
}