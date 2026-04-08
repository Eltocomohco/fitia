import 'package:isar_community/isar.dart';

import 'alimento.dart';

part 'ingrediente_receta.g.dart';

/// Grupo funcional del ingrediente dentro de una receta.
enum GrupoComponenteReceta {
  /// Fuente principal del plato.
  principal,

  /// Componente vegetal del plato.
  vegetal,

  /// Componente añadido (salsa, topping, extra).
  anadido,
}

/// Extensiones de presentación para [GrupoComponenteReceta].
extension GrupoComponenteRecetaX on GrupoComponenteReceta {
  /// Etiqueta legible para UI.
  String get label {
    return switch (this) {
      GrupoComponenteReceta.principal => 'Principal',
      GrupoComponenteReceta.vegetal => 'Vegetal',
      GrupoComponenteReceta.anadido => 'Añadido',
    };
  }
}

/// Ingrediente de una receta asociado a un alimento y su cantidad en gramos.
@Collection(accessor: 'ingredientesReceta')
class IngredienteReceta {
  /// Crea un [IngredienteReceta].
  IngredienteReceta({
    this.id = Isar.autoIncrement,
    required this.cantidadGramos,
    this.grupo = GrupoComponenteReceta.principal,
  });

  /// Identificador autoincremental.
  Id id;

  /// Referencia al alimento base del ingrediente.
  final alimento = IsarLink<Alimento>();

  /// Cantidad usada del alimento en gramos.
  late double cantidadGramos;

  /// Grupo al que pertenece dentro de la receta.
  @Enumerated(EnumType.name)
  GrupoComponenteReceta grupo;
}
