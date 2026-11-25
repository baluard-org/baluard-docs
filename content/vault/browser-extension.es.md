+++
title = "Extensión de navegador"
description = "Conecta Chrome o Firefox con tu app local de Baluard para autocompletar accesos, copiar códigos de verificación y usar llaves de acceso."
weight = 11
template = "page.html"

[extra]
+++

La extensión de navegador de Baluard conecta **Chrome** (y navegadores basados en Chromium) o **Firefox** con tu app de escritorio local de Baluard para rellenar inicios de sesión, copiar códigos de verificación e iniciar sesión con llaves de acceso sin copiar y pegar desde la app.

## Qué hace

- **Autocompletar accesos:** Muestra las entradas que coinciden con el sitio actual en la ventana emergente de la barra y mediante un botón opcional de Baluard dentro de los campos de acceso. Las entradas solo se rellenan cuando haces clic en ellas, nunca de forma automática al cargar la página.
- **Códigos de verificación (TOTP):** Copia códigos 2FA desde la ventana emergente, rellena un campo de código en la página o copia el código automáticamente justo después de rellenar un acceso.
- **Limpieza automática del portapapeles:** Las contraseñas, usuarios y códigos de verificación copiados desde la extensión se borran del portapapeles tras un tiempo configurable (1 minuto por defecto).
- **Llaves de acceso:** Responde opcionalmente a las solicitudes de inicio de sesión y registro con llaves de acceso guardadas en tu bóveda. Consulta [Llaves de acceso en tu navegador](@/vault/passkeys.es.md) para más detalles.
- **Espacios combinados:** Las entradas de tu bóveda personal y de cualquier Espacio desbloqueado aparecen juntas. Si un Espacio está bloqueado, puedes pedir su desbloqueo directamente desde la extensión.

## Cómo funciona

La extensión es un cliente puente ligero, no una bóveda independiente. No guarda **ni tu contraseña maestra ni las claves de la bóveda**.

- **Puente local:** Tu navegador se comunica con el daemon local de Baluard a través de un host de mensajería nativa (`baluard-nmh`) instalado junto con la app de escritorio.
- **Coincidencia estricta de origen:** La extensión compara el origen exacto de la página (esquema, dominio y puerto) con las URLs guardadas en tus entradas. Un acceso guardado para `https://example.com` no se rellenará en `http://example.com` ni en otro puerto.
- **Comprobación privada de pestañas:** Para mostrar cuántas entradas coinciden en el icono de la barra, la extensión consulta la URL de la pestaña activa contra el daemon local por IPC local. Nada sale de tu dispositivo.
- **Requiere la app de escritorio:** Como todo el descifrado ocurre en la app de escritorio, la extensión solo funciona mientras Baluard esté abierto y desbloqueado.

## Cómo configurarla

1. **Instala la app de escritorio de Baluard.** El instalador de escritorio (y el AppImage de Linux en el primer inicio) registra automáticamente el host de mensajería nativa para Chrome, navegadores Chromium y Firefox.
2. **Instala la extensión de navegador** en Chrome o Firefox desde [baluard.app](https://baluard.app).
3. **Inicia el emparejamiento en la app de escritorio:** Abre Baluard, desbloquea tu bóveda, ve a **Ajustes -> Conexión del navegador** y haz clic en **Agregar extensión de navegador**. La app mostrará un **Código de emparejamiento** de 8 caracteres.
4. **Conecta desde el navegador:** Haz clic en el icono de Baluard en la barra del navegador, pulsa **Tengo Baluard instalado**, escribe el código de emparejamiento de 8 caracteres y haz clic en **Conectar a Baluard**.
5. **Aprueba la solicitud:** Vuelve a la app de escritorio de Baluard y haz clic en **Aprobar**.

Puedes ver los navegadores conectados o desconectar cualquiera en cualquier momento haciendo clic en **Revocar** dentro de **Ajustes -> Conexión del navegador**.

## Cómo usarla

- **Rellenar desde la barra:** Haz clic en el icono de Baluard en la barra del navegador para ver los inicios de sesión que coinciden con el sitio actual. Haz clic en **Rellenar**, o usa los botones para copiar el usuario, la contraseña o el código de verificación.
- **Rellenar en la página:** Haz clic en el pequeño botón de Baluard dentro de un campo de usuario, contraseña o código de verificación y elige la entrada que quieras rellenar.
- **Ajustar la extensión:** Abre el icono de engranaje en la ventana de la extensión para configurar:
  - **Mostrar sugerencias en formularios:** Activa o desactiva el botón de Baluard en los campos del formulario.
  - **Copiar códigos de verificación al rellenar:** Copia automáticamente el código TOTP cuando rellenas un acceso.
  - **Limpiar el portapapeles después de:** Elige `10 segundos`, `30 segundos`, `1 minuto`, `2 minutos` o `Nunca`.
  - **Ofrecer llaves de acceso:** Activa o desactiva la intercepción de llaves de acceso en el navegador.
  - **Usar Baluard como gestor de contraseñas predeterminado:** Desactiva el aviso del navegador para guardar contraseñas y deja que solo Baluard lo gestione.

Si la ventana muestra **Bóveda bloqueada** o **Abre la app de Baluard**, abre y desbloquea la app de escritorio para seguir rellenando.
