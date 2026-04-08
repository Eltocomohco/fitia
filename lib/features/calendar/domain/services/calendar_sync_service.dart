/// Contrato para sincronización y clonado de bloques del calendario alimentario.
abstract class CalendarSyncService {
  /// Clona una semana completa desde [sourceStartWeek] hacia [targetStartWeek].
  ///
  /// Debe duplicar registros diarios desplazando fechas según diferencia semanal.
  Future<void> clonarBloqueSemanal({
    required DateTime sourceStartWeek,
    required DateTime targetStartWeek,
  });
}
