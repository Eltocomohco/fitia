import 'package:isar_community/isar.dart';

part 'registro_agua.g.dart';

/// Registro de toma de agua.
@Collection(accessor: 'registrosAgua')
class RegistroAgua {
  /// Crea un [RegistroAgua].
  RegistroAgua({
    this.id = Isar.autoIncrement,
    required this.fecha,
    required this.mililitros,
  });

  /// Identificador autoincremental.
  Id id;

  /// Fecha y hora de la toma.
  @Index()
  DateTime fecha;

  /// Cantidad en mililitros.
  int mililitros;
}
