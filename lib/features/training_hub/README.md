# training_hub

## Propósito
Gestión de rutinas de entrenamiento, ejercicios y planes personalizados.

## Modelos principales
- TrainingRoutine: lista de ejercicios, días, objetivos.

## Providers y flujos
- trainingProvider: estado y lógica de rutinas.

## Servicios
- TrainingService: lógica de recomendación y seguimiento.

## Ejemplo de uso
```dart
final routines = ref.watch(trainingProvider);
```

## Dependencias
- features/user, features/progress.

## Notas para IA/desarrolladores
- Permitir personalización avanzada y feedback automático.
