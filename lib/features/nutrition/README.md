# Feature: Nutrition

## Propósito
Gestiona toda la lógica de nutrición: cálculo de macros, registro de alimentos y recetas, consolidación de listas de compras y generación de resúmenes diarios. Es el núcleo para el seguimiento nutricional personalizado.

## Modelos principales

- **Alimento** (`data/models/alimento.dart`)
  - Entidad base de alimento con macros por porción.
  - Campos: `id`, `externalId`, `nombre`, `kcal`, `proteinas`, `carbohidratos`, `grasas`, `grupo` (enum: principal, vegetal, añadido).
  - Ejemplo de uso:
    ```dart
    final pollo = Alimento(nombre: 'Pollo', kcal: 120, proteinas: 22, carbohidratos: 0, grasas: 2, grupo: GrupoAlimento.principal);
    ```

- **IngredienteReceta** (`data/models/ingrediente_receta.dart`)
  - Relaciona un alimento con una cantidad y grupo funcional dentro de una receta.
  - Campos: `id`, `cantidadGramos`, `grupo` (enum: principal, vegetal, añadido).

- **Receta** (`data/models/receta.dart`)
  - Receta compuesta por múltiples ingredientes.
  - Campos: `id`, `externalId`, `nombre`, `instrucciones`, `numeroRaciones`, `ingredientes` (IsarLinks<IngredienteReceta>).

- **RegistroDiario** (`data/models/registro_diario.dart`)
  - Registro de consumo de alimento o receta en una fecha concreta.
  - Campos: `id`, `fecha`, `tipoComida` (enum: desayuno, comida, cena, snack), `esReceta`, `itemId`, `cantidadConsumidaGramos`.

- **NutritionalSummary** (`domain/models/nutritional_summary.dart`)
  - Resumen agregado de macros y energía.
  - Campos: `kcal`, `proteinas`, `carbohidratos`, `grasas`.

## Servicios y lógica de negocio

- **NutritionCalculatorService** (`domain/services/nutrition_calculator_service.dart`)
  - Calcula macros totales de una receta considerando ingredientes y porciones.
  - Calcula macros consumidos en un día a partir de los registros diarios.
  - Ejemplo de uso:
    ```dart
    final resumen = await nutritionCalculator.calcularMacrosReceta(receta);
    ```

- **ShoppingListService** (`domain/services/shopping_list_service.dart`)
  - Consolida ingredientes necesarios para un rango de fechas, útil para generar listas de compras automáticas.
  - Ejemplo de uso:
    ```dart
    final lista = await shoppingListService.consolidarIngredientes(startDate: inicio, endDate: fin);
    ```

## Flujos clave

1. **Registro de consumo diario**
   - El usuario registra alimentos o recetas consumidas (RegistroDiario).
   - Se agregan a la base de datos y se usan para cálculos diarios.

2. **Cálculo de macros diarios**
   - Se consultan los registros del día y se suman los macros usando NutritionCalculatorService.

3. **Consolidación de lista de compras**
   - Se analizan los registros planeados para un rango de fechas y se consolidan los ingredientes requeridos.

## Dependencias
- core/database: persistencia de modelos.
- features/meals: integración para planes alimenticios.
- features/food_hub: consulta de alimentos.

## Ejemplo de uso real
```dart
// Calcular macros de una receta
final resumen = await nutritionCalculator.calcularMacrosReceta(receta);

// Consolidar lista de compras semanal
final lista = await shoppingListService.consolidarIngredientes(startDate: lunes, endDate: domingo);
```

## Recomendaciones para IA/desarrolladores
- Si agregas un nuevo tipo de comida o campo nutricional, actualiza los modelos y los servicios de cálculo.
- Mantén la lógica de agregación y consolidación en los servicios de domain/ para facilitar el testing y la extensión.
- Documenta cualquier cambio en los enums o relaciones entre modelos.
