+++
title = "Automatización de navegador con secretos"
description = "Permite que un agente de IA complete formularios web con valores de tu bóveda mientras los secretos quedan fuera del contexto del agente."
weight = 6
template = "page.html"

[extra]
+++

Los agentes de IA pueden manejar un navegador: completar formularios, terminar compras, iniciar sesión en sitios. Si pegas un número de tarjeta o una contraseña en el prompt del agente, el valor queda en el contexto del modelo y en la transcripción de la sesión. También queda en cada log que guarde la conversación. Baluard te da dos patrones que mantienen el valor fuera del agente. Ambos usan las mismas referencias `baluard://` que cualquier comando agéntico (ver [Flujos agénticos con el CLI](@/cli-and-agents/agentic-workflows.es.md)).

## Patrón 1: inyectar en el entorno del proceso (recomendado)

`baluard run` envuelve todo tu comando de automatización e inyecta los campos aprobados como variables de entorno. El valor existe solo dentro del proceso hijo. El agente y el modelo jamás lo ven, y `stdout` y `stderr` vuelven con los bytes de secretos filtrados limpiados.

```bash
baluard run \
  --env CARD_NUMBER=baluard://Personal/Visa/number \
  --env CARD_EXP_MONTH=baluard://Personal/Visa/exp_month \
  --env CARD_EXP_YEAR=baluard://Personal/Visa/exp_year \
  --need "completar compra en shop.example.com" \
  -- mi-automatizacion fill-checkout
```

El daemon te muestra un aviso de aprobación antes de lanzar el hijo. La concesión queda ligada al árbol de procesos solicitante y expira a los 15 minutos.

## Patrón 2: capturar valores dentro de un script (code mode)

Muchos harnesses de agentes pueden ejecutar un script que llama herramientas. El modelo escribe el script. El script guarda los valores en sus propias variables. Solo el resumen final vuelve al modelo.

La forma es la misma en todos los harnesses. Los nombres de la API dependen de tu herramienta:

```js
// Un solo script, escrito por el agente. El modelo jamás ve los valores.
const num = (await shell("baluard read baluard://Personal/Visa/number")).trim();
const exp = (await shell("baluard read baluard://Personal/Visa/exp_year")).trim();
await browser.click({ selector: 'iframe[title="Card number input"]' });
await browser.type({ text: num });
await browser.click({ selector: "#expiry" });
await browser.type({ text: exp });
return "formulario completado";
```

`baluard read` imprime el valor de un campo y funciona en tu sesión desbloqueada. Corre solo en modo daemon.

El patrón 1 mantiene el valor fuera del contexto del modelo y del trace de ejecución. El patrón 2 lo mantiene fuera del contexto del modelo. Pero cada llamada a herramienta dentro del script queda visible en el trace de ejecución legible por humanos. Si ese trace se comparte o se guarda, prefiere el patrón 1.

## Nombres de campos de tarjeta

Una entrada de tipo `card` expone estos campos a las referencias:

| Campo | Sufijo de referencia |
|-------|---------------------|
| Titular | `cardholder_name` |
| Marca | `brand` |
| Número de tarjeta | `number` |
| Mes de expiración | `exp_month` |
| Año de expiración | `exp_year` |
| CVV/CVC | `code` |

`totp` y `custom:<nombre>` también funcionan en cualquier tipo de entrada. Las claves SSH, claves de firma y campos de claves privadas siguen bloqueados para concesiones de agentes.

## Mantén el valor fuera de los traces

El valor queda fuera del contexto del modelo en ambos patrones. Todavía puede llegar a lugares que un humano lee después. Tres reglas:

1. Prefiere `baluard run`. El valor existe solo en el entorno del hijo, no en ninguna llamada a herramienta o línea del script.
2. Pasa el valor por stdin, no por argv. Los argumentos de comandos aparecen en la salida de `ps`, el historial del shell y los traces de herramientas:

   ```bash
   printf '%s' "$CARD_NUMBER" | mi-automatizacion fill --stdin
   ```

3. No tomes screenshots de campos completados. Un screenshot envía la imagen de vuelta al modelo, y el modelo la lee. Toma screenshots antes de completar, o recorta hacia campos vacíos.

## Aprobaciones

Ambos patrones usan el flujo de aprobación estándar. La app de escritorio muestra un diálogo. Para uso headless, corre `baluard agent pending` y `baluard agent approve` en una segunda terminal. Ver [Aprobar solicitudes](@/cli-and-agents/agentic-workflows.es.md#aprobar-solicitudes-escritorio-y-cli-headless) para el flujo completo y los códigos de salida.

Una advertencia: `baluard agent auto-approve --yolo` elimina la puerta de aprobación para toda solicitud posterior en este dispositivo. No lo uses para sesiones de navegador en sitios que no controlas.

Estos patrones no necesitan un servidor MCP ni un plugin. Cualquier agente que pueda ejecutar comandos de shell puede usarlos.
