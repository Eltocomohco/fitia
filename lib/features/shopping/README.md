# shopping

## Propósito
Gestión de listas de compras y sincronización con inventario.

## Modelos principales
- ShoppingItem: producto, cantidad, comprado.

## Providers y flujos
- shoppingProvider: estado de la lista de compras.

## Servicios
- ShoppingService: lógica de actualización y sugerencias.

## Ejemplo de uso
```dart
final shopping = ref.watch(shoppingProvider);
```

## Dependencias
- features/inventory, features/food_hub.

## Notas para IA/desarrolladores
- Permitir generación automática de listas según planes de comidas.
