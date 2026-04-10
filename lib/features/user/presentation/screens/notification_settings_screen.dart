import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/notification_settings_provider.dart';

/// Pantalla para configurar recordatorios locales de la app.
class NotificationSettingsScreen extends ConsumerWidget {
  /// Crea una [NotificationSettingsScreen].
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recordatorios y notificaciones')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No se pudo cargar la configuracion')),
        data: (settings) {
          final quietStart = _timeOfDayFromMinutes(settings.quietHoursStartMinutes);
          final quietEnd = _timeOfDayFromMinutes(settings.quietHoursEndMinutes);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recordatorios activos',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Activa avisos locales configurables para agua, comidas, entreno y planificacion.',
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: settings.notificationsEnabled,
                            onChanged: (value) async {
                              if (value) {
                                final granted = await ref
                                    .read(notificationSettingsProvider.notifier)
                                    .enableNotifications();
                                if (!context.mounted) {
                                  return;
                                }
                                if (!granted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'No se concedieron permisos de notificacion.',
                                      ),
                                    ),
                                  );
                                }
                                return;
                              }

                              await ref
                                  .read(notificationSettingsProvider.notifier)
                                  .setGlobalEnabled(false);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Silencio nocturno',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Durante esta franja no se enviaran avisos. Si un recordatorio cae dentro, se movera al primer tramo permitido.',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: settings.notificationsEnabled
                                  ? () => _pickQuietTime(
                                        context,
                                        ref,
                                        start: true,
                                        initial: quietStart,
                                        fallback: quietEnd,
                                      )
                                  : null,
                              icon: const Icon(Icons.nightlight_round),
                              label: Text('Desde ${_formatTime(quietStart)}'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: settings.notificationsEnabled
                                  ? () => _pickQuietTime(
                                        context,
                                        ref,
                                        start: false,
                                        initial: quietEnd,
                                        fallback: quietStart,
                                      )
                                  : null,
                              icon: const Icon(Icons.wb_sunny_outlined),
                              label: Text('Hasta ${_formatTime(quietEnd)}'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Beber agua',
                subtitle: 'Recuerda hidratarte durante el dia con el intervalo que prefieras.',
                enabled: settings.waterEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.water_drop_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.water, value),
                trailing: DropdownButton<int>(
                  value: settings.waterIntervalHours,
                  onChanged: !settings.notificationsEnabled || !settings.waterEnabled
                      ? null
                      : (value) {
                          if (value == null) {
                            return;
                          }
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .setWaterIntervalHours(value);
                        },
                  items: const [1, 2, 3, 4, 5, 6]
                      .map(
                        (hours) => DropdownMenuItem(
                          value: hours,
                          child: Text('Cada $hours h'),
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Pensar la cena de manana',
                subtitle: 'Te ayuda a no improvisar la cena del dia siguiente.',
                enabled: settings.dinnerPlanningEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.restaurant_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.dinnerPlanning, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.dinnerPlanningEnabled,
                  time: _timeOfDayFromMinutes(settings.dinnerPlanningMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.dinnerPlanning,
                    _timeOfDayFromMinutes(settings.dinnerPlanningMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Preparar la comida de manana',
                subtitle: 'Avanza tu tupper o tu cena y deja el dia siguiente bajo control.',
                enabled: settings.mealPrepEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.lunch_dining_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.mealPrep, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.mealPrepEnabled,
                  time: _timeOfDayFromMinutes(settings.mealPrepMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.mealPrep,
                    _timeOfDayFromMinutes(settings.mealPrepMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Registrar comidas',
                subtitle: 'Un toque para que no se te quede el diario sin completar.',
                enabled: settings.mealLoggingEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.edit_note_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.mealLogging, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.mealLoggingEnabled,
                  time: _timeOfDayFromMinutes(settings.mealLoggingMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.mealLogging,
                    _timeOfDayFromMinutes(settings.mealLoggingMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Entrenamiento',
                subtitle: 'Reserva un hueco para la rutina antes de que se te vaya el dia.',
                enabled: settings.workoutEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.sports_gymnastics_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.workout, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.workoutEnabled,
                  time: _timeOfDayFromMinutes(settings.workoutMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.workout,
                    _timeOfDayFromMinutes(settings.workoutMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Revisar despensa',
                subtitle: 'Comprueba si falta algo importante antes de manana.',
                enabled: settings.shoppingEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.shopping_basket_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.shopping, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.shoppingEnabled,
                  time: _timeOfDayFromMinutes(settings.shoppingMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.shopping,
                    _timeOfDayFromMinutes(settings.shoppingMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ReminderCard(
                title: 'Revisar objetivos de manana',
                subtitle: 'Un cierre corto del dia para dejar claro el plan del siguiente.',
                enabled: settings.goalsReviewEnabled,
                active: settings.notificationsEnabled,
                icon: Icons.flag_outlined,
                onToggle: (value) => ref
                    .read(notificationSettingsProvider.notifier)
                    .setReminderEnabled(ReminderType.goalsReview, value),
                trailing: _TimeButton(
                  enabled: settings.notificationsEnabled && settings.goalsReviewEnabled,
                  time: _timeOfDayFromMinutes(settings.goalsReviewMinutes),
                  onPressed: () => _pickReminderTime(
                    context,
                    ref,
                    ReminderType.goalsReview,
                    _timeOfDayFromMinutes(settings.goalsReviewMinutes),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickQuietTime(
    BuildContext context,
    WidgetRef ref, {
    required bool start,
    required TimeOfDay initial,
    required TimeOfDay fallback,
  }) async {
    final selected = await showTimePicker(context: context, initialTime: initial);
    if (selected == null) {
      return;
    }

    await ref.read(notificationSettingsProvider.notifier).setQuietHours(
          start: start ? selected : fallback,
          end: start ? fallback : selected,
        );
  }

  Future<void> _pickReminderTime(
    BuildContext context,
    WidgetRef ref,
    ReminderType type,
    TimeOfDay initial,
  ) async {
    final selected = await showTimePicker(context: context, initialTime: initial);
    if (selected == null) {
      return;
    }
    await ref.read(notificationSettingsProvider.notifier).setReminderTime(type, selected);
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.active,
    required this.icon,
    required this.trailing,
    required this.onToggle,
  });

  final String title;
  final String subtitle;
  final bool enabled;
  final bool active;
  final IconData icon;
  final Widget trailing;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(subtitle),
                    ],
                  ),
                ),
                Switch(value: enabled, onChanged: active ? onToggle : null),
              ],
            ),
            const SizedBox(height: 12),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({
    required this.enabled,
    required this.time,
    required this.onPressed,
  });

  final bool enabled;
  final TimeOfDay time;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: const Icon(Icons.schedule_outlined),
        label: Text('Hora: ${_formatTime(time)}'),
      ),
    );
  }
}

TimeOfDay _timeOfDayFromMinutes(int minutes) {
  return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
}

String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}