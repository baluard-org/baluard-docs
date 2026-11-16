+++
title = "Introduction"
description = "What Baluard is and how the pieces fit together."
weight = 1
sort_by = "weight"

[extra]
+++

Baluard is a Git-native password manager. Your vault is a folder of AES-256-GCM encrypted files that lives on your devices, and its history is kept as a git repository on storage you choose: a private GitHub or GitLab repo, your own server, or a USB drive. There is no Baluard account, no central server, and no telemetry.

Start here, by section:

1. [Install](@/introduction/install/_index.md): package repositories for Debian, Ubuntu, and Fedora, the Windows installer, the macOS app, and the CLI — plus what to do about the Windows SmartScreen and macOS Gatekeeper download warnings.
2. [Sync](@/introduction/sync/_index.md): how git sync works, choosing a provider, and protecting the provider account with 2FA.
3. [Your vault](@/introduction/vault/_index.md): import from Bitwarden, attachments, and your 24-word recovery phrase.

The [project homepage](https://baluard.app) covers the architecture and the security model in depth, including the [security white paper](https://baluard.app/security/). Not familiar with git? The [What the Git?](https://baluard.app/what-the-git/) explainer covers everything a vault owner needs in five minutes.
