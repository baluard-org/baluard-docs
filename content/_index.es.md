+++
template = "landing.html"
title = "Documentación de Baluard"

[extra]
section_order = ["hero", "features", "easy_command", "final_cta"]

[extra.hero]
title = "Documentación de Baluard"
badge = "Beta"
description = "Baluard es un gestor de contraseñas git-nativo: bóvedas cifradas guardadas como repositorios git en tu propio proveedor de git. Sin servidor central, sin cuenta, sin telemetría. Esta documentación cubre la instalación, los fundamentos de la bóveda, la sincronización y la línea de comandos."
gradient_opacity = 30
cta_buttons = [
    { text = "Empezar", url = "/es/introduction/", style = "primary" },
    { text = "baluard.app", url = "https://baluard.app", style = "secondary" },
]

[extra.features_section]
title = "Qué hace Baluard"
description = "Una bóveda, todos tus dispositivos, tu almacenamiento"

[[extra.features_section.features]]
title = "Cifrado por defecto"
desc = "Cifrado AES-256-GCM. Tus claves y tu bóveda permanecen en tus dispositivos."
icon = "lock"

[[extra.features_section.features]]
title = "Sincronización con tu propio Git"
desc = "Un repositorio privado de GitHub o GitLab, tu servidor, o una unidad USB. El remoto solo ve texto cifrado."
icon = "github"

[[extra.features_section.features]]
title = "Fusión sin conexión"
desc = "Edita en dos dispositivos sin internet. La fusión de tres vías de git resuelve las diferencias."
icon = "code-merge"

[[extra.features_section.features]]
title = "Apps y CLI"
desc = "App de escritorio, extensión de navegador con autocompletado, app móvil y una línea de comandos completa."
icon = "terminal"

[extra.easy_command_section]
title = "Instala con un comando"
description = "Paquetes para Debian, Ubuntu y Fedora mediante el repositorio firmado de baluard.app"

[[extra.easy_command_section.tabs]]
name = "Deb (APT)"
command = "sudo curl -fsSL -o /usr/share/keyrings/baluard-archive-keyring.asc https://baluard.app/repo/baluard-release.asc && curl -fsSL https://baluard.app/repo/baluard.sources | sudo tee /etc/apt/sources.list.d/baluard.sources && sudo apt update && sudo apt install baluard"

[[extra.easy_command_section.tabs]]
name = "RPM (DNF)"
command = "sudo dnf config-manager addrepo --from-repofile=https://baluard.app/repo/baluard.repo && sudo dnf install baluard"

[[extra.easy_command_section.tabs]]
name = "Descarga directa"
link = "https://github.com/baluard-org/baluard/releases/latest"

[extra.final_cta_section]
title = "¿Nuevo en Git?"
description = "No necesitas saber Git para usar Baluard. La explicación en baluard.app cubre todo lo que necesita quien tiene una bóveda, en cinco minutos."
button = { text = "¿Qué es el Git?", url = "https://baluard.app/what-the-git/" }
+++
