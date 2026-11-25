+++
title = "Desbloqueo rápido y protección por hardware"
description = "Desbloquea más rápido con biometría o un PIN de 6 dígitos, o vincula tu bóveda al chip de seguridad del dispositivo o a una llave física."
weight = 12
template = "page.html"

[extra]
+++

Por defecto, Baluard protege tu bóveda solo con tu contraseña maestra. Puedes acelerar el desbloqueo diario con **Desbloqueo rápido** o un **PIN**, o impedir ataques sin conexión ante el robo del disco vinculando tu bóveda al **chip de seguridad del dispositivo** o a una **llave de seguridad física**.

## Desbloqueo rápido (biometría y llavero del sistema)

El **Desbloqueo rápido** guarda el secreto de desbloqueo en el llavero de tu sistema operativo, protegido por biometría o el desbloqueo del equipo.

- **Cómo activarlo:** Abre **Ajustes -> General y seguridad** y activa **Desbloqueo rápido**.
- **Nota en Linux:** El desbloqueo rápido necesita un servicio de llavero del sistema (Secret Service, como GNOME Keyring o KWallet). Si falta, Baluard muestra el comando para instalarlo.
- **Aviso en equipos compartidos:** Cualquier persona con su biometría registrada en el equipo, o que pueda desbloquear tu sesión del sistema, podrá abrir la bóveda mientras el desbloqueo rápido esté activo.

## Desbloquear con PIN

Puedes configurar un **PIN de 6 dígitos** en **Ajustes -> General y seguridad** -> **Desbloquear con PIN** para no escribir tu contraseña maestra completa en cada desbloqueo.

Un PIN es menos seguro que tu contraseña maestra y protege solo este dispositivo local. Seguirás necesitando tu contraseña maestra tras un reinicio completo o si desactivas el PIN.

## Proteger con el chip de seguridad de este dispositivo

Si tu equipo tiene un chip de seguridad por hardware (como Apple Secure Enclave o un TPM), puedes vincularle tu bóveda en **Ajustes -> General y seguridad** -> **Proteger con el chip de seguridad de este dispositivo**.

- **Qué evita:** Un disco o respaldo robado por sí solo no puede abrir tu bóveda, ni siquiera si alguien conoce tu contraseña maestra.
- **Confirmar en cada desbloqueo:** Activa **Confirmar en cada desbloqueo** si además quieres que el chip pida tu huella o rostro cada vez que se abra la bóveda, impidiendo que alguien que sepa tu contraseña la abra en tu equipo.
- **Recuperación:** Si el chip de seguridad falla o se reinicia la biometría, usa tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md) para volver a conectar el dispositivo.

## Proteger con tu llave de seguridad

Puedes proteger una bóveda con una llave de seguridad física FIDO2 (como una YubiKey) en **Ajustes -> General y seguridad** -> **Proteger con tu llave de seguridad**.

- **Cómo funciona:** Baluard te pide tocar la llave cuando parpadea al activar la protección y al desbloquear. Abrir la bóveda exige tanto tu contraseña maestra como la llave física, por lo que un disco o respaldo robado no puede descifrarse sin conexión.
- **Recuperación:** Si pierdes la llave de seguridad, usa tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md) para recuperar el acceso.
- **Límite en móvil:** Las bóvedas protegidas por una llave de seguridad física no admiten autocompletado móvil en Android.

## Confirmación por entrada con contraseña maestra

Para entradas especialmente sensibles (como accesos bancarios o códigos de recuperación), puedes activar la confirmación de contraseña maestra al editar la entrada. Baluard te pedirá confirmar tu contraseña maestra antes de mostrar o copiar esos campos, incluso con la bóveda desbloqueada.
