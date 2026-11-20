+++
title = "Claves de acceso en tu navegador"
description = "Inicia sesión en sitios con las claves de acceso guardadas en tu bóveda, a través de la extensión de navegador."
weight = 8
template = "page.html"

aliases = ["es/introduction/vault/passkeys"]

[extra]
+++

Una clave de acceso (passkey) es una credencial de inicio de sesión que vive en tus dispositivos en lugar de una contraseña. Baluard guarda claves de acceso dentro de tus entradas de inicio de sesión, cifradas y sincronizadas como todo lo demás en tu bóveda. La extensión de navegador te permite usarlas en sitios web: cuando un sitio pide una clave de acceso, Baluard responde con una de tu bóveda.

Las claves de acceso son opcionales. Baluard funciona bien sin ellas, y los sitios que siguen usando contraseñas siguen funcionando como siempre.

## Actívalas

1. [Instala la extensión de navegador](https://baluard.app) y emparéjala con la app de escritorio. Las claves de acceso necesitan la app: la firma ocurre allí, y el navegador nunca ve la clave privada.
2. Abre la ventana emergente de la extensión y ve a los ajustes.
3. Activa **Ofrecer claves de acceso**.

Mientras la opción está activa, el ícono de la barra de herramientas muestra una marca PK en los sitios donde Baluard puede responder solicitudes de claves de acceso.

La opción viene desactivada porque la extensión responde solicitudes de claves de acceso en todos los sitios que visitas mientras está activa. El interruptor es global, no por sitio: actívala solo si usas claves de acceso con Baluard.

Si la página de ajustes dice "Este navegador no puede ofrecer claves de acceso", a tu navegador le falta la API que Baluard necesita. Actualiza el navegador, o administra tus claves de acceso desde la vista de entrada en la app de escritorio.

## Cómo se siente un inicio de sesión

Cuando un sitio pide una clave de acceso, se abre una pequeña ventana de Baluard:

- **Iniciar sesión:** si tu bóveda tiene una clave de acceso para el sitio, Baluard pregunta cuál usar e inicia sesión.
- **Guardar una nueva:** si registras una clave de acceso nueva, Baluard ofrece guardarla en una entrada existente o en una nueva.
- **Ya guardada:** si el sitio ya tiene una clave de acceso en tu bóveda, Baluard te lo dice y ofrece usarla en su lugar.
- **Nada guardado:** si no tienes una clave de acceso para el sitio, Baluard te lo dice, y los métodos de inicio de sesión habituales del sitio siguen disponibles.

Si tu bóveda está bloqueada, Baluard te pide desbloquear la app primero y reintentar. En muchos sitios la clave de acceso también aparece como sugerencia en el campo de usuario, así que puedes elegirla sin salir del formulario.

Cuando Baluard no puede responder una solicitud, se aparta y el flujo de claves de acceso de tu propio navegador toma el control. Un sitio que exige una llave de seguridad física sigue funcionando.

## Límites que conviene conocer

- Las claves de acceso funcionan en el navegador donde corre la extensión, emparejada con la app de escritorio. No hay flujo de teléfono-como-llave: Baluard no retransmite inicios de sesión entre tu teléfono y tu computadora.
- Las claves de acceso importadas desde Bitwarden llegan como entradas de solo lectura. La exportación de Bitwarden no lleva claves privadas, así que esas claves no pueden firmar; regístralas de nuevo en cada sitio.
- La firma ocurre en la app de Baluard. Si la bóveda está bloqueada, los inicios de sesión con clave de acceso esperan un desbloqueo. Si la app no está abierta, Baluard se aparta y el flujo de claves de acceso de tu navegador responde en su lugar.
