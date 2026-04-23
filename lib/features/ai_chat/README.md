# ai_chat

## Propósito
Módulo de chat con IA para interacción conversacional, sugerencias y soporte inteligente.

## Modelos principales
- ChatMessage: mensaje individual, autor, timestamp, tipo (usuario/IA).

## Providers y flujos
- aiChatProvider: gestiona el estado de la conversación y llamadas a la IA.

## Servicios
- AiChatService: maneja la comunicación con el backend de IA.

## Ejemplo de uso
```dart
final chat = ref.watch(aiChatProvider);
```

## Dependencias
- core/database: almacenamiento de mensajes.

## Notas para IA/desarrolladores
- Extensible para nuevos tipos de mensajes o integraciones de IA.
