import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/ingrediente_receta.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';

part 'inventory_provider.g.dart';

/// Instancia activa de Isar para el módulo de inventario.
final inventoryIsarProvider = Provider<Isar>((ref) {
  final instance = Isar.instanceNames.isNotEmpty
      ? Isar.getInstance(Isar.instanceNames.first)
      : null;

  if (instance == null) {
    throw StateError('No existe una instancia de Isar activa.');
  }

  return instance;
});

/// Controlador de estado para la lista de alimentos base.
@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  @override
  Future<List<Alimento>> build() async {
    final isar = ref.read(inventoryIsarProvider);
    return isar.alimentos.where().findAll();
  }

  /// Inserta un nuevo alimento y actualiza el estado en memoria.
  Future<void> addAlimento(Alimento nuevoAlimento) async {
    final isar = ref.read(inventoryIsarProvider);

    try {
      final insertedId = await isar.writeTxn(() async {
        return isar.alimentos.put(nuevoAlimento);
      });

      nuevoAlimento.id = insertedId;

      final currentList = state.asData?.value ?? <Alimento>[];
      state = AsyncData([...currentList, nuevoAlimento]);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Actualiza un alimento existente.
  Future<void> updateAlimento(Alimento alimento) async {
    final isar = ref.read(inventoryIsarProvider);

    try {
      await isar.writeTxn(() async {
        await isar.alimentos.put(alimento);
      });

      final currentList = [...(state.asData?.value ?? <Alimento>[])];
      final index = currentList.indexWhere((e) => e.id == alimento.id);
      if (index >= 0) {
        currentList[index] = alimento;
      }
      state = AsyncData(currentList);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Elimina un alimento y limpia referencias asociadas.
  Future<void> deleteAlimento(int alimentoId) async {
    final isar = ref.read(inventoryIsarProvider);

    try {
      final ingredientes = await isar.ingredientesReceta.where().findAll();
      final recipes = await isar.recetas.where().findAll();
      final logs = await isar.registrosDiarios.where().findAll();

      final ingredientIdsToDelete = <int>[];
      for (final ingrediente in ingredientes) {
        await ingrediente.alimento.load();
        if (ingrediente.alimento.value?.id == alimentoId) {
          ingredientIdsToDelete.add(ingrediente.id);
        }
      }

      final logIdsToDelete = logs
          .where((e) => !e.esReceta && e.itemId == alimentoId)
          .map((e) => e.id)
          .toList();

      await isar.writeTxn(() async {
        if (ingredientIdsToDelete.isNotEmpty) {
          for (final recipe in recipes) {
            await recipe.ingredientes.load();
            recipe.ingredientes.removeWhere(
              (ing) => ingredientIdsToDelete.contains(ing.id),
            );
            await recipe.ingredientes.save();
          }
          await isar.ingredientesReceta.deleteAll(ingredientIdsToDelete);
        }

        if (logIdsToDelete.isNotEmpty) {
          await isar.registrosDiarios.deleteAll(logIdsToDelete);
        }

        await isar.alimentos.delete(alimentoId);
      });

      final updated = (state.asData?.value ?? <Alimento>[])
          .where((e) => e.id != alimentoId)
          .toList();
      state = AsyncData(updated);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
