import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../inventory/presentation/providers/inventory_provider.dart';
import '../../../nutrition/data/models/alimento.dart';
import '../../../nutrition/data/models/ingrediente_receta.dart';
import '../../../nutrition/data/models/receta.dart';
import '../../../nutrition/data/models/registro_diario.dart';

part 'recipe_provider.freezed.dart';
part 'recipe_provider.g.dart';

/// Notifier para consultar recetas persistidas en Isar.
@riverpod
class RecipeListNotifier extends _$RecipeListNotifier {
  @override
  Future<List<Receta>> build() async {
    final isar = ref.read(inventoryIsarProvider);

    final recetas = await isar.recetas.where().findAll();
    await _loadRecipeLinks(recetas);
    return recetas;
  }

  /// Fuerza recarga de recetas desde base de datos.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }

  Future<void> _loadRecipeLinks(List<Receta> recetas) async {
    for (final receta in recetas) {
      await receta.ingredientes.load();
      for (final ingrediente in receta.ingredientes) {
        await ingrediente.alimento.load();
      }
    }
  }

  /// Actualiza metadatos básicos de una receta.
  Future<void> updateRecipeMeta({
    required int recipeId,
    required String nombre,
    required int raciones,
  }) async {
    final isar = ref.read(inventoryIsarProvider);
    final recipe = await isar.recetas.get(recipeId);
    if (recipe == null) {
      return;
    }

    recipe.nombre = nombre.trim();
    recipe.numeroRaciones = raciones < 1 ? 1 : raciones;

    await isar.writeTxn(() async {
      await isar.recetas.put(recipe);
    });

    await refresh();
  }

  /// Elimina receta, ingredientes vinculados y logs diarios asociados.
  Future<void> deleteRecipe(int recipeId) async {
    final isar = ref.read(inventoryIsarProvider);
    final recipe = await isar.recetas.get(recipeId);
    if (recipe == null) {
      return;
    }

    await recipe.ingredientes.load();
    final ingredientIds = recipe.ingredientes.map((e) => e.id).toList();

    final logs = await isar.registrosDiarios.where().findAll();
    final logIdsToDelete = logs
        .where((e) => e.esReceta && e.itemId == recipeId)
        .map((e) => e.id)
        .toList();

    await isar.writeTxn(() async {
      await recipe.ingredientes.reset();
      if (ingredientIds.isNotEmpty) {
        await isar.ingredientesReceta.deleteAll(ingredientIds);
      }
      if (logIdsToDelete.isNotEmpty) {
        await isar.registrosDiarios.deleteAll(logIdsToDelete);
      }
      await isar.recetas.delete(recipeId);
    });

    await refresh();
  }
}

/// Ingrediente temporal dentro del constructor de recetas.
@freezed
abstract class RecipeBuilderIngredient with _$RecipeBuilderIngredient {
  /// Crea un ingrediente temporal de receta.
  const factory RecipeBuilderIngredient({
    required Alimento alimento,
    required double cantidadGramos,
    @Default(GrupoComponenteReceta.principal) GrupoComponenteReceta grupo,
  }) = _RecipeBuilderIngredient;
}

/// Estado temporal para construcción de una receta nueva.
@freezed
abstract class RecipeBuilderState with _$RecipeBuilderState {
  /// Crea el estado de constructor de recetas.
  const factory RecipeBuilderState({
    int? editingRecipeId,
    @Default('') String nombre,
    @Default(1) int raciones,
    @Default(<RecipeBuilderIngredient>[])
    List<RecipeBuilderIngredient> ingredientes,
  }) = _RecipeBuilderState;
}

/// Notifier para gestionar el estado temporal de creación de recetas.
@Riverpod(keepAlive: true)
class RecipeBuilderNotifier extends _$RecipeBuilderNotifier {
  @override
  RecipeBuilderState build() => const RecipeBuilderState();

  /// Reinicia el estado del constructor.
  void resetBuilder() {
    state = const RecipeBuilderState();
  }

  /// Actualiza nombre de receta.
  void updateNombre(String nombre) {
    state = state.copyWith(nombre: nombre);
  }

  /// Actualiza raciones mínimas válidas.
  void updateRaciones(int raciones) {
    state = state.copyWith(raciones: raciones < 1 ? 1 : raciones);
  }

  /// Agrega un ingrediente temporal (alimento + gramos).
  void addIngrediente({
    required Alimento alimento,
    required double gramos,
    required GrupoComponenteReceta grupo,
  }) {
    final saneGramos = gramos < 0 ? 0.0 : gramos;
    final list = [...state.ingredientes];
    list.add(
      RecipeBuilderIngredient(
        alimento: alimento,
        cantidadGramos: saneGramos,
        grupo: grupo,
      ),
    );
    state = state.copyWith(ingredientes: list);
  }

  /// Elimina ingrediente temporal por índice.
  void removeIngredienteAt(int index) {
    final list = [...state.ingredientes]..removeAt(index);
    state = state.copyWith(ingredientes: list);
  }

  /// Actualiza gramos de un ingrediente temporal por índice.
  void updateIngredienteGramosAt(int index, double gramos) {
    if (index < 0 || index >= state.ingredientes.length) {
      return;
    }
    final list = [...state.ingredientes];
    final current = list[index];
    list[index] = current.copyWith(cantidadGramos: gramos <= 0 ? 1.0 : gramos);
    state = state.copyWith(ingredientes: list);
  }

  /// Carga una receta existente al constructor para edición completa.
  Future<void> loadRecipeForEdit(int recipeId) async {
    final isar = ref.read(inventoryIsarProvider);
    final recipe = await isar.recetas.get(recipeId);
    if (recipe == null) {
      return;
    }

    await recipe.ingredientes.load();
    final items = <RecipeBuilderIngredient>[];
    for (final ingredient in recipe.ingredientes) {
      await ingredient.alimento.load();
      final food = ingredient.alimento.value;
      if (food == null) {
        continue;
      }
      items.add(
        RecipeBuilderIngredient(
          alimento: food,
          cantidadGramos: ingredient.cantidadGramos,
          grupo: ingredient.grupo,
        ),
      );
    }

    if (!ref.mounted) return;
    state = RecipeBuilderState(
      editingRecipeId: recipe.id,
      nombre: recipe.nombre,
      raciones: recipe.numeroRaciones,
      ingredientes: items,
    );
  }

  /// Persiste receta e ingredientes en Isar, vincula relaciones y refresca listado.
  Future<void> saveRecipe() async {
    final isar = ref.read(inventoryIsarProvider);

    final recipeName = state.nombre.trim();
    if (recipeName.isEmpty || state.ingredientes.isEmpty) {
      throw StateError('La receta debe tener nombre e ingredientes.');
    }

    await isar.writeTxn(() async {
      final existingId = state.editingRecipeId;
      final receta = existingId == null
          ? Receta(nombre: recipeName, numeroRaciones: state.raciones)
          : (await isar.recetas.get(existingId)) ??
                Receta(nombre: recipeName, numeroRaciones: state.raciones);

      receta.nombre = recipeName;
      receta.numeroRaciones = state.raciones;
      receta.id = await isar.recetas.put(receta);

      await receta.ingredientes.load();
      final oldIds = receta.ingredientes.map((e) => e.id).toList();
      await receta.ingredientes.reset();
      if (oldIds.isNotEmpty) {
        await isar.ingredientesReceta.deleteAll(oldIds);
      }

      for (final ingredientDraft in state.ingredientes) {
        final ingrediente = IngredienteReceta(
          cantidadGramos: ingredientDraft.cantidadGramos,
          grupo: ingredientDraft.grupo,
        );

        ingrediente.alimento.value = ingredientDraft.alimento;
        ingrediente.id = await isar.ingredientesReceta.put(ingrediente);
        await ingrediente.alimento.save();

        receta.ingredientes.add(ingrediente);
      }

      await receta.ingredientes.save();
    });

    ref.invalidate(recipeListProvider);
    state = const RecipeBuilderState();
  }
}
