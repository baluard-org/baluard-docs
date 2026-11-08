+++
title = "Instalación"
description = "Instala Baluard desde los repositorios de paquetes firmados o descargas directas."
weight = 1
template = "page.html"

[extra]
+++

Baluard está en beta. La versión actual es la 0.1.0 para escritorio Linux, con las extensiones de navegador y las compilaciones móviles en desarrollo.

## Debian y Ubuntu (APT)

El repositorio apt usa el formato deb822 (predeterminado en Ubuntu 24.04+ y Debian 13+). La clave blindada se usa directamente, sin paso de dearmor:

```bash
sudo curl -fsSL -o /usr/share/keyrings/baluard-archive-keyring.asc https://baluard.app/repo/baluard-release.asc
curl -fsSL https://baluard.app/repo/baluard.sources | sudo tee /etc/apt/sources.list.d/baluard.sources
sudo apt update && sudo apt install baluard
```

## Fedora (DNF)

Fedora 41+ con dnf 5:

```bash
sudo dnf config-manager addrepo --from-repofile=https://baluard.app/repo/baluard.repo
sudo dnf install baluard
```

En RHEL y derivados (dnf 4), añade el repositorio con:

```bash
sudo dnf config-manager --add-repo=https://baluard.app/repo/baluard.repo
```

## Descarga directa

Los artefactos de versión firmados (AppImage, instalador de Windows y código fuente) están en la [página de releases de GitHub](https://github.com/baluard-org/baluard/releases/latest).

## Solo línea de comandos (mise)

La CLI se instala con [mise](https://mise.jdx.dev/) sin sudo ni repositorio de paquetes. Esto instala los comandos `baluard` y `baluard-daemon` desde los archivos de versión firmados de GitHub.

```bash
mise use -g github:baluard-org/baluard    # instalar
mise upgrade github:baluard-org/baluard   # actualizar
mise uninstall github:baluard-org/baluard # eliminar
```

Notas:

- Fijar una versión con `@x.y.z` no funciona. mise antepone `v` a las etiquetas de versión y Baluard usa etiquetas sin prefijo. Usa `mise upgrade` para moverte entre versiones.
- Las versiones recién publicadas permanecen ocultas tras la ventana de frescura de cadena de suministro de mise durante un tiempo antes de que `mise upgrade` las ofrezca.

## Solo línea de comandos (tarball manual)

Descarga el archivo y las sumas de verificación firmadas desde la [última versión](https://github.com/baluard-org/baluard/releases/latest) (`Baluard-cli-amd64.tar.gz` para Linux, `Baluard-cli-darwin-arm64.tar.gz` para Apple Silicon, `Baluard-cli-windows-x86_64.tar.gz` para Windows).

```bash
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/Baluard-cli-amd64.tar.gz
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/updater.pub
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/SHA256SUMS
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/SHA256SUMS.sig
base64 -d SHA256SUMS.sig > SHA256SUMS.minisig
minisign -V -p updater.pub -x SHA256SUMS.minisig -m SHA256SUMS
sha256sum -c SHA256SUMS
```

`sha256sum -c` reporta una línea fallida por cada artefacto de escritorio que no descargaste; la línea del archivo de la CLI debe pasar. Extrae el archivo: `baluard` y `baluard-daemon` quedan lado a lado. Ponlos en tu `PATH`.

## Mantener la CLI al día

`baluard self-update` descarga la última versión, verifica las `SHA256SUMS` firmadas y reemplaza los binarios `baluard` y `baluard-daemon` en su lugar. Nunca retrocede de versión y se niega a tocar instalaciones gestionadas por mise (usa `mise upgrade` ahí).

La CLI también busca una versión nueva como máximo una vez cada 24 horas e imprime un aviso en stderr hasta que la CLI esté al día. Los scripts, CI y agentes quedan exentos. Configura `BALUARD_NO_UPDATE_CHECK=1` para desactivarlo.

## Verifica la clave de firma del repositorio

Los repositorios de paquetes están firmados. Antes de confiar en las importaciones del repositorio, verifica la huella de la clave de firma:

```
223310EA BF1A B6FE E6BD DF3E 2A53 1D54 E6D7 4804
```
