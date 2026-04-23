# core/database

## Propósito
Provee la configuración y acceso centralizado a la base de datos local Isar. Permite a todos los módulos acceder y persistir modelos de datos de forma eficiente y tipada.

## Componentes principales
- **isar_config.dart**: Inicializa y gestiona la instancia única de Isar. Registra todos los modelos usados en la app.

## Modelos gestionados
Incluye modelos de:
- ai_chat (mensajes, conversaciones, logs)
- dashboard (checkin, tareas)
- nutrition (alimentos, recetas, registros diarios)
- progress (métricas corporales, agua, objetivos)
- shopping (productos, items manuales)
- tracking (perfil usuario, sesiones ayuno)
- user (preferencias de notificación)
- workouts (ejercicios, rutinas, sesiones)

## Ejemplo de inicialización
```dart
final isar = await IsarConfig.ensureInitialized();
```

## Recomendaciones para IA/desarrolladores
- Si agregas un nuevo modelo, regístralo en isar_config.dart.
- Usa la instancia singleton para evitar corrupción de datos.
- Consulta la documentación de cada modelo en su feature correspondiente.
