+++
title = "Compartir directo (Contactos y Buzones)"
description = "Comparte entradas individuales o carpetas en espejo vivo con contactos de confianza sin crear un Espacio compartido."
weight = 4
template = "page.html"

[extra]
+++

Si solo necesitas enviar algunas contraseñas a alguien sin crear un [Espacio compartido](@/shared-spaces/_index.es.md), puedes compartir de forma directa usando **Contactos** y **Buzones**.

## Agregar y verificar contactos

Antes de compartir directo, intercambia tarjetas de contacto en **Ajustes -> Contactos**:

1. En **Mi tarjeta**, haz clic en **Copiar código de contacto** y envíaselo a la otra persona.
2. Cuando te envíe el suyo, pégalo en **Agregar contacto** y haz clic en **Agregar**.
3. **Verifica por otro canal:** Comparen **Mi código de verificación** y **Su código de verificación** en una llamada, en persona o por otro canal de confianza. Cuando coincidan, haz clic en **Los códigos coinciden** para marcar el contacto como **Verificado**.

Si un contacto muestra "Tarjeta antigua: pídele que la comparta de nuevo para recibir", pídele que te envíe un código de contacto nuevo desde su versión actual de Baluard.

## Carpetas en espejo vivo (Buzones)

En **Ajustes -> Buzones**, puedes reflejar entradas elegidas en una carpeta compartida (por ejemplo, una carpeta sincronizada con Dropbox, Nextcloud o Syncthing) para que los destinatarios tengan siempre copias actualizadas:

- **Compartir a una carpeta:** En **Reflejar elementos**, elige las entradas y destinatarios, selecciona la **Carpeta** y haz clic en **Espejar**. Si eliges varios destinatarios, Baluard crea una subcarpeta independiente para cada uno dentro de esa carpeta.
- **Actualizaciones:** Cuando editas una entrada espejada, Baluard actualiza la copia del destinatario. También puedes hacer clic en **Sincronizar ahora** para enviar los cambios al instante.
- **Detener el espejo:** Haz clic en **Detener** en cualquier carpeta reflejada para dejar de enviar cambios futuros. Las copias que el destinatario ya recibió siguen en su dispositivo.
- **Recibir una carpeta:** En **Carpetas recibidas**, haz clic en **Agregar** y elige la ruta de la carpeta compartida que te enviaron. Haz clic en **Ver elementos** para leer o copiar las entradas compartidas.

## Ten en cuenta

- Todo lo que compartes por Contactos y Buzones se cifra para la clave del destinatario antes de escribirse en la carpeta.
- Quitar un contacto en **Ajustes -> Contactos** no borra los elementos que ya recibió.
- Compartir directo funciona mejor para entregas puntuales o grupos pequeños de accesos. Para colaboración continua en familia, equipos o trabajo con roles y carpetas compartidas, crea un [Espacio compartido](@/shared-spaces/_index.es.md).
