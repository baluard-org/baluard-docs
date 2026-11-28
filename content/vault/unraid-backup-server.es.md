+++
title = "Copias programadas en Unraid"
description = "Ejecuta el contenedor baluard-unraid en tu servidor Unraid para respaldar tus bóvedas en un share según un calendario."
weight = 15
template = "page.html"

[extra]
+++

Tu bóveda se sincroniza con un repositorio git, pero la sincronización solo ocurre cuando alguno de tus dispositivos está encendido. El contenedor baluard-unraid descarga tus bóvedas desde el remoto git según un calendario y guarda snapshots en un share de Unraid, incluso cuando todos los computadores y teléfonos están apagados. Corre en el propio NAS: instalas el contenedor una vez, agregas un archivo de configuración por bóveda y te olvidas.

La imagen y la referencia completa de configuración viven en [github.com/baluard-org/baluard-unraid](https://github.com/baluard-org/baluard-unraid).

## Qué necesitas

- Un servidor Unraid (el contenedor es amd64).
- Tu bóveda sincronizada con GitHub, GitLab o Codeberg.
- Un token de solo lectura que el contenedor pueda usar para clonar. En GitHub, crea un personal access token fine-grained con **Contents: read** sobre los repositorios de las bóvedas. Nada más.

## Instalar el contenedor

Unraid instala contenedores a partir de archivos de plantilla. La nuestra vive en el repositorio baluard-unraid; dejarla en su lugar es una copia única por el flash share, sin terminal:

1. Descarga [`templates/baluard-unraid.xml`](https://raw.githubusercontent.com/baluard-org/baluard-unraid/main/templates/baluard-unraid.xml) del repositorio.
2. Abre el flash share en tu explorador de archivos: `\\<server>\flash` en Windows, `smb://<server>/flash` en macOS. Navega a `config/plugins/dockerMan/templates-user/` (crea la carpeta si no existe) y guarda ahí el archivo como `my-baluard-unraid.xml`.
3. En la interfaz web de Unraid, ve a la pestaña **Docker**, haz clic en **Add Container** y elige `my-baluard-unraid` en el dropdown de Template. Todos los campos se rellenan solos.
4. Mapea las dos rutas:
   - `/config` a `/mnt/user/appdata/baluard-unraid` (configuración, clones de bóvedas, logs).
   - `/backups` al share donde deben quedar los snapshots, por ejemplo `/mnt/user/backups`.
5. Pon **Git Token** con el token de solo lectura del paso anterior, y **Timezone** con la tuya, para que el calendario corra cuando esperas.
6. Apply. El contenedor no necesita puertos ni interfaz web.

Un listado en Community Applications está planeado, con los archivos de postulación ya en el repositorio. Cuando salga, instalar será **Apps** -> buscar "baluard" -> **Install**, sin copiar archivos. Hasta entonces, la copia por el flash share de arriba es lo único que el contenedor te pide.

## Agregar una bóveda

Crea un archivo `.env` por bóveda en la carpeta `vaults.d` del directorio appdata. Este es el ejemplo mínimo útil:

```ini
VAULT_URL=https://github.com/you/baluard-family.git
```

Eso es todo: el formato por defecto es un mirror git de solo lectura del repo de la bóveda, programado diario a las 03:00, conservando los últimos 5 snapshots en `/backups/<nombre-del-repo>/`. La próxima ejecución programada lo toma en cuenta; sin reiniciar.

Un ejemplo completo con todas las opciones está en [`config/vaults.d.example/`](https://github.com/baluard-org/baluard-unraid/tree/main/config/vaults.d.example) del repositorio.

## Formatos de respaldo

Cada bóveda elige su formato con `VAULT_FORMAT`:

| Formato | Qué queda en el share | Master password | Se une a la bóveda | Restaurar |
| --- | --- | --- | --- | --- |
| `mirror` (por defecto) | Zip de un mirror git del repo de la bóveda, historial completo | No | No — basta acceso de solo lectura | Clonar el mismo remote de nuevo y unirse como dispositivo |
| `zip` | Zip del clone de trabajo del CLI, con el historial git | No | Sí — el primer clone necesita la invitación del dueño | Descomprimir y abrir la carpeta con Baluard |
| `bldbak` | Export cifrado, restaurable en cualquier bóveda Baluard | Sí | Sí | Importar el archivo y entrar la backup passphrase |
| `json` | Export en texto plano de todas las entradas | Sí | Sí | Importar el archivo |

El contenido de tu bóveda está cifrado en reposo, y por eso `mirror` y `zip` nunca necesitan tu master password: el contenedor solo maneja bytes cifrados. `mirror` es el formato por defecto porque solo necesita acceso de lectura al repo git.

Dos advertencias honestas:

- `zip`, `bldbak` y `json` clonan a través del CLI de Baluard, que inscribe la caja de respaldo como dispositivo de la bóveda. La política de confianza de dispositivos de Baluard exige que el dueño invite a la caja primero (`baluard members invite`, la caja la registra, tú la apruebas). Una caja no invitada no puede inscribirse, así que esos formatos fallan en la primera ejecución sin la invitación. `mirror` no tiene ese requisito.
- `bldbak` y `json` necesitan el master password en el archivo de configuración, y la primera ejecución también necesita la [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md) una sola vez, para esa inscripción. `json` escribe passwords legibles en el share. Evita este formato salvo que entiendas y aceptes eso.

## Calendario y retención

El calendario a nivel de contenedor es `daily` (03:00), `weekly` (domingos 03:00), `monthly` (día 1, 03:00), o cualquier expresión cron con `BALUARD_CRON`. Una bóveda puede seguir su propio ritmo con `VAULT_SCHEDULE`.

La retención conserva los N snapshots más nuevos por bóveda, 5 por defecto, configurable con `BALUARD_RETENTION` o por bóveda con `VAULT_RETENTION`. La limpieza solo borra archivos creados por el contenedor, llamados `<nombre-del-repo>-<fecha>-<hora>.ext`, dentro de la carpeta propia de cada bóveda.

## Restaurar un snapshot

**Desde un zip:** descomprime en cualquier máquina y abre la carpeta con Baluard (`baluard open <carpeta>`, o desde la app de escritorio). El zip lleva el historial git de la bóveda, así que no se pierde nada.

**Desde un `.bldbak`:** impórtalo desde **Settings -> Data Import / Export** en la app de escritorio con la backup passphrase, igual que cualquier respaldo cifrado.

**Desde un export JSON:** impórtalo igual. Contiene entradas legibles, así que trata el archivo como sensible mientras exista.

## Actualizaciones y fallos

Con `BALUARD_AUTO_UPDATE=true` (por defecto), el contenedor revisa los releases oficiales de Baluard antes de cada ejecución y actualiza su copia del CLI en el lugar, verificando las sumas de control contra las firmas del release. El tag de la imagen funciona como piso de versión.

Si una bóveda falla, las demás igual corren, el trabajo termina con error y, con `BALUARD_WEBHOOK_URL` configurada, el contenedor envía un mensaje JSON `{vault, status, time}` a tu webhook (Discord, Slack, ntfy, o lo que acepte JSON). Los logs están en `docker logs` y en `/config/logs`.

## Notas de seguridad

- El modo `mirror` por defecto no guarda ningún master password y no tiene acceso de escritura a la bóveda. El contenedor no puede leer una sola entrada; archiva bytes cifrados.
- Si usas `bldbak` o `json`, mantén los permisos de los archivos `.env` ajustados (600): guardan el master password y, opcionalmente, la frase de recuperación.
- La imagen verifica la descarga del CLI de Baluard contra el `SHA256SUMS` oficial del release al compilar, y cada actualización contra las mismas firmas.
- Los snapshots en el share son tan privados como tu red y la configuración del share. El remoto git ya es la primera copia de tu bóveda; trata estos snapshots como la segunda, y considera una tercera (nube o almacenamiento frío) para lo que de verdad importa.
