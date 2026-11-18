+++
title = "El aviso de Gatekeeper en macOS"
description = "Por qué macOS dice que no puede verificar Baluard, y cómo abrirlo de todos modos."
weight = 3
aliases = ["es/introduction/macos-gatekeeper", "es/introduction/install/macos-gatekeeper"]
template = "page.html"

[extra]
+++

## Lo que ves

La primera vez que abres Baluard en macOS, Gatekeeper lo detiene. El texto exacto varía según la versión de macOS, pero el mensaje es uno de estos:

> "Baluard" no se puede abrir porque procede de un desarrollador no identificado.

> "Baluard" no se puede abrir porque Apple no puede verificarlo buscando software malicioso.

macOS también puede decir que la aplicación "está dañada y no se puede abrir". Todos significan lo mismo, explicado abajo.

## Por qué ocurre

La compilación de Baluard para macOS lleva una firma ad-hoc y no está notarizada. Notarizar significa que Apple examinó una copia de la aplicación buscando malware conocido y la aprobó; exige una cuenta de desarrollador de Apple de pago, y la compilación de macOS lo lista como una carencia conocida.

Así que el aviso no es un informe de virus. Es Apple diciendo "aún no he revisado esta aplicación". Muchos proyectos pequeños y de código abierto publican compilaciones sin notarizar por esta misma razón.

## Abrir Baluard de todos modos

Desde macOS 15 Sequoia, el viejo truco de clic derecho y Abrir ya no funciona. La confirmación vive en Ajustes del Sistema:

1. Intenta abrir Baluard desde Aplicaciones. En el diálogo de aviso, haz clic en **OK**. No hagas clic en Mover a la papelera.
2. Abre **Ajustes del Sistema**, ve a **Privacidad y seguridad** y baja hasta el área **Seguridad**. Junto a "Baluard fue bloqueado para proteger tu Mac", haz clic en **Abrir igualmente**.
3. Confirma con tu contraseña y haz clic en **Abrir igualmente** una vez más en el diálogo final.
4. Baluard se abre. macOS recuerda la elección, así que desde entonces se abre como cualquier otra aplicación.

El botón **Abrir igualmente** aparece durante alrededor de una hora tras el intento bloqueado. Si no está, intenta abrir Baluard una vez más y vuelve al paso 2.

Cuando instales una versión más nueva de Baluard más adelante, macOS puede preguntar de nuevo. Los pasos son los mismos.

## Desde el Terminal, si lo prefieres

Un comando hace lo mismo que los pasos de arriba. macOS marca como puesto en cuarentena todo archivo descargado, y esa marca es lo que dispara la comprobación:

```bash
xattr -dr com.apple.quarantine "/Applications/Baluard.app"
```

## Comprueba la descarga antes

El aviso es tu única comprobación sobre una aplicación que Apple no ha revisado, así que úsalo antes de hacer clic en Abrir igualmente. Cada versión publica un archivo `SHA256SUMS`, y ese archivo está firmado con la clave minisign de Baluard.

Verifica el zip descargado contra él:

```bash
shasum -a 256 ~/Downloads/Baluard-macos-aarch64-non-notarized.zip
```

Compara la salida con la línea `Baluard-macos-aarch64-non-notarized.zip` del archivo `SHA256SUMS` de la misma página de la versión. Si coinciden, el archivo que tienes es el que publicamos. Los pasos manuales de minisign para verificar la lista están en [Instalación](installation.es.md) y funcionan igual en macOS.

Y las reglas de siempre: descarga solo desde las [versiones oficiales de GitHub](https://github.com/baluard-org/baluard/releases/latest) o [baluard.app](https://baluard.app), nunca desde un espejo o un enlace que te envió alguien. Baluard es código abierto bajo GPL-3.0-or-later, así que el código que ejecutas es el código que puedes leer.
