+++
title = "Syncing your vault"
description = "How git sync works, where the copy lives, and what your provider can see."
weight = 2
template = "page.html"
aliases = ["introduction/syncing-your-vault", "introduction/sync/syncing-your-vault"]

[extra]
+++

Your vault is a folder of encrypted files on your devices. Baluard keeps a git notebook for that folder: every change (a login added, an entry edited, an item deleted) becomes one signed commit in the history. Nothing is silently overwritten, and any earlier state of the vault can be recovered.

## Choose where the copy lives

Sync is optional. You have two kinds of paths, and both move the same signed commits:

- **Storage you control:** a private repository on GitHub or GitLab, your own home server, a plain USB drive, or a folder that another tool backs up for you, such as Dropbox, Google Drive, iCloud Drive, or Syncthing.
- **Your devices, directly:** peer-to-peer sync moves commits straight between your enrolled devices, with no storage host at all. See [Peer-to-peer sync](@/sync/peer-to-peer-sync.md).

Baluard never receives a copy, and because it is built on git itself, it works with any provider or none at all. [Choosing a git provider](@/sync/git-providers.md) compares the hosts, with size limits, pros, and cons.

## What your provider can see

Every line of the vault is encrypted on your device before it leaves. The repository contains only ciphertext: your git provider, someone who steals the whole repository, and even the Baluard developers cannot read it without your master password and your device keys. Technical metadata (commit timestamps, repository size) is visible to the provider by the nature of git; the contents are not.

The details, including the exact crypto construction, are in the [security white paper](https://baluard.app/security/).

## Conflicts

Change an entry offline on your laptop while your phone edits a different one? When both devices sync, git performs a three-way merge and keeps both changes. If two devices change the same field, Baluard lets you inspect the discrepancy and resolve it field by field, so nothing is lost and nothing silently wins.

New to git? The [What the Git?](https://baluard.app/what-the-git/) explainer on baluard.app covers repositories, commits, remotes, and merges in plain language.
