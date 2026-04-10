import '../../data/models/serie.dart';

/// Utilidades biomecánicas para analizar el rendimiento en entrenamientos.
abstract final class BiomechanicsCalculator {
  /// Estima el 1RM con la fórmula de Epley.
  static double calculate1RM(double weight, int reps) {
    if (weight <= 0 || reps <= 0) {
      return 0;
    }
    return weight * (1 + (reps / 30));
  }

  /// Calcula el tonelaje total de una colección de series completadas.
  static double calculateTonnage(List<Serie> series) {
    return series
        .where((serie) => serie.completada)
        .fold<double>(
          0,
          (sum, serie) => sum + (serie.pesoKg * serie.repeticiones),
        );
  }
}
