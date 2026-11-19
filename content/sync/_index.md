+++
title = "Sync"
description = "How your vault travels: git on storage you choose, or direct peer-to-peer between devices, plus how to pick and protect a provider."
weight = 3
sort_by = "weight"
template = "section.html"

[extra]
+++

Your vault syncs as a git repository. The copy can live on storage you choose: GitHub, GitLab, Codeberg, your own server, or a folder another tool backs up for you; or your devices can sync directly with each other, peer to peer. There is no Baluard account and no central server. This section covers how sync works, how to pick a provider, and how to protect the provider account.

1. [Syncing your vault](@/sync/syncing-your-vault.md): how git sync works and what your provider can see.
2. [Peer-to-peer sync](@/sync/peer-to-peer-sync.md): sync directly between your enrolled devices, with no provider; setup, security, and limits.
3. [Folder sync](@/sync/folder-sync.md): sync through a folder you already back up with Dropbox, Drive, iCloud Drive, or Syncthing; no account needed.
4. [Choosing a git provider](@/sync/git-providers.md): GitHub, GitLab, Codeberg, or your own server; size limits, pros, and cons.
5. [Two-factor authentication (2FA) and your git provider](@/sync/provider-2fa.md): why 2FA lives on the provider instead of inside your vault.
6. [The SSH agent](@/sync/ssh-agent.md): let terminal tools and git sign with your vault's SSH keys; setup for Linux and macOS.
