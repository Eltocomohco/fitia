# workouts

## Propósito
Gestión de sesiones de entrenamiento individuales y registro de ejercicios.

## Modelos principales
- WorkoutSession: fecha, ejercicios, duración.

## Providers y flujos
- workoutsProvider: estado y lógica de sesiones.

## Servicios
- WorkoutsService: lógica de registro y análisis.

## Ejemplo de uso
```dart
final workouts = ref.watch(workoutsProvider);
```

## Dependencias
- features/training_hub, features/user.

## Notas para IA/desarrolladores
- Permitir análisis de rendimiento y sugerencias automáticas.
