+++
title = "Encontrar logs para reportes de errores"
description = "Dónde guarda Baluard el archivo daemon.log en Windows, Linux y macOS, y cómo recogerlo para un reporte."
weight = 5
template = "page.html"

[extra]
+++

Cuando algo falla en la aplicación de escritorio o en la CLI, el servicio en segundo plano registra errores y eventos de sincronización en un archivo llamado `daemon.log`. Adjuntar las líneas relevantes de `daemon.log` en un reporte ayuda a identificar la causa del fallo.

## Ubicación de los logs por plataforma

| Plataforma | Ruta |
| --- | --- |
| Windows | `%LOCALAPPDATA%\baluard\logs\daemon.log` |
| Linux | `~/.local/state/baluard/daemon.log` |
| macOS | `~/Library/Logs/baluard/daemon.log` |

Si tienes `BALUARD_LOG_DIR` definido en tu entorno, Baluard escribe `daemon.log` dentro de esa carpeta.

### Windows

Pulsa **Win + R**, pega la ruta siguiente y pulsa **Enter** para abrir la carpeta de logs en el Explorador de archivos:

```text
%LOCALAPPDATA%\baluard\logs
```

Ten en cuenta que Baluard guarda sus logs, `registry.json` y bóvedas locales en `%LOCALAPPDATA%\baluard\`, no en `%APPDATA%\baluard\`.

### Linux

Si `XDG_STATE_HOME` está definido, Baluard escribe en `$XDG_STATE_HOME/baluard/daemon.log`. En caso contrario usa `~/.local/state/baluard/daemon.log` (o `~/.local/share/baluard/daemon.log` en sistemas sin directorio de estado).

Para mostrar las últimas 100 líneas en una terminal:

```bash
tail -n 100 "${XDG_STATE_HOME:-$HOME/.local/state}/baluard/daemon.log"
```

### macOS

Abre **Finder**, pulsa **Cmd + Shift + G**, pega la ruta siguiente y pulsa **Enter**:

```text
~/Library/Logs/baluard
```

O muestra las últimas 100 líneas en Terminal:

```bash
tail -n 100 ~/Library/Logs/baluard/daemon.log
```

## Antes de compartir un log

`daemon.log` no guarda tu contraseña maestra, tu frase de recuperación ni entradas descifradas. Puede incluir rutas locales, slugs de bóvedas y URLs de repositorios, así que revisa las líneas que copies antes de publicarlas en un issue público.
