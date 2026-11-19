+++
title = "Folder sync"
description = "Sync your vault through a folder you already back up: Dropbox, Google Drive, iCloud Drive, Nextcloud, or Syncthing."
weight = 4
template = "page.html"

[extra]
+++

Folder sync turns any folder on your disk into the vault's remote. Baluard keeps a git repository inside the folder you pick, and you let whatever already syncs that folder, such as Dropbox, Google Drive, iCloud Drive, Nextcloud, or Syncthing, carry it to your other devices. Those services do the copying; Baluard does the git. No provider account, no token, no SSH key.

Under the hood this is the same sync as everywhere else: the folder holds a small git repository (a `<slug>.git` subfolder), and your vault moves as signed commits with the same merge rules. The folder-sync service is just a courier for git data.

## When folder sync fits

- You already pay for or run a folder-sync service and do not want a git host account.
- You want an off-device copy without trusting a new party: the service you already chose holds the (encrypted) folder.
- Your devices are not online at the same moments. Unlike [peer-to-peer sync](@/sync/peer-to-peer-sync.md), the folder stores commits until each device comes back, so devices never need to meet.

## Set it up in the desktop app

Open Settings, then the Sync tab, and find the "Sync to a folder" card:

1. Press **Select folder** and pick a folder that your sync service covers, for example a folder inside your Dropbox or iCloud Drive.
2. Baluard creates the git repository inside it and enables folder sync.

On your other device, connect to the same folder (see the CLI below, or pick the synced folder the same way on mobile). The commits reach the folder through your sync service, and each device pulls them on its next sync.

## Set it up on mobile

Open Settings and find the "Sync to a folder" card, then press **Select folder**. Android shows its system folder picker: choose the folder your sync app keeps updated, or a folder of the sync app itself. On iOS, pick a folder from iCloud Drive or the Files app. Baluard copies the git data between the shared folder and an internal working copy, so the vault keeps working even when the sync service is mid-transfer.

## Set it up from the CLI

Point an existing vault at a folder:

```bash
baluard sync remote --folder ~/Dropbox/baluard
baluard sync push
```

Connect a new device from a folder that already holds the vault (after the sync service has delivered it):

```bash
baluard sync clone-url --folder ~/Dropbox/baluard
```

The folder needs no preparation: the first command creates the `<slug>.git` repository inside it if it does not exist yet. `baluard sync status` shows where the vault points.

## What lives in the folder

The folder gains a `<slug>.git` subfolder, for example `baluard-vault.git`. Inside is the same encrypted git data as a provider would hold: ciphertext and signed commits. Do not edit its contents; the folder is a remote, not a document.

One note about what this is not: the folder is not a readable backup. To open the vault you always need Baluard plus your master password (and your recovery phrase if the device is lost). See [Syncing your vault](@/sync/syncing-your-vault.md) for what a stolen copy can and cannot reveal.

## Know the limits

- **The courier sets the pace.** Baluard writes to the folder; your sync service decides when that reaches the other devices. On a slow connection, expect the usual Dropbox or Drive delay, not an instant sync.
- **Conflict copies are tolerated.** Folder services occasionally produce duplicate files (a Dropbox "conflicted copy", for example) when devices race. Baluard detects these artifacts and syncs around them; the vault itself merges through git, so two devices writing at once converge on the next sync.
- **It is still not a backup plan by itself.** The folder lives under your sync service's terms. If you want belt and suspenders, pair it with [peer-to-peer sync](@/sync/peer-to-peer-sync.md) between your devices or a second copy somewhere else.

## Which transport should I pick?

- A git host ([Choosing a git provider](@/sync/git-providers.md)): a permanent off-device store with history; needs an account with the host.
- Folder sync (this page): a store you already have, through a service you already pay for or run; no account with anyone new.
- [Peer-to-peer sync](@/sync/peer-to-peer-sync.md): no store at all; devices hand commits to each other directly, and need to be online together.
