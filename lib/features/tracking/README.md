# tracking

## Propósito
Seguimiento de actividades físicas, pasos, calorías quemadas.

## Modelos principales
- Activity: tipo, duración, calorías.

## Providers y flujos
- trackingProvider: estado y lógica de tracking.

## Servicios
- TrackingService: integración con sensores y APIs externas.

## Ejemplo de uso
```dart
final tracking = ref.watch(trackingProvider);
```

## Dependencias
- features/user, core/database.

## Notas para IA/desarrolladores
- Integrar nuevos tipos de actividades fácilmente.
