+++
title = "Conecta la CLI a una bóveda existente"
description = "Primera vez con la CLI de Baluard: arranca el daemon, conecta un proveedor git, clona tu bóveda, inscribe la máquina y deja listo el agente SSH."
weight = 9
template = "page.html"
aliases = ["es/introduction/connect-existing-vault"]

[extra]
+++

Esta página recorre la primera vez con la CLI de `baluard` en una máquina nueva contra una bóveda que ya vive en un proveedor git. Necesitas tres cosas antes de empezar: la CLI instalada, tu contraseña maestra y la frase de recuperación de 24 palabras de la bóveda. La frase es necesaria porque una máquina nueva todavía no tiene clave en la bóveda, y la contraseña maestra sola no puede agregar una. Es el segundo factor para la recuperación ante desastres.

## Arranca el daemon

La CLI habla con un daemon en esta máquina. El daemon sirve las sesiones de bóveda y el endpoint del agente SSH. Arráncalo una vez:

```bash
baluard ssh serve
```

En Linux esto lanza el daemon como servicio de usuario de systemd para la sesión. En macOS y Windows arranca un proceso desligado que escribe su log en el directorio de estado de baluard. Para hacerlo permanente, instala el servicio:

```bash
baluard ssh install
```

`baluard ssh install` escribe y activa una unidad de usuario de systemd. Arranca el daemon ahora y en cada inicio. Para revertirlo, corre `baluard ssh uninstall`. Puedes revisar el estado cuando quieras:

```bash
baluard ssh status
```

## Conecta tu proveedor git

La CLI lee la cuenta del proveedor desde una conexión única. La conexión usa tu navegador:

```bash
baluard provider connect github
```

Escribe el código corto que aparece en pantalla en github.com/login/device. Confirma con `baluard provider status github`. GitLab y Codeberg funcionan igual.

## Clona tu bóveda

Lista las bóvedas que tu cuenta puede ver, y clona la que quieras:

```bash
baluard provider vault-repos github
baluard sync clone github owner/baluard-vault
```

Cambia `owner/baluard-vault` por el nombre del repositorio de la lista. Un repositorio de bóveda lleva una marca dentro, así que `vault-repos` lista solo bóvedas reales de Baluard, no todos los repositorios de la cuenta.

El clon aterriza en `~/.local/share/baluard/vaults/` con un nombre local, el slug. El slug es el nombre que usas en los flags `--vault` en esta máquina. Puede diferir del nombre del repositorio.

## Inscribe esta máquina

Un clon fresco no tiene clave para esta máquina, así que todavía no puede desbloquear. Inscríbela con la frase de recuperación:

```bash
baluard devices enroll-with-phrase --vault baluard-vault
```

Escribe las 24 palabras cuando las pida, confirma, y escribe la contraseña maestra. La inscripción escribe una nueva clave de dispositivo y la sella con tu contraseña maestra. La bóveda en tus otros dispositivos no se toca, y nada reemplaza sus claves.

## Desbloquea y sincroniza

Desbloquea con tu contraseña maestra, y manda la inscripción al proveedor para que tus otros dispositivos vean esta máquina:

```bash
baluard unlock --vault baluard-vault
baluard sync push --vault baluard-vault
```

Sigue usando la misma forma de comando después de un desbloqueo: si desbloqueaste con `--vault`, pasa el mismo flag a los comandos que siguen, o desbloquea una vez sin el flag para trabajar contra la bóveda activa.

## Revisa la bóveda

```bash
baluard list --vault baluard-vault
baluard sync status --vault baluard-vault
```

`list` muestra tus entradas. `sync status` compara este clon con el proveedor y reporta cambios pendientes. Después de un desbloqueo, los mismos comandos suelen funcionar sin el flag también: la CLI guarda la sesión para comandos simples cuando el keyring del sistema está disponible. Pasar el flag siempre funciona.

## Deja listo el agente SSH

El daemon sirve las claves SSH de tu bóveda en un endpoint de agente. Las claves se comparten solo cuando tres cosas se cumplen: la bóveda está desbloqueada, el interruptor del agente SSH está activo en esta máquina, y la entrada de la clave tiene la marca "Compartir por el agente SSH". Las marcas se ponen en la app de escritorio, o las claves nuevas las aceptan desde la CLI con `--serve-via-agent`. Las marcas cambiadas en otro dispositivo llegan aquí con `baluard sync pull`.

Activa el interruptor para esta máquina (pide la contraseña maestra otra vez):

```bash
baluard agents policy --enable
```

`baluard agents policy` solo imprime el estado actual. Por defecto cada firma pide aprobación en la app de escritorio; agrega `--auto-approve` si quieres que git firme sin preguntar.

Muestra el endpoint en esta máquina:

```bash
baluard ssh status
```

Apunta OpenSSH para una sola shell (Linux):

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/baluard/baluard-agent.sock"
```

O déjalo fijo para un host en `~/.ssh/config` (ruta de Linux):

```
Host github.com
    IdentityAgent /run/user/1000/baluard/baluard-agent.sock
    IdentitiesOnly yes
```

Cambia `1000` por tu id de usuario (`id -u`). En macOS, corre `baluard ssh status` y copia las líneas que imprime: la ruta es `~/Library/Application Support/baluard/baluard-agent.sock` y lleva comillas. Luego revisa que el agente liste tus claves:

```bash
ssh-add -l
```

Una lista vacía con la bóveda desbloqueada significa que el interruptor está apagado o falta marcar claves. `Could not open a connection` significa que el daemon está caído o la ruta del socket está mal: corre `baluard ssh status` y copia las líneas que imprime. La página del [agente SSH](@/introduction/sync/ssh-agent.es.md) cubre los casos de falla en detalle.

## Mantén el daemon corriendo

`baluard ssh serve` arranca el daemon para esta sesión. Tras un reinicio el daemon está caído hasta que algo lo arranque. Corre `baluard ssh install` una vez para arrancarlo en cada inicio, o arráncalo a mano con `baluard ssh serve` cuando lo necesites.
