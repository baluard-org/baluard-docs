+++
title = "Flujos agénticos con el CLI"
description = "Permite que agentes de IA y scripts ejecuten comandos con tus secretos sin ver jamás los valores en texto plano."
weight = 5
template = "page.html"

aliases = ["es/introduction/vault/agentic-workflows", "es/vault/agentic-workflows"]

[extra]
+++

Baluard permite que agentes de código con IA y scripts de automatización usen tus credenciales para ejecutar comandos o renderizar archivos de configuración sin ver jamás los secretos. El CLI `baluard` envía una solicitud por referencia a `baluard-daemon`, que pide tu aprobación, lanza el comando por sí mismo, inyecta los campos aprobados y limpia cualquier secreto filtrado de `stdout` y `stderr` antes de devolver la salida.

## Descubrir entradas sin exponer secretos

Los agentes pueden buscar y listar metadatos de entradas (`id`, `name`, `type`, `username`) en JSON sin descifrar ningún secreto:

```bash
baluard list --json
baluard search "Stripe" --json
```

## Referencias de secretos

Las referencias usan `baluard://[bóveda/]entrada/campo`:

- **Dos segmentos (`baluard://GitHub/password`):** resuelve `entrada` en la bóveda activa por UUID exacto, prefijo hexadecimal único de 4+ caracteres o título sin distinguir mayúsculas.
- **Tres segmentos (`baluard://work/GitHub/password`):** apunta a una bóveda específica por slug o nombre visible.
- **Escape:** codifica `/` como `%2F` y `%` como `%25` dentro de un segmento.
- **Tipos y campos permitidos:** `login`, `secure_note`, `card`, `identity`, `bank_account`, `drivers_license` y `passport` (`username`, `password`, código `totp` en vivo, `notes`, `custom:<nombre>` y campos escalares). Las claves SSH, claves de firma y claves privadas están bloqueadas.

Si un título o prefijo coincide con varias entradas, el CLI sale con código `2` y lista los IDs candidatos para desambiguar.

## Casos de uso habituales

### 1. Pasar credenciales a un comando (`baluard run --env`)

```bash
baluard run --env GH_TOKEN=baluard://GitHub/password --need "publicar release" -- gh release create v1.0.0
```

La entrada estándar (`stdin`) redirigida se reenvía al comando (hasta 1 MiB), `stdout` y `stderr` se transmiten en vivo con los secretos limpiados (en forma cruda, base64, porcentaje y JSON escapado), y `SIGINT`, `SIGTERM` y `SIGHUP` se reenvían al grupo de procesos hijo. Usa `--timeout` (por ejemplo `--timeout 5m`, por defecto `60s`, máximo `1h`) para compilaciones o despliegues largos.

### 2. Usar un archivo `.env.tpl` o variables heredadas

Combina referencias `baluard://` con valores literales no secretos en una plantilla de entorno:

```dotenv
# .env.tpl
NODE_ENV=production
STRIPE_KEY=baluard://Stripe/custom:api_key
```

Ejecuta el comando con una sola aprobación:

```bash
baluard run --env-file .env.tpl --need "ejecutar pruebas" -- npm test
```

Orden de prioridad de menor a mayor: variables heredadas cuyo valor empiece con `baluard://`, entradas de `--env-file` en orden y flags `--env`.

### 3. Renderizar un archivo de configuración (`baluard inject`)

Cuando una herramienta necesita secretos dentro de un archivo de configuración en lugar de variables de entorno, usa `baluard inject`:

```bash
baluard inject -i config.tpl -o config.json --need "escribir configuración local"
```

Solo se reemplazan los marcadores `{% raw %}{{ baluard://... }}{% endraw %}`; cualquier otra sintaxis `{% raw %}{{ ... }}{% endraw %}` (como Helm o Jinja) queda intacta. Los archivos de salida se escriben de forma atómica con permisos `0600`. Baluard registra los archivos inyectados y rechaza sobrescribir un archivo editado manualmente salvo que pases `--force`. Omite `-o` (o pasa `-o -`) para escribir en `stdout`.

### 4. Leer un valor único en tu propia sesión desbloqueada (`baluard read`)

Para uso interactivo en tu shell cuando la bóveda ya está desbloqueada:

```bash
baluard read baluard://GitHub/totp
```

## Aprobar solicitudes (Escritorio y CLI headless)

- **Aplicación de escritorio:** Cuando un agente ejecuta `baluard run` o `baluard inject`, se abre un diálogo de aprobación. Si la bóveda está bloqueada, la pantalla de bloqueo muestra un aviso indicando el agente en espera; al desbloquear se abre la aprobación de inmediato.
- **CLI headless (SSH o servidor):** Aprueba desde otra terminal donde tu bóveda esté desbloqueada:

```bash
baluard agent pending
baluard agent approve <request_id>
baluard agent deny <request_id>
```

- **Permisos y auditoría:** Las concesiones aprobadas quedan ligadas al árbol de procesos solicitante y expiran a los 15 minutos. Puedes inspeccionar o revocar permisos activos con `baluard agent list` y `baluard agent revoke`.
- **Aprobación automática acotada:** Para omitir avisos temporalmente en este dispositivo (5 minutos por defecto si omites `--duration`):

```bash
baluard agent auto-approve --on
baluard agent auto-approve --on --duration 30m
baluard agent auto-approve --on --yolo   # indefinido hasta --off
baluard agent auto-approve --off
```

## Códigos de salida

- `0`: éxito (para `baluard run`, devuelve el código de salida del hijo o `128 + señal`).
- `1`: entrada no encontrada o error general.
- `2`: referencia ambigua (imprime lista de candidatos).
- `3`: bóveda bloqueada.
- `4`: solicitud denegada o expirada.
- `5`: límite de frecuencia por proceso excedido.
