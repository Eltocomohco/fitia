# Decisiones técnicas y convenciones

- Se prioriza la modularidad y la extensibilidad.
- Los seeds solo se ejecutan si no hay datos previos (idempotentes).
- Los servicios no críticos no deben bloquear el arranque.
- Los nombres de archivos y clases siguen lower_snake_case y UpperCamelCase respectivamente.
- Los tests deben ir en `/test/` y reflejar la estructura de `/lib/`.
- Los cambios de la IA deben documentarse en el README.md del módulo afectado.
