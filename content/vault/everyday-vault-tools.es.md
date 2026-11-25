+++
title = "Herramientas diarias de la bóveda"
description = "Cambia entre múltiples bóvedas, usa el generador de contraseñas, ejecuta el chequeo de seguridad y conoce los tipos de entrada."
weight = 16
template = "page.html"

[extra]
+++

Con tu bóveda configurada, Baluard incluye cambio entre múltiples bóvedas, nueve tipos de entrada estructurados, un generador integrado de contraseñas y frases de paso, y un chequeo de seguridad bajo demanda.

## Cambio entre bóvedas y vista combinada

Si tienes una bóveda personal y uno o más Espacios compartidos, usa el selector de bóvedas en la parte superior de la barra lateral para moverte entre ellas.

Cada bóveda registrada muestra uno de tres estados:

- **Desbloqueada (punto verde):** Las llaves están en memoria. Al hacer clic, cambia al instante.
- **Bloqueada (punto ámbar):** Registrada y abierta en el daemon, pero bloqueada. Al hacer clic, pide la contraseña maestra de esa bóveda.
- **Cerrada (punto gris):** Registrada en disco, sin cargar en memoria. Al hacer clic, se abre y desbloquea.

### Vista combinada entre bóvedas abiertas

Cuando tienes varias bóvedas desbloqueadas a la vez, Baluard combina las entradas de tus otras bóvedas abiertas en la lista principal y en los resultados de búsqueda (excepto en **Papelera**, **Archivo** y el filtro **Sin carpeta**). Las entradas de otras bóvedas muestran su bóveda de origen para que puedas buscar entre tu bóveda personal y tus espacios compartidos sin cambiar cada vez.

### Cerrar frente a desvincular una bóveda

- **Cerrar:** Descarga la bóveda de memoria y borra sus llaves manteniendo la entrada en el selector de bóvedas.
- **Desvincular:** Quita la bóveda del registro de Baluard. Por defecto, la carpeta queda en disco para que puedas volver a agregarla después; borrarla del disco requiere confirmación explícita dentro del diálogo.

## Tipos de entrada

Baluard admite nueve tipos de entrada:

- **Acceso:** Usuario, contraseña, URLs de sitios web, códigos TOTP en vivo, llaves de acceso y campos personalizados.
- **Tarjeta:** Titular, marca, número, mes/año de vencimiento y código de seguridad.
- **Identidad:** Nombre, cargo, empresa, correo, teléfono y dirección postal.
- **Nota segura:** Notas cifradas compatibles con Markdown.
- **Llave SSH:** Llave pública, llave privada, huella y opción para servirla con el agente SSH.
- **Llave de firma:** Metadatos y material de llaves criptográficas de firma.
- **Cuenta bancaria:** Titular, números de ruta/cuenta y datos del banco.
- **Licencia de conducir:** Número de licencia, autoridad emisora y fechas.
- **Pasaporte:** Número de pasaporte, nacionalidad y fechas de emisión y vencimiento.

## Generador de contraseñas

Abre el **Generador de contraseñas** desde la barra superior o directo desde el campo de contraseña al crear o editar una entrada:

- **Modo contraseña:** Ajusta la longitud (por defecto `16`) y activa o desactiva mayúsculas, números y símbolos.
- **Modo frase de paso:** Ajusta la cantidad de palabras (por defecto `5`), el separador (por defecto `-`) y si incluye mayúsculas, números o símbolos.
- **Historial:** Al copiar un valor generado o pulsar **Regenerar**, se guarda en el historial del generador de la bóveda para recuperar un valor reciente si hace falta. Abre el panel de historial para copiar entradas anteriores o limpiar la lista.

## Chequeo de seguridad

Ejecuta una auditoría bajo demanda de las contraseñas de tu bóveda en **Ajustes -> General y Seguridad -> Chequeo de seguridad -> Ejecutar chequeo**.

Baluard analiza la bóveda activa de forma local y agrupa los resultados en tres categorías:

- **Contraseñas débiles:** Contraseñas demasiado cortas, comunes, con un mismo carácter repetido o secuencias simples.
- **Contraseñas reutilizadas:** Contraseñas repetidas en varias entradas.
- **Contraseñas antiguas:** Contraseñas que no se han cambiado en mucho tiempo.

Si no hay hallazgos, Baluard informa que no se encontraron problemas.
