# calendar

## Propósito
Gestión de eventos, recordatorios y visualización de calendario para el usuario.

## Modelos principales
- CalendarEvent: evento con fecha, tipo, descripción.

## Providers y flujos
- calendarProvider: estado y lógica de eventos.

## Servicios
- CalendarService: lógica de negocio para eventos.

## Ejemplo de uso
```dart
final events = ref.watch(calendarProvider);
```

## Dependencias
- core/database: persistencia de eventos.

## Notas para IA/desarrolladores
- Sincronizable con otros módulos (ej: workouts, meals).
