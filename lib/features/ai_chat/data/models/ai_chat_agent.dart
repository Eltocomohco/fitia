enum AiChatAgent {
  nutrition,
  workout,
  boss,
}

extension AiChatAgentX on AiChatAgent {
  String get routeValue {
    return switch (this) {
      AiChatAgent.nutrition => 'nutrition',
      AiChatAgent.workout => 'workout',
      AiChatAgent.boss => 'boss',
    };
  }

  int get conversationId {
    return switch (this) {
      AiChatAgent.boss => 1,
      AiChatAgent.nutrition => 2,
      AiChatAgent.workout => 3,
    };
  }

  String get displayName {
    return switch (this) {
      AiChatAgent.nutrition => 'NutriFitio',
      AiChatAgent.workout => 'GymBroFitio',
      AiChatAgent.boss => 'FitiBoss',
    };
  }

  String get shortLabel {
    return switch (this) {
      AiChatAgent.nutrition => 'Nutricion',
      AiChatAgent.workout => 'Entreno',
      AiChatAgent.boss => 'Boss',
    };
  }

  String get description {
    return switch (this) {
      AiChatAgent.nutrition =>
        'Comidas, recetas, despensa, objetivos y metricas corporales.',
      AiChatAgent.workout =>
        'Rutinas, ejercicios, descanso, progresion y sesiones.',
      AiChatAgent.boss =>
        'Coordina nutricion y entreno cuando la decision mezcla ambos mundos.',
    };
  }

  String get composerHint {
    return switch (this) {
      AiChatAgent.nutrition =>
        'Pregunta a NutriFitio por comidas, recetas o compra',
      AiChatAgent.workout =>
        'Pregunta a GymBroFitio por rutina, ejercicios o descanso',
      AiChatAgent.boss =>
        'Pregunta a FitiBoss por decisiones que mezclan comida y entreno',
    };
  }
}

AiChatAgent parseAiChatAgent(String? rawValue) {
  final normalized = rawValue?.trim().toLowerCase();
  return switch (normalized) {
    'nutrition' || 'nutrifitio' || 'food' || 'comida' =>
      AiChatAgent.nutrition,
    'workout' || 'gymbrofitio' || 'training' || 'entreno' =>
      AiChatAgent.workout,
    'boss' || 'fitiboss' => AiChatAgent.boss,
    _ => AiChatAgent.boss,
  };
}

AiChatAgent inferAiChatAgentForMessage(String rawMessage) {
  final message = rawMessage.trim().toLowerCase();
  if (message.isEmpty) {
    return AiChatAgent.boss;
  }

  const nutritionKeywords = <String>[
    'comida',
    'comer',
    'cena',
    'desayuno',
    'snack',
    'receta',
    'recetas',
    'despensa',
    'compra',
    'supermercado',
    'kcal',
    'calorias',
    'proteina',
    'proteinas',
    'carbohidratos',
    'grasas',
    'macros',
    'alimento',
    'alimentos',
    'peso',
    'grasa corporal',
    'menu',
    'menus',
  ];
  const workoutKeywords = <String>[
    'entreno',
    'entrenar',
    'rutina',
    'rutinas',
    'ejercicio',
    'ejercicios',
    'serie',
    'series',
    'repeticiones',
    'gym',
    'gimnasio',
    'pesas',
    'fuerza',
    'hipertrofia',
    'descanso',
    'recuperacion',
    'sesion',
    'sesiones',
    'progresion',
    'volumen',
    'cardio',
  ];
  const bossKeywords = <String>[
    'recomposicion',
    'plan completo',
    'plan semanal',
    'objetivo',
    'objetivos',
    'deficit',
    'superavit',
    'ganar masa',
    'perder grasa',
    'cambiar mi fisico',
  ];

  final nutritionScore = nutritionKeywords
      .where((keyword) => message.contains(keyword))
      .length;
  final workoutScore = workoutKeywords
      .where((keyword) => message.contains(keyword))
      .length;
  final hasBossSignal = bossKeywords.any(message.contains);

  if (hasBossSignal || (nutritionScore > 0 && workoutScore > 0)) {
    return AiChatAgent.boss;
  }
  if (nutritionScore > 0) {
    return AiChatAgent.nutrition;
  }
  if (workoutScore > 0) {
    return AiChatAgent.workout;
  }
  return AiChatAgent.boss;
}