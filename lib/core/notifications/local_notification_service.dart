import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../database/isar_config.dart';
import '../services/gemini_companion_service.dart';
import '../../features/user/data/models/notification_preferences.dart';

/// Servicio centralizado para programar recordatorios locales configurables.
class LocalNotificationService {
  LocalNotificationService._();

  static const int _timerCompleteNotificationId = 9001;
  static const int _weeklyWeightCheckNotificationIdBase = 8000;
  static const int _weeklyProgressNotificationIdBase = 8100;

  /// Instancia singleton del servicio.
  static final LocalNotificationService instance = LocalNotificationService._();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'fitia_reminders',
    'Recordatorios Fitia',
    description: 'Avisos configurables de hidratacion, comidas y rutina.',
    importance: Importance.defaultImportance,
  );

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Inicializa el plugin y la zona horaria local.
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    tz.initializeTimeZones();
    try {
      final timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
      ),
    );

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.createNotificationChannel(_channel);

    _initialized = true;
  }

  /// Solicita permisos de notificación cuando la plataforma los requiere.
  Future<bool> requestPermissions() async {
    await initialize();

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final iosImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final macImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >();

    final androidGranted =
        await androidImplementation?.requestNotificationsPermission() ?? true;
    final iosGranted =
        await iosImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        true;
    final macGranted =
        await macImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        true;

    return androidGranted && iosGranted && macGranted;
  }

  /// Muestra una alerta local inmediata cuando termina el temporizador.
  static Future<void> showTimerCompleteNotification() async {
    await instance.initialize();
    await instance._plugin.show(
      _timerCompleteNotificationId,
      'Descanso completado',
      'Ya puedes empezar la siguiente serie.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fitia_reminders',
          'Recordatorios Fitia',
          channelDescription: 'Avisos configurables de hidratacion, comidas y rutina.',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        macOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
    );
  }

  /// Cancela y vuelve a programar todos los recordatorios de la aplicación.
  Future<void> rescheduleAll(NotificationPreferences settings) async {
    await initialize();
    await _plugin.cancelAll();

    if (!settings.notificationsEnabled) {
      return;
    }

    final isar = await IsarConfig.ensureInitialized();
    final gemini = FitiCoachService();
    final dinnerBody = await gemini.buildNotificationSuggestion(
      isar: isar,
      kind: GeminiNotificationKind.dinnerPlanning,
    );
    final mealPrepBody = await gemini.buildNotificationSuggestion(
      isar: isar,
      kind: GeminiNotificationKind.mealPrep,
    );
    final weeklyWeightBody = await gemini.buildNotificationSuggestion(
      isar: isar,
      kind: GeminiNotificationKind.weeklyWeightCheckIn,
    );
    final weeklyProgressBody = await gemini.buildNotificationSuggestion(
      isar: isar,
      kind: GeminiNotificationKind.weeklyProgress,
    );

    await _scheduleHydration(settings);
    await _scheduleDailyReminder(
      idBase: 2000,
      settings: settings,
      enabled: settings.dinnerPlanningEnabled,
      minutes: settings.dinnerPlanningMinutes,
      title: 'Piensa la cena de manana',
      body: dinnerBody,
    );
    await _scheduleDailyReminder(
      idBase: 3000,
      settings: settings,
      enabled: settings.mealPrepEnabled,
      minutes: settings.mealPrepMinutes,
      title: 'Prepara la comida de manana',
      body: mealPrepBody,
    );
    await _scheduleDailyReminder(
      idBase: 4000,
      settings: settings,
      enabled: settings.mealLoggingEnabled,
      minutes: settings.mealLoggingMinutes,
      title: 'Registra lo que has comido',
      body: 'Anota tus comidas del dia para mantener el seguimiento al dia.',
    );
    await _scheduleDailyReminder(
      idBase: 5000,
      settings: settings,
      enabled: settings.workoutEnabled,
      minutes: settings.workoutMinutes,
      title: 'Momento de entrenar',
      body: 'Reserva un rato para tu rutina y deja el entreno marcado.',
    );
    await _scheduleDailyReminder(
      idBase: 6000,
      settings: settings,
      enabled: settings.shoppingEnabled,
      minutes: settings.shoppingMinutes,
      title: 'Revisa la despensa',
      body: 'Comprueba si te falta algo para manana y evita improvisar.',
    );
    await _scheduleDailyReminder(
      idBase: 7000,
      settings: settings,
      enabled: settings.goalsReviewEnabled,
      minutes: settings.goalsReviewMinutes,
      title: 'Revisa tus objetivos de manana',
      body: 'Deja claros tus objetivos y tu plan antes de cerrar el dia.',
    );
    await _scheduleWeeklyReminder(
      idBase: _weeklyWeightCheckNotificationIdBase,
      enabled: true,
      weekday: DateTime.monday,
      hour: 8,
      minute: 30,
      title: 'Check-in semanal',
      body: weeklyWeightBody,
    );
    await _scheduleWeeklyReminder(
      idBase: _weeklyProgressNotificationIdBase,
      enabled: true,
      weekday: DateTime.sunday,
      hour: 20,
      minute: 0,
      title: 'Resumen semanal Fiti',
      body: weeklyProgressBody,
    );
  }

  Future<void> _scheduleHydration(NotificationPreferences settings) async {
    if (!settings.waterEnabled) {
      return;
    }

    final interval = settings.waterIntervalHours.clamp(1, 12);
    final dayStart = settings.quietHoursEndMinutes;
    final dayEnd = settings.quietHoursStartMinutes;
    final today = tz.TZDateTime.now(tz.local);

    for (var dayOffset = 0; dayOffset < 14; dayOffset++) {
      final baseDay = tz.TZDateTime(
        tz.local,
        today.year,
        today.month,
        today.day + dayOffset,
      );

      var slot = 0;
      for (var minutes = dayStart; minutes < dayEnd; minutes += interval * 60) {
        final scheduled = _atMinutes(baseDay, minutes);
        if (scheduled.isBefore(today.add(const Duration(minutes: 1)))) {
          continue;
        }

        await _plugin.zonedSchedule(
          1000 + dayOffset * 100 + slot,
          'Hora de beber agua',
          'Toca hidratarte. Un vaso de agua ahora te ayuda a llegar mejor al final del dia.',
          scheduled,
          _details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
        slot++;
      }
    }
  }

  Future<void> _scheduleDailyReminder({
    required int idBase,
    required NotificationPreferences settings,
    required bool enabled,
    required int minutes,
    required String title,
    required String body,
  }) async {
    if (!enabled) {
      return;
    }

    final now = tz.TZDateTime.now(tz.local);
    for (var dayOffset = 0; dayOffset < 14; dayOffset++) {
      final baseDay = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day + dayOffset,
      );
      final safeMinutes = _clampToActiveWindow(
        minutes: minutes,
        quietStartMinutes: settings.quietHoursStartMinutes,
        quietEndMinutes: settings.quietHoursEndMinutes,
      );
      final scheduled = _atMinutes(baseDay, safeMinutes);
      if (scheduled.isBefore(now.add(const Duration(minutes: 1)))) {
        continue;
      }

      await _plugin.zonedSchedule(
        idBase + dayOffset,
        title,
        body,
        scheduled,
        _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> _scheduleWeeklyReminder({
    required int idBase,
    required bool enabled,
    required int weekday,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    if (!enabled) {
      return;
    }

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != weekday || !scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    for (var weekOffset = 0; weekOffset < 8; weekOffset++) {
      final current = scheduled.add(Duration(days: 7 * weekOffset));
      await _plugin.zonedSchedule(
        idBase + weekOffset,
        title,
        body,
        current,
        _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  tz.TZDateTime _atMinutes(tz.TZDateTime baseDay, int minutes) {
    return tz.TZDateTime(
      tz.local,
      baseDay.year,
      baseDay.month,
      baseDay.day,
      minutes ~/ 60,
      minutes % 60,
    );
  }

  int _clampToActiveWindow({
    required int minutes,
    required int quietStartMinutes,
    required int quietEndMinutes,
  }) {
    if (quietStartMinutes <= quietEndMinutes) {
      return minutes;
    }

    final isQuiet = minutes >= quietStartMinutes || minutes < quietEndMinutes;
    if (!isQuiet) {
      return minutes;
    }

    return quietEndMinutes;
  }

  NotificationDetails get _details {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'fitia_reminders',
        'Recordatorios Fitia',
        channelDescription: 'Avisos configurables de hidratacion, comidas y rutina.',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );
  }
}