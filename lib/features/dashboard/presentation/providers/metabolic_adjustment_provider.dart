import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../tracking/domain/services/metabolic_engine.dart';
import '../../../tracking/presentation/providers/tracking_provider.dart';
import 'daily_macros_provider.dart';

/// Sugerencia reactiva de reajuste calórico cuando el peso se estanca.
final metabolicAdjustmentSuggestionProvider =
    Provider<MetabolicAdjustmentSuggestion?>((ref) {
      final trackingAsync = ref.watch(bodyTrackingProvider);
      final macrosAsync = ref.watch(dailyMacrosProvider);

      final weights = trackingAsync.asData?.value;
      final macros = macrosAsync.asData?.value;
      if (weights == null || macros == null) {
        return null;
      }

      return MetabolicEngine.evaluate(weightHistory: weights, macros: macros);
    });
