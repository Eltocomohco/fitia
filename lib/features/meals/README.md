# meals

## Propósito
Gestión de comidas, planes alimenticios y registro diario.

## Modelos principales
- Meal: comida, lista de alimentos, horario.

## Providers y flujos
- mealsProvider: estado de comidas del día.

## Servicios
- MealsService: lógica de registro y sugerencias.

## Ejemplo de uso
```dart
final meals = ref.watch(mealsProvider);
```

## Dependencias
- features/food_hub, features/nutrition.

## Notas para IA/desarrolladores
- Permitir personalización de planes y sugerencias automáticas.
