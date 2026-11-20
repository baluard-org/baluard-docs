+++
title = "Tu frase de recuperación de 24 palabras"
description = "Por qué importa tu frase de recuperación de 24 palabras, cómo protege tu bóveda y cómo guardarla de forma segura para siempre."
weight = 6
template = "page.html"
aliases = ["es/introduction/recovery-phrase", "es/introduction/vault/recovery-phrase"]

[extra]
+++

Cuando creas una bóveda nueva en Baluard, la aplicación genera una **frase de recuperación de 24 palabras** (por ejemplo: *apple, river, lantern, ...*). Esas 24 palabras son la llave maestra de tu bóveda en caso de emergencia. Guárdalas en un lugar seguro y consérvalas para siempre.

## Por qué es tan importante

Baluard no tiene servidores centrales ni cuentas de usuario. Nadie en Baluard puede restablecer tu acceso ni recuperar tus datos por ti. Pero tú sí puedes: en una instalación nueva, tu frase de 24 palabras vuelve a abrir la bóveda y te deja elegir una **nueva contraseña maestra**, sin necesidad de la antigua. En la app de escritorio usa "¿Olvidaste tu contraseña maestra?" en la pantalla de desbloqueo; en el móvil usa la entrada de recuperación de la pantalla de bienvenida. La carpeta de la bóveda (con su kit de recuperación) debe estar primero en ese dispositivo: clónala desde tu proveedor git o añade la carpeta, y después recupera.

Si te roban la laptop, se rompe tu teléfono o pierdes acceso a todos tus dispositivos al mismo tiempo, tu frase de recuperación de 24 palabras es la **única** forma de volver a entrar en tu bóveda. Sin ella, tus datos cifrados quedan bloqueados para siempre.

## Tu segundo factor (2FA)

En Baluard, tu bóveda está protegida por dos elementos:

1. **Tu contraseña maestra** (algo que sabes).
2. **La clave de tu dispositivo** (algo que guarda tu dispositivo).

Conocer tu contraseña maestra no basta por sí solo para abrir tu bóveda en un dispositivo nuevo. Para agregar un dispositivo nuevo o recuperarte tras una catástrofe, necesitas un dispositivo ya autorizado **o** tu frase de recuperación de 24 palabras. En la práctica, esas 24 palabras funcionan como tu **autenticación de dos factores (2FA)** para recuperación ante desastres.

## Cómo guardarla de forma segura, para siempre

Trata tu frase de 24 palabras como la escritura de tu casa o la llave de repuesto de una caja fuerte:

- **Escríbela en papel.** Usa un bolígrafo, escribe con letra clara y revisa dos veces la ortografía y el orden de las 24 palabras.
- **Guárdala en un lugar físico y seguro.** Un cajón con llave, una caja fuerte ignífuga en casa o una caja de seguridad bancaria.
- **Considera tener una segunda copia física.** Si ocurre un incendio o una inundación en casa, una segunda copia guardada con un familiar de confianza o en otro lugar te salva.
- **Mantenla fuera de internet.** Nunca le tomes una foto ni una captura de pantalla. Nunca la guardes en un correo electrónico, una nota en la nube, un mensaje de chat ni un archivo de texto en tu computadora.
- **Nunca la compartas.** Cualquiera que consiga tu contraseña maestra junto con tu frase de 24 palabras podrá abrir tu bóveda.

## Cuándo la vas a necesitar

No necesitas la frase de 24 palabras en el día a día: tus dispositivos se desbloquean con tu contraseña maestra. Solo la necesitarás cuando:

- Todos tus dispositivos autorizados se pierdan, se rompan o se borren al mismo tiempo.
- Estés configurando un dispositivo nuevo y no tengas a mano otro dispositivo ya autorizado para aprobarlo.
- Hayas olvidado tu contraseña maestra. Recupera en una instalación nueva (o en un dispositivo sin esta bóveda) solo con la frase, y elige una contraseña nueva.

Guárdala bien, mantenla fuera de internet y nunca la tires.
