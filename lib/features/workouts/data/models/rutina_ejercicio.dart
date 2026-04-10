import 'package:isar_community/isar.dart';

import 'ejercicio.dart';
import 'rutina_plantilla.dart';

part 'rutina_ejercicio.g.dart';

/// Relación ordenada entre una rutina plantilla y un ejercicio.
@Collection(accessor: 'rutinasEjercicio')
class RutinaEjercicio {
  /// Crea una [RutinaEjercicio].
  RutinaEjercicio({
    this.id = Isar.autoIncrement,
    required this.orden,
    this.seriesObjetivo = 3,
    this.repeticionesMinimasObjetivo,
    this.repeticionesMaximasObjetivo,
    this.pesoObjetivoKg,
  });

  /// Identificador autoincremental.
  Id id;

  /// Referencia a la rutina que contiene el ejercicio.
  final rutina = IsarLink<RutinaPlantilla>();

  /// Referencia al ejercicio asociado.
  final ejercicio = IsarLink<Ejercicio>();

  /// Posición lineal dentro de la rutina.
  late int orden;

  /// Número objetivo de series para este ejercicio.
  late int seriesObjetivo;

  /// Rango mínimo de repeticiones recomendado.
  int? repeticionesMinimasObjetivo;

  /// Rango máximo de repeticiones recomendado.
  int? repeticionesMaximasObjetivo;

  /// Peso objetivo de referencia para el ejercicio.
  double? pesoObjetivoKg;
}