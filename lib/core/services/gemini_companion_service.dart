import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:isar_community/isar.dart';

import '../../features/ai_chat/data/models/ai_chat_agent.dart';
import '../../features/ai_chat/data/services/ai_chat_local_store.dart';
import '../../features/nutrition/data/models/alimento.dart';
import '../../features/nutrition/data/models/registro_diario.dart';
import '../../features/nutrition/data/models/receta.dart';
import '../../features/progress/data/models/metrica_corporal.dart';
import '../../features/progress/data/models/objetivos_nutricionales.dart';
import '../../features/shopping/data/models/despensa_producto.dart';
import '../../features/tracking/data/models/perfil_usuario.dart';
import '../../features/workouts/data/models/ejercicio.dart';
import '../../features/workouts/data/models/rutina_ejercicio.dart';
import '../../features/workouts/data/models/rutina_plantilla.dart';
import '../../features/workouts/data/models/serie.dart';
import '../../features/workouts/data/models/sesion_entrenamiento.dart';

/// Servicio conversacional de Fiti enriquecido con datos locales.
class FitiCoachService {
  static const List<String> _chatCandidateModels = <String>[
    'gemini-2.5-flash',
    'gemini-flash-latest',
    'gemini-2.5-flash-lite',
    'gemini-2.5-pro',
  ];

  static const List<String> _notificationCandidateModels = <String>[
    'gemini-2.5-flash-lite',
    'gemini-2.5-flash',
    'gemini-flash-latest',
  ];

  /// Crea un [FitiCoachService].
  FitiCoachService({String? apiKey})
    : _apiKey = (apiKey ?? dotenv.env['GEMINI_API_KEY'] ?? '').trim();

  final String _apiKey;
  String? _resolvedChatModelName;
  String? _resolvedNotificationModelName;
  final Map<AiChatAgent, ChatSession> _chatSessions =
      <AiChatAgent, ChatSession>{};

  static final Map<AiChatAgent, Future<String>> _systemPromptCache = {};

  void resetChat([AiChatAgent? agent]) {
    if (agent == null) {
      _chatSessions.clear();
      return;
    }
    _chatSessions.remove(agent);
  }

  /// Envía la consulta del usuario a Gemini añadiendo contexto local de Isar.
  Future<GeminiChatResponse> askGemini(
    String userMessage,
    Isar isar, {
    required AiChatAgent agent,
    List<GeminiConversationContextTurn> conversationHistory =
        const <GeminiConversationContextTurn>[],
  }) async {
    final normalizedMessage = userMessage.trim();
    if (normalizedMessage.isEmpty) {
      return const GeminiChatResponse(
        reply: 'Escribe una consulta antes de enviar el mensaje.',
      );
    }

    if (_apiKey.isEmpty || _apiKey == 'tu_clave_aqui') {
      if (_apiKey.isEmpty || _apiKey == 'tu_clave_aqui') {
        return const GeminiChatResponse(
          reply:
              'Configura GEMINI_API_KEY en el archivo .env para activar el asistente.',
        );
      }
      return const GeminiChatResponse(
        reply: 'No se pudo inicializar el modelo de Gemini.',
      );
    }

    final systemPrompt = await _getSystemPrompt(agent);
    final hiddenContext = await _buildAgentHiddenContext(isar, agent);
    final sessionDirective = _buildSessionDirective(hiddenContext, agent);

    final triedModels = <String>[];
    final candidateModels = <String>[
      if (_resolvedChatModelName != null) _resolvedChatModelName!,
      ..._chatCandidateModels.where((model) => model != _resolvedChatModelName),
    ];

    final activeSession = _chatSessions[agent];
    if (activeSession != null) {
      try {
        final response = await activeSession.sendMessage(
          Content.text(normalizedMessage),
        ).timeout(const Duration(seconds: 30));
        final text = response.text?.trim();
        if (text == null || text.isEmpty) {
          return const GeminiChatResponse(
            reply: 'Gemini no devolvió contenido utilizable para esta consulta.',
          );
        }
        return _parseChatResponse(text, agent);
      } on GenerativeAIException catch (error, stackTrace) {
        debugPrint(
          'Gemini ChatSession exception con modelo $_resolvedChatModelName: ${error.message}',
        );
        debugPrintStack(stackTrace: stackTrace);
        return GeminiChatResponse(reply: _mapGeminiErrorMessage(error.message));
      } catch (error, stackTrace) {
        debugPrint('Gemini ChatSession unexpected error: $error');
        debugPrintStack(stackTrace: stackTrace);
        return GeminiChatResponse(reply: _mapGeminiErrorMessage(error.toString()));
      }
    }

    for (final modelName in candidateModels) {
      final model = _buildModel(_apiKey, modelName, systemPrompt);
      if (model == null) {
        continue;
      }

      triedModels.add(modelName);

      try {
        final chatSession = model.startChat(
          history: <Content>[
            Content.text(sessionDirective),
            ..._buildChatHistory(conversationHistory),
          ],
        );
        _chatSessions[agent] = chatSession;
        final response = await chatSession.sendMessage(
          Content.text(normalizedMessage),
        ).timeout(const Duration(seconds: 30));
        final text = response.text?.trim();
        if (text == null || text.isEmpty) {
          return const GeminiChatResponse(
            reply: 'Gemini no devolvió contenido utilizable para esta consulta.',
          );
        }
        _resolvedChatModelName = modelName;
        return _parseChatResponse(text, agent);
      } on GenerativeAIException catch (error, stackTrace) {
        _chatSessions.remove(agent);
        debugPrint(
          'Gemini GenerativeAIException con modelo $modelName: ${error.message}',
        );
        debugPrintStack(stackTrace: stackTrace);
        if (_isModelUnavailableError(error.message)) {
          continue;
        }
        return GeminiChatResponse(reply: _mapGeminiErrorMessage(error.message));
      } catch (error, stackTrace) {
        _chatSessions.remove(agent);
        debugPrint('Gemini unexpected error con modelo $modelName: $error');
        debugPrintStack(stackTrace: stackTrace);
        return GeminiChatResponse(reply: _mapGeminiErrorMessage(error.toString()));
      }
    }

    return GeminiChatResponse(
      reply:
          'No hay un modelo Gemini disponible para esta clave API. Modelos probados: ${triedModels.join(', ')}.',
    );
  }

  Future<String> buildNotificationSuggestion({
    required Isar isar,
    required GeminiNotificationKind kind,
  }) async {
    final systemPrompt = await _getSystemPrompt(AiChatAgent.nutrition);
    final hiddenContext = await _buildHiddenContext(
      isar,
      profile: GeminiContextProfile.notification,
    );
    const toneInstruction =
        'Tono obligatorio: duro, seco, exigente y nada complaciente. No felicites por defecto, no endulces, no uses frases tipo "todo va bien" o "vas genial" salvo que el contexto lo sostenga de forma clara. Prioriza urgencia util, realidad y accion inmediata. Sin insultos ni lenguaje abusivo. '; 
    final instruction = switch (kind) {
      GeminiNotificationKind.dinnerPlanning =>
        '${toneInstruction}Genera una unica sugerencia breve para una notificacion local de cena de manana. Debe caber en una notificacion y mencionar una cena o idea concreta basada en el historial real si existe. Maximo 140 caracteres. Sin markdown. Sin JSON.',
      GeminiNotificationKind.mealPrep =>
        '${toneInstruction}Genera una unica sugerencia breve para una notificacion local de preparar la comida de manana. Maximo 140 caracteres. Sin markdown. Sin JSON.',
      GeminiNotificationKind.weeklyWeightCheckIn =>
        '${toneInstruction}Genera una unica pregunta breve para una notificacion local pidiendo el peso semanal del usuario. Si no hay porcentaje de grasa reciente, puedes insistir en que tambien le ayudaria anadirlo. Maximo 140 caracteres. Sin markdown. Sin JSON.',
      GeminiNotificationKind.weeklyProgress =>
        '${toneInstruction}Genera un unico resumen breve para una notificacion local con la evolucion semanal del usuario. Si solo hay peso, no saques conclusiones rotundas sobre recomposicion. Si falta grasa corporal, dilo con claridad y propone anadirla para afinar. Maximo 140 caracteres. Sin markdown. Sin JSON.',
    };

    final candidateModels = <String>[
      if (_resolvedNotificationModelName != null)
        _resolvedNotificationModelName!,
      ..._notificationCandidateModels.where(
        (model) => model != _resolvedNotificationModelName,
      ),
    ];

    for (final modelName in candidateModels) {
      final model = _buildModel(_apiKey, modelName, systemPrompt);
      if (model == null) {
        continue;
      }

      try {
        final response = await model.generateContent([
          Content.text('$hiddenContext\n\n$instruction'),
        ]).timeout(const Duration(seconds: 30));
        final text = response.text?.trim();
        if (text == null || text.isEmpty) {
          continue;
        }
        _resolvedNotificationModelName = modelName;
        return _cleanNotificationText(text);
      } on GenerativeAIException catch (error) {
        if (_isModelUnavailableError(error.message)) {
          continue;
        }
        break;
      } catch (_) {
        break;
      }
    }

    return switch (kind) {
      GeminiNotificationKind.dinnerPlanning =>
        'Deja cerrada la cena de manana hoy. Si improvisas luego, comes peor.',
      GeminiNotificationKind.mealPrep =>
        'Prepara la comida de manana ahora. Si lo dejas para luego, no lo haces.',
      GeminiNotificationKind.weeklyWeightCheckIn =>
        'Pasa el peso de esta semana. Sin ese dato vas a ciegas. Si puedes, anade tambien tu % de grasa.',
      GeminiNotificationKind.weeklyProgress =>
        'Tu semana no se evalua sola. Si faltan peso y % de grasa, la lectura se queda coja.',
    };
  }

  String _cleanNotificationText(String rawText) {
    final compact = rawText
        .replaceAll(RegExp(r'[`#*_\n\r]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (compact.length <= 140) {
      return compact;
    }
    return '${compact.substring(0, 137).trim()}...';
  }


  static Future<String> _getSystemPrompt(AiChatAgent agent) {
    return _systemPromptCache.putIfAbsent(agent, () => _loadCombinedPrompt(agent));
  }

  static Future<String> _loadCombinedPrompt(AiChatAgent agent) async {
    final general = await rootBundle.loadString('assets/prompts/agent_general_rules.txt');
    String specificPath;
    switch (agent) {
      case AiChatAgent.nutrition:
        specificPath = 'assets/prompts/agent_nutrifitio.txt';
        break;
      case AiChatAgent.workout:
        specificPath = 'assets/prompts/agent_gymbrofitio.txt';
        break;
      case AiChatAgent.boss:
        specificPath = 'assets/prompts/agent_fitiboss.txt';
        break;
    }
    final specific = await rootBundle.loadString(specificPath);
    return general.trim() + '\n\n' + specific.trim();
  }

  static GenerativeModel? _buildModel(
    String apiKey,
    String modelName,
    String systemPrompt,
  ) {
    if (apiKey.isEmpty || apiKey == 'tu_clave_aqui') {
      return null;
    }

    return GenerativeModel(
      model: modelName,
      apiKey: apiKey,
      systemInstruction: Content.system(systemPrompt),
    );
  }

  Future<String> _buildHiddenContext(
    Isar isar, {
    required GeminiContextProfile profile,
  }) async {
    return switch (profile) {
      GeminiContextProfile.chat => _buildChatHiddenContext(isar),
      GeminiContextProfile.notification => _buildNotificationHiddenContext(isar),
    };
  }

  Future<String> _buildAgentHiddenContext(Isar isar, AiChatAgent agent) async {
    final perfilUsuario = await _loadUserProfileContext(isar);
    final pesoActual = await _loadCurrentWeight(isar);
    final grasaActual = await _loadCurrentBodyFat(isar);
    final objetivosNutricion = await _loadNutritionGoalsContext(isar);

    switch (agent) {
      case AiChatAgent.nutrition:
        final kcalObjetivo = await _loadCalorieGoal(isar);
        final kcalHoy = await _loadTodayKcal(isar);
        final comidasSemana = await _loadWeeklyFoodContext(isar);
        final compraActual = await _loadShoppingListContext(isar);
        final catalogoAlimentos = await _loadFoodCatalogContext(isar);
        final catalogoRecetas = await _loadRecipeCatalogContext(isar);
        final memorySnapshot = await AiChatLocalStore.loadOrRefreshMemorySnapshot(
          isar,
        );
        return '[Agente: NutriFitio. Perfil usuario: $perfilUsuario, Peso actual: ${_formatNullableDouble(pesoActual, suffix: ' kg')}, Grasa corporal actual: ${_formatNullableDouble(grasaActual, suffix: ' %')}, Objetivos nutricion: $objetivosNutricion, Kcal objetivo: ${_formatNullableDouble(kcalObjetivo)}, Kcal hoy: ${kcalHoy.toStringAsFixed(0)}, Historial comida 7 dias: $comidasSemana, Compra prevista 7 dias: $compraActual, Catalogo alimentos: $catalogoAlimentos, Catalogo recetas: $catalogoRecetas, Memoria nutricion: preferencias=${memorySnapshot.preferencesSummary}; alimentos_frecuentes=${memorySnapshot.frequentFoodsSummary}; cenas_repetidas=${memorySnapshot.repeatedDinnersSummary}; cumplimiento_semanal=${memorySnapshot.weeklyAdherenceSummary}]';
      case AiChatAgent.workout:
        final ultimoEntreno = await _loadLastWorkoutSummary(isar);
        final catalogoEjercicios = await _loadExerciseCatalogContext(isar);
        final catalogoRutinas = await _loadRoutineCatalogContext(isar);
        final metricasRecientes = await _loadRecentBodyMetricsContext(isar);
        return '[Agente: GymBroFitio. Perfil usuario: $perfilUsuario, Peso actual: ${_formatNullableDouble(pesoActual, suffix: ' kg')}, Grasa corporal actual: ${_formatNullableDouble(grasaActual, suffix: ' %')}, Ultimo entreno: $ultimoEntreno, Catalogo ejercicios: $catalogoEjercicios, Catalogo rutinas: $catalogoRutinas, Metricas recientes: $metricasRecientes]';
      case AiChatAgent.boss:
        return _buildBossHiddenContext(isar);
    }
  }

  Future<String> _buildChatHiddenContext(Isar isar) async {
    final pesoActual = await _loadCurrentWeight(isar);
    final grasaActual = await _loadCurrentBodyFat(isar);
    final kcalObjetivo = await _loadCalorieGoal(isar);
    final objetivosNutricion = await _loadNutritionGoalsContext(isar);
    final kcalHoy = await _loadTodayKcal(isar);
    final perfilUsuario = await _loadUserProfileContext(isar);
    final ultimoEntreno = await _loadLastWorkoutSummary(isar);
    final comidasSemana = await _loadWeeklyFoodContext(isar);
    final compraActual = await _loadShoppingListContext(isar);
    final catalogoAlimentos = await _loadFoodCatalogContext(isar);
    final catalogoRecetas = await _loadRecipeCatalogContext(isar);
    final catalogoEjercicios = await _loadExerciseCatalogContext(isar);
    final catalogoRutinas = await _loadRoutineCatalogContext(isar);
    final metricasRecientes = await _loadRecentBodyMetricsContext(isar);
    final memorySnapshot = await AiChatLocalStore.loadOrRefreshMemorySnapshot(
      isar,
    );

    return '[Datos App: Perfil usuario: $perfilUsuario, Peso actual: ${_formatNullableDouble(pesoActual, suffix: ' kg')}, Grasa corporal actual: ${_formatNullableDouble(grasaActual, suffix: ' %')}, Metricas recientes: $metricasRecientes, Objetivos nutricion: $objetivosNutricion, Kcal objetivo: ${_formatNullableDouble(kcalObjetivo)}, Kcal hoy: ${kcalHoy.toStringAsFixed(0)}, Último entreno: $ultimoEntreno, Historial comida 7 dias: $comidasSemana, Compra prevista 7 dias: $compraActual, Catalogo alimentos: $catalogoAlimentos, Catalogo recetas: $catalogoRecetas, Catalogo ejercicios: $catalogoEjercicios, Catalogo rutinas: $catalogoRutinas, Memoria local: preferencias=${memorySnapshot.preferencesSummary}; alimentos_frecuentes=${memorySnapshot.frequentFoodsSummary}; cenas_repetidas=${memorySnapshot.repeatedDinnersSummary}; cumplimiento_semanal=${memorySnapshot.weeklyAdherenceSummary}]';
  }

  Future<String> _buildBossHiddenContext(Isar isar) async {
    final baseContext = await _buildChatHiddenContext(isar);
    final nutritionBrief = await AiChatLocalStore.loadRecentConversationBrief(
      isar,
      AiChatAgent.nutrition,
    );
    final workoutBrief = await AiChatLocalStore.loadRecentConversationBrief(
      isar,
      AiChatAgent.workout,
    );

    return '$baseContext\n[Resumen reciente especialistas: NutriFitio => $nutritionBrief. GymBroFitio => $workoutBrief.]';
  }

  Future<String> _buildNotificationHiddenContext(Isar isar) async {
    final kcalObjetivo = await _loadCalorieGoal(isar);
    final kcalHoy = await _loadTodayKcal(isar);
    final comidasHoy = await _loadTodayMealContext(isar);
    final cenasRecientes = await _loadRecentDinnerContext(isar);
    final perfilUsuario = await _loadUserProfileContext(isar);
    final memorySnapshot = await AiChatLocalStore.loadOrRefreshMemorySnapshot(
      isar,
    );

    return '[Contexto ligero notificacion: Perfil usuario: $perfilUsuario, Kcal objetivo: ${_formatNullableDouble(kcalObjetivo)}, Kcal hoy: ${kcalHoy.toStringAsFixed(0)}, Comidas de hoy: $comidasHoy, Cenas recientes: $cenasRecientes, Alimentos frecuentes: ${memorySnapshot.frequentFoodsSummary}, Cenas repetidas: ${memorySnapshot.repeatedDinnersSummary}]';
  }

  String _buildSessionDirective(String hiddenContext, AiChatAgent agent) {
    final agentDirective = _buildAgentDirective(agent);
    final actionInstructions = _buildActionInstructions(agent);
    return '$hiddenContext\n\n'
        '$agentDirective\n\n'
        '[Instrucciones de respuesta]\n'
        'Responde en espanol.\n'
        'Da una respuesta breve, concreta y util para el usuario final.\n'
        'Si conoces el nombre del usuario, usalo de forma natural sin forzarlo.\n'
        'Si el nombre no esta disponible y el contexto es personal, pideselo con naturalidad antes de profundizar.\n'
        'Prioriza recomendaciones accionables basadas en los datos disponibles.\n'
        'Si faltan datos, menciona solo lo imprescindible en 1 o 2 lineas.\n'
        'Evita roadmaps, tono corporativo, lenguaje de consultoria y relleno.\n'
        'Usa bullets cortos solo si aportan claridad.\n\n'
        '[Modo acciones]\n'
        'Si el usuario pide anadir, corregir, actualizar, guardar o crear datos en la app, devuelve acciones estructuradas.\n'
        'Devuelve SIEMPRE un JSON valido con esta forma exacta:\n'
        '{"reply":"respuesta breve en markdown para el usuario","actions":[...]}\n'
        '$actionInstructions\n'
        'Si no hay cambios a base de datos, usa "actions": [].\n'
        'No inventes IDs ni digas que ya has guardado algo si no hay confirmacion de la app.';
  }

  String _buildAgentDirective(AiChatAgent agent) {
    return switch (agent) {
      AiChatAgent.nutrition =>
        '[Identidad]\nEres NutriFitio, especialista en nutricion, recetas, compra y adherencia alimentaria. Tu dominio es comida, despensa, recetas, objetivos caloricos, objetivos de macros, lista de la compra y metricas corporales basicas. Usa de forma proactiva los objetivos de kcal, proteina, carbohidratos, grasas y agua cuando existan. Si el usuario pide una lista de la compra, apóyate en la compra prevista del contexto y devuelve una lista clara de alimentos que faltan. No propongas revisar rutinas, ejercicios ni entrenamiento por iniciativa propia. Si el usuario pide programacion de entreno, volumen, ejercicios o rutinas, dilo claro y deriva a GymBroFitio salvo que el punto afecte directamente a la comida.',
      AiChatAgent.workout =>
        '[Identidad]\nEres GymBroFitio, especialista en entrenamiento, ejercicios, rutinas, descanso y recuperacion. Tu dominio es la programacion del entreno y la ejecucion. Usa de forma proactiva el catalogo de rutinas, el catalogo de ejercicios, el peso actual, la grasa corporal actual y las metricas recientes cuando existan para responder con contexto real del usuario. Si el usuario pide menus, recetas, despensa o compra, dilo claro y deriva a NutriFitio salvo que solo necesites una nota minima para contextualizar el entreno.',
      AiChatAgent.boss =>
        '[Identidad]\nEres FitiBoss, el coordinador superior. Tomas decisiones cuando nutricion y entreno se cruzan. Sintetiza ambos mundos, evita contradicciones y decide que parte pesa mas en cada recomendacion. Antes de responder, apóyate en los resúmenes recientes de NutriFitio y GymBroFitio si existen.',
    };
  }

  String _buildActionInstructions(AiChatAgent agent) {
    final allowedActions = _allowedActionsForAgent(agent);
    final lines = <String>['Tipos de accion soportados para este agente:'];
    if (allowedActions.contains(GeminiActionType.addFood)) {
      lines.add(
        '- add_food => {"type":"add_food","payload":{"nombre":"","kcal":0,"proteinas":0,"carbohidratos":0,"grasas":0,"porcionBaseGramos":100,"grupos":["principal"]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.updateFood)) {
      lines.add(
        '- update_food => {"type":"update_food","match":{"nombre":""},"changes":{"kcal":0,"proteinas":0}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.createRoutine)) {
      lines.add(
        '- create_routine => {"type":"create_routine","payload":{"name":"","exercises":[{"exerciseName":"","targetSets":3,"targetRepsMin":5,"targetRepsMax":8,"targetWeightKg":null}]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.updateRoutine)) {
      lines.add(
        '- update_routine => {"type":"update_routine","match":{"name":""},"payload":{"name":"","exercises":[{"exerciseName":"","targetSets":3,"targetRepsMin":5,"targetRepsMax":8,"targetWeightKg":null}]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.deleteRoutine)) {
      lines.add(
        '- delete_routine => {"type":"delete_routine","match":{"name":""}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.createExercise)) {
      lines.add(
        '- create_exercise => {"type":"create_exercise","payload":{"name":"","muscleGroup":"","restSeconds":90,"exerciseType":"fuerza","description":""}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.createRecipe)) {
      lines.add(
        '- create_recipe => {"type":"create_recipe","payload":{"name":"","servings":1,"instructions":"","ingredients":[{"foodName":"","grams":0,"group":"principal"}]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.updateRecipe)) {
      lines.add(
        '- update_recipe => {"type":"update_recipe","match":{"name":""},"payload":{"name":"","servings":1,"instructions":"","ingredients":[{"foodName":"","grams":0,"group":"principal"}]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.deleteRecipe)) {
      lines.add(
        '- delete_recipe => {"type":"delete_recipe","match":{"name":""}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.updateBodyMetric)) {
      lines.add(
        '- update_body_metric => {"type":"update_body_metric","payload":{"weightKg":0,"bodyFatPercent":null}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.planWeeklyMenu)) {
      lines.add(
        '- plan_weekly_menu => {"type":"plan_weekly_menu","payload":{"startDate":"YYYY-MM-DD","replaceExisting":true,"days":[{"dayOffset":0,"meals":[{"mealType":"desayuno","itemType":"recipe","itemName":"","grams":0}]}]}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.openShoppingList)) {
      lines.add(
        '- open_shopping_list => {"type":"open_shopping_list"}',
      );
    }
    if (allowedActions.contains(GeminiActionType.logConsumption)) {
      lines.add(
        '- log_consumption => {"type":"log_consumption","payload":{"itemName":"","itemType":"food o recipe","grams":0,"mealType":"desayuno,comida,cena,snack"}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.addWater)) {
      lines.add(
        '- add_water => {"type":"add_water","payload":{"mililitros":0}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.manageFasting)) {
      lines.add(
        '- manage_fasting => {"type":"manage_fasting","payload":{"activa":true,"horasObjetivo":16}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.updatePantry)) {
      lines.add(
        '- update_pantry => {"type":"update_pantry","payload":{"nombreProducto":"","nombreAlimentoBase":"","gramosPorUnidad":0,"cantidad":0}}',
      );
    }
    if (allowedActions.contains(GeminiActionType.addCheckin)) {
      lines.add(
        '- add_checkin => {"type":"add_checkin","payload":{"animo":"muy_mal,mal,neutral,bien,muy_bien","notas":""}}',
      );
    }
    lines.add(
      'Antes de create_recipe o create_routine, comprueba si cada alimento o ejercicio ya existe en los catalogos del contexto. Si falta alguno, devuelve primero una accion separada para crearlo y explica en el reply que el usuario debe revisar y aprobar esas altas.',
    );
    lines.add(
      'Si la receta o rutina ya existe y el usuario quiere cambiarla, anadir elementos, quitar elementos o renombrarla, usa update_recipe o update_routine en vez de create_recipe o create_routine. Si el usuario quiere borrarla, usa delete_recipe o delete_routine.',
    );
    if (allowedActions.contains(GeminiActionType.planWeeklyMenu)) {
      lines.add(
        'Si el usuario pide un menu semanal o planificar comidas de varios dias, usa plan_weekly_menu con 7 dias consecutivos. Usa recetas o alimentos que ya existan en los catalogos del contexto. Si falta algo, propón antes create_recipe o add_food. Si el usuario quiere rehacer la semana, usa replaceExisting=true. En el reply resume el menu y la compra esperada de forma clara.',
      );
      lines.add(
        'Cuando uses plan_weekly_menu, rellena los 7 dias completos y mete como minimo desayuno, comida y cena en cada dia, salvo que el usuario pida expresamente menos comidas. No dejes dias vacios ni medias semanas.',
      );
    }
    if (allowedActions.contains(GeminiActionType.openShoppingList)) {
      lines.add(
        'Si el usuario quiere ver, revisar o gestionar manualmente la lista de la compra de la app, usa open_shopping_list. Si pide la lista, además resume en el reply qué falta por comprar.',
      );
    }
    if (allowedActions.contains(GeminiActionType.logConsumption)) {
      lines.add(
        'Si el usuario menciona que ha comido o bebido algo específico ahora o hace poco, usa log_consumption. Comprueba si el item ya existe en los catalogos. Si no existe, propone antes add_food o create_recipe.',
      );
    }
    if (allowedActions.contains(GeminiActionType.addWater)) {
      lines.add(
        'Si el usuario menciona que ha bebido agua, usa add_water con la cantidad en ml.',
      );
    }
    if (allowedActions.contains(GeminiActionType.manageFasting)) {
      lines.add(
        'Si el usuario quiere empezar o terminar un ayuno, usa manage_fasting. Por defecto usa horasObjetivo=16 si no se indica otra cosa.',
      );
    }
    if (allowedActions.contains(GeminiActionType.updatePantry)) {
      lines.add(
        'Si el usuario menciona que ha comprado algo para la despensa o que se ha acabado algo, usa update_pantry. nombreAlimentoBase debe coincidir con un alimento del catalogo.',
      );
    }
    if (allowedActions.contains(GeminiActionType.addCheckin)) {
      lines.add(
        'Si el usuario expresa sentimientos, estado de animo o cansancio, usa add_checkin.',
      );
    }
    if (allowedActions.contains(GeminiActionType.addFood)) {
      lines.add(
        'Para alimentos nuevos, estima macros razonables y usa porcionBaseGramos=100 por defecto salvo que el usuario indique otra base.',
      );
    }
    if (allowedActions.contains(GeminiActionType.createExercise)) {
      lines.add(
        'Para ejercicios nuevos, estima muscleGroup, usa restSeconds=90 por defecto y exerciseType="fuerza" salvo que sea claramente movilidad o estiramiento.',
      );
    }
    if (allowedActions.contains(GeminiActionType.seedKeto)) {
      lines.add(
        '- seed_keto_database => {"type":"seed_keto_database"}',
      );
    }
    if (allowedActions.contains(GeminiActionType.searchExternalFood)) {
      lines.add(
        '- search_external_food => {"type":"search_external_food","payload":{"query":""}}',
      );
    }
    return lines.join('\n');
  }

  List<Content> _buildChatHistory(
    List<GeminiConversationContextTurn> conversationHistory,
  ) {
    if (conversationHistory.isEmpty) {
      return const <Content>[];
    }

    final recentTurns = conversationHistory.length <= 10
        ? conversationHistory
        : conversationHistory.sublist(conversationHistory.length - 10);
    return recentTurns.map((turn) {
      return switch (turn.role) {
        GeminiConversationRole.user => Content.text(turn.text),
        GeminiConversationRole.assistant =>
          Content.model(<Part>[TextPart(turn.text)]),
      };
    }).toList(growable: false);
  }

  Future<double?> _loadCurrentWeight(Isar isar) async {
    final metrics = await isar.metricasCorporales.where().findAll();
    if (metrics.isEmpty) {
      return null;
    }

    metrics.sort((a, b) => b.fecha.compareTo(a.fecha));
    return metrics.first.peso;
  }

  Future<double?> _loadCurrentBodyFat(Isar isar) async {
    final metrics = await isar.metricasCorporales.where().findAll();
    if (metrics.isEmpty) {
      return null;
    }

    metrics.sort((a, b) => b.fecha.compareTo(a.fecha));
    for (final metric in metrics) {
      if (metric.porcentajeGrasa != null) {
        return metric.porcentajeGrasa;
      }
    }
    return null;
  }

  Future<String> _loadRecentBodyMetricsContext(Isar isar) async {
    final metrics = await isar.metricasCorporales.where().findAll();
    if (metrics.isEmpty) {
      return 'sin metricas corporales guardadas';
    }

    metrics.sort((a, b) => b.fecha.compareTo(a.fecha));
    final preview = metrics.take(4).map((metric) {
      final dateLabel = _formatDate(metric.fecha);
      final weightLabel = '${metric.peso.toStringAsFixed(metric.peso.truncateToDouble() == metric.peso ? 0 : 1)} kg';
      final bodyFatLabel = metric.porcentajeGrasa == null
          ? 'sin % grasa'
          : '${metric.porcentajeGrasa!.toStringAsFixed(metric.porcentajeGrasa!.truncateToDouble() == metric.porcentajeGrasa ? 0 : 1)} % grasa';
      return '$dateLabel: $weightLabel, $bodyFatLabel';
    }).join(' | ');

    return preview.isEmpty ? 'sin metricas corporales guardadas' : preview;
  }

  Future<double?> _loadCalorieGoal(Isar isar) async {
    final goal = await isar.objetivosNutricionales.where().findFirst();
    return goal?.kcalObjetivo;
  }

  Future<String> _loadShoppingListContext(Isar isar) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(
      start.year,
      start.month,
      start.day + 6,
      23,
      59,
      59,
      999,
      999,
    );

    final logs = await isar.registrosDiarios
        .filter()
        .fechaBetween(start, end)
        .findAll();
    if (logs.isEmpty) {
      return 'sin consumo planificado en los proximos 7 dias';
    }

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

      final recipe = await isar.recetas.get(log.itemId);
      if (recipe == null) {
        continue;
      }

      await recipe.ingredientes.load();
      if (recipe.ingredientes.isEmpty) {
        continue;
      }

      var recipeBaseGrams = 0.0;
      for (final ingredient in recipe.ingredientes) {
        recipeBaseGrams += ingredient.cantidadGramos;
      }
      if (recipeBaseGrams <= 0) {
        continue;
      }

      final proportion = log.cantidadConsumidaGramos / recipeBaseGrams;
      for (final ingredient in recipe.ingredientes) {
        await ingredient.alimento.load();
        final food = ingredient.alimento.value;
        if (food == null) {
          continue;
        }

        gramsByFoodId.update(
          food.id,
          (value) => value + ingredient.cantidadGramos * proportion,
          ifAbsent: () => ingredient.cantidadGramos * proportion,
        );
      }
    }

    final pantryItems = await isar.despensaProductos.where().findAll();
    final availableByFoodId = <int, double>{};
    for (final DespensaProducto pantryItem in pantryItems) {
      availableByFoodId.update(
        pantryItem.alimentoId,
        (value) => value + pantryItem.gramosPorUnidad * pantryItem.cantidad,
        ifAbsent: () => pantryItem.gramosPorUnidad * pantryItem.cantidad,
      );
    }

    final lines = <String>[];
    final foodIds = gramsByFoodId.keys.toList()..sort();
    for (final foodId in foodIds) {
      final food = await isar.alimentos.get(foodId);
      if (food == null) {
        continue;
      }

      final requiredGrams = gramsByFoodId[foodId] ?? 0;
      final availableGrams = availableByFoodId[foodId] ?? 0;
      final missingGrams = requiredGrams - availableGrams;
      if (missingGrams <= 0) {
        continue;
      }

      lines.add(
        '${food.nombre}: faltan ${missingGrams.toStringAsFixed(0)} g (necesitas ${requiredGrams.toStringAsFixed(0)} g, despensa ${availableGrams.toStringAsFixed(0)} g)',
      );
    }

    if (lines.isEmpty) {
      return 'no falta comprar nada para los proximos 7 dias';
    }

    final preview = lines.take(12).join(' | ');
    final suffix = lines.length > 12 ? ' | ... (${lines.length} alimentos)' : '';
    return '$preview$suffix';
  }

  Future<String> _loadNutritionGoalsContext(Isar isar) async {
    final goal = await isar.objetivosNutricionales.where().findFirst();
    if (goal == null) {
      return 'sin objetivos nutricionales guardados';
    }

    return 'kcal=${goal.kcalObjetivo.toStringAsFixed(goal.kcalObjetivo.truncateToDouble() == goal.kcalObjetivo ? 0 : 1)}, proteinas=${goal.proteinasObjetivo.toStringAsFixed(goal.proteinasObjetivo.truncateToDouble() == goal.proteinasObjetivo ? 0 : 1)} g, carbohidratos=${goal.carbohidratosObjetivo.toStringAsFixed(goal.carbohidratosObjetivo.truncateToDouble() == goal.carbohidratosObjetivo ? 0 : 1)} g, grasas=${goal.grasasObjetivo.toStringAsFixed(goal.grasasObjetivo.truncateToDouble() == goal.grasasObjetivo ? 0 : 1)} g, agua=${goal.aguaObjetivoMl.toStringAsFixed(goal.aguaObjetivoMl.truncateToDouble() == goal.aguaObjetivoMl ? 0 : 1)} ml';
  }

  Future<String> _loadUserProfileContext(Isar isar) async {
    final profile = await isar.perfilesUsuario.get(1);
    if (profile == null) {
      return 'sin perfil extendido';
    }

    final fields = <String>[
      'nombre=${profile.nombre.isEmpty ? 'desconocido' : profile.nombre}',
      'objetivo=${profile.objetivoPrincipal.isEmpty ? 'sin definir' : profile.objetivoPrincipal}',
      'peso_objetivo=${_formatNullableDouble(profile.pesoObjetivoKg, suffix: ' kg')}',
      'peso_objetivo_plazo=${profile.pesoObjetivoPlazoSemanas == null ? 'sin definir' : '${profile.pesoObjetivoPlazoSemanas} semanas'}',
      'hambre=${profile.hambreHabitual.isEmpty ? 'sin definir' : profile.hambreHabitual}',
      'saciedad=${profile.saciedadComidas.isEmpty ? 'sin definir' : profile.saciedadComidas}',
      'saciedad_desayuno=${profile.saciedadDesayuno.isEmpty ? 'sin definir' : profile.saciedadDesayuno}',
      'saciedad_comida=${profile.saciedadComida.isEmpty ? 'sin definir' : profile.saciedadComida}',
      'saciedad_cena=${profile.saciedadCena.isEmpty ? 'sin definir' : profile.saciedadCena}',
      'pasos=${profile.pasosDiarios}',
      'sueno=${_formatSleepRange(profile.suenoInicioMinutos, profile.suenoFinMinutos)}',
      'adherencia_dieta=${profile.adherenciaDietaSemanal}%',
      'adherencia_entreno=${profile.adherenciaEntrenoSemanal}%',
      'digestion=${profile.digestion.isEmpty ? 'sin definir' : profile.digestion}',
      'alimentos_mal=${profile.alimentosQueSientanMal.isEmpty ? 'sin definir' : profile.alimentosQueSientanMal}',
      'preferencias=${profile.preferenciasComida.isEmpty ? 'sin definir' : profile.preferenciasComida}',
      'emocional_comida=${profile.estadoEmocionalComida.isEmpty ? 'sin definir' : profile.estadoEmocionalComida}',
    ];
    return fields.join(', ');
  }

  Future<double> _loadTodayKcal(Isar isar) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final registros = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfDay, endOfDay)
        .findAll();

    var totalKcal = 0.0;
    for (final registro in registros) {
      final macros = registro.esReceta
          ? await _sumRecipeMacros(isar, registro)
          : await _sumFoodMacros(isar, registro);
      totalKcal += macros.kcal;
    }
    return totalKcal;
  }

  Future<String> _loadLastWorkoutSummary(Isar isar) async {
    final sessions = await isar.sesionesEntrenamiento.where().findAll();
    final completed = sessions
        .where(
          (session) => session.estado == EstadoSesionEntrenamiento.completada,
        )
        .toList(growable: false);

    if (completed.isEmpty) {
      return 'sin entrenos registrados';
    }

    completed.sort((a, b) {
      final left = a.fechaFin ?? a.fechaInicio;
      final right = b.fechaFin ?? b.fechaInicio;
      return right.compareTo(left);
    });

    final lastSession = completed.first;
    // Optimized: Only load series for the last session
    final sessionSeries = await isar.series.filter().sesion((q) => q.idEqualTo(lastSession.id)).findAll();
    
    final exerciseNames = <String>{};
    var tonelaje = 0.0;
    var completedSeries = 0;
 
    for (final serie in sessionSeries) {
      if (!serie.completada) continue;
 
      completedSeries += 1;
      tonelaje += serie.pesoKg * serie.repeticiones;
      
      await serie.ejercicio.load(); 
      final exerciseName = serie.ejercicio.value?.nombre;
      if (exerciseName != null && exerciseName.trim().isNotEmpty) {
        exerciseNames.add(exerciseName);
      }
    }
 
    final namesPreview = exerciseNames.take(3).join(', ');
    final date = lastSession.fechaFin ?? lastSession.fechaInicio;
    final dateLabel =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
 
    if (completedSeries == 0) {
      return 'sesión del $dateLabel sin series completadas';
    }
 
    final exercisesText = namesPreview.isEmpty
        ? 'sin ejercicios legibles'
        : namesPreview;
    return 'sesión del $dateLabel con $completedSeries series, tonelaje ${tonelaje.toStringAsFixed(0)} kg y ejercicios: $exercisesText';
  }

  Future<String> _loadWeeklyFoodContext(Isar isar) async {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfWindow = startOfToday.subtract(const Duration(days: 6));

    final registros = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfWindow, now)
        .findAll();

    if (registros.isEmpty) {
      return 'sin comidas registradas en los ultimos 7 dias';
    }

    registros.sort((a, b) => a.fecha.compareTo(b.fecha));

    // Batch load names
    final weeklyRecipeIds = registros.where((r) => r.esReceta).map((r) => r.itemId).toSet().toList();
    final weeklyFoodIds = registros.where((r) => !r.esReceta).map((r) => r.itemId).toSet().toList();
    final weeklyRecipes = await isar.recetas.getAll(weeklyRecipeIds);
    final weeklyFoods = await isar.alimentos.getAll(weeklyFoodIds);
    final weeklyRecipeNameMap = {for (var i = 0; i < weeklyRecipeIds.length; i++) if (weeklyRecipes[i] != null) weeklyRecipeIds[i]: weeklyRecipes[i]!.nombre.trim()};
    final weeklyFoodNameMap = {for (var i = 0; i < weeklyFoodIds.length; i++) if (weeklyFoods[i] != null) weeklyFoodIds[i]: weeklyFoods[i]!.nombre.trim()};

    final mealsByKey = <String, _WeeklyMealSummary>{};
    for (final registro in registros) {
      final mealDate = DateTime(
        registro.fecha.year,
        registro.fecha.month,
        registro.fecha.day,
      );
      final mealKey =
          '${mealDate.toIso8601String()}-${registro.tipoComida.name}';
      final summary = mealsByKey.putIfAbsent(
        mealKey,
        () => _WeeklyMealSummary(date: mealDate, mealType: registro.tipoComida),
      );
 
      final itemName = registro.esReceta ? weeklyRecipeNameMap[registro.itemId] : weeklyFoodNameMap[registro.itemId];
      if (itemName != null && itemName.isNotEmpty) {
        summary.items.add(itemName);
      }
 
      // Optimized macros loading
      final macros = await (registro.esReceta 
          ? _sumRecipeMacros(isar, registro) 
          : _sumFoodMacros(isar, registro));
      summary.kcal += macros.kcal;
    }

    final meals = mealsByKey.values.toList()
      ..sort((a, b) {
        final dateComparison = a.date.compareTo(b.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return a.mealType.index.compareTo(b.mealType.index);
      });

    final groupedByDay = <DateTime, List<_WeeklyMealSummary>>{};
    for (final meal in meals) {
      groupedByDay.putIfAbsent(meal.date, () => <_WeeklyMealSummary>[]).add(meal);
    }

    final lines = groupedByDay.entries.map((entry) {
      final mealsText = entry.value.map((meal) {
        final items = meal.items.isEmpty
            ? 'sin detalle'
            : meal.items.take(3).join(', ');
        return '${_mealTypeLabel(meal.mealType)}: $items (${meal.kcal.toStringAsFixed(0)} kcal)';
      }).join(' | ');

      return '${_weekdayLabel(entry.key)} ${entry.key.day.toString().padLeft(2, '0')}/${entry.key.month.toString().padLeft(2, '0')}: $mealsText';
    }).join(' || ');

    return lines;
  }

  Future<String> _loadFoodCatalogContext(Isar isar) async {
    final foods = await isar.alimentos.where().findAll();
    if (foods.isEmpty) {
      return 'sin alimentos guardados';
    }

    final names = foods
        .map((food) => food.nombre.trim())
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    final preview = names.take(80).join(', ');
    final suffix = names.length > 80 ? ' ... (${names.length} total)' : '';
    return preview.isEmpty ? 'sin alimentos guardados' : '$preview$suffix';
  }

  Future<String> _loadRecipeCatalogContext(Isar isar) async {
    final recipes = await isar.recetas.where().findAll();
    if (recipes.isEmpty) {
      return 'sin recetas guardadas';
    }

    final names = recipes
        .map((recipe) => recipe.nombre.trim())
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    final preview = names.take(80).join(', ');
    final suffix = names.length > 80 ? ' ... (${names.length} total)' : '';
    return preview.isEmpty ? 'sin recetas guardadas' : '$preview$suffix';
  }

  Future<String> _loadExerciseCatalogContext(Isar isar) async {
    final exercises = await isar.ejercicios.where().findAll();
    if (exercises.isEmpty) {
      return 'sin ejercicios guardados';
    }

    final names = exercises
        .map((exercise) => exercise.nombre.trim())
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    final preview = names.take(80).join(', ');
    final suffix = names.length > 80 ? ' ... (${names.length} total)' : '';
    return preview.isEmpty ? 'sin ejercicios guardados' : '$preview$suffix';
  }

  Future<String> _loadRoutineCatalogContext(Isar isar) async {
    final routines = await isar.rutinasPlantilla.where().findAll();
    if (routines.isEmpty) {
      return 'sin rutinas guardadas';
    }

    final routineExercises = await isar.rutinasEjercicio.where().findAll();
    final exerciseCountByRoutineId = <int, int>{};
    for (final entry in routineExercises) {
      await entry.rutina.load();
      final routine = entry.rutina.value;
      if (routine == null) {
        continue;
      }
      exerciseCountByRoutineId.update(
        routine.id,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    final descriptions = routines.map((routine) {
      final name = routine.nombre.trim();
      final count = exerciseCountByRoutineId[routine.id] ?? 0;
      return name.isEmpty
          ? null
          : count > 0
          ? '$name ($count ejercicios)'
          : name;
    }).whereType<String>().toSet().toList()
      ..sort();

    final preview = descriptions.take(50).join(', ');
    final suffix = descriptions.length > 50
        ? ' ... (${descriptions.length} total)'
        : '';
    return preview.isEmpty ? 'sin rutinas guardadas' : '$preview$suffix';
  }

  Future<String> _loadTodayMealContext(Isar isar) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));

    final registros = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfDay, endOfDay)
        .findAll();

    if (registros.isEmpty) {
      return 'sin registros hoy';
    }

    registros.sort((a, b) => a.fecha.compareTo(b.fecha));
    final grouped = <TipoComida, List<String>>{};
    for (final registro in registros) {
      final itemName = await _loadConsumedItemName(isar, registro);
      if (itemName == null || itemName.isEmpty) {
        continue;
      }
      grouped.putIfAbsent(registro.tipoComida, () => <String>[]).add(itemName);
    }

    if (grouped.isEmpty) {
      return 'sin detalle util hoy';
    }

    return grouped.entries
        .map(
          (entry) => '${_mealTypeLabel(entry.key)}: ${entry.value.take(3).join(', ')}',
        )
        .join(' | ');
  }

  Future<String> _loadRecentDinnerContext(Isar isar) async {
    final now = DateTime.now();
    final startOfWindow = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 3));

    final registros = await isar.registrosDiarios
        .filter()
        .fechaBetween(startOfWindow, now)
        .tipoComidaEqualTo(TipoComida.cena)
        .findAll();

    if (registros.isEmpty) {
      return 'sin cenas recientes';
    }

    registros.sort((a, b) => b.fecha.compareTo(a.fecha));
    final summaries = <String>[];
    final seenDayKeys = <int>{};
    for (final registro in registros) {
      if (seenDayKeys.contains(registro.fechaDiaKey)) {
        continue;
      }
      seenDayKeys.add(registro.fechaDiaKey);
      final sameDay = registros
          .where((item) => item.fechaDiaKey == registro.fechaDiaKey)
          .toList(growable: false);
      final itemNames = <String>[];
      for (final item in sameDay) {
        final name = await _loadConsumedItemName(isar, item);
        if (name != null && name.isNotEmpty) {
          itemNames.add(name);
        }
      }
      if (itemNames.isEmpty) {
        continue;
      }
      summaries.add(
        '${_weekdayLabel(registro.fecha)}: ${itemNames.take(3).join(', ')}',
      );
      if (summaries.length >= 3) {
        break;
      }
    }

    if (summaries.isEmpty) {
      return 'sin detalle de cenas recientes';
    }
    return summaries.join(' | ');
  }

  Future<String?> _loadConsumedItemName(Isar isar, RegistroDiario registro) async {
    if (registro.esReceta) {
      final recipe = await isar.recetas.get(registro.itemId);
      return recipe?.nombre.trim();
    }

    final food = await isar.alimentos.get(registro.itemId);
    return food?.nombre.trim();
  }

  String _mealTypeLabel(TipoComida mealType) {
    return switch (mealType) {
      TipoComida.desayuno => 'desayuno',
      TipoComida.comida => 'comida',
      TipoComida.cena => 'cena',
      TipoComida.snack => 'snack',
    };
  }

  String _weekdayLabel(DateTime date) {
    return switch (date.weekday) {
      DateTime.monday => 'lunes',
      DateTime.tuesday => 'martes',
      DateTime.wednesday => 'miercoles',
      DateTime.thursday => 'jueves',
      DateTime.friday => 'viernes',
      DateTime.saturday => 'sabado',
      DateTime.sunday => 'domingo',
      _ => 'dia',
    };
  }

  Future<_MacroSnapshot> _sumFoodMacros(
    Isar isar,
    RegistroDiario registro,
  ) async {
    final food = await isar.alimentos.get(registro.itemId);
    if (food == null) {
      return const _MacroSnapshot();
    }

    final factor = food.porcionBaseGramos <= 0
        ? 0.0
        : registro.cantidadConsumidaGramos / food.porcionBaseGramos;
    return _MacroSnapshot(kcal: food.kcal * factor);
  }

  Future<_MacroSnapshot> _sumRecipeMacros(
    Isar isar,
    RegistroDiario registro,
  ) async {
    final recipe = await isar.recetas.get(registro.itemId);
    if (recipe == null) {
      return const _MacroSnapshot();
    }

    await recipe.ingredientes.load();
    if (recipe.ingredientes.isEmpty) {
      return const _MacroSnapshot();
    }

    var recipeKcal = 0.0;
    var totalRecipeWeight = 0.0;

    for (final ingredient in recipe.ingredientes) {
      await ingredient.alimento.load();
      final food = ingredient.alimento.value;
      if (food == null) {
        continue;
      }

      final factor = food.porcionBaseGramos <= 0
          ? 0.0
          : ingredient.cantidadGramos / food.porcionBaseGramos;
      recipeKcal += food.kcal * factor;
      totalRecipeWeight += ingredient.cantidadGramos;
    }

    if (totalRecipeWeight <= 0) {
      return const _MacroSnapshot();
    }

    final consumptionFactor =
        registro.cantidadConsumidaGramos / totalRecipeWeight;
    return _MacroSnapshot(kcal: recipeKcal * consumptionFactor);
  }

  String _formatNullableDouble(double? value, {String suffix = ''}) {
    if (value == null) {
      return 'sin dato';
    }
    final text = value.truncateToDouble() == value
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
    return '$text$suffix';
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  String _formatSleepRange(int? startMinutes, int? endMinutes) {
    if (startMinutes == null || endMinutes == null) {
      return 'sin dato';
    }
    return '${_formatClock(startMinutes)}-${_formatClock(endMinutes)}';
  }

  String _formatClock(int minutes) {
    final hours = (minutes ~/ 60).toString().padLeft(2, '0');
    final mins = (minutes % 60).toString().padLeft(2, '0');
    return '$hours:$mins';
  }

  String _mapGeminiErrorMessage(String rawMessage) {
    final normalized = rawMessage.toLowerCase();
    if (normalized.contains('free_tier') && normalized.contains('limit: 0')) {
      return 'La clave API está asociada a un proyecto sin cuota habilitada para Gemini API. Tener Gemini Pro o Gemini Advanced en la app no activa automáticamente la API. Necesitas una clave de Google AI Studio o Google Cloud con la Gemini API habilitada y facturación/cuota disponible en ese proyecto.';
    }
    if (normalized.contains('api key') ||
        normalized.contains('permission denied')) {
      return 'Gemini rechazó la clave API. Revisa que GEMINI_API_KEY sea válida y que esa clave tenga acceso a la API de Gemini.';
    }
    if (normalized.contains('quota') || normalized.contains('rate limit')) {
      return 'Gemini no respondió porque la cuota de la API se agotó o se alcanzó el límite de peticiones.';
    }
    if (normalized.contains('model') && normalized.contains('not found')) {
      return 'El modelo configurado de Gemini no está disponible para esta clave API.';
    }
    if (normalized.contains('socket') ||
        normalized.contains('network') ||
        normalized.contains('connection') ||
        normalized.contains('handshake') ||
        normalized.contains('timed out')) {
      return 'No se pudo conectar con Gemini. Revisa la conexión a internet del dispositivo.';
    }
    return 'Gemini devolvió un error: $rawMessage';
  }

  GeminiChatResponse _parseChatResponse(String rawText, AiChatAgent agent) {
    final normalized = _extractJsonObject(rawText);
    if (normalized == null) {
      return GeminiChatResponse(reply: _sanitizeReplyFallback(rawText));
    }

    try {
      final decoded = jsonDecode(normalized);
      if (decoded is! Map<String, dynamic>) {
        return GeminiChatResponse(
          reply: _extractReplyField(normalized) ?? _sanitizeReplyFallback(rawText),
        );
      }


      final reply = decoded['reply']?.toString().trim();
      final rawActions = decoded['actions'];
      final actions = <GeminiActionProposal>[];
      final allowedActions = _allowedActionsForAgent(agent);
      if (rawActions is List) {
        for (final entry in rawActions) {
          if (entry is Map<String, dynamic>) {
            final proposal = GeminiActionProposal.fromJson(entry);
            if (proposal != null && allowedActions.contains(proposal.type)) {
              actions.add(proposal);
            }
          }
        }
      }

      if (reply == null || reply.isEmpty) {
        return GeminiChatResponse(
          reply: _extractReplyField(normalized) ?? _sanitizeReplyFallback(rawText),
          actions: actions,
        );
      }
      return GeminiChatResponse(reply: reply, actions: actions);
    } catch (_) {
      return GeminiChatResponse(
        reply: _extractReplyField(normalized) ?? _sanitizeReplyFallback(rawText),
      );
    }
  }

  String? _extractJsonObject(String rawText) {
    final trimmed = rawText.trim();
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      return trimmed;
    }

    final withoutFence = trimmed
        .replaceFirst(RegExp(r'^```json\s*'), '')
        .replaceFirst(RegExp(r'^```\s*'), '')
        .replaceFirst(RegExp(r'\s*```$'), '')
        .trim();
    if (withoutFence.startsWith('{') && withoutFence.endsWith('}')) {
      return withoutFence;
    }

    final firstBrace = withoutFence.indexOf('{');
    final lastBrace = withoutFence.lastIndexOf('}');
    if (firstBrace >= 0 && lastBrace > firstBrace) {
      return withoutFence.substring(firstBrace, lastBrace + 1);
    }
    return null;
  }

  String? _extractReplyField(String rawJsonLikeText) {
    final match = RegExp(r'"reply"\s*:\s*"((?:\\.|[^"\\])*)"').firstMatch(
      rawJsonLikeText,
    );
    final encoded = match?.group(1);
    if (encoded == null || encoded.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode('"$encoded"');
      return decoded is String && decoded.trim().isNotEmpty
          ? decoded.trim()
          : null;
    } catch (_) {
      return encoded.replaceAll(r'\n', '\n').trim();
    }
  }

  String _sanitizeReplyFallback(String rawText) {
    final withoutJsonFences = rawText.replaceAll(
      RegExp(r'```json[\s\S]*?```'),
      '',
    );
    final withoutGenericFences = withoutJsonFences.replaceAll(
      RegExp(r'```[\s\S]*?```'),
      '',
    );
    final compact = withoutGenericFences
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (compact.isNotEmpty &&
        !(compact.startsWith('{') && compact.endsWith('}'))) {
      return compact;
    }

    final replyFromJson = _extractReplyField(rawText);
    if (replyFromJson != null && replyFromJson.isNotEmpty) {
      return replyFromJson;
    }

    return 'He preparado cambios y propuestas para revisar en la tarjeta inferior.';
  }

  bool _isModelUnavailableError(String rawMessage) {
    final normalized = rawMessage.toLowerCase();
    return normalized.contains('model') &&
        (normalized.contains('not found') ||
            normalized.contains('not supported') ||
            normalized.contains('not available') ||
            normalized.contains('unsupported') ||
            normalized.contains('no longer available') ||
            normalized.contains('deprecated') ||
            normalized.contains('obsolete') ||
            normalized.contains('new users'));
  }

  Set<GeminiActionType> _allowedActionsForAgent(AiChatAgent agent) {
    return switch (agent) {
      AiChatAgent.nutrition => <GeminiActionType>{
        GeminiActionType.addFood,
        GeminiActionType.updateFood,
        GeminiActionType.createRecipe,
        GeminiActionType.updateRecipe,
        GeminiActionType.deleteRecipe,
        GeminiActionType.updateBodyMetric,
        GeminiActionType.planWeeklyMenu,
        GeminiActionType.openShoppingList,
        GeminiActionType.logConsumption,
        GeminiActionType.addWater,
        GeminiActionType.manageFasting,
        GeminiActionType.updatePantry,
        GeminiActionType.addCheckin,
      },
      AiChatAgent.workout => <GeminiActionType>{
        GeminiActionType.createExercise,
        GeminiActionType.createRoutine,
        GeminiActionType.updateRoutine,
        GeminiActionType.deleteRoutine,
        GeminiActionType.addCheckin,
      },
      AiChatAgent.boss => GeminiActionType.values.toSet(),
    };
  }
}

class GeminiChatResponse {
  const GeminiChatResponse({required this.reply, this.actions = const []});

  final String reply;
  final List<GeminiActionProposal> actions;
}

enum GeminiConversationRole { user, assistant }

enum GeminiContextProfile { chat, notification }

enum GeminiNotificationKind {
  dinnerPlanning,
  mealPrep,
  weeklyWeightCheckIn,
  weeklyProgress,
}

class GeminiConversationContextTurn {
  const GeminiConversationContextTurn({required this.role, required this.text});

  final GeminiConversationRole role;
  final String text;
}

enum GeminiActionType {
  addFood,
  updateFood,
  createExercise,
  createRoutine,
  updateRoutine,
  deleteRoutine,
  createRecipe,
  updateRecipe,
  deleteRecipe,
  updateBodyMetric,
  planWeeklyMenu,
  openShoppingList,
  logConsumption,
  addWater,
  manageFasting,
  updatePantry,
  addCheckin,
  seedKeto,
  searchExternalFood,
}

class GeminiActionProposal {
  const GeminiActionProposal({
    required this.type,
    required this.raw,
    this.payload = const <String, dynamic>{},
    this.match = const <String, dynamic>{},
    this.changes = const <String, dynamic>{},
  });

  final GeminiActionType type;
  final Map<String, dynamic> raw;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> match;
  final Map<String, dynamic> changes;

  static GeminiActionProposal? fromJson(Map<String, dynamic> json) {
    final typeValue = json['type']?.toString().trim();
    final type = switch (typeValue) {
      'add_food' => GeminiActionType.addFood,
      'update_food' => GeminiActionType.updateFood,
      'create_exercise' => GeminiActionType.createExercise,
      'create_routine' => GeminiActionType.createRoutine,
      'update_routine' => GeminiActionType.updateRoutine,
      'delete_routine' => GeminiActionType.deleteRoutine,
      'create_recipe' => GeminiActionType.createRecipe,
      'update_recipe' => GeminiActionType.updateRecipe,
      'delete_recipe' => GeminiActionType.deleteRecipe,
      'update_body_metric' => GeminiActionType.updateBodyMetric,
      'plan_weekly_menu' => GeminiActionType.planWeeklyMenu,
      'open_shopping_list' => GeminiActionType.openShoppingList,
      'log_consumption' => GeminiActionType.logConsumption,
      'add_water' => GeminiActionType.addWater,
      'manage_fasting' => GeminiActionType.manageFasting,
      'update_pantry' => GeminiActionType.updatePantry,
      'add_checkin' => GeminiActionType.addCheckin,
      _ => null,
    };
    if (type == null) {
      return null;
    }

    return GeminiActionProposal(
      type: type,
      raw: json,
      payload: (json['payload'] as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{},
      match: (json['match'] as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{},
      changes: (json['changes'] as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{},
    );
  }

  String get previewLabel {
    return switch (type) {
      GeminiActionType.addFood =>
        'Añadir alimento: ${payload['nombre'] ?? 'sin nombre'}',
      GeminiActionType.updateFood =>
        'Corregir alimento: ${match['nombre'] ?? 'sin criterio'}',
      GeminiActionType.createExercise =>
        'Crear ejercicio: ${payload['name'] ?? payload['nombre'] ?? 'sin nombre'}',
      GeminiActionType.createRoutine =>
        'Crear rutina: ${payload['name'] ?? 'sin nombre'}',
      GeminiActionType.updateRoutine =>
        'Actualizar rutina: ${match['name'] ?? match['nombre'] ?? 'sin criterio'}',
      GeminiActionType.deleteRoutine =>
        'Eliminar rutina: ${match['name'] ?? match['nombre'] ?? 'sin criterio'}',
      GeminiActionType.createRecipe =>
        'Crear receta: ${payload['name'] ?? payload['nombre'] ?? 'sin nombre'}',
      GeminiActionType.updateRecipe =>
        'Actualizar receta: ${match['name'] ?? match['nombre'] ?? 'sin criterio'}',
      GeminiActionType.deleteRecipe =>
        'Eliminar receta: ${match['name'] ?? match['nombre'] ?? 'sin criterio'}',
      GeminiActionType.updateBodyMetric =>
        'Guardar metricas: ${payload['weightKg'] ?? 'sin peso'} kg${payload['bodyFatPercent'] == null ? '' : ' · ${payload['bodyFatPercent']} % grasa'}',
      GeminiActionType.planWeeklyMenu => 'Planificar menu semanal',
      GeminiActionType.openShoppingList => 'Abrir lista de la compra',
      GeminiActionType.logConsumption =>
        'Registrar consumo: ${payload['itemName'] ?? 'sin nombre'}',
      GeminiActionType.addWater =>
        'Registrar agua: ${payload['mililitros'] ?? '0'} ml',
      GeminiActionType.manageFasting =>
        '${payload['activa'] == true ? 'Iniciar' : 'Terminar'} ayuno',
      GeminiActionType.updatePantry =>
        'Actualizar despensa: ${payload['nombreProducto'] ?? 'sin nombre'}',
      GeminiActionType.addCheckin =>
        'Registrar check-in: ${payload['animo'] ?? 'neutral'}',
      GeminiActionType.seedKeto => 'Poblar base de datos Keto',
      GeminiActionType.searchExternalFood =>
        'Buscar en Edamam: ${payload['query'] ?? 'sin consulta'}',
    };
  }
}

class _WeeklyMealSummary {
  _WeeklyMealSummary({required this.date, required this.mealType});

  final DateTime date;
  final TipoComida mealType;
  final List<String> items = <String>[];
  double kcal = 0;
}

class _MacroSnapshot {
  const _MacroSnapshot({this.kcal = 0});

  final double kcal;
}
