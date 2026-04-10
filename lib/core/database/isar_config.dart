import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/ai_chat/data/models/ai_chat_conversation.dart';
import '../../features/ai_chat/data/models/ai_chat_conversation_log.dart';
import '../../features/ai_chat/data/models/ai_chat_memory_snapshot.dart';
import '../../features/ai_chat/data/models/ai_chat_message.dart';
import '../../features/nutrition/data/models/alimento.dart';
import '../../features/nutrition/data/models/ingrediente_receta.dart';
import '../../features/nutrition/data/models/receta.dart';
import '../../features/nutrition/data/models/registro_diario.dart';
import '../../features/progress/data/models/metrica_corporal.dart';
import '../../features/progress/data/models/dia_entrenamiento.dart';
import '../../features/progress/data/models/registro_agua.dart';
import '../../features/shopping/data/models/despensa_producto.dart';
import '../../features/shopping/data/models/shopping_manual_item.dart';
import '../../features/progress/data/models/objetivos_nutricionales.dart';
import '../../features/tracking/data/models/perfil_usuario.dart';
import '../../features/tracking/data/models/sesion_ayuno.dart';
import '../../features/user/data/models/notification_preferences.dart';
import '../../features/workouts/data/models/audio_playlist.dart';
import '../../features/workouts/data/models/ejercicio.dart';
import '../../features/workouts/data/models/registro_ejercicio_sesion.dart';
import '../../features/workouts/data/models/rutina_ejercicio.dart';
import '../../features/workouts/data/models/rutina_plantilla.dart';
import '../../features/workouts/data/models/serie.dart';
import '../../features/workouts/data/models/sesion_entrenamiento.dart';

/// Configuración centralizada de Isar para la aplicación.
abstract final class IsarConfig {
  static const String _instanceName = 'nutrition_offline_db';

  /// Garantiza que la instancia de Isar esté abierta y lista para usarse.
  static Future<Isar> ensureInitialized() async {
    final existing = Isar.getInstance(_instanceName);
    if (existing != null) {
      return existing;
    }

    final dir = await getApplicationDocumentsDirectory();

    return Isar.open(
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
        ShoppingManualItemSchema,
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
      name: _instanceName,
      directory: dir.path,
      inspector: true,
    );
  }
}
