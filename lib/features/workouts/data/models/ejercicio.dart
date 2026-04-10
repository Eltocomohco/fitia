import 'package:isar_community/isar.dart';

part 'ejercicio.g.dart';

/// Clasificación operativa del ejercicio para automatizaciones y descansos.
enum TipoEjercicio {
  /// Trabajo de movilidad y activación previa.
  movilidad,

  /// Trabajo principal de fuerza o hipertrofia.
  fuerza,

  /// Trabajo de vuelta a la calma y liberación.
  estiramiento,
}

/// Ejercicio base disponible para construir rutinas y sesiones.
@Collection(accessor: 'ejercicios')
class Ejercicio {
  /// Crea un [Ejercicio].
  Ejercicio({
    this.id = Isar.autoIncrement,
    required this.nombre,
    required this.grupoMuscular,
    required this.tiempoDescansoBaseSegundos,
    this.descripcionBreve,
    this.tipoEjercicio = TipoEjercicio.fuerza,
  });

  /// Identificador autoincremental.
  Id id;

  /// Nombre legible del ejercicio.
  late String nombre;

  /// Grupo muscular predominante del ejercicio.
  late String grupoMuscular;

  /// Descanso sugerido entre series para este ejercicio.
  late int tiempoDescansoBaseSegundos;

  /// Indicación breve para ejercicios guiados como movilidad o estiramientos.
  String? descripcionBreve;

  /// Tipo técnico usado para automatización y descansos.
  @Enumerated(EnumType.name)
  TipoEjercicio tipoEjercicio;
}
