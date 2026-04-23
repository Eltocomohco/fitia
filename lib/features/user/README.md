# user

## Propósito
Gestión de perfil, preferencias y datos personales del usuario.

## Modelos principales
- UserProfile: nombre, edad, sexo, objetivos.

## Providers y flujos
- userProvider: estado y lógica del usuario.

## Servicios
- UserService: lógica de actualización y sincronización.

## Ejemplo de uso
```dart
final user = ref.watch(userProvider);
```

## Dependencias
- core/database, features/progress.

## Notas para IA/desarrolladores
- Manejar privacidad y sincronización multi-dispositivo.
