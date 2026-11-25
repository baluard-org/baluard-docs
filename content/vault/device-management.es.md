+++
title = "Gestión de dispositivos"
description = "Consulta qué dispositivos se han sincronizado con tu bóveda, agrega dispositivos nuevos y revoca equipos perdidos o robados."
weight = 12
template = "page.html"

[extra]
+++

Cada computadora o teléfono que sincroniza con tu bóveda de Baluard queda registrado como un dispositivo con su propia clave. Puedes revisar tus dispositivos activos y revocar cualquiera que ya no uses o en el que no confíes.

## Ver tus dispositivos

Abre **Ajustes -> Dispositivos** en la app de escritorio para ver los dispositivos que se han sincronizado con esta bóveda:

- **Este dispositivo** señala el equipo que estás usando ahora.
- **Última sincronización** muestra cuándo sincronizó por última vez cada dispositivo.
- **Estado** refleja su actividad reciente (**Activo**, **Inactivo**, **Antiguo** o **Dormido**).

## Agregar un dispositivo nuevo

Para sumar una segunda computadora o teléfono a una bóveda existente:

1. Instala Baluard en el dispositivo nuevo y conéctalo al mismo [proveedor git](@/sync/git-providers.es.md), [sincronización con carpeta](@/sync/folder-sync.es.md) o [sincronización entre pares](@/sync/peer-to-peer-sync.es.md).
2. Desbloquea con tu contraseña maestra (o usa tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md) si vinculas desde cero).
3. Sincroniza una vez para que el dispositivo nuevo aparezca en **Ajustes -> Dispositivos**.

## Revocar un dispositivo perdido o robado

Si pierdes, te roban o retiras una computadora o un teléfono:

1. Abre **Ajustes -> Dispositivos** en un dispositivo de confianza.
2. Haz clic en **Revocar** junto al dispositivo que quieres quitar y confirma. Baluard rota las claves de la bóveda para que el dispositivo revocado no pueda descifrar cambios futuros.
3. **Rota las credenciales de git:** Si la bóveda sincroniza con GitHub, GitLab o Codeberg, abre la configuración del repositorio en tu proveedor y elimina la clave de despliegue o token (PAT) del dispositivo revocado; luego marca **He rotado las credenciales de git** en Baluard.

Si la revocación desde el escritorio falla, puedes ejecutar `baluard --direct devices revoke <id>` desde la CLI.

## Ten en cuenta

- Revocar un dispositivo impide que lea cambios futuros, pero todo lo que ya sincronizó mientras tenía acceso puede seguir en su disco local. Si te robaron un equipo desbloqueado o con Desbloqueo rápido activo, cambia también las contraseñas de tus cuentas más importantes.
- En un **Espacio compartido**, los miembros actuales pueden agregar sus propios dispositivos adicionales sin necesitar una nueva aprobación de administrador.
