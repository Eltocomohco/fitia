# core/services

## Propósito
Servicios globales reutilizables por múltiples features. Incluye lógica de audio, IA, widgets nativos y consultas externas.

## Componentes principales
- **audio_player_service.dart**: Inicializa y gestiona el audio para entrenamientos.
- **gemini_action_executor.dart**: Ejecuta acciones propuestas por IA Gemini sobre la base de datos.
- **gemini_companion_service.dart**: Servicio conversacional enriquecido con datos locales.
- **home_widget_service.dart**: Sincroniza datos con widgets nativos de pantalla de inicio.
- **open_food_facts_service.dart**: Consulta información nutricional por código de barras.

## Ejemplo de inicialización de audio
```dart
await WorkoutAudioService.ensureInitialized();
```

## Recomendaciones para IA/desarrolladores
- Usa estos servicios para lógica transversal a varias features.
- Consulta la documentación interna de cada archivo para detalles de implementación.
