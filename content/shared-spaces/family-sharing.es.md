+++
title = "Compartir en familia"
description = "Una sola bóveda compartida del hogar para tutores, parejas e hijos, con visibilidad separada para lo compartido y lo privado."
weight = 1
template = "page.html"

[extra]
+++

Un **Espacio familiar** le da a tu hogar una sola bóveda compartida sin obligar a que todos vean todo. Las cuentas de streaming, contraseñas de Wi-Fi y servicios del hogar viven en un mismo lugar, mientras que los registros sensibles de los adultos quedan ocultos para los hijos.

## Cómo se organiza un Espacio familiar

- **Tutores (Administradores):** Adultos que administran el Espacio, invitan o retiran miembros, aprueban la incorporación de nuevos miembros y pueden ver todas las carpetas, incluidas las exclusivas para tutores.
- **Hijos y otros miembros (Editores o Lectores):** Miembros que ven la carpeta **Compartida** (`Shared`) más cualquier carpeta propia creada para ellos, sin ver elementos exclusivos de tutores (como finanzas del hogar o accesos bancarios). A los hijos también se les puede activar la marca de **Menor**, que les impide reclamar la propiedad, usar el kit de recuperación o aprobar acciones de gobierno.
- **Carpeta protegida `Shared`:** Se crea automáticamente para los accesos cotidianos del hogar, de modo que toda la familia tenga lo que necesita.

## Comodidad en el día a día

- **Vista unificada:** No hace falta cambiar de bóveda constantemente. Tu bóveda personal y tu Espacio familiar aparecen juntos en la búsqueda y el autocompletado.
- **Sin contraseña maestra compartida:** Cada integrante usa su propia identidad de Baluard y el desbloqueo de su dispositivo, sin andar compartiendo una contraseña maestra.
- **Invitaciones por código:** Invita a tus familiares con un código corto; al introducir el código, su incorporación se aprueba automáticamente.
- **Mismo proveedor de Git:** Todos los integrantes del Espacio familiar necesitan una cuenta gratuita en el mismo [proveedor de Git](@/introduction/sync/git-providers.es.md) (por ejemplo, todos en GitHub o todos en GitLab).

## Dispositivos perdidos y emergencias

- **Teléfono o tableta robados:** Un administrador puede revocar el dispositivo perdido, reemplazar el acceso del miembro y rotar las llaves de las carpetas afectadas para que ese dispositivo no pueda descifrar cambios futuros.
- **Kit de recuperación del Espacio:** Un Espacio familiar no tiene contraseña maestra. En su lugar, el **Kit de recuperación del Espacio** genera una frase propia de 24 palabras para ese Espacio. Guárdala en un lugar físico seguro (igual que los documentos importantes de la familia): la recuperación de emergencia exige tanto esta frase del kit como acceso de lectura al repositorio Git del Espacio.
- **Renovación tras una salida:** Si un tutor sale del Espacio o cambia la propiedad, Baluard emite automáticamente un nuevo Kit de recuperación con otra frase de 24 palabras. La frase anterior deja de servir, así que los tutores deben anotar la nueva.

## Ten en cuenta

Los administradores pueden ver todo en el Espacio familiar, mientras que los demás miembros solo descifran las carpetas que se les asignaron. Recuerda que quien pudo ver una contraseña antes pudo haberla copiado; si alguien deja el hogar y no debe conservar acceso, cambia también las contraseñas de esas cuentas compartidas.
