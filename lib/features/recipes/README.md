# recipes

## Propósito
Gestión y sugerencia de recetas saludables.

## Modelos principales
- Recipe: ingredientes, pasos, valores nutricionales.

## Providers y flujos
- recipesProvider: búsqueda y filtrado de recetas.

## Servicios
- RecipesService: lógica de recomendación y gestión.

## Ejemplo de uso
```dart
final recipes = ref.watch(recipesProvider);
```

## Dependencias
- features/food_hub, features/meals.

## Notas para IA/desarrolladores
- Integrar IA para sugerencias personalizadas.
