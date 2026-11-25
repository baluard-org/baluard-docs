+++
title = "Servidor MCP (baluard mcp)"
description = "Conecta herramientas de código como Claude Code o Cursor a Baluard por MCP con acceso de solo lectura aprobado por ti."
weight = 7
template = "page.html"

[extra]
+++

Baluard puede funcionar como servidor del Protocolo de Contexto de Modelo (MCP) para que herramientas como Claude Code o Cursor consulten accesos y códigos de dos factores cuando lo necesiten. El acceso es de solo lectura y pasa por la misma política de aprobaciones que los demás flujos de agentes.

## Dos formas de conectar

Puedes conectar un cliente MCP de cualquiera de estas dos maneras:

1. **Transporte stdio (`baluard mcp serve`):** Tu herramienta de código lanza `baluard mcp serve` como subproceso. En la primera llamada, `baluard-daemon` identifica al proceso padre y te pide aprobar la sesión volátil (espera máxima de 60 segundos). Pasa `--vault <slug>` para fijar la sesión a una bóveda específica en lugar de la activa.
2. **Punto de acceso HTTP local (vinculado en Escritorio):** La app de escritorio levanta un servidor MCP HTTP local (puerto por defecto `17990`, ruta `http://127.0.0.1:17990/mcp`). Vincula un agente en **Ajustes -> Agentes -> Agentes MCP** para obtener un token Bearer de un solo uso y un fragmento JSON listo para pegar en tu configuración de usuario. Consulta [Agentes MCP en la app de escritorio](@/vault/mcp-agents.es.md).

## Configurar `baluard mcp serve` (stdio)

Agrega `baluard` en la configuración MCP a nivel de usuario de tu herramienta de código:

```json
{
  "mcpServers": {
    "baluard": {
      "command": "baluard",
      "args": ["mcp", "serve"]
    }
  }
}
```

Para fijar la sesión a una bóveda concreta por slug:

```json
{
  "mcpServers": {
    "baluard": {
      "command": "baluard",
      "args": ["mcp", "serve", "--vault", "trabajo"]
    }
  }
}
```

Al iniciar, `baluard mcp serve` limpia cualquier variable de entorno `BALUARD_*` heredada para que el cliente no pueda redirigir el socket del daemon ni reutilizar tu token de sesión personal del CLI.

## Herramientas expuestas al agente

El servidor MCP expone tres herramientas de solo lectura:

| Herramienta | Propósito | Aprobación |
|-------------|-----------|------------|
| `search_items` | Busca entradas por nombre o usuario (`query`, máximo 20 resultados). Devuelve IDs, nombres, usuarios y URIs sin secretos. | Permitida con la sesión activa |
| `get_login` | Lee usuario, contraseña y campos personalizados de un `item_id` (nunca devuelve semillas TOTP). | Requiere tu aprobación en cada lectura |
| `get_totp` | Lee el código de dos factores actual de un `item_id`. | Requiere tu aprobación en cada lectura |

Las operaciones de escritura, las llaves privadas SSH y las semillas TOTP sin procesar nunca se exponen por MCP.

## Aprobar o autoaprobar solicitudes

Cuando un agente llama a `get_login` o `get_totp`, Baluard te pide confirmación en la app de escritorio (o con `baluard agent pending` / `baluard agent approve <id>` en una terminal sin interfaz gráfica).

Si estás en una sesión desatendida y quieres autoaprobación temporal:

- **Para agentes vinculados por HTTP:** Activa **Autoaprobación** en **Ajustes -> Agentes -> Agentes MCP**, elige una duración (`5`, `15`, `30` o `60` min) y confirma con tu contraseña maestra.
- **Desde el CLI:** Ejecuta `baluard agent auto-approve --on --duration 5m` (y `baluard agent auto-approve --off` o `baluard agent revoke` para detenerlo).
