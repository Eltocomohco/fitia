import 'package:isar_community/isar.dart';

part 'dia_entrenamiento.g.dart';

/// Día marcado como entrenado por el usuario.
@Collection(accessor: 'diasEntrenamiento')
class DiaEntrenamiento {
  /// Crea un [DiaEntrenamiento].
  DiaEntrenamiento({this.id = Isar.autoIncrement, required this.fecha});

  /// Identificador autoincremental.
  Id id;

  /// Fecha del entrenamiento.
  @Index()
  DateTime fecha;

  /// Clave de día calendario para búsquedas rápidas.
  @Index()
  int get fechaDiaKey => fecha.year * 10000 + fecha.month * 100 + fecha.day;
}
