# progress

## Propósito
Seguimiento de métricas de progreso: peso, medidas, fotos, hitos.

## Modelos principales
- ProgressEntry: fecha, tipo de métrica, valor.

## Providers y flujos
- progressProvider: estado y lógica de progreso.

## Servicios
- ProgressService: lógica de registro y visualización.

## Ejemplo de uso
```dart
final progress = ref.watch(progressProvider);
```

## Dependencias
- features/user, core/database.

## Notas para IA/desarrolladores
- Permitir visualización gráfica y exportación de datos.
