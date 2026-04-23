# splash

## Propósito
Pantalla de bienvenida y lógica de inicialización de la app.

## Modelos principales
- SplashState: estado de carga, errores.

## Providers y flujos
- splashProvider: controla el estado de la pantalla splash.

## Servicios
- SplashService: lógica de inicialización y chequeos previos.

## Ejemplo de uso
```dart
final splash = ref.watch(splashProvider);
```

## Dependencias
- core/database, core/navigation.

## Notas para IA/desarrolladores
- Personalizar mensajes y animaciones según contexto.
