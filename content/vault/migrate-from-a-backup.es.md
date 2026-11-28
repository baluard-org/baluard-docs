+++
title = "Migra a otro gestor de contraseñas"
description = "Convierte un zip de respaldo y tu frase de 24 palabras en una exportación en texto plano, sin instalar Baluard ni restaurar la bóveda."
weight = 16
template = "page.html"

[extra]
+++

Irte de Baluard antes significaba instalar la app, restaurar un respaldo y exportar a mano. El comando `backup-extract` reduce eso a un paso: le entregas un zip de respaldo y escribe cada entrada y cada adjunto como archivos de texto plano que otros gestores pueden importar. No toca tu bóveda, no se une a nada y nunca toca la red.

## Lo que necesitas

- Un zip de respaldo de la bóveda. Sirve un snapshot del [respaldo en Unraid](@/vault/unraid-backup-server.es.md) o cualquier zip de la carpeta de la bóveda, incluido un snapshot `mirror`.
- Tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md). El respaldo no lleva llaves de dispositivo, así que la frase es la única forma de abrirlo en una máquina nueva.
- Tu contraseña maestra. El comando la verifica cuando el respaldo trae la comprobación que lo permite, así que una contraseña filtrada por sí sola nunca basta para abrir un respaldo robado.
- La herramienta de línea de comandos de Baluard (`baluard`). En Linux viene con los paquetes de la app; en otros sistemas, descarga el archivo del CLI desde la [página de releases](https://github.com/baluard-org/baluard/releases).

Un archivo `.bldbak` cifrado por sí solo no basta: guarda metadatos de las entradas pero ningún adjunto. Extrae desde un zip de la carpeta de la bóveda.

## Ejecuta la extracción

```bash
baluard backup-extract baluard-vault-20261128-030000.zip --out migrated/
```

El comando pide la frase de recuperación y la contraseña maestra, y luego escribe la carpeta de salida. Para scripts, las variables de entorno `BALUARD_RECOVERY_PHRASE` y `BALUARD_PASSWORD` responden a las preguntas, con la advertencia de siempre: otros procesos de la máquina pueden leer variables de entorno.

## Qué obtienes

- `entries.json` — cada entrada, con una estructura que la mayoría de los gestores importan directamente. Si el tuyo no tiene importación JSON genérica, su opción de importación de Bitwarden lee este mismo formato.
- `attachments/` — cada adjunto, descifrado y agrupado por entrada.
- `manifest.json` — conteos y checksums SHA-256 de cada archivo, para verificar la copia.
- `README.txt` — la misma advertencia de texto plano de esta página, dentro de la carpeta.

Importa `entries.json` en la otra app, revisa algunas entradas y listo.

## Borra la copia en texto plano

La carpeta de salida contiene tus contraseñas en forma legible. Después de importar en otro lado:

1. Revisa algunas entradas en la app nueva.
2. Borra la carpeta de salida y vacía la papelera si el escritorio mantiene una.
3. Conserva el zip de respaldo. Está cifrado, es tu copia, y versiones futuras de Baluard siempre podrán extraer de él de nuevo.

## Notas

- La extracción es totalmente offline. Sin cuenta, sin sync, sin contacto con ningún servidor.
- El comando nunca inscribe la máquina como dispositivo de la bóveda ni escribe en el respaldo, así que usarlo sobre el respaldo de una bóveda que no te pertenece no deja rastro en ningún lado.
- La carpeta de salida y cada archivo dentro se crean legibles solo para tu usuario (modo 0700/0600).
- El comando `backup-extract` llega en el próximo release de Baluard; el resto de esta página lo describe tal como se comportará ahí.
