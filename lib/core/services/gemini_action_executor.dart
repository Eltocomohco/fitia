import 'package:isar_community/isar.dart';

import '../../features/nutrition/data/models/alimento.dart';
import '../../features/nutrition/data/models/ingrediente_receta.dart';
import '../../features/nutrition/data/models/receta.dart';
import '../../features/nutrition/data/models/registro_diario.dart';
import '../../features/progress/data/models/metrica_corporal.dart';
import '../../features/workouts/data/models/ejercicio.dart';
import '../../features/workouts/data/models/rutina_ejercicio.dart';
import '../../features/workouts/data/models/rutina_plantilla.dart';
import '../../features/workouts/presentation/providers/workout_routine_provider.dart';
import 'gemini_companion_service.dart';

class GeminiActionExecutionResult {
  const GeminiActionExecutionResult({
    required this.applied,
    required this.messages,
  });

  final int applied;
  final List<String> messages;

  String get summary => messages.join('\n');
}

abstract final class GeminiActionExecutor {
  static Future<GeminiActionExecutionResult> apply({
    required List<GeminiActionProposal> actions,
    required Isar isar,
  }) async {
    final messages = <String>[];
    var applied = 0;
    final orderedActions = [...actions]..sort(_actionPriorityCompare);

    for (final action in orderedActions) {
      switch (action.type) {
        case GeminiActionType.addFood:
          final message = await _applyAddFood(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.updateFood:
          final message = await _applyUpdateFood(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.createExercise:
          final message = await _applyCreateExercise(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.createRoutine:
          final message = await _applyCreateRoutine(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.updateRoutine:
          final message = await _applyUpdateRoutine(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.deleteRoutine:
          final message = await _applyDeleteRoutine(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.createRecipe:
          final message = await _applyCreateRecipe(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.updateRecipe:
          final message = await _applyUpdateRecipe(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.deleteRecipe:
          final message = await _applyDeleteRecipe(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.updateBodyMetric:
          final message = await _applyUpdateBodyMetric(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.planWeeklyMenu:
          final message = await _applyPlanWeeklyMenu(isar, action);
          messages.add(message);
          if (message.startsWith('OK:')) {
            applied += 1;
          }
        case GeminiActionType.openShoppingList:
          messages.add('OK: lista de la compra lista para revisar.');
          applied += 1;
      }
    }

    return GeminiActionExecutionResult(applied: applied, messages: messages);
  }

  static Future<String> _applyCreateExercise(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final exerciseName =
        payload['name']?.toString().trim() ??
        payload['nombre']?.toString().trim() ??
        '';
    if (exerciseName.isEmpty) {
      return 'ERROR: create_exercise sin nombre.';
    }

    final catalog = await isar.ejercicios.where().findAll();
    final duplicate = _findExerciseByName(catalog, exerciseName);
    if (duplicate != null) {
      return 'ERROR: el ejercicio "$exerciseName" ya existe.';
    }

    final muscleGroup =
        payload['muscleGroup']?.toString().trim() ??
        payload['grupoMuscular']?.toString().trim() ??
        'general';
    final restSeconds = _toInt(
          payload['restSeconds'] ?? payload['tiempoDescansoBaseSegundos'],
        ) ??
        90;
    final description = payload['description']?.toString().trim();

    final exercise = Ejercicio(
      nombre: exerciseName,
      grupoMuscular: muscleGroup.isEmpty ? 'general' : muscleGroup,
      tiempoDescansoBaseSegundos: restSeconds < 15 ? 15 : restSeconds,
      descripcionBreve: description == null || description.isEmpty
          ? null
          : description,
      tipoEjercicio: _toExerciseType(payload['exerciseType']),
    );

    await isar.writeTxn(() async {
      exercise.id = await isar.ejercicios.put(exercise);
    });

    return 'OK: ejercicio "$exerciseName" añadido.';
  }

  static Future<String> _applyAddFood(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final name = payload['nombre']?.toString().trim() ?? '';
    if (name.isEmpty) {
      return 'ERROR: add_food sin nombre.';
    }

    final existing = await isar.alimentos.where().findAll();
    final duplicate = existing.any(
      (item) => item.nombre.trim().toLowerCase() == name.toLowerCase(),
    );
    if (duplicate) {
      return 'ERROR: el alimento "$name" ya existe.';
    }

    final kcal = _toDouble(payload['kcal']);
    final proteins = _toDouble(payload['proteinas']);
    final carbs = _toDouble(payload['carbohidratos']);
    final fats = _toDouble(payload['grasas']);
    final portion = _toDouble(payload['porcionBaseGramos']) ?? 100;
    if ([kcal, proteins, carbs, fats].contains(null)) {
      return 'ERROR: faltan macros validos para "$name".';
    }

    final groups = (payload['grupos'] as List?)
            ?.map((value) => value.toString().trim())
            .where((value) => value.isNotEmpty)
            .toList(growable: false) ??
        const <String>[];

    final food = Alimento(
      nombre: name,
      kcal: kcal!,
      proteinas: proteins!,
      carbohidratos: carbs!,
      grasas: fats!,
      porcionBaseGramos: portion <= 0 ? 100 : portion,
      grupos: groups,
    );

    await isar.writeTxn(() async {
      food.id = await isar.alimentos.put(food);
    });

    return 'OK: alimento "$name" añadido.';
  }

  static Future<String> _applyUpdateFood(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final name = action.match['nombre']?.toString().trim() ?? '';
    if (name.isEmpty) {
      return 'ERROR: update_food sin criterio de nombre.';
    }

    final foods = await isar.alimentos.where().findAll();
    final food = _findFoodByName(foods, name);
    if (food == null) {
      return 'ERROR: no existe alimento llamado "$name".';
    }

    final changes = action.changes;
    if (changes.isEmpty) {
      return 'ERROR: update_food sin cambios para "$name".';
    }

    final newName = changes['nombre']?.toString().trim();
    if (newName != null && newName.isNotEmpty) {
      food.nombre = newName;
    }
    final kcal = _toDouble(changes['kcal']);
    if (kcal != null) {
      food.kcal = kcal;
    }
    final proteins = _toDouble(changes['proteinas']);
    if (proteins != null) {
      food.proteinas = proteins;
    }
    final carbs = _toDouble(changes['carbohidratos']);
    if (carbs != null) {
      food.carbohidratos = carbs;
    }
    final fats = _toDouble(changes['grasas']);
    if (fats != null) {
      food.grasas = fats;
    }
    final portion = _toDouble(changes['porcionBaseGramos']);
    if (portion != null && portion > 0) {
      food.porcionBaseGramos = portion;
    }
    final groups = (changes['grupos'] as List?)
        ?.map((value) => value.toString().trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);
    if (groups != null) {
      food.grupos = groups;
    }

    await isar.writeTxn(() async {
      await isar.alimentos.put(food);
    });

    return 'OK: alimento "$name" actualizado.';
  }

  static Future<String> _applyCreateRoutine(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final routineName = payload['name']?.toString().trim() ?? '';
    if (routineName.isEmpty) {
      return 'ERROR: create_routine sin nombre.';
    }

    final routines = await isar.rutinasPlantilla.where().findAll();
    final duplicate = routines.any(
      (item) => item.nombre.trim().toLowerCase() == routineName.toLowerCase(),
    );
    if (duplicate) {
      return 'ERROR: la rutina "$routineName" ya existe.';
    }

    final rawExercises = payload['exercises'];
    if (rawExercises is! List || rawExercises.isEmpty) {
      return 'ERROR: la rutina "$routineName" no trae ejercicios validos.';
    }

    final catalog = await isar.ejercicios.where().findAll();
    final draftExercises = <WorkoutRoutineDraftExercise>[];
    final missing = <String>[];

    for (final rawExercise in rawExercises) {
      if (rawExercise is! Map) {
        continue;
      }
      final exerciseName = rawExercise['exerciseName']?.toString().trim() ?? '';
      if (exerciseName.isEmpty) {
        continue;
      }

      final exercise = _findExerciseByName(catalog, exerciseName);
      if (exercise == null) {
        missing.add(exerciseName);
        continue;
      }

      draftExercises.add(
        WorkoutRoutineDraftExercise(
          exercise: exercise,
          targetSets: _toInt(rawExercise['targetSets']) ?? 3,
          targetRepsMin: _toInt(rawExercise['targetRepsMin']),
          targetRepsMax: _toInt(rawExercise['targetRepsMax']),
          targetWeightKg: _toDouble(rawExercise['targetWeightKg']),
        ),
      );
    }

    if (missing.isNotEmpty) {
      return 'ERROR: ejercicios no encontrados para "$routineName": ${missing.join(', ')}. Propón primero acciones create_exercise y vuelve a aplicar la rutina.';
    }
    if (draftExercises.isEmpty) {
      return 'ERROR: la rutina "$routineName" no contiene ejercicios aplicables.';
    }

    final routine = RutinaPlantilla(nombre: routineName);

    await isar.writeTxn(() async {
      routine.id = await isar.rutinasPlantilla.put(routine);

      for (var index = 0; index < draftExercises.length; index++) {
        final draft = draftExercises[index];
        final relation = RutinaEjercicio(
          orden: index,
          seriesObjetivo: draft.targetSets < 1 ? 1 : draft.targetSets,
          repeticionesMinimasObjetivo: draft.targetRepsMin,
          repeticionesMaximasObjetivo: draft.targetRepsMax,
          pesoObjetivoKg: draft.targetWeightKg,
        );
        relation.rutina.value = routine;
        relation.ejercicio.value = draft.exercise;
        relation.id = await isar.rutinasEjercicio.put(relation);
        await relation.rutina.save();
        await relation.ejercicio.save();
      }
    });

    return 'OK: rutina "$routineName" creada con ${draftExercises.length} ejercicios.';
  }

  static Future<String> _applyUpdateRoutine(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final matchName =
        action.match['name']?.toString().trim() ??
        action.match['nombre']?.toString().trim() ??
        action.payload['name']?.toString().trim() ??
        '';
    if (matchName.isEmpty) {
      return 'ERROR: update_routine sin nombre de rutina.';
    }

    final routines = await isar.rutinasPlantilla.where().findAll();
    final routine = _findRoutineByName(routines, matchName);
    if (routine == null) {
      return 'ERROR: no existe rutina llamada "$matchName".';
    }

    final updatedName = action.payload['name']?.toString().trim();
    final payload = action.payload;
    final rawExercises = payload['exercises'];
    if (rawExercises is! List || rawExercises.isEmpty) {
      return 'ERROR: update_routine sin ejercicios validos para "$matchName".';
    }

    final catalog = await isar.ejercicios.where().findAll();
    final draftExercises = <WorkoutRoutineDraftExercise>[];
    final missing = <String>[];
    for (final rawExercise in rawExercises) {
      if (rawExercise is! Map) {
        continue;
      }
      final exerciseName = rawExercise['exerciseName']?.toString().trim() ?? '';
      if (exerciseName.isEmpty) {
        continue;
      }
      final exercise = _findExerciseByName(catalog, exerciseName);
      if (exercise == null) {
        missing.add(exerciseName);
        continue;
      }
      draftExercises.add(
        WorkoutRoutineDraftExercise(
          exercise: exercise,
          targetSets: _toInt(rawExercise['targetSets']) ?? 3,
          targetRepsMin: _toInt(rawExercise['targetRepsMin']),
          targetRepsMax: _toInt(rawExercise['targetRepsMax']),
          targetWeightKg: _toDouble(rawExercise['targetWeightKg']),
        ),
      );
    }

    if (missing.isNotEmpty) {
      return 'ERROR: ejercicios no encontrados para "$matchName": ${missing.join(', ')}. Propón primero acciones create_exercise y vuelve a aplicar la rutina.';
    }
    if (draftExercises.isEmpty) {
      return 'ERROR: update_routine no contiene ejercicios aplicables para "$matchName".';
    }

    final allRelations = await isar.rutinasEjercicio.where().findAll();
    final existingRelations = <RutinaEjercicio>[];
    for (final relation in allRelations) {
      await relation.rutina.load();
      if (relation.rutina.value?.id == routine.id) {
        existingRelations.add(relation);
      }
    }

    await isar.writeTxn(() async {
      if (updatedName != null && updatedName.isNotEmpty) {
        routine.nombre = updatedName;
      }
      await isar.rutinasPlantilla.put(routine);

      if (existingRelations.isNotEmpty) {
        await isar.rutinasEjercicio.deleteAll(
          existingRelations.map((relation) => relation.id).toList(growable: false),
        );
      }

      for (var index = 0; index < draftExercises.length; index++) {
        final draft = draftExercises[index];
        final relation = RutinaEjercicio(
          orden: index,
          seriesObjetivo: draft.targetSets < 1 ? 1 : draft.targetSets,
          repeticionesMinimasObjetivo: draft.targetRepsMin,
          repeticionesMaximasObjetivo: draft.targetRepsMax,
          pesoObjetivoKg: draft.targetWeightKg,
        );
        relation.rutina.value = routine;
        relation.ejercicio.value = draft.exercise;
        relation.id = await isar.rutinasEjercicio.put(relation);
        await relation.rutina.save();
        await relation.ejercicio.save();
      }
    });

    return 'OK: rutina "$matchName" actualizada.';
  }

  static Future<String> _applyDeleteRoutine(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final matchName =
        action.match['name']?.toString().trim() ??
        action.match['nombre']?.toString().trim() ??
        '';
    if (matchName.isEmpty) {
      return 'ERROR: delete_routine sin nombre de rutina.';
    }

    final routines = await isar.rutinasPlantilla.where().findAll();
    final routine = _findRoutineByName(routines, matchName);
    if (routine == null) {
      return 'ERROR: no existe rutina llamada "$matchName".';
    }

    final allRelations = await isar.rutinasEjercicio.where().findAll();
    final relationIds = <int>[];
    for (final relation in allRelations) {
      await relation.rutina.load();
      if (relation.rutina.value?.id == routine.id) {
        relationIds.add(relation.id);
      }
    }

    await isar.writeTxn(() async {
      if (relationIds.isNotEmpty) {
        await isar.rutinasEjercicio.deleteAll(relationIds);
      }
      await isar.rutinasPlantilla.delete(routine.id);
    });

    return 'OK: rutina "$matchName" eliminada.';
  }

  static Future<String> _applyCreateRecipe(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final recipeName =
        payload['name']?.toString().trim() ??
        payload['nombre']?.toString().trim() ??
        '';
    if (recipeName.isEmpty) {
      return 'ERROR: create_recipe sin nombre.';
    }

    final existingRecipes = await isar.recetas.where().findAll();
    final duplicate = existingRecipes.any(
      (item) => item.nombre.trim().toLowerCase() == recipeName.toLowerCase(),
    );
    if (duplicate) {
      return 'ERROR: la receta "$recipeName" ya existe.';
    }

    final rawIngredients = payload['ingredients'] ?? payload['ingredientes'];
    if (rawIngredients is! List || rawIngredients.isEmpty) {
      return 'ERROR: la receta "$recipeName" no trae ingredientes validos.';
    }

    final foods = await isar.alimentos.where().findAll();
    final draftIngredients = <IngredienteReceta>[];
    final missingFoods = <String>[];
    final invalidIngredients = <String>[];

    for (final rawIngredient in rawIngredients) {
      if (rawIngredient is! Map) {
        continue;
      }

      final foodName =
          rawIngredient['foodName']?.toString().trim() ??
          rawIngredient['alimento']?.toString().trim() ??
          rawIngredient['nombreAlimento']?.toString().trim() ??
          '';
      final grams =
          _toDouble(rawIngredient['grams']) ??
          _toDouble(rawIngredient['cantidadGramos']) ??
          _toDouble(rawIngredient['cantidad']);

      if (foodName.isEmpty || grams == null || grams <= 0) {
        invalidIngredients.add(foodName.isEmpty ? 'ingrediente sin nombre' : foodName);
        continue;
      }

      final food = _findFoodByName(foods, foodName);
      if (food == null) {
        missingFoods.add(foodName);
        continue;
      }

      final ingredient = IngredienteReceta(
        cantidadGramos: grams,
        grupo: _toRecipeGroup(rawIngredient['group'] ?? rawIngredient['grupo']),
      );
      ingredient.alimento.value = food;
      draftIngredients.add(ingredient);
    }

    if (missingFoods.isNotEmpty) {
      return 'ERROR: alimentos no encontrados para "$recipeName": ${missingFoods.join(', ')}. Propón primero acciones add_food y vuelve a aplicar la receta.';
    }
    if (invalidIngredients.isNotEmpty) {
      return 'ERROR: ingredientes invalidos para "$recipeName": ${invalidIngredients.join(', ')}.';
    }
    if (draftIngredients.isEmpty) {
      return 'ERROR: la receta "$recipeName" no contiene ingredientes aplicables.';
    }

    final instructions = payload['instructions']?.toString().trim();
    final servings =
        _toInt(payload['servings']) ??
        _toInt(payload['numeroRaciones']) ??
        _toInt(payload['raciones']) ??
        1;
    final recipe = Receta(
      nombre: recipeName,
      instrucciones: instructions != null && instructions.isNotEmpty
          ? instructions
          : null,
      numeroRaciones: servings < 1 ? 1 : servings,
    );

    await isar.writeTxn(() async {
      recipe.id = await isar.recetas.put(recipe);
      for (final ingredient in draftIngredients) {
        ingredient.id = await isar.ingredientesReceta.put(ingredient);
        await ingredient.alimento.save();
        recipe.ingredientes.add(ingredient);
      }
      await recipe.ingredientes.save();
    });

    return 'OK: receta "$recipeName" creada con ${draftIngredients.length} ingredientes.';
  }

  static Future<String> _applyUpdateRecipe(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final matchName =
        action.match['name']?.toString().trim() ??
        action.match['nombre']?.toString().trim() ??
        action.payload['name']?.toString().trim() ??
        action.payload['nombre']?.toString().trim() ??
        '';
    if (matchName.isEmpty) {
      return 'ERROR: update_recipe sin nombre de receta.';
    }

    final recipes = await isar.recetas.where().findAll();
    final recipe = _findRecipeByName(recipes, matchName);
    if (recipe == null) {
      return 'ERROR: no existe receta llamada "$matchName".';
    }

    final rawIngredients = action.payload['ingredients'] ?? action.payload['ingredientes'];
    if (rawIngredients is! List || rawIngredients.isEmpty) {
      return 'ERROR: update_recipe sin ingredientes validos para "$matchName".';
    }

    final foods = await isar.alimentos.where().findAll();
    final draftIngredients = <IngredienteReceta>[];
    final missingFoods = <String>[];
    final invalidIngredients = <String>[];
    for (final rawIngredient in rawIngredients) {
      if (rawIngredient is! Map) {
        continue;
      }
      final foodName =
          rawIngredient['foodName']?.toString().trim() ??
          rawIngredient['alimento']?.toString().trim() ??
          rawIngredient['nombreAlimento']?.toString().trim() ??
          '';
      final grams =
          _toDouble(rawIngredient['grams']) ??
          _toDouble(rawIngredient['cantidadGramos']) ??
          _toDouble(rawIngredient['cantidad']);
      if (foodName.isEmpty || grams == null || grams <= 0) {
        invalidIngredients.add(foodName.isEmpty ? 'ingrediente sin nombre' : foodName);
        continue;
      }
      final food = _findFoodByName(foods, foodName);
      if (food == null) {
        missingFoods.add(foodName);
        continue;
      }
      final ingredient = IngredienteReceta(
        cantidadGramos: grams,
        grupo: _toRecipeGroup(rawIngredient['group'] ?? rawIngredient['grupo']),
      );
      ingredient.alimento.value = food;
      draftIngredients.add(ingredient);
    }

    if (missingFoods.isNotEmpty) {
      return 'ERROR: alimentos no encontrados para "$matchName": ${missingFoods.join(', ')}. Propón primero acciones add_food y vuelve a aplicar la receta.';
    }
    if (invalidIngredients.isNotEmpty) {
      return 'ERROR: ingredientes invalidos para "$matchName": ${invalidIngredients.join(', ')}.';
    }
    if (draftIngredients.isEmpty) {
      return 'ERROR: update_recipe no contiene ingredientes aplicables para "$matchName".';
    }

    final updatedName =
        action.payload['name']?.toString().trim() ??
        action.payload['nombre']?.toString().trim();
    final instructions = action.payload['instructions']?.toString().trim();
    final servings =
        _toInt(action.payload['servings']) ??
        _toInt(action.payload['numeroRaciones']) ??
        _toInt(action.payload['raciones']);

    await isar.writeTxn(() async {
      if (updatedName != null && updatedName.isNotEmpty) {
        recipe.nombre = updatedName;
      }
      if (instructions != null && instructions.isNotEmpty) {
        recipe.instrucciones = instructions;
      }
      if (servings != null) {
        recipe.numeroRaciones = servings < 1 ? 1 : servings;
      }
      await isar.recetas.put(recipe);

      await recipe.ingredientes.load();
      final oldIds = recipe.ingredientes.map((e) => e.id).toList(growable: false);
      await recipe.ingredientes.reset();
      if (oldIds.isNotEmpty) {
        await isar.ingredientesReceta.deleteAll(oldIds);
      }

      for (final ingredient in draftIngredients) {
        ingredient.id = await isar.ingredientesReceta.put(ingredient);
        await ingredient.alimento.save();
        recipe.ingredientes.add(ingredient);
      }
      await recipe.ingredientes.save();
    });

    return 'OK: receta "$matchName" actualizada.';
  }

  static Future<String> _applyDeleteRecipe(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final matchName =
        action.match['name']?.toString().trim() ??
        action.match['nombre']?.toString().trim() ??
        '';
    if (matchName.isEmpty) {
      return 'ERROR: delete_recipe sin nombre de receta.';
    }

    final recipes = await isar.recetas.where().findAll();
    final recipe = _findRecipeByName(recipes, matchName);
    if (recipe == null) {
      return 'ERROR: no existe receta llamada "$matchName".';
    }

    await recipe.ingredientes.load();
    final ingredientIds = recipe.ingredientes.map((e) => e.id).toList(growable: false);
    final logs = await isar.registrosDiarios.where().findAll();
    final logIdsToDelete = logs
        .where((entry) => entry.esReceta && entry.itemId == recipe.id)
        .map((entry) => entry.id)
        .toList(growable: false);

    await isar.writeTxn(() async {
      await recipe.ingredientes.reset();
      if (ingredientIds.isNotEmpty) {
        await isar.ingredientesReceta.deleteAll(ingredientIds);
      }
      if (logIdsToDelete.isNotEmpty) {
        await isar.registrosDiarios.deleteAll(logIdsToDelete);
      }
      await isar.recetas.delete(recipe.id);
    });

    return 'OK: receta "$matchName" eliminada.';
  }

  static Future<String> _applyUpdateBodyMetric(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final weightKg = _toDouble(payload['weightKg'] ?? payload['pesoKg']);
    final bodyFatPercent = _toDouble(
      payload['bodyFatPercent'] ?? payload['porcentajeGrasa'],
    );

    if (weightKg == null || weightKg <= 0) {
      return 'ERROR: update_body_metric necesita un peso valido.';
    }

    if (bodyFatPercent != null &&
        (bodyFatPercent <= 0 || bodyFatPercent >= 100)) {
      return 'ERROR: el porcentaje de grasa debe estar entre 0 y 100.';
    }

    final metric = MetricaCorporal(
      fecha: DateTime.now(),
      peso: weightKg,
      porcentajeGrasa: bodyFatPercent,
    );

    await isar.writeTxn(() async {
      metric.id = await isar.metricasCorporales.put(metric);
    });

    return bodyFatPercent == null
        ? 'OK: peso guardado en ${weightKg.toStringAsFixed(weightKg.truncateToDouble() == weightKg ? 0 : 1)} kg.'
        : 'OK: metricas guardadas en ${weightKg.toStringAsFixed(weightKg.truncateToDouble() == weightKg ? 0 : 1)} kg y ${bodyFatPercent.toStringAsFixed(bodyFatPercent.truncateToDouble() == bodyFatPercent ? 0 : 1)} % de grasa.';
  }

  static Future<String> _applyPlanWeeklyMenu(
    Isar isar,
    GeminiActionProposal action,
  ) async {
    final payload = action.payload;
    final rawDays = payload['days'];
    if (rawDays is! List || rawDays.isEmpty) {
      return 'ERROR: plan_weekly_menu sin dias validos.';
    }

    final startDate = _parseDate(payload['startDate']) ?? _normalizeDay(DateTime.now());
    final replaceExisting = payload['replaceExisting'] != false;
    final foods = await isar.alimentos.where().findAll();
    final recipes = await isar.recetas.where().findAll();
    final plannedLogs = <RegistroDiario>[];
    final missingItems = <String>[];

    for (final rawDay in rawDays) {
      if (rawDay is! Map) {
        continue;
      }
      final dayOffset = _toInt(rawDay['dayOffset']) ?? 0;
      final date = _normalizeDay(startDate.add(Duration(days: dayOffset)));
      final rawMeals = rawDay['meals'];
      if (rawMeals is! List || rawMeals.isEmpty) {
        continue;
      }

      for (final rawMeal in rawMeals) {
        if (rawMeal is! Map) {
          continue;
        }
        final mealType = _toMealType(rawMeal['mealType'] ?? rawMeal['tipoComida']);
        final itemType = _toPlannedItemType(rawMeal['itemType'] ?? rawMeal['tipoItem']);
        final itemName =
            rawMeal['itemName']?.toString().trim() ??
            rawMeal['name']?.toString().trim() ??
            rawMeal['nombre']?.toString().trim() ??
            '';
        final grams =
            _toDouble(rawMeal['grams']) ??
            _toDouble(rawMeal['cantidadGramos']) ??
            _toDouble(rawMeal['cantidad']);

        if (mealType == null || itemType == null || itemName.isEmpty || grams == null || grams <= 0) {
          continue;
        }

        final itemId = switch (itemType) {
          _PlannedMenuItemType.food => _findFoodByName(foods, itemName)?.id,
          _PlannedMenuItemType.recipe => _findRecipeByName(recipes, itemName)?.id,
        };

        if (itemId == null) {
          missingItems.add(itemName);
          continue;
        }

        plannedLogs.add(
          RegistroDiario(
            fecha: date,
            tipoComida: mealType,
            esReceta: itemType == _PlannedMenuItemType.recipe,
            itemId: itemId,
            cantidadConsumidaGramos: grams,
          ),
        );
      }
    }

    if (missingItems.isNotEmpty) {
      final uniqueMissing = missingItems.toSet().toList()..sort();
      return 'ERROR: faltan recetas o alimentos para montar el menu semanal: ${uniqueMissing.join(', ')}. Crea primero esos elementos y vuelve a aplicar el plan.';
    }

    if (plannedLogs.isEmpty) {
      return 'ERROR: plan_weekly_menu no contiene comidas aplicables.';
    }

    final endDate = _normalizeDay(startDate.add(const Duration(days: 6)))
        .add(const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999, microseconds: 999));

    await isar.writeTxn(() async {
      if (replaceExisting) {
        final existingLogs = await isar.registrosDiarios
            .filter()
            .fechaBetween(startDate, endDate)
            .findAll();
        if (existingLogs.isNotEmpty) {
          await isar.registrosDiarios.deleteAll(
            existingLogs.map((entry) => entry.id).toList(growable: false),
          );
        }
      }

      for (final log in plannedLogs) {
        await isar.registrosDiarios.put(log);
      }
    });

    final uniqueDays = plannedLogs
        .map((log) => _normalizeDay(log.fecha).millisecondsSinceEpoch)
        .toSet()
        .length;
    return 'OK: menu semanal guardado con ${plannedLogs.length} comidas en $uniqueDays dias.';
  }

  static double? _toDouble(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value.toString().replaceAll(',', '.'));
  }

  static int? _toInt(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value.toString());
  }

  static Alimento? _findFoodByName(List<Alimento> foods, String name) {
    final normalized = name.trim().toLowerCase();
    for (final food in foods) {
      if (food.nombre.trim().toLowerCase() == normalized) {
        return food;
      }
    }
    return null;
  }

  static Ejercicio? _findExerciseByName(
    List<Ejercicio> exercises,
    String name,
  ) {
    final normalized = name.trim().toLowerCase();
    for (final exercise in exercises) {
      if (exercise.nombre.trim().toLowerCase() == normalized) {
        return exercise;
      }
    }
    return null;
  }

  static RutinaPlantilla? _findRoutineByName(
    List<RutinaPlantilla> routines,
    String name,
  ) {
    final normalized = name.trim().toLowerCase();
    for (final routine in routines) {
      if (routine.nombre.trim().toLowerCase() == normalized) {
        return routine;
      }
    }
    return null;
  }

  static Receta? _findRecipeByName(List<Receta> recipes, String name) {
    final normalized = name.trim().toLowerCase();
    for (final recipe in recipes) {
      if (recipe.nombre.trim().toLowerCase() == normalized) {
        return recipe;
      }
    }
    return null;
  }

  static GrupoComponenteReceta _toRecipeGroup(Object? value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return switch (normalized) {
      'vegetal' || 'verdura' || 'verduras' => GrupoComponenteReceta.vegetal,
      'anadido' || 'añadido' || 'extra' || 'salsa' =>
        GrupoComponenteReceta.anadido,
      _ => GrupoComponenteReceta.principal,
    };
  }

  static TipoEjercicio _toExerciseType(Object? value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return switch (normalized) {
      'movilidad' || 'mobility' => TipoEjercicio.movilidad,
      'estiramiento' || 'stretch' || 'stretching' =>
        TipoEjercicio.estiramiento,
      _ => TipoEjercicio.fuerza,
    };
  }

  static int _actionPriorityCompare(
    GeminiActionProposal left,
    GeminiActionProposal right,
  ) {
    return _actionPriority(left.type).compareTo(_actionPriority(right.type));
  }

  static int _actionPriority(GeminiActionType type) {
    return switch (type) {
      GeminiActionType.addFood => 0,
      GeminiActionType.createExercise => 0,
      GeminiActionType.updateFood => 1,
      GeminiActionType.updateRecipe => 1,
      GeminiActionType.updateRoutine => 1,
      GeminiActionType.createRecipe => 2,
      GeminiActionType.createRoutine => 2,
      GeminiActionType.planWeeklyMenu => 3,
      GeminiActionType.deleteRecipe => 4,
      GeminiActionType.deleteRoutine => 4,
      GeminiActionType.updateBodyMetric => 4,
      GeminiActionType.openShoppingList => 5,
    };
  }

  static DateTime _normalizeDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime? _parseDate(Object? value) {
    final raw = value?.toString().trim();
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return DateTime.tryParse(raw);
  }

  static TipoComida? _toMealType(Object? value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return switch (normalized) {
      'desayuno' || 'breakfast' => TipoComida.desayuno,
      'comida' || 'almuerzo' || 'lunch' => TipoComida.comida,
      'cena' || 'dinner' => TipoComida.cena,
      'snack' || 'snacks' || 'tentempie' || 'tentempié' => TipoComida.snack,
      _ => null,
    };
  }

  static _PlannedMenuItemType? _toPlannedItemType(Object? value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return switch (normalized) {
      'food' || 'alimento' => _PlannedMenuItemType.food,
      'recipe' || 'receta' => _PlannedMenuItemType.recipe,
      _ => null,
    };
  }
}

enum _PlannedMenuItemType { food, recipe }