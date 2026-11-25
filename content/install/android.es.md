+++
title = "App de Android y autocompletado móvil"
description = "Instala Baluard en Android, conecta tu bóveda y configura el autocompletado del sistema, llaves de acceso y relleno por accesibilidad."
weight = 5
template = "page.html"

[extra]
+++

Baluard funciona de forma nativa en Android con cifrado local de la bóveda, desbloqueo biométrico, sincronización por git o carpeta, llaves de acceso y autocompletado en todo el sistema.

## Instalar en Android

Puedes instalar la app de Android desde cualquiera de estas tres fuentes:

- **Google Play:** Instala directamente desde la [ficha de Google Play](https://play.google.com/store/apps/details?id=app.baluard.mobile).
- **F-Droid:** Con F-Droid instalado en tu teléfono, abre `https://packages.baluard.app/fdroid/repo/` y toca **Add to F-Droid**, o agrega esa URL en **Ajustes -> Repositorios** dentro de F-Droid.
- **APK directo:** Descarga el APK firmado desde la [página de lanzamientos en GitHub](https://github.com/baluard-org/baluard/releases/latest).

## Conectar tu bóveda

Al abrir la app por primera vez, puedes crear una bóveda nueva o traer una existente a tu teléfono:

- **Proveedor git:** Inicia sesión en GitHub, GitLab o Codeberg para clonar el repositorio de tu bóveda y vincula el teléfono con tu contraseña maestra o tu frase de recuperación de 24 palabras.
- **Sincronización por carpeta o entre dispositivos:** Empareja con una carpeta sincronizada en tu dispositivo (consulta [Sincronización con una carpeta](@/sync/folder-sync.es.md)) o sincroniza directo con tu computadora por [Sincronización entre pares](@/sync/peer-to-peer-sync.es.md).
- **Desbloqueo biométrico:** Después de desbloquear con tu contraseña maestra, Baluard ofrece activar el desbloqueo rápido biométrico para que el autocompletado y los desbloqueos diarios usen tu huella o rostro sin recalcular la derivación completa de la contraseña cada vez.

## Configurar el autocompletado en Android

1. Abre Baluard en tu teléfono y ve a **Ajustes -> Autocompletado**.
2. Toca **Servicios de autocompletar** y elige **Baluard** en el selector del sistema Android.
3. En **Mostrar sugerencias de autocompletar**, elige **Integrado (aparece en el teclado)** o **Ventana emergente (sobre el campo)**.
4. Si usas **Chrome**, **Brave** o **Vivaldi** en Android, toca la opción de integración del navegador en **Ajustes -> Autocompletado** para que el navegador delegue el autocompletado a gestores externos como Baluard.

Cuando tu bóveda está bloqueada, el autocompletado muestra la opción para desbloquear Baluard. Al tocarla, verifica tu biometría y muestra los accesos coincidentes para esa app o sitio. Si el acceso tiene un código 2FA, Baluard copia el código al portapapeles automáticamente al rellenar.

### Llaves de acceso en Android

En **Ajustes -> Autocompletado**, toca **Claves de acceso (iniciar sesión con claves guardadas)** -> **Abrir** para elegir Baluard como proveedor de llaves de acceso en los ajustes de Android. Ten en cuenta que las bóvedas protegidas con llave de seguridad física no admiten autocompletado móvil.

### Sugerir credenciales web en apps y dominios equivalentes

- **Sugerir credenciales web en apps:** Cuando una app de Android coincide con un acceso web de tu bóveda, Baluard te pregunta si quieres **Confiar** en esa app una vez antes de rellenar credenciales web dentro de ella. Puedes gestionar las apps de confianza y bloqueadas en **Ajustes -> Autocompletado**.
- **Dominios equivalentes:** Agrega grupos de dominios separados por comas (por ejemplo, el portal de tu empresa y su sitio público) para que los accesos guardados en uno se autocompleten en los demás.

## Relleno por accesibilidad (acceso directo en ajustes rápidos)

Algunas apps y navegadores de Android ignoran el autocompletado estándar del sistema. Baluard incluye una alternativa opcional que solo actúa cuando tú la tocas:

1. En Baluard, ve a **Ajustes -> Autocompletado**, activa **Usar accesibilidad** y toca **Permitir** en el aviso.
2. Toca **Abrir ajustes de accesibilidad** y activa Baluard en el menú de Accesibilidad de Android.
3. Edita el panel de ajustes rápidos de Android y agrega el acceso directo de **Baluard**.

Cuando estés en una pantalla de inicio de sesión donde no aparezca el autocompletado normal, baja los ajustes rápidos y toca el acceso directo de Baluard. Baluard lee solo los campos de acceso de la pantalla actual, muestra un selector, rellena la entrada elegida y copia el código TOTP si existe. Nada de lo que ve en pantalla se guarda ni se envía a ningún lado.

## Ajustes de sincronización en Android

Abre **Ajustes -> Sincronización** para controlar cómo se sincroniza tu teléfono con tu repositorio remoto, carpeta o computadora emparejada:

- **Sincronizar al desbloquear la bóveda:** Descarga y sube cambios cada vez que desbloqueas la bóveda.
- **Sincronizar después de cada cambio:** Sincroniza automáticamente al crear, editar o eliminar una entrada.
- **Sincronizar al volver a primer plano:** Actualiza la bóveda cuando vuelves a abrir Baluard.
- **Sincronización en segundo plano:** Ejecuta sincronizaciones periódicas en segundo plano según el intervalo configurado en minutos. Consume más batería, así que la mayoría de personas no lo necesita.
- **Sincronizar solo por Wi-Fi (orientativo):** Evita sincronizaciones automáticas usando datos móviles.
- **Sincronización manual y diagnóstico:** Toca **Sincronizar ahora** para sincronizar al instante, o abre **Diagnóstico de bóveda** para ver la hora de última sincronización y su estado.

### Sincronización directa entre dispositivos

En **Ajustes -> Sincronización**, también puedes activar la **Sincronización directa entre dispositivos** para sincronizar directo con tus dispositivos vinculados sin usar una cuenta en la nube. Copia **Dirección de este dispositivo**, ingresa la **Dirección del dispositivo par** y toca **Sincronizar par**.

> [!WARNING]
> Usar solo sincronización entre dispositivos no deja respaldo fuera de tus equipos: si pierdes todos los dispositivos vinculados pierdes tu bóveda, salvo que también tengas respaldo por Git o carpeta.

## Espacios compartidos en Android

Los Espacios compartidos funcionan directo en Android para unirte a un Espacio, gestionar miembros y organizar carpetas compartidas desde tu teléfono:

- **Compartir (`Ajustes -> Compartir -> Gestionar personas`):** Consulta los miembros y sus roles (**Propietario**, **Administrador**, **Miembro**, **Lector**). Quienes administran pueden pegar respuestas de invitación o aprobar/rechazar **Solicitudes de ingreso** (con la verificación de secreto por canal externo), resolver **Solicitudes de acceso** (otorgando lectura o edición) y generar códigos de restablecimiento.
- **Carpetas compartidas (`Ajustes -> Carpetas compartidas -> Gestionar carpetas`):** Crea, renombra o elimina carpetas compartidas, y publica o limpia el catálogo de solicitudes para que los miembros vean los nombres al pedir acceso.
- **Política del Espacio (`Ajustes -> Espacio`):** Quienes administran pueden definir **Quién puede invitar miembros** (Administradores + propietario o Solo propietario), **Permitir exportar a lectores**, **Compartir con invitados** y el **Kit de recuperación** de 24 palabras.
- **Actividad (`Ajustes -> Actividad -> Ver actividad`):** Revisa avisos que requieren atención, actividad reciente compartida y actualizaciones rechazadas en el dispositivo.
