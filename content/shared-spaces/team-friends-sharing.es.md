+++
title = "Compartir con equipos y amistades"
description = "Comparte contraseñas con tu pareja, compañero de piso, cofundador o grupo pequeño sin servidor central."
weight = 2
template = "page.html"

[extra]
+++

Ya sea para dividir cuentas de casa con un compañero de piso, lanzar un proyecto paralelo con un cofundador o compartir herramientas con un grupo pequeño de amistades, Baluard te permite compartir sin mandar contraseñas por chat.

**Atención: todos los integrantes de este Espacio necesitan una cuenta en el mismo proveedor de Git para esta bóveda.**

## Dos formas de compartir

### 1. Espacio en pareja (dos personas)

Si dos personas necesitan compartir todo en un mismo Espacio (por ejemplo, dos cofundadores o una pareja), un **Espacio en pareja** mantiene la configuración al mínimo. Un Espacio en pareja comparte todas las entradas directamente sin carpetas, limita la membresía a dos personas y tiene un **Propietario** y un **Editor** o **Lector** (sin rol de Administrador).

### 2. Espacio de grupo o equipo pequeño (3 o más personas)

Para tres o más personas, usa un **Espacio de equipo** con carpetas y roles:

- **Carpetas compartidas:** Crea carpetas separadas por tema (por ejemplo, `Hosting`, `Redes` o `Casa`). Da acceso a editores y lectores solo a las carpetas que necesitan; los administradores pueden descifrar todas las carpetas.
- **Roles:** Asigna **Administrador** a quienes organizan, **Editor** a quienes aportan y **Lector** a quienes solo necesitan consultar.
- **Permisos en el proveedor:** Baluard combina el cifrado por carpeta con los permisos del repositorio en tu proveedor de Git para que los lectores no puedan subir cambios no autorizados.

## Cómo funciona la sincronización

Cada miembro debe tener una cuenta en el mismo [proveedor de Git](@/introduction/sync/git-providers.es.md) y conectar el Espacio al repositorio privado compartido. Cada cambio se firma con el dispositivo del miembro antes de enviarse, y los demás dispositivos verifican esa firma al descargar.

Si dos personas editan entradas distintas sin conexión al mismo tiempo, git combina ambos cambios sin problema. Si editan el mismo campo, Baluard te permite resolverlo campo por campo.

## Cuando alguien deja el grupo

1. Retira a la persona del Espacio y revoca su acceso al repositorio en tu proveedor de Git.
2. Rota las llaves: en un Espacio en pareja, Baluard rota la llave raíz del Espacio; en un Espacio de equipo, Baluard rota las llaves de las carpetas a las que tenía acceso.
3. **Cambia las contraseñas** de las cuentas compartidas que esa persona pudo ver antes, ya que pudo haberlas copiado mientras formaba parte del grupo.
