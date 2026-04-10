import 'package:isar_community/isar.dart';

part 'sesion_ayuno.g.dart';

/// Sesión singleton para el seguimiento del ayuno intermitente.
@Collection(accessor: 'sesionesAyuno')
class SesionAyuno {
  /// Crea una [SesionAyuno] con estado por defecto inactivo.
  SesionAyuno({
    this.id = 1,
    required this.fechaInicio,
    this.horasObjetivo = 16,
    this.activa = false,
  });

  /// Construye una sesión inactiva con sello temporal actual.
  factory SesionAyuno.inactive() {
    return SesionAyuno(fechaInicio: DateTime.now());
  }

  /// Identificador fijo del documento singleton.
  Id id;

  /// Momento en el que comenzó el ayuno.
  DateTime fechaInicio;

  /// Horas objetivo del ayuno actual.
  int horasObjetivo;

  /// Indica si el ayuno sigue activo.
  bool activa;
}