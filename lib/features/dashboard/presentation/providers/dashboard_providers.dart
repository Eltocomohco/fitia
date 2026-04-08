import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fecha activa para mostrar métricas y comidas del día en dashboard.
final dashboardSelectedDateProvider =
    NotifierProvider<DashboardSelectedDateNotifier, DateTime>(
      DashboardSelectedDateNotifier.new,
    );

/// Notifier de fecha seleccionada en dashboard.
class DashboardSelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Actualiza la fecha seleccionada.
  void setDate(DateTime value) {
    state = DateTime(value.year, value.month, value.day);
  }
}
