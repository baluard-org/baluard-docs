+++
template = "landing.html"
title = "Baluard Docs"

[extra]
section_order = ["hero", "features", "easy_command", "final_cta"]

[extra.hero]
title = "Baluard Documentation"
badge = "Beta"
description = "Baluard is a Git-native password manager: encrypted vaults stored as git repositories on your own git provider. No central server, no account, no telemetry. These docs cover installation, vault basics, sync, and the command line."
gradient_opacity = 30
cta_buttons = [
    { text = "Get Started", url = "/introduction", style = "primary" },
    { text = "baluard.app", url = "https://baluard.app", style = "secondary" },
]

[extra.features_section]
title = "What Baluard does"
description = "One vault, every device, your storage"

[[extra.features_section.features]]
title = "Encrypted by default"
desc = "AES-256-GCM encryption. Your keys and your vault stay on your devices."
icon = "lock"

[[extra.features_section.features]]
title = "Sync through your own Git"
desc = "A private GitHub or GitLab repo, your home server, or a USB drive. The remote sees only ciphertext."
icon = "github"

[[extra.features_section.features]]
title = "Offline-first merging"
desc = "Edit on two devices without internet. Git three-way merge resolves the differences."
icon = "code-merge"

[[extra.features_section.features]]
title = "Apps and CLI"
desc = "Desktop app, browser extension with autofill, mobile app, and a full command line."
icon = "terminal"

[extra.easy_command_section]
title = "Install in one command"
description = "Packages for Debian, Ubuntu, and Fedora through the signed baluard.app repository"

[[extra.easy_command_section.tabs]]
name = "Deb (APT)"
command = "sudo curl -fsSL -o /usr/share/keyrings/baluard-archive-keyring.asc https://baluard.app/repo/baluard-release.asc && curl -fsSL https://baluard.app/repo/baluard.sources | sudo tee /etc/apt/sources.list.d/baluard.sources && sudo apt update && sudo apt install baluard"

[[extra.easy_command_section.tabs]]
name = "RPM (DNF)"
command = "sudo dnf config-manager addrepo --from-repofile=https://baluard.app/repo/baluard.repo && sudo dnf install baluard"

[[extra.easy_command_section.tabs]]
name = "Direct download"
link = "https://github.com/baluard-org/baluard/releases/latest"

[extra.final_cta_section]
title = "New to Git?"
description = "You do not need to know Git to use Baluard. The explainer on baluard.app covers everything a vault owner needs, in five minutes."
button = { text = "What the Git?", url = "https://baluard.app/what-the-git/" }
+++
