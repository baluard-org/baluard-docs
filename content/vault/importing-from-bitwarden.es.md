+++
title = "Importar desde Bitwarden"
description = "Traslada tu bóveda de Bitwarden a Baluard: exporta un .json en texto plano, respalda los adjuntos, importa y vuelve a adjuntar tus archivos."
weight = 4
template = "page.html"
aliases = ["es/introduction/importing-from-bitwarden", "es/introduction/vault/importing-from-bitwarden"]

[extra]
+++

Baluard importa la exportación `.json` en texto plano de Bitwarden: inicios de sesión con URIs y detección de coincidencias, semillas TOTP, notas, tarjetas, identidades, notas seguras, claves SSH, campos personalizados, historial de contraseñas, favoritos y carpetas. Las passkeys llegan como entradas de solo lectura, porque Bitwarden no puede exportar la clave privada de una passkey; regístralas de nuevo con los servicios que las usan.

Las exportaciones cifradas de Bitwarden (`.json (Encrypted)` y la variante con contraseña del móvil) no sirven. La importación lee solo texto plano. La exportación `.csv` de Bitwarden también se importa (`bw-csv`), pero pierde datos, así que prefiere el `.json`.

## Exportar desde Bitwarden

La exportación contiene toda tu bóveda en forma legible, así que trata el archivo con cuidado: nunca lo envíes por correo ni por chat, y bórralo cuando termines.

Desde la [app web de Bitwarden](https://vault.bitwarden.com):

1. Entra en Tools y luego Export.
2. En Export from, elige My vault.
3. En File format, elige `.json` (el de texto plano, no `.json (Encrypted)`).
4. Pulsa Export y confirma con tu contraseña maestra.

Desde la línea de comandos, ejecuta primero `bw sync` y luego:

```sh
bw export --format json --output bitwarden.json
```

La CLI usa `.csv` por defecto, así que la opción `--format json` importa.

## Respalda tus adjuntos primero

Los adjuntos de Bitwarden no van dentro de la exportación `.json`. Expórtalos aparte, o se quedan atrás.

Desde la misma pantalla de Export, haz una segunda exportación con el formato `.zip (with attachments)`. Descomprime el zip en un lugar seguro y consérvalo hasta que cada adjunto esté vuelto a adjuntar en Baluard. El zip también lleva una copia del `.json` de la bóveda, así que la carpeta sirve por sí sola como respaldo completo previo a la migración.

## Importar a Baluard

La importación vive en la app, no en una terminal. Desbloquea tu bóveda primero y luego:

**Escritorio (Windows, macOS, Linux):** abre Ajustes y ve a la pestaña Importación / exportación de datos. En Importar datos de la bóveda, elige Bitwarden JSON en el menú de origen, haz clic en Importar y selecciona el archivo `.json` exportado. Un resumen te dice cuántas entradas se importaron, y aparecen en tu bóveda de inmediato.

**Móvil (Android):** abre Ajustes y ve a Datos. Toca Importar entradas, elige Bitwarden JSON y selecciona el archivo exportado.

La importación mapea inicios de sesión con URIs y detección de coincidencias, semillas TOTP, notas, tarjetas, identidades, notas seguras, claves SSH, campos personalizados, historial de contraseñas, favoritos y carpetas. Las passkeys llegan como entradas de solo lectura, porque Bitwarden no puede exportar la clave privada de una passkey; regístralas de nuevo con los servicios que las usan.

¿Prefieres la terminal? `baluard import bw-json bitwarden.json` contra una bóveda desbloqueada hace lo mismo.

## Vuelve a adjuntar tus archivos

Abre la carpeta descomprimida del respaldo de adjuntos y añade los archivos a mano, una entrada cada vez. Emparéjalos por nombre; Bitwarden guarda los adjuntos por elemento, y el `.json` conserva los nombres de los elementos.

## Eliminar la exportación

El `.json` en texto plano y la carpeta de adjuntos descomprimida contienen todos tus secretos en forma legible. Borra ambos cuando termine la migración, y vacía la papelera de tu gestor de archivos para que el archivo desaparezca de verdad. Conserva el zip solo si quieres un respaldo de largo plazo en formato Bitwarden; es tan sensible como la propia bóveda.

Comprueba algunas entradas importadas en Baluard antes de eliminarla: URIs, semillas TOTP y campos personalizados son los que conviene revisar.
