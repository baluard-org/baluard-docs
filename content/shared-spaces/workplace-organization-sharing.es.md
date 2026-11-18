+++
title = "Compartir en el trabajo y organizaciones"
description = "Carpetas por departamento, acceso por roles, aprobaciones entre varios administradores y bajas de personal sin servidor central."
weight = 3
template = "page.html"

[extra]
+++

Un **Espacio de organización** permite a una empresa o equipo administrar credenciales compartidas en un repositorio git privado bajo tu control, sin un servidor SaaS de terceros ni dependencia de una nube por asiento.

**Atención: todos los integrantes de este Espacio necesitan una cuenta en el mismo proveedor de Git para esta bóveda.**

## Control de acceso sin servidor central

- **Carpetas por departamento o proyecto (colecciones):** Organiza las credenciales en carpetas como `Ingeniería`, `Producción`, `Finanzas` o `Marketing`. Los editores y lectores solo reciben las llaves criptográficas de las carpetas que tienen asignadas. **Importante:** los administradores y el propietario pueden descifrar todas las carpetas del Espacio; el aislamiento por carpeta restringe a editores y lectores, no a los administradores.
- **Roles:**
  - **Propietario:** Control total sobre el Espacio, transferencia de propiedad y acciones destructivas.
  - **Administrador:** Gestiona miembros, carpetas y la aprobación de nuevos miembros.
  - **Editor:** Crea y actualiza entradas en las carpetas asignadas.
  - **Lector:** Consulta entradas en las carpetas asignadas sin permisos de escritura.
- **Historial firmado:** Cada commit en el repositorio del Espacio va firmado por el dispositivo de un miembro autorizado y es verificado por los demás al sincronizar.

## Resguardos entre varios administradores y continuidad

- **Aprobación por quórum:** Los Espacios de organización pueden exigir que varios administradores aprueben cambios sensibles (como retirar a un administrador o cambiar la gobernanza del Espacio), evitando que una sola cuenta comprometida tome el control.
- **Kit de recuperación del Espacio:** Guarda el Kit de recuperación del Espacio (una frase propia de 24 palabras para ese Espacio) fuera de internet según la política de continuidad de tu empresa. Recuperar el Espacio exige tanto esa frase del kit como acceso de lectura al repositorio Git. Si un administrador sale o cambia la propiedad, Baluard emite una nueva frase del kit que debe anotarse de nuevo.
- **2FA en el proveedor y tokens acotados:** Exige [autenticación de dos factores (2FA)](@/sync/provider-2fa.es.md) en las cuentas del proveedor de Git de todo el equipo. En organizaciones, usa tokens granulares o una GitHub App en lugar de tokens clásicos con el ámbito amplio `repo`.

## Expectativas claras al dar de baja a alguien

Como Baluard no tiene servidor central:

- **Las lecturas son locales:** Una vez que un miembro descifra una entrada en su dispositivo, no existe un registro central de lecturas, y revocar su acceso después no borra lo que ya haya copiado.
- **Lista de baja de personal:**
  1. Retira al miembro del Espacio y revoca su acceso de colaborador en tu proveedor de Git.
  2. Rota las llaves de todas las carpetas a las que tenía acceso.
  3. **Rota las contraseñas, claves de API y tokens reales** guardados en esas carpetas.
