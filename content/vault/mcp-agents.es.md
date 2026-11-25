+++
title = "Agentes MCP en la app de escritorio"
description = "Vincula agentes de código en Ajustes -> Agentes -> Agentes MCP, aprueba o autoaprueba lecturas y revoca tokens."
weight = 15
template = "page.html"

[extra]
+++

La app de escritorio ejecuta un punto de acceso HTTP MCP local para que herramientas de código (como Claude Code o Cursor) consulten entradas de la bóveda con tu aprobación. Administra los vínculos y permisos en **Ajustes -> Agentes -> Agentes MCP**.

Para usar el transporte stdio (`baluard mcp serve`) y ver la lista de herramientas de solo lectura expuestas, consulta [Servidor MCP (`baluard mcp`)](@/cli-and-agents/mcp-server.es.md).

## Verificar el punto de acceso local

Cuando tu bóveda está desbloqueada, **Ajustes -> Agentes -> Agentes MCP** muestra el estado del servidor local:

- **Activo:** `Punto de acceso de agentes activo en el puerto <puerto>` (por defecto `17990`, escuchando solo en `127.0.0.1`).
- **Con error:** Si no se pudo abrir el puerto, la sección muestra el mensaje de error.

## Vincular un agente

1. Abre **Ajustes -> Agentes -> Agentes MCP**.
2. Escribe un nombre descriptivo (por ejemplo, `Claude Code en este portátil`) y haz clic en **Vincular agente**.
3. Copia el token Bearer de un solo uso y el fragmento JSON generado.

El fragmento configura el agente con la URL local (`http://127.0.0.1:<puerto>/mcp`) y la cabecera `Authorization: Bearer <token>`.

> [!IMPORTANT]
> Copia el token antes de cerrar la tarjeta de vinculación. Baluard solo guarda un hash del token y no puede volver a mostrarlo. Pega el fragmento en la **configuración de usuario** del agente, nunca en un archivo de configuración de proyecto, porque el token hereda los permisos del archivo.

## Aprobaciones por lectura frente a autoaprobación

Por defecto, cada lectura de secretos (`get_login` o `get_totp`) abre un aviso de aprobación en la app de escritorio con el nombre del agente, la entrada y el campo solicitado.

Si necesitas que un agente lea entradas sin preguntar durante una ventana corta:

1. En **Agentes vinculados**, elige una duración en el selector (`5 min`, `15 min`, `30 min` o `60 min`).
2. Activa **Autoaprobación**.
3. Lee la advertencia y confirma con tu contraseña maestra.

Mientras la autoaprobación está activa, la fila muestra los minutos restantes (`autoaprobación termina en <n> min`). Cualquiera que tenga ese token de vinculación obtiene el mismo acceso hasta que venza el plazo.

## Detener la autoaprobación o revocar un agente

- **Detener la autoaprobación antes de tiempo:** Desactiva el interruptor **Autoaprobación** en la fila del agente.
- **Quitar el acceso por completo:** Haz clic en **Revocar** en la fila del agente. Esto invalida de inmediato su token Bearer y detiene cualquier ventana de autoaprobación activa.
