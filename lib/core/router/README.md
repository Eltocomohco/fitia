# core/router

## Propósito
Define y centraliza todas las rutas de la app usando GoRouter. Permite navegación declarativa y tipada entre pantallas.

## Componentes principales
- **app_router.dart**: Declara rutas, parsea parámetros y conecta pantallas de features.

## Ejemplo de uso
```dart
context.go('/dashboard');
```

## Recomendaciones para IA/desarrolladores
- Si agregas una nueva pantalla global, declárala aquí.
- Usa funciones auxiliares para parsear parámetros complejos.
