import 'dart:io';

import 'package:isar_community/isar.dart';

import 'package:nutrition_offline_app/features/ai_chat/data/models/ai_chat_conversation.dart';
import 'package:nutrition_offline_app/features/ai_chat/data/models/ai_chat_conversation_log.dart';
import 'package:nutrition_offline_app/features/ai_chat/data/models/ai_chat_memory_snapshot.dart';
import 'package:nutrition_offline_app/features/ai_chat/data/models/ai_chat_message.dart';
import 'package:nutrition_offline_app/features/nutrition/data/models/alimento.dart';
import 'package:nutrition_offline_app/features/nutrition/data/models/ingrediente_receta.dart';
import 'package:nutrition_offline_app/features/nutrition/data/models/receta.dart';
import 'package:nutrition_offline_app/features/nutrition/data/models/registro_diario.dart';
import 'package:nutrition_offline_app/features/progress/data/models/dia_entrenamiento.dart';
import 'package:nutrition_offline_app/features/progress/data/models/metrica_corporal.dart';
import 'package:nutrition_offline_app/features/progress/data/models/objetivos_nutricionales.dart';
import 'package:nutrition_offline_app/features/progress/data/models/registro_agua.dart';
import 'package:nutrition_offline_app/features/shopping/data/models/despensa_producto.dart';
import 'package:nutrition_offline_app/features/tracking/data/models/perfil_usuario.dart';
import 'package:nutrition_offline_app/features/tracking/data/models/sesion_ayuno.dart';
import 'package:nutrition_offline_app/features/user/data/models/notification_preferences.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/audio_playlist.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/ejercicio.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/registro_ejercicio_sesion.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/rutina_ejercicio.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/rutina_plantilla.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/serie.dart';
import 'package:nutrition_offline_app/features/workouts/data/models/sesion_entrenamiento.dart';

Future<void> main(List<String> args) async {
  final directoryPath = args.isNotEmpty ? args.first : '/tmp/fitia_chat_logs';
  final agentKey = args.length > 1 ? args[1] : 'nutrition';
  final conversationId = switch (agentKey) {
    'nutrition' => 2,
    'workout' => 3,
    _ => 1,
  };
  final directory = Directory(directoryPath);
  if (!directory.existsSync()) {
    stderr.writeln('Directory not found: $directoryPath');
    exitCode = 2;
    return;
  }

  final isar = await Isar.open(
    [
      AiChatConversationSchema,
      AiChatConversationLogSchema,
      AiChatMessageSchema,
      AiChatMemorySnapshotSchema,
      AlimentoSchema,
      IngredienteRecetaSchema,
      RecetaSchema,
      RegistroDiarioSchema,
      MetricaCorporalSchema,
      DiaEntrenamientoSchema,
      RegistroAguaSchema,
      DespensaProductoSchema,
      ObjetivosNutricionalesSchema,
      PerfilUsuarioSchema,
      SesionAyunoSchema,
      NotificationPreferencesSchema,
      AudioPlaylistSchema,
      EjercicioSchema,
      RegistroEjercicioSesionSchema,
      RutinaPlantillaSchema,
      RutinaEjercicioSchema,
      SesionEntrenamientoSchema,
      SerieSchema,
    ],
    name: 'nutrition_offline_db',
    directory: directory.path,
    inspector: false,
  );

  try {
    final logs = await isar.aiChatConversationLogs
        .filter()
        .agentKeyEqualTo(agentKey)
        .sortByCreatedAtDesc()
        .findAll();

    stdout.writeln('agentKey=$agentKey logs=${logs.length}');
    for (final log in logs) {
      stdout.writeln('--- LOG ${log.id} ${log.createdAt.toIso8601String()} ---');
      stdout.writeln(log.transcript);
      stdout.writeln('--- END LOG ${log.id} ---');
    }

    final currentMessages = await isar.aiChatMessages
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByCreatedAt()
        .findAll();
    stdout.writeln('currentConversationId=$conversationId messages=${currentMessages.length}');
    for (final message in currentMessages) {
      final speaker = message.role == AiChatMessageRole.user ? 'Usuario' : agentKey;
      stdout.writeln('[$speaker] ${message.createdAt.toIso8601String()}');
      stdout.writeln(message.text);
      if (message.actionResult != null && message.actionResult!.trim().isNotEmpty) {
        stdout.writeln('result=${message.actionResult!.trim()}');
      }
      stdout.writeln('');
    }
  } finally {
    await isar.close();
  }
}
