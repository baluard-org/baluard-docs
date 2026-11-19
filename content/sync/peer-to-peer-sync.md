+++
title = "Peer-to-peer sync"
description = "Sync your vault directly between your enrolled devices, with no git provider and no storage host."
weight = 3
template = "page.html"

[extra]
+++

Peer-to-peer sync is the second way to move your vault. Your vault stays a git repository, and sync still sends the same signed commits; the difference is the path. Instead of storing a copy on GitHub or a USB drive, your devices connect to each other directly and hand over the new commits. No provider, no account, no storage host anywhere in the path.

## When peer-to-peer fits

- You sync between two or more of your own devices and do not want a git provider account at all.
- Your devices are on the same network, or both online at the same moment.

Both devices must be enrolled to the same vault, and both must be running Baluard when you sync. A device that is not enrolled cannot connect even if it learns your address: Baluard checks the device keys of every connection attempt in both directions and refuses strangers.

## Turn it on in the desktop app

Open Settings, then the Sync tab, and find the "Direct peer-to-peer sync" card:

1. Press **Enable P2P**. Baluard shows a warning: P2P-only means no off-device backup. Keep reading below.
2. Copy the code next to **This device address**.
3. On your other device, enable P2P the same way and paste your first device's address into **Peer device address**.
4. Press **Sync peer**. When it finishes, both devices hold the same commits.

Swap the addresses to sync in the other direction, or repeat the steps on every device you want in the loop.

## Turn it on on mobile

Open Settings and find "Direct peer-to-peer sync". The steps are the same: enable P2P, copy this device's address, paste the peer's address, and sync.

On mobile, the peer-to-peer listener runs only while the app is open. On desktop it also runs in the background while the daemon is active. Start the app on the phone, then sync from the computer.

## Turn it on from the CLI

P2P commands talk to the daemon, so it must be running (no `--direct`):

```bash
baluard sync p2p status                 # state and this device's address
baluard sync p2p enable                 # start the endpoint
baluard sync p2p sync <peer-address>    # sync with one enrolled peer
baluard sync p2p disable                # stop the endpoint
```

## What travels over the wire

The same encrypted git data as everywhere else. Your peer receives only ciphertext plus the signed commits describing it, and the receiving device verifies the sender's device keys before anything is applied. If a direct connection is not possible, for example behind a strict network, Baluard relays the connection through a helper server. The relay passes along encrypted traffic only; it cannot read your vault.

## Know the limits

- **Sync needs both sides present.** Unlike a git provider, which stores your commits until you come back, a peer-to-peer sync only happens when both devices are online and Baluard is running on both.
- **P2P-only means no off-device backup.** If every enrolled device is lost at the same time, the vault is gone. The warning says this in the app, and it matters: pair peer-to-peer with a [git provider](@/sync/git-providers.md), [folder sync](@/sync/syncing-your-vault.md), or an encrypted backup so a copy exists somewhere off your devices.
- Conflicts resolve the same way as with git sync: [changes merge, and same-field edits ask you](@/sync/syncing-your-vault.md#conflicts).
