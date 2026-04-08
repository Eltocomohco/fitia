import '../../data/models/alimento.dart';

/// Contrato para consolidación de lista de compras por rango de fechas.
abstract class ShoppingListService {
  /// Consolida ingredientes necesarios entre [startDate] y [endDate].
  ///
  /// Retorna un mapa con alimento y gramos totales requeridos.
  Future<Map<Alimento, double>> consolidarIngredientes({
    required DateTime startDate,
    required DateTime endDate,
  });
}
