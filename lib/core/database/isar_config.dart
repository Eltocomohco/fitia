import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/nutrition/data/models/alimento.dart';
import '../../features/nutrition/data/models/ingrediente_receta.dart';
import '../../features/nutrition/data/models/receta.dart';
import '../../features/nutrition/data/models/registro_diario.dart';
import '../../features/progress/data/models/metrica_corporal.dart';
import '../../features/progress/data/models/dia_entrenamiento.dart';
import '../../features/progress/data/models/registro_agua.dart';
import '../../features/progress/data/models/objetivos_nutricionales.dart';
import '../../features/tracking/data/models/perfil_usuario.dart';

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
        AlimentoSchema,
        IngredienteRecetaSchema,
        RecetaSchema,
        RegistroDiarioSchema,
        MetricaCorporalSchema,
        DiaEntrenamientoSchema,
        RegistroAguaSchema,
        ObjetivosNutricionalesSchema,
        PerfilUsuarioSchema,
      ],
      name: _instanceName,
      directory: dir.path,
      inspector: true,
    );
  }
}
