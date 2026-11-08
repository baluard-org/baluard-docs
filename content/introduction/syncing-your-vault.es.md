+++
title = "Sincronizar tu bóveda"
description = "Cómo funciona la sincronización git, dónde vive la copia y qué puede ver tu proveedor."
weight = 2
template = "page.html"

[extra]
+++

Tu bóveda es una carpeta de archivos cifrados en tus dispositivos. Baluard lleva un cuaderno git de esa carpeta: cada cambio (un acceso añadido, una entrada editada, un elemento eliminado) se convierte en un commit firmado en el historial. Nada se sobrescribe en silencio, y cualquier estado anterior de la bóveda se puede recuperar.

## Elige dónde vive la copia

La sincronización es opcional y apunta a almacenamiento que controlas:

- un repositorio privado en GitHub o GitLab,
- tu propio servidor,
- o una unidad USB.

Baluard nunca recibe una copia, y como está construido sobre el propio git, funciona con cualquier proveedor o con ninguno.

## Qué puede ver tu proveedor

Cada línea de la bóveda se cifra en tu dispositivo antes de salir. El repositorio contiene solo texto cifrado: tu proveedor de git, alguien que robe el repositorio entero, e incluso los desarrolladores de Baluard no pueden leerlo sin tu contraseña maestra y las claves de tus dispositivos. Los metadatos técnicos (fechas de los commits, tamaño del repositorio) son visibles para el proveedor por la naturaleza de git; los contenidos no.

Los detalles, incluida la construcción criptográfica exacta, están en el [documento de seguridad](https://baluard.app/security/).

## Conflictos

¿Editas una entrada sin conexión en tu portátil mientras tu teléfono edita otra distinta? Cuando ambos dispositivos sincronizan, git realiza una fusión a tres bandas y conserva ambos cambios. Si dos dispositivos cambian el mismo campo, Baluard te deja inspeccionar la discrepancia y resolverla campo por campo, así que nada se pierde y nada gana en silencio.

¿Nuevo en git? La explicación [What the Git?](https://baluard.app/what-the-git/) en baluard.app cubre repositorios, commits, remotos y fusiones en lenguaje claro.
