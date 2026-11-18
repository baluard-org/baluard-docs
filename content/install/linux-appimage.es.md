+++
title = "El AppImage de Linux"
description = "Ejecuta y gestiona el AppImage de Baluard en Linux: FUSE, menú de aplicaciones, actualizaciones y distribuciones inmutables."
weight = 2
template = "page.html"

aliases = ["es/introduction/install/linux-appimage"]

[extra]
+++

Baluard se distribuye en dos formatos de Linux: paquetes deb y rpm, y un AppImage de archivo único. Los paquetes se instalan desde un repositorio e integran todo por ti; consulta [Instalación](installation.es.md). El AppImage no necesita repositorio, ni sudo, ni paso de instalación: descarga, marca como ejecutable, ejecuta. Esta página cubre el AppImage.

## Descarga y ejecución

Descarga `Baluard-amd64.AppImage` desde la [página de releases](https://github.com/baluard-org/baluard/releases/latest). Algunos navegadores y gestores de archivos lo guardan sin el bit de ejecución. Arréglalo en una terminal:

```bash
chmod +x ~/Downloads/Baluard-amd64.AppImage
~/Downloads/Baluard-amd64.AppImage
```

O usa tu gestor de archivos: clic derecho sobre el archivo, abre Propiedades y permite ejecutarlo. El texto exacto cambia entre gestores.

## Si no arranca: FUSE

Los AppImage arrancan a través de FUSE. La mayoría de las distribuciones de escritorio lo incluyen; algunas instalaciones mínimas no. El error típico es:

> dlopen(): error loading libfuse.so.2

Instala la biblioteca FUSE 2 con tu gestor de paquetes:

```bash
sudo apt install libfuse2      # Debian 12, Ubuntu 22.04
sudo apt install libfuse2t64   # Debian 13+, Ubuntu 24.04+
sudo dnf install fuse          # Fedora
sudo pacman -S fuse2           # Arch
```

Sin sudo también puedes ejecutar el AppImage. Cualquier AppImage puede desempaquetarse y ejecutarse sin FUSE:

```bash
./Baluard-amd64.AppImage --appimage-extract-and-run
```

El arranque es más lento y usa más disco. Sirve como respaldo.

## Agrega Baluard al menú de aplicaciones

Un AppImage es solo un archivo. No crea una entrada en el menú ni un icono por sí solo, y queda donde lo guardaste. Un gestor de AppImage lo resuelve: guarda los AppImage en una carpeta, conecta la entrada del menú y el icono, y elimina todo al desinstalar.

Recomendamos:

- [AppManager](https://github.com/kem-a/AppManager/releases): instalador y gestor general de AppImage. Instala un AppImage con entrada de menú e icono, y desinstala limpio. Él mismo se distribuye como AppImage.
- [Gear Lever](https://flathub.org/en/apps/it.mijorus.gearlever): si usas una distribución inmutable o prefieres Flatpak. Organiza los AppImage en una carpeta gestionada, los integra en la cuadrícula de aplicaciones y conserva la versión anterior como respaldo antes de actualizar.

## Actualizaciones

El AppImage se actualiza solo. Baluard busca una versión nueva en segundo plano, muestra un aviso e instala tras tu confirmación. Cada actualización se verifica con firma, y una firma fallida la aborta.

Los paquetes deb y rpm también buscan actualizaciones, pero solo avisan; tu gestor de paquetes es dueño de la instalación. El AppImage es el único formato de Linux que se actualiza solo.

AppManager y Gear Lever también pueden vigilar GitHub en busca de versiones nuevas. Usa un solo canal de actualización, no dos a la vez.

## Distribuciones inmutables

En Fedora Silverblue, openSUSE Aeon y sistemas similares, los paquetes deb y rpm requieren agregar capas a la imagen del sistema, y este sitio no documenta esa ruta. El AppImage se ejecuta desde tu carpeta personal sin cambios en el sistema. Instala Gear Lever desde Flathub y gestiona Baluard como cualquier otro AppImage.

## Brecha conocida: la extensión de navegador

La extensión de navegador está en desarrollo. Su puente de escritorio se registra automáticamente cuando instalas los paquetes deb o rpm. Desde el AppImage, ese registro es un paso manual y aún no está automatizado. Si la extensión de navegador es la razón por la que usas Baluard, los paquetes son hoy el formato más sencillo.

## Verifica la descarga primero

El AppImage se salta los avisos de instalación de Windows y macOS, así que la suma de verificación de la descarga es tu comprobación principal. Cada versión publica un archivo `SHA256SUMS` firmado con la clave minisign de Baluard:

```bash
sha256sum ~/Downloads/Baluard-amd64.AppImage
```

Compara la salida con la línea `Baluard-amd64.AppImage` del `SHA256SUMS` de la misma página de release. Si coinciden, el archivo que tienes es el archivo que publicamos. Los pasos de minisign que verifican la lista están en [Instalación](installation.es.md).
