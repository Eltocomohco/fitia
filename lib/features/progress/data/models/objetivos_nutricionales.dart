import 'package:isar_community/isar.dart';

part 'objetivos_nutricionales.g.dart';

/// Objetivos diarios de energía y macronutrientes del usuario.
@Collection(accessor: 'objetivosNutricionales')
class ObjetivosNutricionales {
  /// Crea un registro de objetivos nutricionales.
  ObjetivosNutricionales({
    this.id = Isar.autoIncrement,
    this.kcalObjetivo = 2000,
    this.proteinasObjetivo = 150,
    this.carbohidratosObjetivo = 25,
    this.grasasObjetivo = 140,
    this.aguaObjetivoMl = 2500,
  });

  /// Identificador autoincremental.
  Id id;

  /// Calorías objetivo diarias.
  double kcalObjetivo;

  /// Proteínas objetivo diarias (g).
  double proteinasObjetivo;

  /// Carbohidratos objetivo diarios (g).
  double carbohidratosObjetivo;

  /// Grasas objetivo diarias (g).
  double grasasObjetivo;

  /// Agua objetivo diaria (ml).
  double aguaObjetivoMl;
}
