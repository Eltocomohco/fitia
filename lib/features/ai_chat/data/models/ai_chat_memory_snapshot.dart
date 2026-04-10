import 'package:isar_community/isar.dart';

part 'ai_chat_memory_snapshot.g.dart';

@Collection(accessor: 'aiChatMemorySnapshots')
class AiChatMemorySnapshot {
  AiChatMemorySnapshot({
    this.id = 1,
    required this.updatedAt,
    this.preferencesSummary = 'Sin resumen de preferencias todavia.',
    this.frequentFoodsSummary = 'Sin alimentos frecuentes detectados.',
    this.repeatedDinnersSummary = 'Sin cenas repetidas detectadas.',
    this.weeklyAdherenceSummary = 'Sin cumplimiento semanal calculado.',
  });

  Id id;

  @Index()
  DateTime updatedAt;

  String preferencesSummary;

  String frequentFoodsSummary;

  String repeatedDinnersSummary;

  String weeklyAdherenceSummary;
}