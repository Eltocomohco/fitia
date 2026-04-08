import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutritional_summary.freezed.dart';
part 'nutritional_summary.g.dart';

/// Resumen agregado de macronutrientes y energía.
@freezed
abstract class NutritionalSummary with _$NutritionalSummary {
  /// Crea un [NutritionalSummary].
  const factory NutritionalSummary({
    @Default(0) double kcal,
    @Default(0) double proteinas,
    @Default(0) double carbohidratos,
    @Default(0) double grasas,
  }) = _NutritionalSummary;

  /// Crea un [NutritionalSummary] desde JSON.
  factory NutritionalSummary.fromJson(Map<String, dynamic> json) =>
      _$NutritionalSummaryFromJson(json);
}
