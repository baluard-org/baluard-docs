+++
title = "El agente SSH"
description = "Deja que la terminal y git firmen con las claves SSH de tu bóveda en Linux, macOS y Windows."
weight = 4
template = "page.html"

[extra]
+++

Tu bóveda puede guardar pares de claves SSH, pero una clave guardada por sí sola no firma nada. Baluard incluye un agente SSH que habla el protocolo estándar de agente desde el daemon: las herramientas de terminal y git pueden pedir firmas con las claves de tu bóveda mientras la parte privada nunca sale de ella. Esta página cubre cómo activarlo y apuntar tu sistema hacia él.

## Actívalo

Dos interruptores controlan el agente, y ambos empiezan apagados:

- **Ajustes, "Agente SSH":** el interruptor principal para este dispositivo. Es local al dispositivo a propósito: activarlo aquí no lo activa en tus otras máquinas.
- **"Compartir por el agente SSH" en cada entrada de clave SSH:** solo las claves marcadas se comparten. Esta marca vive en la propia entrada y se sincroniza con tu bóveda.

Un tercer interruptor, "Aprobar firmas automáticamente", se salta el aviso de aprobación. Empieza apagado: con él apagado, cada petición de firma aparece en la app de escritorio y nombra la entrada que quiere firmar. Desde ahí apruebas o rechazas, y una petición rechazada o expirada falla en el lado que pidió la firma.

## Apunta tus herramientas al agente

El agente responde en un socket llamado `baluard-agent.sock` junto al propio socket de Baluard. Las herramientas que leen `SSH_AUTH_SOCK`, git incluido, firman a través de Baluard cuando la variable apunta ahí.

En Linux:

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/baluard/baluard-agent.sock"
```

En macOS:

```bash
export SSH_AUTH_SOCK="$HOME/Library/Application Support/baluard/baluard-agent.sock"
```

Pon la línea que corresponda en el archivo de inicio de tu shell (`~/.bashrc`, `~/.zshrc`) para que cada terminal nueva la tome.

¿Prefieres mantener el agente del sistema para todo menos un host? Añade una línea `IdentityAgent` en `~/.ssh/config`:

```
Host github.com
    IdentityAgent /run/user/1000/baluard/baluard-agent.sock
    IdentitiesOnly yes
```

Cambia `1000` por tu id de usuario (míralo con `id -u`). En macOS la ruta es la del export de arriba, entre comillas por los espacios: `IdentityAgent "~/Library/Application Support/baluard/baluard-agent.sock"`. Las dos configuraciones conviven: el agente del sistema sigue sirviendo sus claves, y la estrofa `Host` enruta las claves de Baluard solo para ese host.

## Windows

En Windows no hay que apuntar nada: Baluard sirve el mismo conducto con nombre que miran los clientes OpenSSH de Windows (`\\.\pipe\openssh-ssh-agent`), así que `ssh`, `ssh-add` y git firman a través de Baluard en cuanto activas el interruptor. El conducto existe mientras el daemon corre; no deja nada al salir.

Solo un programa puede tener el conducto a la vez. Windows trae su propio servicio de agente OpenSSH y viene desactivado, así que la mayoría de máquinas no necesitan nada. Si la lista de claves de Baluard está vacía y el servicio está corriendo, pon su tipo de inicio en Deshabilitado: abre Servicios, elige Agente de autenticación OpenSSH, marca Deshabilitado y reinicia la app de Baluard.

Git para Windows trae su propio ssh que ignora el conducto. Apunta git al cliente OpenSSH de Microsoft una vez y la firma por agente funciona en todas partes:

```bash
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

No hay opción `IdentityAgent` por clave en Windows: las claves de Baluard y las de cualquier otro agente en marcha comparten el único conducto, y el agente que lo posee sirve todas.

## Comprueba que funciona

```bash
ssh-add -l
```

Con el interruptor principal activo y al menos una clave marcada, esto muestra las huellas de tus claves de la bóveda. Una lista vacía o un error suele significar que la bóveda está bloqueada o que falta algún interruptor. Después prueba con tu proveedor:

```bash
ssh -T git@github.com
```

## Límites que conviene conocer

- La bóveda debe estar desbloqueada. Una bóveda bloqueada se niega a listar claves o firmar.
- Las claves con material privado cifrado se rechazan sin excepción: el agente nunca pide una frase de contraseña.
- Los avisos de aprobación son locales al dispositivo: una petición se aprueba en la máquina que firma.
