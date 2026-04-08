import 'package:isar_community/isar.dart';

import 'ingrediente_receta.dart';

part 'receta.g.dart';

/// Receta compuesta por múltiples ingredientes enlazados.
@Collection(accessor: 'recetas')
class Receta {
  /// Crea una [Receta].
  Receta({
    this.id = Isar.autoIncrement,
    this.externalId,
    required this.nombre,
    this.instrucciones,
    this.numeroRaciones = 1,
  });

  /// Identificador autoincremental.
  Id id;

  /// Identificador externo opcional para sincronización/importación.
  @Index(caseSensitive: false)
  String? externalId;

  /// Nombre de la receta.
  @Index(caseSensitive: false)
  late String nombre;

  /// Instrucciones opcionales de preparación.
  String? instrucciones;

  /// Número de raciones de la receta.
  int numeroRaciones = 1;

  /// Ingredientes asociados a la receta.
  final ingredientes = IsarLinks<IngredienteReceta>();
}
