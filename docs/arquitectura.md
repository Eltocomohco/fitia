# Arquitectura del Proyecto Fitia

- Arquitectura basada en Clean Architecture y modularidad por features.
- Gestión de estado con Riverpod.
- Persistencia local con Isar.
- Navegación con GoRouter.
- Separación clara entre presentación, dominio (implícito) y datos.
- Servicios centralizados para lógica transversal.

## Capas principales
- **core/**: servicios, configuración, utilidades globales.
- **features/**: cada funcionalidad aislada (ej: nutrition, tracking, user...)
- **dev/**: scripts y seeds de desarrollo.

## Flujos típicos
- Añadir feature: crear carpeta en `features/`, documentar en su README.md, exponer provider si aplica.
- Añadir modelo: definir en `data/models/`, enlazar con Isar si es persistente.
- Añadir provider: usar Riverpod, documentar propósito y dependencias.
