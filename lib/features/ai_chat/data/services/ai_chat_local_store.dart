import 'dart:convert';

import 'package:isar_community/isar.dart';

import '../models/ai_chat_agent.dart';
import '../models/ai_chat_conversation_log.dart';
import '../../../../features/nutrition/data/models/alimento.dart';
import '../../../../features/nutrition/data/models/receta.dart';
import '../../../../features/nutrition/data/models/registro_diario.dart';
import '../../../../features/progress/data/models/metrica_corporal.dart';
import '../../../../features/progress/data/models/objetivos_nutricionales.dart';
import '../models/ai_chat_conversation.dart';
import '../models/ai_chat_memory_snapshot.dart';
import '../models/ai_chat_message.dart';

abstract final class AiChatLocalStore {
  static const int memorySnapshotId = 1;
  static const String _legacyAssistantTitle = 'Gemini Companion';
  static const String _legacyPrimaryTitle = 'Fiti';

  static Future<AiChatConversation> loadOrCreateConversation(
    Isar isar,
    AiChatAgent agent,
  ) async {
    final existing = await isar.aiChatConversations.get(agent.conversationId);
    if (existing != null) {
      if (_shouldNormalizeTitle(existing.title, agent)) {
        existing.title = agent.displayName;
        await isar.writeTxn(() async {
          await isar.aiChatConversations.put(existing);
        });
      }
      return existing;
    }

    final now = DateTime.now();
    final conversation = AiChatConversation(
      id: agent.conversationId,
      title: agent.displayName,
      createdAt: now,
      updatedAt: now,
    );
    await isar.writeTxn(() async {
      await isar.aiChatConversations.put(conversation);
    });
    return conversation;
  }

  static Future<List<AiChatMessage>> loadConversationMessages(
    Isar isar,
    int conversationId,
  ) {
    return isar.aiChatMessages
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByCreatedAt()
        .findAll();
  }

  static Future<String> loadRecentConversationBrief(
    Isar isar,
    AiChatAgent agent, {
    int maxMessages = 4,
  }) async {
    final messages = await loadConversationMessages(isar, agent.conversationId);
    if (messages.isEmpty) {
      return 'sin conversacion reciente';
    }

    final recentMessages = messages.length <= maxMessages
        ? messages
        : messages.sublist(messages.length - maxMessages);

    return recentMessages.map((message) {
      final speaker = message.role == AiChatMessageRole.user
          ? 'usuario'
          : agent.displayName;
      return '$speaker: ${_compactConversationText(message.text)}';
    }).join(' | ');
  }

  static Future<void> clearConversation(Isar isar, AiChatAgent agent) async {
    final existingMessages = await loadConversationMessages(
      isar,
      agent.conversationId,
    );

    await isar.writeTxn(() async {
      final transcript = _buildConversationTranscript(existingMessages, agent);
      if (transcript != null) {
        await isar.aiChatConversationLogs.put(
          AiChatConversationLog(
            agentKey: agent.routeValue,
            createdAt: DateTime.now(),
            transcript: transcript,
          ),
        );
      }

      await isar.aiChatMessages
          .filter()
          .conversationIdEqualTo(agent.conversationId)
          .deleteAll();

      final conversation =
          await isar.aiChatConversations.get(agent.conversationId) ??
          AiChatConversation(
            id: agent.conversationId,
            title: agent.displayName,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
      conversation.title = agent.displayName;
      conversation.updatedAt = DateTime.now();
      await isar.aiChatConversations.put(conversation);
    });
  }

  static Future<List<AiChatConversationLog>> loadArchivedLogs(
    Isar isar,
    AiChatAgent agent, {
    int limit = 20,
  }) async {
    final logs = await isar.aiChatConversationLogs
        .filter()
        .agentKeyEqualTo(agent.routeValue)
        .sortByCreatedAtDesc()
        .findAll();
    return logs.length <= limit ? logs : logs.take(limit).toList(growable: false);
  }

  static Future<AiChatMessage> appendMessage({
    required Isar isar,
    required int conversationId,
    required AiChatMessageRole role,
    required String text,
    String? actionsJson,
    AiChatMessageActionStatus actionStatus = AiChatMessageActionStatus.none,
    String? actionResult,
  }) async {
    final message = AiChatMessage(
      conversationId: conversationId,
      role: role,
      text: text,
      createdAt: DateTime.now(),
      actionsJson: actionsJson,
      actionStatus: actionStatus,
      actionResult: actionResult,
    );

    await isar.writeTxn(() async {
      message.id = await isar.aiChatMessages.put(message);
      final conversation =
          await isar.aiChatConversations.get(conversationId) ??
          AiChatConversation(
            id: conversationId,
            title: _displayNameForConversationId(conversationId),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
      conversation.updatedAt = DateTime.now();
      if (conversation.title.trim().isEmpty) {
        conversation.title = _displayNameForConversationId(conversationId);
      }
      await isar.aiChatConversations.put(conversation);
    });

    return message;
  }

  static Future<void> updateMessageActionState({
    required Isar isar,
    required int messageId,
    required AiChatMessageActionStatus status,
    String? actionResult,
  }) async {
    final message = await isar.aiChatMessages.get(messageId);
    if (message == null) {
      return;
    }

    message.actionStatus = status;
    message.actionResult = actionResult;
    await isar.writeTxn(() async {
      await isar.aiChatMessages.put(message);
    });
  }

  static Future<AiChatMemorySnapshot> loadOrRefreshMemorySnapshot(
    Isar isar,
  ) async {
    final snapshot = await _buildMemorySnapshot(isar);
    await isar.writeTxn(() async {
      await isar.aiChatMemorySnapshots.put(snapshot);
    });
    return snapshot;
  }

  static String encodeActionsJson(List<Map<String, dynamic>> rawActions) {
    return jsonEncode(rawActions);
  }

  static List<Map<String, dynamic>> decodeActionsJson(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) {
      return const <Map<String, dynamic>>[];
    }

    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! List) {
        return const <Map<String, dynamic>>[];
      }
      return decoded
          .whereType<Map>()
          .map((entry) => entry.cast<String, dynamic>())
          .toList(growable: false);
    } catch (_) {
      return const <Map<String, dynamic>>[];
    }
  }

  static String _compactConversationText(String rawText, {int maxChars = 120}) {
    final normalized = rawText.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.length <= maxChars) {
      return normalized;
    }
    return '${normalized.substring(0, maxChars - 3).trim()}...';
  }

  static String? _buildConversationTranscript(
    List<AiChatMessage> messages,
    AiChatAgent agent,
  ) {
    if (messages.isEmpty) {
      return null;
    }

    final lines = <String>[
      '${agent.displayName} · ${DateTime.now().toIso8601String()}',
    ];
    for (final message in messages) {
      final speaker = message.role == AiChatMessageRole.user
          ? 'Usuario'
          : agent.displayName;
      lines.add('$speaker: ${message.text.trim()}');
      if (message.actionResult != null && message.actionResult!.trim().isNotEmpty) {
        lines.add('Resultado: ${message.actionResult!.trim()}');
      }
    }
    return lines.join('\n');
  }

  static bool _shouldNormalizeTitle(String currentTitle, AiChatAgent agent) {
    final trimmed = currentTitle.trim();
    return trimmed.isEmpty ||
        trimmed == _legacyAssistantTitle ||
        trimmed == _legacyPrimaryTitle ||
        _knownDisplayNames.contains(trimmed) && trimmed != agent.displayName;
  }

  static String _displayNameForConversationId(int conversationId) {
    for (final agent in AiChatAgent.values) {
      if (agent.conversationId == conversationId) {
        return agent.displayName;
      }
    }
    return AiChatAgent.boss.displayName;
  }

  static const Set<String> _knownDisplayNames = <String>{
    _legacyAssistantTitle,
    _legacyPrimaryTitle,
    'NutriFitio',
    'GymBroFitio',
    'FitiBoss',
  };

  static Future<AiChatMemorySnapshot> _buildMemorySnapshot(Isar isar) async {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final weeklyWindow = startOfToday.subtract(const Duration(days: 6));
    final frequentWindow = startOfToday.subtract(const Duration(days: 13));
    final dinnerWindow = startOfToday.subtract(const Duration(days: 20));

    final weeklyRecords = await isar.registrosDiarios
        .filter()
        .fechaBetween(weeklyWindow, now)
        .findAll();
    final frequentRecords = await isar.registrosDiarios
        .filter()
        .fechaBetween(frequentWindow, now)
        .findAll();
    final dinnerRecords = await isar.registrosDiarios
        .filter()
        .fechaBetween(dinnerWindow, now)
        .tipoComidaEqualTo(TipoComida.cena)
        .findAll();

    final calorieGoal = await _loadCalorieGoal(isar);
    final latestWeight = await _loadCurrentWeight(isar);

    final preferenceSummary = await _buildPreferencesSummary(
      isar,
      weeklyRecords,
      calorieGoal,
      latestWeight,
    );
    final frequentFoodsSummary = await _buildFrequentFoodsSummary(
      isar,
      frequentRecords,
    );
    final repeatedDinnersSummary = await _buildRepeatedDinnersSummary(
      isar,
      dinnerRecords,
    );
    final weeklyAdherenceSummary = await _buildWeeklyAdherenceSummary(
      isar,
      weeklyRecords,
      calorieGoal,
    );

    return AiChatMemorySnapshot(
      id: memorySnapshotId,
      updatedAt: now,
      preferencesSummary: preferenceSummary,
      frequentFoodsSummary: frequentFoodsSummary,
      repeatedDinnersSummary: repeatedDinnersSummary,
      weeklyAdherenceSummary: weeklyAdherenceSummary,
    );
  }

  static Future<String> _buildPreferencesSummary(
    Isar isar,
    List<RegistroDiario> weeklyRecords,
    double? calorieGoal,
    double? latestWeight,
  ) async {
    if (weeklyRecords.isEmpty) {
      return 'Sin registros suficientes para deducir preferencias recientes.';
    }

    final mealTypeCount = <TipoComida, int>{};
    for (final record in weeklyRecords) {
      mealTypeCount.update(record.tipoComida, (value) => value + 1,
          ifAbsent: () => 1);
    }

    final dominantMealType = mealTypeCount.entries
        .reduce((left, right) => left.value >= right.value ? left : right)
        .key;
    final loggedDays = weeklyRecords.map((record) => record.fechaDiaKey).toSet().length;
    final goalText = calorieGoal == null
        ? 'sin objetivo kcal configurado'
        : 'objetivo de ${calorieGoal.toStringAsFixed(0)} kcal';
    final weightText = latestWeight == null
        ? 'sin peso reciente'
        : 'peso reciente ${latestWeight.toStringAsFixed(latestWeight.truncateToDouble() == latestWeight ? 0 : 1)} kg';

    return '$goalText, $weightText y $loggedDays/7 dias con comida registrada. Suele registrar mas ${_mealTypeLabel(dominantMealType)}.';
  }

  static Future<String> _buildFrequentFoodsSummary(
    Isar isar,
    List<RegistroDiario> records,
  ) async {
    if (records.isEmpty) {
      return 'Sin alimentos frecuentes detectados en las ultimas dos semanas.';
    }

    final counter = <String, int>{};
    for (final record in records) {
      final itemName = await _loadConsumedItemName(isar, record);
      if (itemName == null || itemName.isEmpty) {
        continue;
      }
      counter.update(itemName, (value) => value + 1, ifAbsent: () => 1);
    }

    if (counter.isEmpty) {
      return 'No se pudieron identificar alimentos frecuentes.';
    }

    final topFoods = counter.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final summary = topFoods
        .take(5)
        .map((entry) => '${entry.key} x${entry.value}')
        .join(', ');
    return 'Alimentos o platos mas repetidos: $summary.';
  }

  static Future<String> _buildRepeatedDinnersSummary(
    Isar isar,
    List<RegistroDiario> dinnerRecords,
  ) async {
    if (dinnerRecords.isEmpty) {
      return 'Sin cenas registradas recientemente.';
    }

    final dinnersByDay = <int, List<String>>{};
    for (final record in dinnerRecords) {
      final itemName = await _loadConsumedItemName(isar, record);
      if (itemName == null || itemName.isEmpty) {
        continue;
      }
      dinnersByDay.putIfAbsent(record.fechaDiaKey, () => <String>[]).add(itemName);
    }

    final dinnerPatternCount = <String, int>{};
    for (final items in dinnersByDay.values) {
      if (items.isEmpty) {
        continue;
      }
      final normalizedItems = List<String>.from(items)..sort();
      final key = normalizedItems.join(' + ');
      dinnerPatternCount.update(key, (value) => value + 1, ifAbsent: () => 1);
    }

    final repeated = dinnerPatternCount.entries
        .where((entry) => entry.value >= 2)
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (repeated.isEmpty) {
      return 'No hay una cena claramente repetida en las ultimas tres semanas.';
    }

    final summary = repeated
        .take(3)
        .map((entry) => '${entry.key} x${entry.value}')
        .join(', ');
    return 'Cenas repetidas detectadas: $summary.';
  }

  static Future<String> _buildWeeklyAdherenceSummary(
    Isar isar,
    List<RegistroDiario> weeklyRecords,
    double? calorieGoal,
  ) async {
    if (weeklyRecords.isEmpty) {
      return 'Esta semana no hay registros para medir cumplimiento.';
    }

    final recordsByDay = <int, List<RegistroDiario>>{};
    for (final record in weeklyRecords) {
      recordsByDay.putIfAbsent(record.fechaDiaKey, () => <RegistroDiario>[]).add(record);
    }

    var totalWeeklyKcal = 0.0;
    var daysWithinGoal = 0;
    for (final dayRecords in recordsByDay.values) {
      var dayKcal = 0.0;
      for (final record in dayRecords) {
        dayKcal += await _loadConsumedKcal(isar, record);
      }
      totalWeeklyKcal += dayKcal;
      if (calorieGoal != null && calorieGoal > 0) {
        final delta = (dayKcal - calorieGoal).abs();
        if (delta <= calorieGoal * 0.1) {
          daysWithinGoal += 1;
        }
      }
    }

    final avgKcal = totalWeeklyKcal / recordsByDay.length;
    if (calorieGoal == null || calorieGoal <= 0) {
      return 'Cumplimiento semanal: $recordsByDay.length/7 dias con ingestas registradas y media de ${avgKcal.toStringAsFixed(0)} kcal.';
    }

    return 'Cumplimiento semanal: $recordsByDay.length/7 dias registrados, $daysWithinGoal dias dentro de un margen del 10% del objetivo y media de ${avgKcal.toStringAsFixed(0)} kcal.';
  }

  static Future<double?> _loadCalorieGoal(Isar isar) async {
    final goal = await isar.objetivosNutricionales.where().findFirst();
    return goal?.kcalObjetivo;
  }

  static Future<double?> _loadCurrentWeight(Isar isar) async {
    final metrics = await isar.metricasCorporales.where().findAll();
    if (metrics.isEmpty) {
      return null;
    }
    metrics.sort((a, b) => b.fecha.compareTo(a.fecha));
    return metrics.first.peso;
  }

  static Future<String?> _loadConsumedItemName(Isar isar, RegistroDiario record) async {
    if (record.esReceta) {
      final recipe = await isar.recetas.get(record.itemId);
      return recipe?.nombre.trim();
    }

    final food = await isar.alimentos.get(record.itemId);
    return food?.nombre.trim();
  }

  static Future<double> _loadConsumedKcal(Isar isar, RegistroDiario record) async {
    if (record.esReceta) {
      final recipe = await isar.recetas.get(record.itemId);
      if (recipe == null) {
        return 0;
      }

      await recipe.ingredientes.load();
      if (recipe.ingredientes.isEmpty) {
        return 0;
      }

      var recipeKcal = 0.0;
      var totalRecipeWeight = 0.0;
      for (final ingredient in recipe.ingredientes) {
        await ingredient.alimento.load();
        final food = ingredient.alimento.value;
        if (food == null || food.porcionBaseGramos <= 0) {
          continue;
        }
        final factor = ingredient.cantidadGramos / food.porcionBaseGramos;
        recipeKcal += food.kcal * factor;
        totalRecipeWeight += ingredient.cantidadGramos;
      }

      if (totalRecipeWeight <= 0) {
        return 0;
      }

      return recipeKcal * (record.cantidadConsumidaGramos / totalRecipeWeight);
    }

    final food = await isar.alimentos.get(record.itemId);
    if (food == null || food.porcionBaseGramos <= 0) {
      return 0;
    }

    return food.kcal * (record.cantidadConsumidaGramos / food.porcionBaseGramos);
  }

  static String _mealTypeLabel(TipoComida mealType) {
    return switch (mealType) {
      TipoComida.desayuno => 'desayuno',
      TipoComida.comida => 'comida',
      TipoComida.cena => 'cena',
      TipoComida.snack => 'snack',
    };
  }
}