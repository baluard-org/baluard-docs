+++
title = "Contacto de confianza"
description = "Entrega a alguien de confianza un kit de recuperación de solo lectura que solo se abre si dejas de abrir tu bóveda."
weight = 9
template = "page.html"

[extra]
+++

Baluard no tiene servidor central ni un equipo de soporte que pueda entregar tus datos. **Contacto de confianza** es la forma de prepararte con anticipación: eliges a una persona de confianza y le entregas un kit de recuperación que le permite abrir una copia de solo lectura de tu bóveda si dejas de desbloquearla.

Contacto de confianza está disponible en la **app de escritorio** y en la **CLI**. La configuración y apertura desde móvil aún no están disponibles.

## Cómo funciona

1. **Creas un kit.** En **Ajustes -> Contacto de confianza**, eliges un tiempo de espera (de 14 a 365 días), escribes una nota personal opcional y generas una frase de cuatro palabras. Baluard genera un archivo `.bldlegacy` llamado **la carta del kit**.
2. **Entregas las partes por separado.** Le das a tu contacto el archivo de la carta del kit y compartes la frase por otro medio. Hasta que pase el tiempo de espera, no podrá abrir nada.
3. **El uso normal reinicia el reloj.** Cada vez que cualquiera de tus dispositivos registrados desbloquea tu bóveda, registra una señal de actividad de forma silenciosa. No hay avisos ni pasos extra.
4. **Tras suficientes días sin actividad, el kit puede abrirse.** Si ninguno de tus dispositivos desbloqueó la bóveda durante los días que elegiste, tu contacto puede abrir el archivo `.bldlegacy` en la app de escritorio de Baluard con la frase.
5. **El acceso es estrictamente de solo lectura.** Baluard descarga una copia privada de tu bóveda, verifica que el kit no haya sido alterado y la abre en solo lectura. Tu contacto puede ver y copiar entradas, pero no puede editar, borrar ni subir cambios. Antes de que termine el tiempo de espera, la apertura se rechaza y muestra cuántos días faltan.

### Qué puedes hacer mientras el kit está activo

- **Ver el kit otra vez:** vuelve a exportar exactamente el mismo archivo `.bldlegacy` si tu contacto lo perdió. La frase no se guarda en ningún sitio; si se perdió la frase, reemplaza el kit y elige una nueva.
- **Desactivar:** desactiva el kit sin rotar las claves de tu bóveda. Puedes volver a configurarlo más tarde.
- **Rechazar solicitud:** cuando el tiempo de espera ya venció, aparece un aviso en **Ajustes -> Contacto de confianza**. Rechazar cierra el kit de forma permanente y rota las claves de tu bóveda para que cualquier copia del kit antiguo quede inservible.
- **Reemplazar:** retira el kit anterior, rota las claves de tu bóveda y crea un kit nuevo.

## Cómo configurarlo

### Requisitos previos

- Tu bóveda debe estar conectada a un proveedor git (**GitHub**, **GitLab** o **Codeberg**).
- Tu cuenta de sincronización conectada debe tener **permisos de administración del repositorio** para que Baluard pueda registrar una clave de solo lectura para tu contacto. Si tu token no tiene permisos suficientes, vuelve a conectar tu cuenta de sincronización primero.

### En la app de escritorio

1. Desbloquea tu bóveda y abre **Ajustes -> Contacto de confianza**.
2. Elige cuántos días sin abrir tu bóveda deben pasar antes de que se abra el kit (**14**, **30**, **90** o **365 días**).
3. En **¿Para quién es el kit?**, escribe el nombre de tu contacto (se guarda solo en tus propios ajustes).
4. Opcionalmente escribe **Una nota para esa persona**. Esta nota aparece en texto plano al inicio de la carta del kit para que tu contacto sepa para qué sirve el archivo.
5. Haz clic en **Crear frase** para generar una frase de cuatro palabras, guárdala en un lugar seguro y marca **Guardé la frase en un lugar seguro**.
6. Haz clic en **Crear el kit**.
7. Haz clic en **Descargar** para guardar el archivo `.bldlegacy` (o en **Copiar texto**).
8. Envía el archivo a tu contacto y comparte la frase por un medio **distinto**.

### Desde la línea de comandos

También puedes gestionar Contacto de confianza desde la CLI con la bóveda desbloqueada:

```bash
baluard legacy arm --days 30 --contact "Ana" --letter "Para emergencias"
baluard legacy status
baluard legacy resend
baluard legacy disarm
baluard legacy deny
baluard legacy replace --days 30 --contact "Ana"
```

## Cómo abre la bóveda tu contacto

Tu contacto **no** necesita una cuenta de Baluard, ni una cuenta en un proveedor git, ni conocimientos técnicos. Solo necesita:

- Un ordenador con la **app de escritorio de Baluard** instalada.
- El archivo `.bldlegacy` (**la carta del kit**).
- La **frase del kit**.

Para abrir la bóveda:

1. Abre Baluard y haz clic en **Abrir con una carta del kit** en la pantalla de bloqueo.
2. Haz clic en **Elegir la carta del kit** y selecciona el archivo `.bldlegacy`.
3. Lee la nota personal (si incluiste una), escribe la **Frase del kit** y haz clic en **Abrir la bóveda**.
4. Baluard descarga y verifica la copia de la bóveda y la abre en solo lectura.

## Recomendaciones y límites reales

- **Separa siempre el archivo y la frase.** Cualquiera que tenga tanto el archivo `.bldlegacy` como la frase puede abrir la bóveda una vez pasado el tiempo de espera. Envía el archivo por un canal (por ejemplo, correo o unidad compartida) y la frase por otro (en persona, en papel o por otra app de mensajería).
- **Entiende qué protege el tiempo de espera.** El tiempo de espera lo aplica la app de Baluard para evitar aperturas accidentales o prematuras, no la criptografía; alguien con software modificado podría saltarse el reloj si ya tiene tanto el archivo como la frase. Lo que *sí* es criptográfico: un kit no entregado, rechazado o reemplazado no abre nada.
- **Elige al menos 14 días (30 o 90 es más seguro).** Un margen amplio evita que unas vacaciones, un teléfono averiado o una semana sin conexión vuelvan el kit utilizable antes de tiempo.
- **Conserva también una copia de seguridad cifrada sin conexión.** Contacto de confianza depende de que tu repositorio git siga accesible. Si renombras el repositorio, cambias de proveedor o se cierra tu cuenta, el kit deja de funcionar. Crea un kit nuevo si mueves tu repositorio.
- **No uses Contacto de confianza para recuperar tu propio acceso.** Contacto de confianza es para otra persona. Para recuperar tu propia bóveda si olvidaste la contraseña maestra o perdiste tus dispositivos, usa tu [frase de recuperación de 24 palabras](@/vault/recovery-phrase.es.md).
