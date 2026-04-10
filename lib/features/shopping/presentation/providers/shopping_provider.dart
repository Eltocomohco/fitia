import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/home_widget_service.dart';
import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';
import '../../data/models/despensa_producto.dart';
import '../../data/models/shopping_manual_item.dart';

part 'shopping_provider.g.dart';

/// Opción de producto comprable para sumar a despensa.
class ProductoCompraOption {
  /// Crea una [ProductoCompraOption].
  const ProductoCompraOption({
    required this.label,
    required this.gramsPerUnit,
  });

  /// Etiqueta visible en UI.
  final String label;

  /// Gramos equivalentes que aporta una unidad del producto.
  final double gramsPerUnit;
}

/// Fila consolidada de lista de la compra con stock aplicado.
class ShoppingListItem {
  /// Crea un [ShoppingListItem].
  const ShoppingListItem({
    required this.key,
    required this.name,
    required this.food,
    required this.requiredGrams,
    required this.availableGrams,
    required this.missingGrams,
    required this.productOptions,
    this.manualItemId,
  });

  /// Clave estable para UI.
  final String key;

  /// Nombre visible del item.
  final String name;

  /// Alimento base asociado.
  final Alimento? food;

  /// Gramos totales requeridos por el rango.
  final double requiredGrams;

  /// Gramos ya disponibles en inventario.
  final double availableGrams;

  /// Gramos que faltan por comprar.
  final double missingGrams;

  /// Productos sugeridos para cargar en despensa.
  final List<ProductoCompraOption> productOptions;

  /// ID manual si este item se añadió explícitamente por el usuario.
  final int? manualItemId;

  bool get isManualOnly => manualItemId != null;
}

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

/// Productos actualmente cargados en la despensa del usuario.
@riverpod
class PantryInventory extends _$PantryInventory {
  @override
  Future<List<DespensaProducto>> build() async {
    final isar = ref.read(inventoryIsarProvider);
    final items = await isar.despensaProductos.where().findAll();
    items.sort((a, b) {
      final byFood = a.nombreAlimento.toLowerCase().compareTo(
        b.nombreAlimento.toLowerCase(),
      );
      if (byFood != 0) {
        return byFood;
      }
      return a.nombreProducto.toLowerCase().compareTo(
        b.nombreProducto.toLowerCase(),
      );
    });
    return items;
  }

  /// Suma una unidad de producto a la despensa.
  Future<void> addProduct(Alimento food, ProductoCompraOption option) async {
    final isar = ref.read(inventoryIsarProvider);
    final current = state.asData?.value ?? <DespensaProducto>[];
    final existing = current.where((item) {
      return item.alimentoId == food.id && item.nombreProducto == option.label;
    }).firstOrNull;

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.cantidad += 1;
        await isar.despensaProductos.put(existing);
      } else {
        await isar.despensaProductos.put(
          DespensaProducto(
            alimentoId: food.id,
            nombreAlimento: food.nombre,
            nombreProducto: option.label,
            gramosPorUnidad: option.gramsPerUnit,
            cantidad: 1,
          ),
        );
      }
    });

    ref.invalidateSelf();
  }

  /// Resta una unidad de producto; si llega a cero, lo elimina.
  Future<void> removeOne(DespensaProducto item) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      if (item.cantidad <= 1) {
        await isar.despensaProductos.delete(item.id);
      } else {
        item.cantidad -= 1;
        await isar.despensaProductos.put(item);
      }
    });
    ref.invalidateSelf();
  }

  /// Vacía por completo la despensa de productos comprados.
  Future<void> clearPantry() async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.despensaProductos.clear();
    });
    ref.invalidateSelf();
  }
}

@riverpod
class ShoppingManualItems extends _$ShoppingManualItems {
  @override
  Future<List<ShoppingManualItem>> build(DateTime start, DateTime end) async {
    final isar = ref.read(inventoryIsarProvider);
    final startAt = DateTime(start.year, start.month, start.day);
    final endAt = DateTime(end.year, end.month, end.day, 23, 59, 59, 999, 999);

    final items = await isar.shoppingManualItems.where().findAll();
    final filtered = items.where((item) {
      return !item.endDate.isBefore(startAt) && !item.startDate.isAfter(endAt);
    }).toList(growable: false)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return filtered;
  }

  Future<void> addItem({
    required String name,
    required double grams,
    required DateTime start,
    required DateTime end,
  }) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.shoppingManualItems.put(
        ShoppingManualItem(
          name: name,
          grams: grams,
          startDate: DateTime(start.year, start.month, start.day),
          endDate: DateTime(end.year, end.month, end.day, 23, 59, 59, 999, 999),
        ),
      );
    });
    ref.invalidateSelf();
    await _syncShoppingWidget(start: start, end: end);
  }

  Future<void> removeItem(int itemId) async {
    final isar = ref.read(inventoryIsarProvider);
    await isar.writeTxn(() async {
      await isar.shoppingManualItems.delete(itemId);
    });
    ref.invalidateSelf();
    await _syncShoppingWidget(start: start, end: end);
  }

  Future<void> _syncShoppingWidget({
    required DateTime start,
    required DateTime end,
  }) async {
    final items = await ref.read(shoppingListProvider(start, end).future);
    await syncShoppingWidgetForRange(start: start, end: end, items: items);
  }
}

/// Consolida ingredientes por rango temporal para lista de la compra.
@riverpod
class ShoppingListNotifier extends _$ShoppingListNotifier {
  @override
  Future<List<ShoppingListItem>> build(DateTime start, DateTime end) async {
    final isar = ref.read(inventoryIsarProvider);
    final pantryItems = await ref.watch(pantryInventoryProvider.future);
    final manualItems = await ref.watch(
      shoppingManualItemsProvider(start, end).future,
    );

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

    final availableByFoodId = <int, double>{};
    for (final pantryItem in pantryItems) {
      availableByFoodId.update(
        pantryItem.alimentoId,
        (value) => value + pantryItem.gramosPorUnidad * pantryItem.cantidad,
        ifAbsent: () => pantryItem.gramosPorUnidad * pantryItem.cantidad,
      );
    }

    final consolidated = <ShoppingListItem>[];
    for (final entry in gramsByFoodId.entries) {
      final food = await isar.alimentos.get(entry.key);
      if (food == null) {
        continue;
      }

      final requiredGrams = entry.value;
      final availableGrams = availableByFoodId[food.id] ?? 0;
      final missingGrams = requiredGrams - availableGrams;
      if (missingGrams <= 0) {
        continue;
      }

      consolidated.add(
        ShoppingListItem(
          key: 'food-${food.id}',
          name: food.nombre,
          food: food,
          requiredGrams: requiredGrams,
          availableGrams: availableGrams,
          missingGrams: missingGrams,
          productOptions: buildProductOptions(food, missingGrams),
        ),
      );
    }

    final foods = await isar.alimentos.where().findAll();
    for (final manualItem in manualItems) {
      final linkedFood = foods.where((food) {
        return food.nombre.trim().toLowerCase() ==
            manualItem.name.trim().toLowerCase();
      }).firstOrNull;
      final availableGrams = linkedFood == null
          ? 0.0
          : (availableByFoodId[linkedFood.id] ?? 0.0);
      final missingGrams = manualItem.grams - availableGrams;
      if (missingGrams <= 0) {
        continue;
      }

      consolidated.add(
        ShoppingListItem(
          key: 'manual-${manualItem.id}',
          name: manualItem.name,
          food: linkedFood,
          requiredGrams: manualItem.grams,
          availableGrams: availableGrams,
          missingGrams: missingGrams,
          productOptions: linkedFood == null
              ? const <ProductoCompraOption>[]
              : buildProductOptions(linkedFood, missingGrams),
          manualItemId: manualItem.id,
        ),
      );
    }

    consolidated.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );

    await syncShoppingWidgetForRange(
      start: start,
      end: end,
      items: consolidated,
    );

    return consolidated;
  }
}

List<ProductoCompraOption> buildProductOptions(Alimento food, double missingGrams) {
  final normalized = food.nombre.toLowerCase();
  if (normalized.contains('huevo')) {
    return const [
      ProductoCompraOption(label: 'Cartón de 12 huevos', gramsPerUnit: 720),
      ProductoCompraOption(label: 'Media docena de huevos', gramsPerUnit: 360),
    ];
  }

  if (missingGrams >= 900) {
    return [
      ProductoCompraOption(label: '1 kg ${food.nombre}', gramsPerUnit: 1000),
      ProductoCompraOption(label: '0,5 kg ${food.nombre}', gramsPerUnit: 500),
    ];
  }

  return [
    ProductoCompraOption(label: '0,5 kg ${food.nombre}', gramsPerUnit: 500),
    ProductoCompraOption(label: '0,25 kg ${food.nombre}', gramsPerUnit: 250),
  ];
}

String buildShoppingReviewMessage(List<ShoppingListItem> items) {
  if (items.isEmpty) {
    return 'Ahora mismo no te falta nada por comprar.';
  }

  final names = items.take(6).map((item) => item.name).join(', ');
  return 'Revisa si te faltan: $names.';
}

Future<void> syncShoppingWidgetForRange({
  required DateTime start,
  required DateTime end,
  required List<ShoppingListItem> items,
}) {
  final subtitle =
      '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')} - ${end.day.toString().padLeft(2, '0')}/${end.month.toString().padLeft(2, '0')}';
  final lines = items.take(3).map((item) {
    return '${item.name} · ${item.missingGrams.toStringAsFixed(0)} g';
  }).toList(growable: false);
  while (lines.length < 3) {
    lines.add(lines.isEmpty ? 'Nada pendiente' : '');
  }

  return HomeWidgetService.updateShoppingWidget(
    title: 'Compra semanal',
    subtitle: subtitle,
    line1: lines[0],
    line2: lines[1],
    line3: lines[2],
    pendingCount: items.length,
  );
}
