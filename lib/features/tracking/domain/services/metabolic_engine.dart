import '../../../dashboard/presentation/providers/daily_macros_provider.dart';
import '../../../progress/data/models/metrica_corporal.dart';

/// Resultado del motor de reajuste metabólico.
class MetabolicAdjustmentSuggestion {
  /// Crea una [MetabolicAdjustmentSuggestion].
  const MetabolicAdjustmentSuggestion({
    required this.shouldAdjustCalories,
    required this.message,
    required this.currentKcalTarget,
    required this.weekOneAverage,
    required this.weekTwoAverage,
  });

  /// Indica si se recomienda revisar el objetivo calórico.
  final bool shouldAdjustCalories;

  /// Mensaje visible para la UI.
  final String message;

  /// Objetivo calórico actual sobre el que se emite la sugerencia.
  final double currentKcalTarget;

  /// Media de peso de la semana 1 analizada.
  final double weekOneAverage;

  /// Media de peso de la semana 2 analizada.
  final double weekTwoAverage;
}

/// Motor de reajuste metabólico basado en evolución reciente del peso.
abstract final class MetabolicEngine {
  /// Evalúa si existe estancamiento comparando dos ventanas semanales.
  static MetabolicAdjustmentSuggestion? evaluate({
    required List<MetricaCorporal> weightHistory,
    required DailyMacrosState macros,
  }) {
    if (weightHistory.length < 8) {
      return null;
    }

    final ordered = [...weightHistory]
      ..sort((a, b) => b.fecha.compareTo(a.fecha));
    final recentFourteen = ordered.take(14).toList(growable: false);
    if (recentFourteen.length < 8) {
      return null;
    }

    final weekTwo = recentFourteen.take(7).toList(growable: false);
    final weekOne = recentFourteen.skip(7).take(7).toList(growable: false);
    if (weekOne.isEmpty || weekTwo.isEmpty) {
      return null;
    }

    final weekOneAverage = _averageWeight(weekOne);
    final weekTwoAverage = _averageWeight(weekTwo);
    final difference = (weekTwoAverage - weekOneAverage).abs();

    if (difference >= 0.2) {
      return null;
    }

    return MetabolicAdjustmentSuggestion(
      shouldAdjustCalories: true,
      message:
          'Se detecta estancamiento de peso en las últimas dos semanas. Revisa tu objetivo actual de ${macros.kcalObjetivo.toStringAsFixed(0)} kcal.',
      currentKcalTarget: macros.kcalObjetivo,
      weekOneAverage: weekOneAverage,
      weekTwoAverage: weekTwoAverage,
    );
  }

  static double _averageWeight(List<MetricaCorporal> metrics) {
    return metrics.fold<double>(0, (sum, metric) => sum + metric.peso) /
        metrics.length;
  }
}
