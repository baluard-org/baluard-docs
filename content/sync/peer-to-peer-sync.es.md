+++
title = "Sincronización entre pares (P2P)"
description = "Sincroniza tu bóveda directamente entre tus dispositivos vinculados, sin proveedor de git ni almacenamiento externo."
weight = 3
template = "page.html"

[extra]
+++

La sincronización entre pares es la segunda forma de mover tu bóveda. Tu bóveda sigue siendo un repositorio git, y la sincronización sigue enviando los mismos commits firmados; la diferencia es el camino. En lugar de guardar una copia en GitHub o en una unidad USB, tus dispositivos se conectan directamente entre ellos y se entregan los commits nuevos. Sin proveedor, sin cuenta, sin almacenamiento externo en el camino.

## Cuándo encaja la sincronización entre pares

- Sincronizas entre dos o más dispositivos tuyos y no quieres una cuenta de proveedor de git.
- Tus dispositivos están en la misma red, o ambos en línea al mismo momento.

Ambos dispositivos deben estar vinculados a la misma bóveda, y ambos deben estar ejecutando Baluard cuando sincronices. Un dispositivo que no esté vinculado no puede conectarse aunque conozca tu dirección: Baluard verifica las claves del dispositivo en cada intento de conexión, en ambas direcciones, y rechaza a los desconocidos.

## Actívala en la app de escritorio

Abre Ajustes, la pestaña Sincronizar, y busca la tarjeta "Sincronización directa entre dispositivos":

1. Pulsa **Activar P2P**. Baluard muestra una advertencia: solo P2P significa que no hay copia fuera del dispositivo. Sigue leyendo más abajo.
2. Copia el código junto a **Dirección de este dispositivo**.
3. En tu otro dispositivo, activa P2P igual y pega la dirección de tu primer dispositivo en **Dirección del otro dispositivo**.
4. Pulsa **Sincronizar**. Al terminar, ambos dispositivos tienen los mismos commits.

Intercambia las direcciones para sincronizar en la otra dirección, o repite los pasos con cada dispositivo que quieras en el grupo.

## Actívala en el móvil

Abre Ajustes y busca "Sincronización directa entre dispositivos". Los pasos son los mismos: activa P2P, copia la dirección de este dispositivo, pega la del otro y sincroniza.

En el móvil, el escucha de P2P funciona solo mientras la app está abierta. En el escritorio también funciona en segundo plano mientras el demonio está activo. Abre la app en el teléfono y sincroniza desde la computadora.

## Actívala desde la CLI

Los comandos P2P hablan con el demonio, así que debe estar en ejecución (sin `--direct`):

```bash
baluard sync p2p status                 # estado y dirección de este dispositivo
baluard sync p2p enable                 # inicia el punto de conexión
baluard sync p2p sync <dirección-par>   # sincroniza con un par vinculado
baluard sync p2p disable                # detiene el punto de conexión
```

## Qué viaja por la conexión

Los mismos datos cifrados de git que en cualquier otro lado. El par recibe solo texto cifrado y los commits firmados que lo describen, y el dispositivo que recibe verifica las claves del que envía antes de aplicar nada. Si no es posible una conexión directa, por ejemplo detrás de una red estricta, Baluard pasa la conexión por un servidor intermediario. El intermediario solo trasmite tráfico cifrado; no puede leer tu bóveda.

## Conoce los límites

- **La sincronización necesita a ambos lados presentes.** A diferencia de un proveedor de git, que guarda tus commits hasta que vuelvas, una sincronización entre pares solo ocurre cuando ambos dispositivos están en línea y con Baluard en ejecución.
- **Solo P2P significa que no hay copia fuera del dispositivo.** Si pierdes todos tus dispositivos vinculados al mismo tiempo, la bóveda se pierde. La advertencia lo dice en la app, y importa: combina la sincronización entre pares con un [proveedor de git](@/sync/git-providers.es.md), una [sincronización por carpeta](@/sync/folder-sync.es.md) o una copia de seguridad cifrada, para que exista una copia fuera de tus dispositivos.
- Los conflictos se resuelven igual que con la sincronización git: [los cambios se combinan y las ediciones del mismo campo te preguntan](@/sync/syncing-your-vault.md#conflicts).
