import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../features/nutrition/data/models/alimento.dart';

/// Motivos conocidos de fallo al consultar OpenFoodFacts.
enum OpenFoodFactsLookupFailure {
  invalidBarcode,
  notFound,
  network,
  invalidResponse,
}

/// Excepción tipada para distinguir errores de consulta en la UI.
class OpenFoodFactsLookupException implements Exception {
  const OpenFoodFactsLookupException(this.failure);

  final OpenFoodFactsLookupFailure failure;
}

/// Cliente mínimo para consultar alimentos por código de barras en OpenFoodFacts.
class OpenFoodFactsService {
  const OpenFoodFactsService({http.Client? client}) : _client = client;

  final http.Client? _client;

  /// Obtiene macros por 100 g a partir de un código de barras.
  Future<Alimento> getMacrosFromBarcode(String barcode) async {
    final normalized = barcode.trim();
    if (normalized.isEmpty) {
      throw const OpenFoodFactsLookupException(
        OpenFoodFactsLookupFailure.invalidBarcode,
      );
    }

    final client = _client ?? http.Client();
    final shouldClose = _client == null;

    try {
      late final http.Response response;
      try {
        response = await client
            .get(
              Uri.parse(
                'https://world.openfoodfacts.org/api/v0/product/$normalized.json',
              ),
            )
            .timeout(const Duration(seconds: 12));
      } on Exception {
        throw const OpenFoodFactsLookupException(
          OpenFoodFactsLookupFailure.network,
        );
      }

      if (response.statusCode != 200) {
        throw const OpenFoodFactsLookupException(
          OpenFoodFactsLookupFailure.network,
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const OpenFoodFactsLookupException(
          OpenFoodFactsLookupFailure.invalidResponse,
        );
      }

      final map = decoded;
      if ((map['status'] as num?)?.toInt() != 1) {
        throw const OpenFoodFactsLookupException(
          OpenFoodFactsLookupFailure.notFound,
        );
      }

      final product = map['product'] as Map<String, dynamic>?;
      final nutriments = product?['nutriments'] as Map<String, dynamic>?;
      if (product == null || nutriments == null) {
        throw const OpenFoodFactsLookupException(
          OpenFoodFactsLookupFailure.invalidResponse,
        );
      }

      return Alimento(
        externalId: normalized,
        nombre: (product['product_name'] as String?)?.trim().isNotEmpty == true
            ? (product['product_name'] as String).trim()
            : 'Producto $normalized',
        kcal: _toDouble(nutriments['energy-kcal_100g']),
        proteinas: _toDouble(nutriments['proteins_100g']),
        carbohidratos: _toDouble(nutriments['carbohydrates_100g']),
        grasas: _toDouble(nutriments['fat_100g']),
        porcionBaseGramos: 100,
        grupos: const [],
      );
    } on OpenFoodFactsLookupException {
      rethrow;
    } finally {
      if (shouldClose) {
        client.close();
      }
    }
  }

  double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '.')) ?? 0;
    }
    return 0;
  }
}