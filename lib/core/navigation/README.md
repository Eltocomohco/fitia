# core/navigation

## Propósito
Contiene el shell principal de navegación con pestañas inferiores persistentes. Permite la navegación entre las principales secciones de la app.

## Componentes principales
- **main_shell_scaffold.dart**: Widget de alto nivel que gestiona el estado de la navegación y la selección de pestañas.

## Ejemplo de uso
```dart
MainShellScaffold(
  child: childWidget,
  location: currentLocation,
)
```

## Recomendaciones para IA/desarrolladores
- Si agregas una nueva sección global, añade una pestaña en _tabs.
- El estado de navegación se gestiona internamente, pero puedes acceder a la ubicación actual vía location.
