# food_hub

## Propósito
Gestión y exploración de alimentos, base de datos de ingredientes y valores nutricionales.

## Modelos principales
- FoodItem: alimento, nutrientes, etiquetas.

## Providers y flujos
- foodProvider: búsqueda y filtrado de alimentos.

## Servicios
- FoodService: lógica de consulta y actualización de alimentos.

## Ejemplo de uso
```dart
final foods = ref.watch(foodProvider);
```

## Dependencias
- core/database, features/nutrition.

## Notas para IA/desarrolladores
- Optimizar búsquedas para grandes volúmenes de datos.
