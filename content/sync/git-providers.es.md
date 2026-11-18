+++
title = "Elegir un proveedor de Git"
description = "Dónde puede vivir una bóveda de Baluard: GitHub, GitLab, Codeberg, tu propio servidor, o ninguno. Límites de tamaño, pros y contras."
weight = 3
template = "page.html"
aliases = ["es/introduction/git-providers", "es/introduction/sync/git-providers"]

[extra]
+++

Una bóveda de Baluard es un repositorio git, y la sincronización envía ese repositorio al servidor que elijas. Cada servidor tiene sus propias reglas sobre cuánto puedes almacenar. Esta página compara los tres proveedores a los que Baluard se conecta de serie, más las opciones que no necesitan ninguna cuenta.

Tu proveedor solo ve texto cifrado, así que ninguno de los límites siguientes expone lo que guardas. Las diferencias están en las cuotas, la seguridad de la cuenta y la propiedad. Lo que puede ver tu proveedor está cubierto en [Sincronizar tu bóveda](@/sync/syncing-your-vault.es.md#que-puede-ver-tu-proveedor).

## La versión corta

| Proveedor | Qué obtiene un repositorio de bóveda | Coste | Auto-alojado |
|-----------|--------------------------------------|-------|--------------|
| GitHub | Sin límite obligatorio en el repositorio; archivos individuales bloqueados por encima de 100 MB, 2 GB por push | Gratis | No |
| GitLab.com | 10 GiB por proyecto en el nivel gratuito, repositorio más LFS | Gratis | Sí (self-managed) |
| Codeberg | 100 MiB en total para repositorios privados; 750 MiB de almacenamiento git en los demás casos | Gratis, financiado por donaciones | Sí (Forgejo) |
| Tu propio servidor | Tu disco | Ninguno | Lo es |
| Unidad USB, o sin sincronización | Tu disco | Ninguno | No aplica |

Una bóveda típica ocupa unos pocos megabytes, y Baluard limita los adjuntos a 2 MB por archivo ([Adjuntos](@/vault/attachments.es.md)). Los límites importan igual porque aplican al repositorio completo, historial incluido, y el historial de una bóveda solo crece.

## GitHub

La opción por defecto para la mayoría. Baluard te conecta con el flujo OAuth de dispositivo: escribe un código corto en github.com, sin pegar tokens.

Pros:

- Repositorios privados ilimitados y gratis.
- Sin límite obligatorio en el tamaño del repositorio. GitHub recomienda no pasar de 10 GB en disco, bloquea archivos individuales de más de 100 MB y aplica un límite de 2 GB por push. Una bóveda queda muy por debajo de los tres.
- Conexión con un clic: nada que pegar, ningún secreto incluido dentro de Baluard.
- El ecosistema más grande y un largo historial de disponibilidad.

Contras:

- Servicio propietario propiedad de Microsoft, bajo jurisdicción de Estados Unidos.
- La conexión pide el ámbito amplio `repo`, y los tokens resultantes no caducan por sí solos.

Números actuales: [Repository limits](https://docs.github.com/en/repositories/creating-and-managing-repositories/repository-limits) en GitHub Docs.

## GitLab

Pros:

- Open core con edición self-managed. Baluard se conecta a tu propia instancia de GitLab mediante la anulación de URL de instancia, sin las cuotas de GitLab.com.
- Conexión por flujo de dispositivo en GitLab 17.1 y posteriores, incluidas instancias autoalojadas.
- 10 GiB por proyecto en el nivel gratuito, repositorio y LFS juntos, y 500 GiB en los planes de pago.

Contras:

- Pasado el límite gratuito de 10 GiB el proyecto pasa a solo lectura hasta comprar almacenamiento.
- Cada push está limitado a 5 GiB.
- Los tokens de acceso caducan a las dos horas. Baluard los renueva automáticamente, pero esto añade piezas móviles que GitHub no tiene.

Números actuales: [Storage](https://docs.gitlab.com/user/storage_usage_quotas/) y [GitLab.com settings](https://docs.gitlab.com/user/gitlab_com/) en GitLab Docs.

## Codeberg

Codeberg es una organización sin ánimo de lucro que ejecuta Forgejo, software libre sin rastreo ni publicidad.

Pros:

- Sin ánimo de lucro, financiado por donaciones y construido por completo con software libre.
- 750 MiB de almacenamiento git por cuenta, más otros 1.5 GiB para LFS, paquetes, releases y adjuntos.
- El mismo software Forgejo funciona en casa, y Baluard puede apuntar a tu instancia en lugar de a codeberg.org.

Contras:

- Los repositorios privados, y los públicos de uso personal, comparten un total de 100 MiB. Un repositorio de bóveda es privado, así que 100 MiB es el techo práctico. La mayoría de las bóvedas caben; un historial largo con muchos adjuntos puede que no. Los proyectos públicos más grandes pueden pedir una excepción.
- Los tokens OAuth de Forgejo no tienen ámbitos, así que un token da acceso completo a la cuenta. Baluard avisa de esto en el momento de conectar.
- Los tokens de acceso caducan a la hora; Baluard los renueva automáticamente.

Números actuales: el [anuncio de las cuotas de almacenamiento](https://blog.codeberg.org/new-storage-limits-on-codeberg-what-you-need-to-know.html) en el blog de Codeberg, vigente desde mayo de 2025.

## Tu propio servidor

Cualquier remoto git alcanzable por SSH funciona, sin cuenta de proveedor y sin cuota más allá de tu disco. Las instancias de GitLab y Forgejo autoalojadas funcionan con los flujos de proveedor de arriba, mediante una anulación de URL de instancia. La disponibilidad, las actualizaciones y las copias de seguridad son tuyas, que es el precio de poseer el almacenamiento.

## Sin proveedor

La sincronización es opcional. Una bóveda puede vivir en una unidad USB o quedarse en una sola máquina, y el cuaderno git sigue ahí para el historial y la recuperación.
