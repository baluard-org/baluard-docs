+++
title = "Importar desde Bitwarden"
description = "Traslada tu bóveda de Bitwarden a Baluard, adjuntos incluidos."
weight = 3
template = "page.html"

[extra]
+++

Baluard importa la exportación en texto plano `.json` de Bitwarden: inicios de sesión con URIs y detección de coincidencias, semillas TOTP, notas, tarjetas, identidades, notas seguras, claves SSH, campos personalizados, historial de contraseñas, favoritos y carpetas.

### Nota sobre la exportación cifrada

La exportación `.json` cifrada de Bitwarden usa un formato propietario que solo descifran sus propias apps, así que Baluard no puede leerla. Usa la exportación en texto plano y borra el archivo cuando termine la importación.

## Exportar desde Bitwarden

Desde la [app web de Bitwarden](https://vault.bitwarden.com):

1. Ve a **Tools** → **Export vault**.
2. Elige el formato de archivo **`.json`** (no el cifrado).
3. Ingresa tu contraseña maestra y guarda `bitwarden.json` en un lugar temporal.

## Importar a Baluard

La importación vive en la app, no en una terminal. Desbloquea tu bóveda primero y luego:

**Escritorio (Windows, macOS, Linux):** abre Settings y ve a la pestaña Data. Bajo Import Vault Data, elige Bitwarden JSON en el menú de origen, pulsa Import y selecciona el archivo `.json` exportado. Un resumen te dice cuántas entradas entraron, y aparecen en tu bóveda de inmediato.

**Móvil (Android):** abre Settings y ve a Data. Pulsa Import entries, elige Bitwarden JSON y selecciona el archivo exportado.

La importación mapea inicios de sesión con URIs y detección de coincidencias, semillas TOTP, notas, tarjetas, identidades, notas seguras, claves SSH, campos personalizados, historial de contraseñas, favoritos y carpetas. Las passkeys llegan como entradas de solo lectura, porque Bitwarden no puede exportar la clave privada de una passkey; regístralas de nuevo con los servicios que las usan.

¿Prefieres la terminal? `baluard import bw-json bitwarden.json` contra una bóveda desbloqueada hace lo mismo.

## Adjuntos

La exportación `.json` de Bitwarden referencia los adjuntos por nombre de archivo, pero no los incluye. Para traerlos:

1. Descarga cada adjunto desde Bitwarden.
2. Renómbralo exactamente al nombre de archivo que la entrada esperaba (el nombre en la entrada original).
3. Abre la entrada importada en Baluard y adjunta el archivo.

## Eliminar la exportación

`bitwarden.json` contiene todas tus contraseñas en texto plano. Cuando la importación esté completa y verificada, bórralo (y vacía la papelera).

Comprueba algunas entradas importadas en Baluard antes de eliminarla: URIs, semillas TOTP y campos personalizados son los que conviene revisar.
