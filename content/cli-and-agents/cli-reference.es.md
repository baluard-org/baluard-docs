+++
title = "Referencia diaria del CLI"
description = "Crea, desbloquea, busca, edita, sincroniza y administra bóvedas y entradas desde la terminal con baluard."
weight = 3
template = "page.html"

[extra]
+++

El CLI `baluard` te da acceso completo a tu bóveda desde la terminal. Úsalo para crear o cambiar bóvedas, agregar y buscar entradas, copiar códigos de dos factores, generar contraseñas y ejecutar sincronizaciones o chequeos de seguridad.

## Modo daemon frente a `--direct`

Por defecto, `baluard` se comunica con `baluard-daemon` por un socket Unix para mantener tu sesión desbloqueada en memoria entre comandos. Pasa `--direct` para omitir el daemon y operar directo sobre el directorio de la bóveda.

Opciones globales disponibles en todos los comandos:

- `--vault <slug>`: apunta a una bóveda registrada por su slug.
- `--vault-path <ruta>`: ruta al directorio de la bóveda al usar `--direct` (por defecto `.`).
- `--direct`: ejecuta sin `baluard-daemon`.
- `--socket <ruta>`: cambia la ruta del socket Unix del daemon.

## Crear, desbloquear y cambiar bóvedas

```bash
baluard init --name "Personal" --profile desktop-std
baluard unlock
baluard lock
```

`baluard init` acepta `--profile` (`mobile-low`, `desktop-std` o `desktop-high`), `--slug`, `--auto-lock <minutos>`, `--theme`, `--lang` y `--family` (crea un Espacio compartido).

Administra varias bóvedas registradas con `baluard vaults`:

```bash
baluard vaults list
baluard vaults switch trabajo
baluard vaults set-default personal
baluard vaults close trabajo
baluard vaults add /ruta/a/la/boveda
baluard vaults detach trabajo
```

- `switch` cambia la bóveda activa en el daemon en ejecución (y pide la contraseña maestra si está bloqueada).
- `close` quita la bóveda del mapa en memoria del daemon y borra sus llaves sin quitarla del registro.
- `detach` quita la bóveda del registro de Baluard dejando los archivos en disco (pasa `--delete-from-disk` solo si quieres borrar el directorio de forma permanente).

## Agregar, buscar, leer y editar entradas

### Agregar entradas

Usa `baluard add <tipo>` para `login`, `card`, `secure-note` (alias `note`), `identity` y `ssh-key` (alias `ssh`):

```bash
baluard add login --name "GitHub" --username "ada" --uri "https://github.com"
baluard add note --name "Wi-Fi" --notes "Red de invitados"
baluard add card --name "Tarjeta empresa" --brand "Visa" --exp-month "08" --exp-year "2028"
baluard add ssh --name "Llave deploy" --serve-via-agent
```

Si omites `--password` o `--private-key` en `add login` o `add ssh`, el CLI los pide de forma interactiva para que no queden en el historial del shell.

### Listar, buscar y leer

```bash
baluard list
baluard list --archived --json
baluard search "GitHub"
baluard search "GitHub" --all
baluard get "GitHub" --decrypt
baluard totp "GitHub"
```

- `baluard list` y `baluard search` devuelven metadatos (`id`, `name`, `type`, `username`). Pasa `--all` en `search` para buscar en todas las bóvedas desbloqueadas, o `--vault <slug>` para una en particular.
- `baluard get <id-o-nombre> --decrypt` pide tu contraseña maestra e imprime la entrada descifrada.
- `baluard totp <id-o-nombre>` muestra el código 2FA actual de una entrada con semilla TOTP.

### Editar, organizar y eliminar

```bash
baluard edit <id> --name "GitHub Trabajo" --favorite true --tags "trabajo,dev"
baluard archive <id>
baluard unarchive <id>
baluard delete <id>
```

Usa `baluard folder` y `baluard tag` para carpetas y etiquetas, `baluard trash` para ver o restaurar elementos eliminados y `baluard attachment` para adjuntos.

## Generador de contraseñas y chequeo de seguridad

Genera una contraseña aleatoria o una frase de paso sin salir de la terminal:

```bash
baluard generate password --length 24
baluard generate password --length 20 --no-symbols
baluard generate passphrase --words 6 --sep "-"
```

Cuando hay una bóveda desbloqueada, los valores generados se guardan en el historial del generador igual que en la app de escritorio.

Ejecuta un chequeo de contraseñas en la bóveda activa para detectar claves débiles, reutilizadas o antiguas:

```bash
baluard health
```

## Sincronizar desde el CLI

```bash
baluard sync status
baluard sync pull
baluard sync push
baluard sync commit
baluard sync log --limit 10
```

También puedes conectar un remoto con `baluard sync remote <url>` o `baluard sync remote --folder <ruta>`, y clonar una bóveda existente con `baluard sync clone <proveedor> <usuario/repo>` o `baluard sync clone-url <url>`.

## Siguiente

- [Flujos agénticos con el CLI](@/cli-and-agents/agentic-workflows.es.md): inyecta secretos en comandos y archivos de configuración sin exponerlos.
- [Servidor MCP (`baluard mcp`)](@/cli-and-agents/mcp-server.es.md): expón consultas de solo lectura a herramientas de código por stdio o HTTP.
