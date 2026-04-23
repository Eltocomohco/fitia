# core/notifications

## Propósito
Gestiona la programación y entrega de notificaciones locales configurables para el usuario.

## Componentes principales
- **local_notification_service.dart**: Servicio singleton para inicializar, programar y cancelar notificaciones.

## Ejemplo de inicialización
```dart
await LocalNotificationService.instance.initialize();
```

## Recomendaciones para IA/desarrolladores
- Usa los métodos del servicio para programar recordatorios personalizados.
- Consulta notification_preferences en features/user para preferencias del usuario.
