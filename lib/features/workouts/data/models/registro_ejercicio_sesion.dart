import 'package:isar_community/isar.dart';

import 'ejercicio.dart';
import 'sesion_entrenamiento.dart';

part 'registro_ejercicio_sesion.g.dart';

/// Valoración subjetiva del usuario al ejecutar un ejercicio en una sesión.
enum SensacionEjercicio {
  /// El ejercicio se sintió muy mal.
  muyMala,

  /// El ejercicio se sintió por debajo de lo esperado.
  mala,

  /// El ejercicio se sintió normal.
  normal,

  /// El ejercicio se sintió bien.
  buena,

  /// El ejercicio se sintió excelente.
  excelente,
}

/// Registro diario por ejercicio dentro de una sesión concreta.
@Collection(accessor: 'registrosEjercicioSesion')
class RegistroEjercicioSesion {
  /// Crea un [RegistroEjercicioSesion].
  RegistroEjercicioSesion({
    this.id = Isar.autoIncrement,
    required this.orden,
    this.sensacion = SensacionEjercicio.normal,
  });

  /// Identificador autoincremental.
  Id id;

  /// Sesión a la que pertenece este registro.
  final sesion = IsarLink<SesionEntrenamiento>();

  /// Ejercicio evaluado en la sesión.
  final ejercicio = IsarLink<Ejercicio>();

  /// Orden del ejercicio dentro de la sesión o plantilla.
  late int orden;

  /// Sensación subjetiva del día para este ejercicio.
  @Enumerated(EnumType.name)
  SensacionEjercicio sensacion;
}