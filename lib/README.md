
# Guía exhaustiva de la carpeta /lib

Este directorio contiene toda la lógica de la app, organizada para facilitar la escalabilidad, el testing y la colaboración entre humanos e IAs. Aquí encontrarás la estructura, convenciones y ejemplos para navegar, modificar o extender cualquier módulo.

## Estructura principal

- **core/**
	- Servicios globales (DB, navegación, tema, configuración, utilidades).
	- Ejemplo: acceso a la base de datos, singletons, helpers, temas, rutas globales.
	- Cada submódulo tiene su propio README.md explicando su API y dependencias.

- **features/**
	- Cada subcarpeta es una funcionalidad independiente (ej: calendar, nutrition, tracking, user, etc).
	- Dentro de cada feature:
		- **models/**: Modelos de datos específicos de la feature.
		- **providers/**: Providers Riverpod para lógica de estado y acceso a datos.
		- **ui/**: Widgets y pantallas.
		- **services/**: Lógica de negocio o acceso a APIs.
		- **README.md**: Documentación específica de la feature (ver plantilla abajo).

- **dev/**
	- Scripts de desarrollo, seeds de datos, utilidades para testing/manual QA.
	- Ejemplo: seed_test_data.dart (genera datos de prueba idempotentes).

## Convenciones generales

- Cada módulo/feature debe ser autocontenida y documentada.
- Los modelos deben estar tipados y, si usan Isar, tener anotaciones y ejemplos de uso.
- Los providers deben documentar su propósito, dependencias y ejemplos de consumo.
- Los flujos complejos (ej: onboarding, sincronización, cálculos) deben tener diagramas o pseudocódigo en su README.
- Si una feature depende de otra, debe indicarse explícitamente en su README.

## Ejemplo de plantilla para README.md de una feature

```
# [Nombre de la feature]

## Propósito
Breve descripción de la funcionalidad y su objetivo en la app.

## Modelos principales
- [Modelo1]: descripción, campos clave, relaciones.
- [Modelo2]: ...

## Providers y flujos
- [Provider1]: qué resuelve, dependencias, ejemplo de uso.
- [Provider2]: ...

## Servicios
- [Servicio1]: lógica, dependencias, ejemplo de llamada.

## Ejemplo de uso
```dart
// Ejemplo mínimo de cómo consumir el provider principal
final value = ref.watch(miProvider);
```

## Dependencias
- [Otra feature/core]: motivo de la dependencia.

## Notas para IA/desarrolladores
- Puntos de extensión, riesgos, decisiones de diseño relevantes.
```

## Ejemplo de navegación entre features

Para modificar la lógica de nutrición:
1. Ir a `features/nutrition/`.
2. Leer el README.md para entender modelos y flujos.
3. Revisar los providers en `providers/` y los modelos en `models/`.
4. Si necesitas datos globales, consulta `core/database/` o `core/theme/`.

## Referencias cruzadas

- [docs/arquitectura.md](../docs/arquitectura.md): visión global de la arquitectura.
- [docs/decisiones.md](../docs/decisiones.md): decisiones técnicas y tradeoffs.
- [docs/ia.md](../docs/ia.md): recomendaciones para colaboración con IA.

---

> **Nota:** Si agregas una nueva feature, copia la plantilla de README.md y documenta modelos, providers y flujos. Si modificas un flujo complejo, actualiza el pseudocódigo o diagrama correspondiente.
