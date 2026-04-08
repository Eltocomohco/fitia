import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/domain/models/nutritional_summary.dart';
import '../../../nutrition/domain/services/nutrition_calculator_service.dart'
    as contract;

/// Implementación del cálculo nutricional para recetas.
class RecipeNutritionCalculatorService
    implements contract.NutritionCalculatorService {
  /// Crea el servicio de cálculo nutricional.
  const RecipeNutritionCalculatorService();

  @override
  Future<NutritionalSummary> calcularMacrosReceta(Receta receta) {
    return receta.calcularResumenNutricionalPorRacion();
  }

  @override
  Future<NutritionalSummary> calcularMacrosConsumidosEnDia(
    DateTime fecha,
  ) async {
    return const NutritionalSummary();
  }
}

/// Extensión para obtener macros totales de receta por ración.
extension RecetaNutritionExtension on Receta {
  /// Calcula energía y macros por ración con enlaces cargados de ingredientes.
  Future<NutritionalSummary> calcularResumenNutricionalPorRacion() async {
    await ingredientes.load();

    var kcal = 0.0;
    var proteinas = 0.0;
    var carbohidratos = 0.0;
    var grasas = 0.0;

    for (final ingrediente in ingredientes) {
      await ingrediente.alimento.load();
      final alimento = ingrediente.alimento.value;
      if (alimento == null || alimento.porcionBaseGramos <= 0) {
        continue;
      }

      final factor = ingrediente.cantidadGramos / alimento.porcionBaseGramos;
      kcal += alimento.kcal * factor;
      proteinas += alimento.proteinas * factor;
      carbohidratos += alimento.carbohidratos * factor;
      grasas += alimento.grasas * factor;
    }

    final divisor = numeroRaciones <= 0 ? 1 : numeroRaciones;

    return NutritionalSummary(
      kcal: kcal / divisor,
      proteinas: proteinas / divisor,
      carbohidratos: carbohidratos / divisor,
      grasas: grasas / divisor,
    );
  }
}
