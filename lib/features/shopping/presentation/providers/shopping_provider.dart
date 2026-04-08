import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';

part 'shopping_provider.g.dart';

/// Rango seleccionado para consolidar la lista de la compra.
@riverpod
class ShoppingRange extends _$ShoppingRange {
  @override
  DateTimeRange build() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 6));
    return DateTimeRange(start: start, end: end);
  }

  /// Actualiza el rango de consulta de compras.
  void setRange(DateTimeRange newRange) {
    state = newRange;
  }
}

/// Consolida ingredientes por rango temporal para lista de la compra.
@riverpod
class ShoppingListNotifier extends _$ShoppingListNotifier {
  @override
  Future<Map<Alimento, double>> build(DateTime start, DateTime end) async {
    final isar = ref.read(inventoryIsarProvider);

    final startAt = DateTime(start.year, start.month, start.day);
    final endAt = DateTime(end.year, end.month, end.day, 23, 59, 59, 999, 999);

    final logs = await isar.registrosDiarios
        .filter()
        .fechaBetween(startAt, endAt)
        .findAll();

    final gramsByFoodId = <int, double>{};

    for (final log in logs) {
      if (!log.esReceta) {
        gramsByFoodId.update(
          log.itemId,
          (value) => value + log.cantidadConsumidaGramos,
          ifAbsent: () => log.cantidadConsumidaGramos,
        );
        continue;
      }

      final receta = await isar.recetas.get(log.itemId);
      if (receta == null) {
        continue;
      }

      await receta.ingredientes.load();
      if (receta.ingredientes.isEmpty) {
        continue;
      }

      var totalBaseRecipeGrams = 0.0;
      for (final ingrediente in receta.ingredientes) {
        totalBaseRecipeGrams += ingrediente.cantidadGramos;
      }
      if (totalBaseRecipeGrams <= 0) {
        continue;
      }

      final proportion = log.cantidadConsumidaGramos / totalBaseRecipeGrams;

      for (final ingrediente in receta.ingredientes) {
        await ingrediente.alimento.load();
        final food = ingrediente.alimento.value;
        if (food == null) {
          continue;
        }

        final gramsToAdd = ingrediente.cantidadGramos * proportion;
        gramsByFoodId.update(
          food.id,
          (value) => value + gramsToAdd,
          ifAbsent: () => gramsToAdd,
        );
      }
    }

    final consolidated = <Alimento, double>{};
    for (final entry in gramsByFoodId.entries) {
      final food = await isar.alimentos.get(entry.key);
      if (food != null) {
        consolidated[food] = entry.value;
      }
    }

    return consolidated;
  }
}
