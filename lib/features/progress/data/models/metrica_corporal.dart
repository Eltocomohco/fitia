import 'package:isar_community/isar.dart';

part 'metrica_corporal.g.dart';

/// Registro de métricas corporales para seguimiento de progreso.
@Collection(accessor: 'metricasCorporales')
class MetricaCorporal {
  /// Crea una [MetricaCorporal].
  MetricaCorporal({
    this.id = Isar.autoIncrement,
    required this.fecha,
    required this.peso,
    this.porcentajeGrasa,
  });

  /// Identificador autoincremental.
  Id id;

  /// Fecha de la medición.
  @Index()
  late DateTime fecha;

  /// Peso corporal en kg.
  late double peso;

  /// Porcentaje de grasa corporal.
  double? porcentajeGrasa;
}
