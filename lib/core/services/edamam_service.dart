import 'dart:convert';
import 'package:http/http.dart' as http;

class EdamamFoodResult {
  final String nombre;
  final double kcal;
  final double proteinas;
  final double carbohidratos;
  final double grasas;
  final String? externalId;

  EdamamFoodResult({
    required this.nombre,
    required this.kcal,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    this.externalId,
  });
}

class EdamamService {
  final String appId;
  final String appKey;

  EdamamService({
    String? appId,
    String? appKey,
  })  : appId = appId ?? const String.fromEnvironment('EDAMAM_APP_ID'),
        appKey = appKey ?? const String.fromEnvironment('EDAMAM_APP_KEY');

  /// Busca un alimento en Edamam con filtro Keto.
  Future<List<EdamamFoodResult>> searchFood(String query) async {
    if (appId.isEmpty || appKey.isEmpty) {
      throw Exception('Edamam API credentials are missing.');
    }

    final url = Uri.parse(
      'https://api.edamam.com/api/food-database/v2/parser'
      '?app_id=$appId'
      '&app_key=$appKey'
      '&ingr=${Uri.encodeComponent(query)}'
      '&health=keto-friendly'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hints = data['hints'] as List? ?? [];
      
      return hints.map((hint) {
        final food = hint['food'];
        final nutrients = food['nutrients'];
        
        return EdamamFoodResult(
          nombre: food['label'] ?? 'Unknown',
          kcal: (nutrients['ENERC_KCAL'] ?? 0).toDouble(),
          proteinas: (nutrients['PROCNT'] ?? 0).toDouble(),
          carbohidratos: (nutrients['CHOCDF'] ?? 0).toDouble(),
          grasas: (nutrients['FAT'] ?? 0).toDouble(),
          externalId: food['foodId'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load food data from Edamam: ${response.body}');
    }
  }
}
