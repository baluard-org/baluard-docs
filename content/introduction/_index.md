+++
title = "Introduction"
description = "What Baluard is and how the pieces fit together."
weight = 1
sort_by = "weight"

[extra]
+++

Baluard is a Git-native password manager. Your vault is a folder of AES-256-GCM encrypted files that lives on your devices, and its history is kept as a git repository on storage you choose: a private GitHub or GitLab repo, your own server, or a USB drive. There is no Baluard account, no central server, and no telemetry.

Start here:

1. [Installation](@/install/installation.md): packages for Debian, Ubuntu, and Fedora, or direct downloads.
2. [Choosing a git provider](@/sync/git-providers.md): GitHub, GitLab, Codeberg, or your own server; size limits, pros, and cons.
3. [Syncing your vault](@/sync/syncing-your-vault.md): how git sync works and what your provider can see.
4. [Attachments](@/vault/attachments.md): the 2 MB per-file limit and how reclaiming space works.
5. [Your 24-word recovery phrase](@/vault/recovery-phrase.md): why it is your safety net in case of catastrophe and how to store it forever.
6. [Two-factor authentication (2FA) and your git provider](@/sync/provider-2fa.md): why 2FA lives on GitHub, GitLab, or Codeberg instead of inside your vault.

The [project homepage](https://baluard.app) covers the architecture and the security model in depth, including the [security white paper](https://baluard.app/security/). Not familiar with git? The [What the Git?](https://baluard.app/what-the-git/) explainer covers everything a vault owner needs in five minutes.
