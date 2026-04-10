import 'package:isar_community/isar.dart';

part 'notification_preferences.g.dart';

/// Ajustes persistidos de recordatorios locales del usuario.
@Collection(accessor: 'notificationPreferences')
class NotificationPreferences {
  /// Crea un [NotificationPreferences] con valores útiles por defecto.
  NotificationPreferences({
    this.id = 1,
    this.notificationsEnabled = false,
    this.quietHoursStartMinutes = 22 * 60,
    this.quietHoursEndMinutes = 8 * 60,
    this.waterEnabled = true,
    this.waterIntervalHours = 2,
    this.dinnerPlanningEnabled = true,
    this.dinnerPlanningMinutes = 20 * 60 + 30,
    this.mealPrepEnabled = true,
    this.mealPrepMinutes = 21 * 60,
    this.mealLoggingEnabled = false,
    this.mealLoggingMinutes = 14 * 60 + 30,
    this.workoutEnabled = false,
    this.workoutMinutes = 18 * 60,
    this.shoppingEnabled = false,
    this.shoppingMinutes = 19 * 60 + 30,
    this.goalsReviewEnabled = true,
    this.goalsReviewMinutes = 21 * 60 + 45,
  });

  /// Documento singleton del usuario.
  Id id;

  /// Activa o desactiva todo el sistema de recordatorios.
  bool notificationsEnabled;

  /// Minutos desde medianoche a partir de los que empieza el silencio.
  int quietHoursStartMinutes;

  /// Minutos desde medianoche en los que termina el silencio.
  int quietHoursEndMinutes;

  /// Activa recordatorios de agua.
  bool waterEnabled;

  /// Intervalo en horas para recordatorios de agua.
  int waterIntervalHours;

  /// Activa recordatorios para planear la cena del día siguiente.
  bool dinnerPlanningEnabled;

  /// Hora del recordatorio para planear la cena.
  int dinnerPlanningMinutes;

  /// Activa recordatorios para dejar lista la comida del día siguiente.
  bool mealPrepEnabled;

  /// Hora del recordatorio de preparación.
  int mealPrepMinutes;

  /// Activa recordatorios para registrar comidas.
  bool mealLoggingEnabled;

  /// Hora del recordatorio de registro de comidas.
  int mealLoggingMinutes;

  /// Activa recordatorios para entrenar.
  bool workoutEnabled;

  /// Hora del recordatorio de entrenamiento.
  int workoutMinutes;

  /// Activa recordatorios para revisar compra o despensa.
  bool shoppingEnabled;

  /// Hora del recordatorio de compra.
  int shoppingMinutes;

  /// Activa recordatorios para revisar objetivos de mañana.
  bool goalsReviewEnabled;

  /// Hora del recordatorio de revisión de objetivos.
  int goalsReviewMinutes;

  /// Devuelve una copia mutable con los campos indicados.
  NotificationPreferences copyWith({
    Id? id,
    bool? notificationsEnabled,
    int? quietHoursStartMinutes,
    int? quietHoursEndMinutes,
    bool? waterEnabled,
    int? waterIntervalHours,
    bool? dinnerPlanningEnabled,
    int? dinnerPlanningMinutes,
    bool? mealPrepEnabled,
    int? mealPrepMinutes,
    bool? mealLoggingEnabled,
    int? mealLoggingMinutes,
    bool? workoutEnabled,
    int? workoutMinutes,
    bool? shoppingEnabled,
    int? shoppingMinutes,
    bool? goalsReviewEnabled,
    int? goalsReviewMinutes,
  }) {
    return NotificationPreferences(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      quietHoursStartMinutes:
          quietHoursStartMinutes ?? this.quietHoursStartMinutes,
      quietHoursEndMinutes: quietHoursEndMinutes ?? this.quietHoursEndMinutes,
      waterEnabled: waterEnabled ?? this.waterEnabled,
      waterIntervalHours: waterIntervalHours ?? this.waterIntervalHours,
      dinnerPlanningEnabled:
          dinnerPlanningEnabled ?? this.dinnerPlanningEnabled,
      dinnerPlanningMinutes:
          dinnerPlanningMinutes ?? this.dinnerPlanningMinutes,
      mealPrepEnabled: mealPrepEnabled ?? this.mealPrepEnabled,
      mealPrepMinutes: mealPrepMinutes ?? this.mealPrepMinutes,
      mealLoggingEnabled: mealLoggingEnabled ?? this.mealLoggingEnabled,
      mealLoggingMinutes: mealLoggingMinutes ?? this.mealLoggingMinutes,
      workoutEnabled: workoutEnabled ?? this.workoutEnabled,
      workoutMinutes: workoutMinutes ?? this.workoutMinutes,
      shoppingEnabled: shoppingEnabled ?? this.shoppingEnabled,
      shoppingMinutes: shoppingMinutes ?? this.shoppingMinutes,
      goalsReviewEnabled: goalsReviewEnabled ?? this.goalsReviewEnabled,
      goalsReviewMinutes: goalsReviewMinutes ?? this.goalsReviewMinutes,
    );
  }
}