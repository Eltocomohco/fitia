// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritional_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NutritionalSummary _$NutritionalSummaryFromJson(Map<String, dynamic> json) =>
    _NutritionalSummary(
      kcal: (json['kcal'] as num?)?.toDouble() ?? 0,
      proteinas: (json['proteinas'] as num?)?.toDouble() ?? 0,
      carbohidratos: (json['carbohidratos'] as num?)?.toDouble() ?? 0,
      grasas: (json['grasas'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$NutritionalSummaryToJson(_NutritionalSummary instance) =>
    <String, dynamic>{
      'kcal': instance.kcal,
      'proteinas': instance.proteinas,
      'carbohidratos': instance.carbohidratos,
      'grasas': instance.grasas,
    };
