+++
title = "El aviso de SmartScreen en Windows"
description = "Por qué Windows muestra 'Windows protegió tu PC' al instalar Baluard, y cómo continuar."
weight = 8
template = "page.html"

[extra]
+++

## Lo que ves

Al ejecutar el instalador de Baluard en Windows, Microsoft Defender SmartScreen puede detenerlo con un diálogo azul:

> Windows protegió tu PC
>
> Microsoft Defender SmartScreen impidió que se iniciara una aplicación no reconocida. Ejecutar esta aplicación puede poner tu PC en riesgo.

Si haces clic en **Más información**, el diálogo muestra el nombre de la aplicación y `Publisher: Unknown publisher`.

## Por qué ocurre

El instalador de Baluard para Windows aún no está firmado con un certificado de código, y las notas de la versión lo listan como una carencia conocida. SmartScreen construye la reputación de los instaladores a partir de firmas digitales y estadísticas de descargas. Un instalador sin firma empieza sin reputación, así que Windows muestra este aviso la primera vez que alguien lo ejecuta.

El aviso no es un informe de virus ni de malware. Es Windows diciendo "aún no conozco este archivo". Aparece con muchos proyectos nuevos y pequeños que no llevan certificado de firma de código.

## Instalar de todos modos

1. Haz clic en **Más información** en el diálogo azul de SmartScreen.
2. Haz clic en **Ejecutar de todos modos**. El instalador arranca.
3. Sigue el instalador como siempre.

Solo hace falta hacerlo una vez por archivo descargado. Si más adelante descargas una versión nueva, Windows puede mostrar el mismo aviso para ese archivo.

## Comprueba el instalador antes de ejecutarlo

No tienes que confiar a ciegas en la descarga. Cada versión publica un archivo `SHA256SUMS`, y ese archivo está firmado con la clave minisign de Baluard.

Para comprobar el instalador en Windows, abre PowerShell en la carpeta donde lo descargaste y ejecuta:

```powershell
Get-FileHash .\Baluard-amd64-setup.exe
```

Compara el hash que imprime con la línea `Baluard-amd64-setup.exe` del archivo `SHA256SUMS` de la misma página de la versión. Si los dos valores coinciden, el archivo que tienes es el que publicamos.

La firma sobre `SHA256SUMS` demuestra que la lista no fue alterada. Los pasos de verificación manual están en [Instalación](../installation/), en la sección del tarball manual, y funcionan igual en Windows.

## Después de la instalación

Durante la instalación, SmartScreen también puede mostrar un aviso más pequeño de Control de cuentas de usuario: "¿Quieres permitir que esta aplicación haga cambios en el dispositivo?". Haz clic en **Sí**. Ese aviso es la pregunta estándar de elevación del instalador, no una advertencia de reputación de SmartScreen.

El instalador coloca Baluard en `%LOCALAPPDATA%\Programs\Baluard`, bajo tu cuenta de usuario, sin cambios en todo el sistema.
