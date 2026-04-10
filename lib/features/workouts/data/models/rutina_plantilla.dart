import 'package:isar_community/isar.dart';

part 'rutina_plantilla.g.dart';

/// Plantilla reutilizable de entrenamiento.
@Collection(accessor: 'rutinasPlantilla')
class RutinaPlantilla {
  /// Crea una [RutinaPlantilla].
  RutinaPlantilla({
    this.id = Isar.autoIncrement,
    required this.nombre,
  });

  /// Identificador autoincremental.
  Id id;

  /// Nombre visible de la rutina.
  late String nombre;
}