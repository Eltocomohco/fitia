import 'package:isar_community/isar.dart';

import 'ejercicio.dart';
import 'sesion_entrenamiento.dart';

part 'serie.g.dart';

/// Serie ejecutable dentro de una sesión de entrenamiento.
@Collection(accessor: 'series')
class Serie {
  /// Crea una [Serie].
  Serie({
    this.id = Isar.autoIncrement,
    this.pesoKg = 0,
    this.repeticiones = 0,
    this.completada = false,
  });

  /// Identificador autoincremental.
  Id id;

  /// Sesión a la que pertenece la serie.
  final sesion = IsarLink<SesionEntrenamiento>();

  /// Ejercicio asociado a la serie.
  final ejercicio = IsarLink<Ejercicio>();

  /// Peso registrado para la serie.
  late double pesoKg;

  /// Repeticiones registradas para la serie.
  late int repeticiones;

  /// Indica si la serie fue completada.
  late bool completada;
}