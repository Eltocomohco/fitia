import 'package:isar_community/isar.dart';

part 'alimento.g.dart';

/// Grupo nutricional usado para componer recetas por etapas.
enum GrupoAlimento {
  /// Fuente principal del plato.
  principal,

  /// Componente vegetal.
  vegetal,

  /// Extra/añadido.
  anadido,
}

/// Utilidades de presentación para [GrupoAlimento].
extension GrupoAlimentoX on GrupoAlimento {
  /// Etiqueta visible para UI y JSON.
  String get label {
    return switch (this) {
      GrupoAlimento.principal => 'principal',
      GrupoAlimento.vegetal => 'vegetal',
      GrupoAlimento.anadido => 'anadido',
    };
  }
}

/// Entidad de alimento base con macros por porción de referencia.
@Collection(accessor: 'alimentos')
class Alimento {
  /// Crea un [Alimento].
  Alimento({
    this.id = Isar.autoIncrement,
    this.externalId,
    required this.nombre,
    required this.kcal,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    this.porcionBaseGramos = 100.0,
    this.grupos = const [],
  });

  /// Identificador autoincremental.
  Id id;

  /// Identificador externo opcional para sincronización/importación.
  @Index(caseSensitive: false)
  String? externalId;

  /// Nombre del alimento.
  @Index(caseSensitive: false)
  late String nombre;

  /// Kilocalorías por [porcionBaseGramos].
  late double kcal;

  /// Proteínas (g) por [porcionBaseGramos].
  late double proteinas;

  /// Carbohidratos (g) por [porcionBaseGramos].
  late double carbohidratos;

  /// Grasas (g) por [porcionBaseGramos].
  late double grasas;

  /// Tamaño de porción base en gramos.
  double porcionBaseGramos = 100.0;

  /// Grupos a los que pertenece el alimento para construir recetas por pasos.
  List<String> grupos;
}
