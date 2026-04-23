# dashboard

## Propósito
Pantalla principal con resumen de métricas, accesos rápidos y widgets de progreso.

## Modelos principales
- DashboardMetric: métrica mostrada (ej: calorías, pasos).

## Providers y flujos
- dashboardProvider: agrega y expone datos de features.

## Servicios
- DashboardService: lógica de agregación y presentación.

## Ejemplo de uso
```dart
final metrics = ref.watch(dashboardProvider);
```

## Dependencias
- features/nutrition, features/progress, features/user.

## Notas para IA/desarrolladores
- Añadir nuevos widgets requiere modificar dashboardProvider y UI.
