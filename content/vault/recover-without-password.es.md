+++
title = "Recuperar una bóveda sin tu contraseña"
description = "¿Sin acceso? Tu frase de recuperación de 24 palabras vuelve a abrir la bóveda en un dispositivo nuevo y te deja elegir una nueva contraseña maestra."
weight = 7
template = "page.html"

[extra]
+++

¿Olvidaste tu contraseña maestra? Tu frase de recuperación de 24 palabras vuelve a abrir la bóveda, sin necesidad de la contraseña antigua. La recuperación ocurre por completo en tu dispositivo: sin cuentas, sin tickets de soporte, sin que nadie de Baluard intervenga. Eliges una nueva contraseña maestra durante el proceso y sigues usando la bóveda como siempre.

## Necesitas tres cosas

1. **Tu frase de 24 palabras.** Las palabras que anotaste cuando creaste la bóveda (o las actuales, si rotaste la frase después). Una frase protege cada bóveda, tanto personales como espacios compartidos.
2. **La carpeta de la bóveda en este dispositivo.** La recuperación abre la carpeta que está en disco. Clona la bóveda desde tu proveedor git o cópiala desde una copia de seguridad para que la carpeta exista aquí.
3. **Un inicio limpio para esta bóveda.** La recuperación funciona en un dispositivo que aún no haya configurado esta bóveda. Una carpeta que ya guarda la clave de dispositivo de esta bóveda rechaza la recuperación: clónala de nuevo en su lugar.

## En la app de escritorio

1. En la pantalla de desbloqueo, elige **¿Olvidaste tu contraseña maestra?** — la pantalla de bienvenida tiene la misma entrada bajo **Recuperar una bóveda con tu frase**.
2. Elige tu bóveda de la lista. Si la lista está vacía, añade primero la carpeta de la bóveda; la pantalla ofrece el selector de carpetas.
3. Escribe las 24 palabras.
4. Elige una nueva contraseña maestra y ponle nombre al dispositivo.
5. Desbloquea con la nueva contraseña. Eso es todo.

## En la app móvil

Desde la pantalla de bienvenida, toca **Recuperar con un kit de recuperación**, elige la carpeta de la bóveda, escribe tus 24 palabras y define la nueva contraseña.

## Desde la línea de comandos

Registra el clon recién hecho y recupéralo por su slug:

```bash
baluard vaults add /ruta/al/clon-de-la-boveda
baluard vaults recover-kit <slug>
```

El comando pide la frase de recuperación, la nueva contraseña maestra y un nombre de dispositivo. Al terminar imprime:

```
Device recovered (<device-id>).
Unlock with your master password, then pull to catch up.
```

## Qué hace la recuperación

- El dispositivo recuperado se une a la bóveda con la nueva contraseña. En una bóveda personal vuelves a ser el propietario. En un espacio compartido vuelves como administrador junto a los demás administradores activos, y como propietario si eras el único.
- Los dispositivos ya registrados siguen funcionando y se desbloquean con la contraseña con la que fueron configurados. Si crees que alguien aprendió tu contraseña antigua, elimina esos dispositivos de la lista de dispositivos en la app.
- La frase sigue siendo válida después de la recuperación, así que conserva la copia en papel. Si rotas la frase más adelante, las palabras nuevas reemplazan a las antiguas.

## Cuándo la recuperación se niega

- Una frase incorrecta no cambia nada: la bóveda queda exactamente como estaba hasta que las palabras sean correctas.
- Una carpeta ya configurada en este dispositivo rechaza la recuperación. Clona la bóveda de nuevo y recupera ese clon.
- Las bóvedas personales muy antiguas, creadas antes de que las bóvedas llevaran un directorio de miembros, aún no tienen ruta de recuperación; la recuperación se niega en ellas.
- Si además perdiste la frase, la bóveda queda bloqueada para siempre. No hay puerta trasera. Consulta [Tu frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md) para guardarla de forma que esto nunca ocurra.
