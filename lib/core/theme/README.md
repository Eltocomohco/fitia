# core/theme

## Propósito
Define la configuración global de colores, fuentes y estilos para toda la app.

## Componentes principales
- **app_theme.dart**: Colores, esquemas de tema claro/oscuro y ThemeData para MaterialApp.

## Ejemplo de uso
```dart
MaterialApp(
  theme: AppTheme.light,
)
```

## Recomendaciones para IA/desarrolladores
- Si cambias la paleta, actualiza los valores en app_theme.dart.
- Usa ThemeData para mantener coherencia visual en toda la app.
