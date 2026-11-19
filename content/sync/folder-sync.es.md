+++
title = "Sincronización por carpeta"
description = "Sincroniza tu bóveda a través de una carpeta que ya respaldas: Dropbox, Google Drive, iCloud Drive, Nextcloud o Syncthing."
weight = 4
template = "page.html"

[extra]
+++

La sincronización por carpeta convierte cualquier carpeta de tu disco en el destino remoto de tu bóveda. Baluard guarda un repositorio git dentro de la carpeta que elijas, y dejas que lo que ya sincroniza esa carpeta, como Dropbox, Google Drive, iCloud Drive, Nextcloud o Syncthing, la lleve a tus otros dispositivos. Esos servicios hacen la copia; Baluard hace el git. Sin cuenta de proveedor, sin token, sin clave SSH.

Por debajo es la misma sincronización de siempre: la carpeta contiene un pequeño repositorio git (una subcarpeta `<slug>.git`), y tu bóveda viaja como commits firmados con las mismas reglas de combinación. El servicio de carpeta es solo un mensajero de datos git.

## Cuándo encaja la sincronización por carpeta

- Ya pagas o ejecutas un servicio de sincronización de carpetas y no quieres una cuenta de proveedor de git.
- Quieres una copia fuera del dispositivo sin confiar en un tercero nuevo: el servicio que ya elegiste guarda la carpeta (cifrada).
- Tus dispositivos no están en línea al mismo momento. A diferencia de la [sincronización entre pares](@/sync/peer-to-peer-sync.es.md), la carpeta guarda los commits hasta que cada dispositivo vuelva, así que los dispositivos nunca necesitan encontrarse.

## Configúrala en la app de escritorio

Abre Ajustes, la pestaña Sincronizar, y busca la tarjeta "Sincronizar con una carpeta":

1. Pulsa **Elegir carpeta** y elige una carpeta que cubra tu servicio de sincronización, por ejemplo una carpeta dentro de tu Dropbox o iCloud Drive.
2. Baluard crea el repositorio git dentro de ella y activa la sincronización por carpeta.

En tu otro dispositivo, conéctate a la misma carpeta (ver la CLI más abajo, o elegir la carpeta sincronizada igual que en el móvil). Los commits llegan a la carpeta a través de tu servicio de sincronización, y cada dispositivo los descarga en su próxima sincronización.

## Configúrala en el móvil

Abre Ajustes y busca la tarjeta "Sincronizar con una carpeta", luego pulsa **Elegir carpeta**. Android muestra su selector de carpetas del sistema: elige la carpeta que tu app de sincronización mantiene al día, o una carpeta de la propia app de sincronización. En iOS, elige una carpeta de iCloud Drive o de la app Archivos. Baluard copia los datos git entre la carpeta compartida y una copia de trabajo interna, así que la bóveda sigue funcionando aunque el servicio esté en plena transferencia.

## Configúrala desde la CLI

Apunta una bóveda existente a una carpeta:

```bash
baluard sync remote --folder ~/Dropbox/baluard
baluard sync push
```

Conecta un dispositivo nuevo desde una carpeta que ya contiene la bóveda (después de que el servicio de sincronización la haya entregado):

```bash
baluard sync clone-url --folder ~/Dropbox/baluard
```

La carpeta no necesita preparación: el primer comando crea el repositorio `<slug>.git` dentro de ella si aún no existe. `baluard sync status` muestra a dónde apunta la bóveda.

## Qué vive en la carpeta

La carpeta gana una subcarpeta `<slug>.git`, por ejemplo `baluard-vault.git`. Dentro están los mismos datos cifrados de git que guardaría un proveedor: texto cifrado y commits firmados. No edites su contenido; la carpeta es un destino remoto, no un documento.

Una aclaración sobre lo que no es: la carpeta no es una copia de seguridad legible. Para abrir la bóveda siempre necesitas Baluard más tu contraseña maestra (y tu frase de recuperación si perdiste el dispositivo). Consulta [Sincronizar tu bóveda](@/sync/syncing-your-vault.es.md) para saber qué puede y no puede revelar una copia robada.

## Conoce los límites

- **El mensajero marca el ritmo.** Baluard escribe en la carpeta; tu servicio de sincronización decide cuándo llega a los otros dispositivos. En una conexión lenta, espera la demora habitual de Dropbox o Drive, no una sincronización instantánea.
- **Las copias de conflicto se toleran.** Los servicios de carpeta a veces producen archivos duplicados (una "copia en conflicto" de Dropbox, por ejemplo) cuando los dispositivos compiten. Baluard detecta estos artefactos y sincroniza a su alrededor; la bóveda misma se combina mediante git, así que dos dispositivos que escriben a la vez convergen en la próxima sincronización.
- **Tampoco es un plan de respaldo por sí sola.** La carpeta vive bajo los términos de tu servicio de sincronización. Si quieres doble seguro, combínala con la [sincronización entre pares](@/sync/peer-to-peer-sync.es.md) entre tus dispositivos o con una segunda copia en otro lugar.

## ¿Qué transporte elijo?

- Un proveedor de git ([Elegir un proveedor de Git](@/sync/git-providers.es.md)): un almacén permanente fuera del dispositivo con historial; necesita una cuenta en el host.
- Sincronización por carpeta (esta página): un almacén que ya tienes, con un servicio que ya pagas o ejecutas; sin cuenta con nadie nuevo.
- [Sincronización entre pares](@/sync/peer-to-peer-sync.es.md): sin almacén; los dispositivos se entregan los commits directamente, y necesitan estar en línea juntos.
