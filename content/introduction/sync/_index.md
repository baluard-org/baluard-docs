+++
title = "Sync"
description = "How your vault travels through git, and how to pick and protect a provider."
weight = 2
sort_by = "weight"
template = "section.html"

[extra]
+++

Your vault syncs as a git repository on storage you choose: GitHub, GitLab, Codeberg, or your own server. There is no Baluard account and no central server. This section covers how sync works, how to pick a provider, and how to protect the provider account.

1. [Syncing your vault](@/introduction/sync/syncing-your-vault.md): how git sync works and what your provider can see.
2. [Choosing a git provider](@/introduction/sync/git-providers.md): GitHub, GitLab, Codeberg, or your own server; size limits, pros, and cons.
3. [Two-factor authentication (2FA) and your git provider](@/introduction/sync/provider-2fa.md): why 2FA lives on the provider instead of inside your vault.
4. [The SSH agent](@/introduction/sync/ssh-agent.md): let terminal tools and git sign with your vault's SSH keys; setup for Linux and macOS.
