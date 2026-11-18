+++
title = "Adjuntos"
description = "Cómo se guardan los archivos adjuntos, el límite de 2 MB por archivo y cómo funciona liberar espacio."
weight = 5
template = "page.html"
aliases = ["es/introduction/attachments", "es/introduction/vault/attachments"]

[extra]
+++

Las entradas pueden llevar archivos: un PDF con tu hoja de recuperación, un documento escaneado, una foto de un número de serie. El archivo se cifra en tu dispositivo antes de guardarse, con la misma clave que protege la entrada a la que pertenece.

## El límite de tamaño

Un archivo puede pesar como máximo 2 MB, y la app acepta archivos de hasta 1,9 MB. La razón son los espacios de almacenamiento: cada archivo se guarda en un espacio con relleno para que su longitud real quede oculta, y 2 MB es el espacio más grande. Un archivo de pocos kilobytes usa un espacio pequeño; todo lo que supere los 250 KB usa el espacio más grande. El límite es estricto y no hay ningún ajuste para subirlo.

Si necesitas algo más grande, guarda el archivo fuera de Baluard y deja una nota que indique dónde vive. Un gestor de contraseñas no es el lugar adecuado para documentos grandes: cada dispositivo que desbloquea la bóveda debe poder descargar y descifrar lo que esta contiene.

## Dónde viven los archivos

Los adjuntos no van dentro del historial de la bóveda. Viajan por un canal lateral cifrado junto a ella. Así el historial principal se mantiene ligero: clonar la bóveda en un dispositivo nuevo es rápido, y los archivos se descargan cuando los pides al abrir una entrada que tiene uno.

Cada archivo guardado queda anclado a sus bytes cifrados por una huella, así un dispositivo siempre puede saber si la copia que recibió está intacta. Si un archivo falta en un dispositivo porque aún no sincronizó, abrir la entrada lo trae del canal lateral en lugar de fallar.

## Borrar un archivo no es lo mismo que recuperar el espacio

Esta es la única idea que vale la pena detenerse a pensar, porque aquí los hábitos de git difieren de los de un gestor de archivos.

Baluard lleva un cuaderno git de cada cambio (la [guía de sincronización](/es/introduction/syncing-your-vault/) lo cubre). El cuaderno es lo que hace posible la recuperación: si borras una entrada por accidente, todavía existe un estado anterior. La misma protección aplica a los adjuntos. Si quitas un archivo de una entrada, la copia cifrada sigue en el almacenamiento compartido, porque estados anteriores de la bóveda pueden seguir referenciándola.

Es deliberado. El costo es que los archivos borrados siguen ocupando espacio hasta que ordenes.

## Liberar espacio

Ajustes, luego Sincronización, luego Almacenamiento de adjuntos, luego **Liberar espacio** (escritorio y móvil). Un toque; Baluard hace el resto:

1. Mira cada entrada que tienes, incluida la papelera, y reúne las huellas de los archivos que todavía están referenciados.
2. Cada archivo del canal lateral cuya huella aparece en esa lista se conserva. Todo lo demás se elimina del almacenamiento compartido por completo, en un solo paso, y la eliminación queda firmada por este dispositivo.
3. Recibes un resumen breve: cuántos archivos se recuperaron, cuánto espacio se liberó y cuántos se conservaron.

Dos reglas te protegen durante esto. La compactación solo elimina archivos que ninguna entrada referencia, así que un adjunto vivo jamás se toca. Y se niega a ejecutarse hasta que cada entrada en este dispositivo sea legible y cada archivo referenciado haya terminado de sincronizar, así nunca decide con información incompleta.

## Cuando otro dispositivo ordena

El almacenamiento es compartido, así que una limpieza en tu teléfono también importa en tu laptop. Cuando un dispositivo libera espacio, todos los demás muestran un aviso que dice quién ordenó (un dispositivo verificado, no solo un nombre), cuántos archivos se quitaron y cuánto espacio se liberó.

En escritorio, el aviso es un banner de pantalla completa. Puedes seguir leyendo y autocompletando mientras está visible, pero guardar cambios se pausa hasta que pulsas **Obtener actualizaciones**. Tus cambios sin enviar quedan en cola y salen en cuanto llegan las actualizaciones; nada se descarta. La app entonces elimina las copias locales obsoletas de los archivos ordenados, y el banner desaparece.

En móvil, el mismo aviso es un diálogo de pantalla completa con las mismas reglas.

¿Por qué pausar? Porque ordenar reescribe el almacenamiento compartido. Si un dispositivo siguiera trabajando con una vista desactualizada y enviara datos nuevos, la limpieza podría deshacerse en silencio y el espacio nunca se recuperaría de verdad. La pausa es lo que hace que la limpieza permanezca para todos.

## Qué puede ver tu proveedor

La misma regla del resto de la bóveda aplica: solo texto cifrado sale de tu dispositivo. El proveedor ve que existen adjuntos y ve grupos de tamaño gruesos (unos pocos kilobytes, hasta 250 KB, o el espacio de 2 MB), porque los espacios de almacenamiento llevan relleno. Los contenidos, los nombres y a qué entrada pertenece cada archivo siguen siendo invisibles sin tu contraseña maestra y tus claves de dispositivo.
