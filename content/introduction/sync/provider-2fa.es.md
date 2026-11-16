+++
title = "Autenticación de dos factores (2FA) y tu proveedor de Git"
description = "Por qué la 2FA va en tu proveedor de Git (GitHub, GitLab o Codeberg) y no dentro de tu bóveda de Baluard."
weight = 7
template = "page.html"
aliases = ["es/introduction/provider-2fa"]

[extra]
+++

Si sincronizas tu bóveda de Baluard con uno de los proveedores compatibles —**GitHub**, **GitLab** o **Codeberg**—, activa la **autenticación de dos factores (2FA)** en esa cuenta.

En Baluard, la 2FA para tu copia de respaldo remota va en el **servicio de Git**, no dentro de la bóveda.

## Por qué la 2FA no está dentro de la bóveda

En los gestores de contraseñas tradicionales en la nube, un servidor de la empresa guarda tu bóveda y te pide un código de 6 dígitos antes de dejarte descargarla.

Baluard funciona distinto:

- No hay ningún servidor de Baluard. Tu bóveda vive como archivos cifrados en tus propios dispositivos.
- Abrir la bóveda ya requiere dos cosas: **tu contraseña maestra** (algo que sabes) y **tu dispositivo autorizado** —o tu [frase de recuperación de 24 palabras](@/introduction/vault/recovery-phrase.es.md) en caso de emergencia— (algo que tienes).
- Poner un código 2FA de 6 dígitos dentro de una bóveda local no añadiría seguridad real. Quien ya tenga tanto tu dispositivo como tu contraseña maestra puede descifrar todo lo que hay en ese dispositivo de todas formas.

Como no existe un servidor de Baluard, no hay un inicio de sesión remoto que proteger con un código dentro de la aplicación.

## Por qué tu proveedor de Git sí necesita 2FA

Cuando activas la sincronización, tu proveedor de Git guarda una copia del repositorio cifrado de tu bóveda. Aunque el proveedor no puede leer tus contraseñas (todo se cifra antes de salir de tu dispositivo), proteger tu cuenta de Git con 2FA sigue siendo fundamental:

- **Evitar que borren tu respaldo:** Alguien que entre en tu cuenta de GitHub, GitLab o Codeberg podría eliminar el repositorio de tu bóveda y borrar tu copia remota.
- **Impedir ataques sin conexión:** Un atacante con acceso a tu cuenta de Git podría descargar tus archivos cifrados e intentar adivinar tu contraseña maestra por fuerza bruta.
- **Mantener el control de tu cuenta:** Sin 2FA, una contraseña filtrada o reutilizada en tu proveedor de Git basta para que otra persona tome el control del servicio donde guardas tus copias.

## Cómo activarla

1. Inicia sesión en el proveedor de Git que hayas elegido (**GitHub**, **GitLab** o **Codeberg**).
2. Ve a la configuración de **Seguridad** de tu cuenta y activa la **autenticación de dos factores (2FA)**.
3. Usa una **aplicación de autenticación** (o una **llave de seguridad física** / passkey) en lugar de SMS siempre que sea posible.
4. Guarda los **códigos de recuperación** de tu proveedor de Git en un lugar seguro fuera de internet —igual que tu [frase de recuperación de 24 palabras](@/introduction/vault/recovery-phrase.es.md)— para no perder el acceso a tu respaldo si pierdes el teléfono.

Para comparar los proveedores compatibles en detalle, consulta [Elegir un proveedor de Git](@/introduction/sync/git-providers.es.md).
