import '../../data/models/receta.dart';
import '../models/nutritional_summary.dart';

/// Contrato para cálculos nutricionales.
abstract class NutritionCalculatorService {
  /// Calcula macros totales de una [Receta] considerando ingredientes y porciones base.
  Future<NutritionalSummary> calcularMacrosReceta(Receta receta);

  /// Calcula macros consumidos en un día a partir de los registros diarios.
  Future<NutritionalSummary> calcularMacrosConsumidosEnDia(DateTime fecha);
}
