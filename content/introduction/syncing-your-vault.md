+++
title = "Syncing your vault"
description = "How git sync works, where the copy lives, and what your provider can see."
weight = 2
template = "page.html"

[extra]
+++

Your vault is a folder of encrypted files on your devices. Baluard keeps a git notebook for that folder: every change (a login added, an entry edited, an item deleted) becomes one signed commit in the history. Nothing is silently overwritten, and any earlier state of the vault can be recovered.

## Choose where the copy lives

Sync is optional and points at storage you control:

- a private repository on GitHub or GitLab,
- your own home server,
- or a plain USB drive.

Baluard never receives a copy, and because it is built on git itself, it works with any provider or none at all.

## What your provider can see

Every line of the vault is encrypted on your device before it leaves. The repository contains only ciphertext: your git provider, someone who steals the whole repository, and even the Baluard developers cannot read it without your master password and your device keys. Technical metadata (commit timestamps, repository size) is visible to the provider by the nature of git; the contents are not.

The details, including the exact crypto construction, are in the [security white paper](https://baluard.app/security/).

## Conflicts

Change an entry offline on your laptop while your phone edits a different one? When both devices sync, git performs a three-way merge and keeps both changes. If two devices change the same field, Baluard lets you inspect the discrepancy and resolve it field by field, so nothing is lost and nothing silently wins.

New to git? The [What the Git?](https://baluard.app/what-the-git/) explainer on baluard.app covers repositories, commits, remotes, and merges in plain language.
