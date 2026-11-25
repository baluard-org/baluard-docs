+++
title = "Exportación y copias de seguridad"
description = "Crea copias cifradas (.bldbak) o exporta los datos de tu bóveda para migrar, imprimir o guardar sin conexión."
weight = 14
template = "page.html"

[extra]
+++

Tu bóveda ya sincroniza con tu repositorio git o carpeta compartida, pero guardar una exportación sin conexión te permite tener un respaldo en una unidad USB, imprimir accesos de emergencia o mover tus datos a otra herramienta.

## Formatos de exportación

Abre **Ajustes -> Importación / exportación de datos** y elige una de las tres opciones en **Exportar datos de la bóveda**:

- **Copia cifrada (`.bldbak`):** Archivo protegido con contraseña de tu bóveda. Baluard genera o te deja elegir una frase de contraseña dedicada para la copia. Esta frase es la única forma de abrir el archivo `.bldbak` (es independiente de tu contraseña maestra y Baluard nunca la guarda).
- **Copia de Baluard (JSON):** Exportación en texto plano de toda tu bóveda para respaldo completo o cambio de dispositivo.
- **Hoja de cálculo (`.csv`):** Solo inicios de sesión, útil para imprimir o abrir en hojas de cálculo y otras apps.

## Guardar una copia cifrada de forma segura

1. En **Exportar datos de la bóveda**, selecciona **Copia cifrada**.
2. Guarda o anota la frase de contraseña de la copia en un lugar seguro (por ejemplo, junto a tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md)).
3. Marca **He guardado esta frase en un lugar seguro** y guarda el archivo `.bldbak` en tu unidad sin conexión o ubicación de respaldo.

Si alguna vez necesitas restaurar desde una copia cifrada, abre **Ajustes -> Importación / exportación de datos**, elige **Copia cifrada (`.bldbak`)** como origen de importación e ingresa la frase de contraseña que guardaste al crearla.

## Exportaciones en texto plano (JSON y CSV)

Los archivos JSON y CSV en texto plano contienen tus contraseñas legibles. Si exportas en texto plano:

- Nunca envíes el archivo por correo, chat o almacenamiento en la nube sin cifrar.
- Borra el archivo en texto plano de Descargas o Escritorio apenas termines de moverlo o imprimirlo.

## Límites en Espacios compartidos

En un **Espacio compartido**, los **Lectores** no pueden exportar una copia de la bóveda salvo que un administrador active **Permitir exportar a lectores** en los ajustes del Espacio.
