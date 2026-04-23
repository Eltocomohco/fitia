# inventory

## Propósito
Gestión del inventario de alimentos y productos del usuario.

## Modelos principales
- InventoryItem: producto, cantidad, fecha de caducidad.

## Providers y flujos
- inventoryProvider: estado y lógica del inventario.

## Servicios
- InventoryService: lógica de actualización y alertas.

## Ejemplo de uso
```dart
final inventory = ref.watch(inventoryProvider);
```

## Dependencias
- features/food_hub, core/database.

## Notas para IA/desarrolladores
- Integrar alertas de caducidad y sincronización con compras.
