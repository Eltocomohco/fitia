import 'package:isar_community/isar.dart';

part 'sesion_entrenamiento.g.dart';

/// Estado persistido de una sesión de entrenamiento.
enum EstadoSesionEntrenamiento {
  /// La sesión está abierta y admite cambios.
  activa,

  /// La sesión fue cerrada por el usuario.
  completada,
}

/// Sesión real de entrenamiento ejecutada por el usuario.
@Collection(accessor: 'sesionesEntrenamiento')
class SesionEntrenamiento {
  /// Crea una [SesionEntrenamiento].
  SesionEntrenamiento({
    this.id = Isar.autoIncrement,
    required this.fechaInicio,
    this.fechaFin,
    this.rutinaPlantillaId,
    this.estado = EstadoSesionEntrenamiento.activa,
  });

  /// Identificador autoincremental.
  Id id;

  /// Momento de apertura de la sesión.
  late DateTime fechaInicio;

  /// Momento de cierre de la sesión, si ya terminó.
  DateTime? fechaFin;

  /// Rutina origen si la sesión se abrió desde una plantilla.
  int? rutinaPlantillaId;

  /// Estado actual de la sesión.
  @Enumerated(EnumType.name)
  EstadoSesionEntrenamiento estado;
}