+++
title = "Device management"
description = "See which devices have synced with your vault, enroll new devices, and revoke lost or stolen ones."
weight = 13
template = "page.html"

[extra]
+++

Every computer or phone that syncs with your Baluard vault is enrolled as a device with its own device key. You can review your active devices and revoke any device you no longer use or trust.

## View your devices

Open **Settings -> Devices** in the desktop app to see the devices that have synced with this vault:

- **This device** marks the computer you are currently using.
- **Last sync** shows when each device last synced with the vault.
- **Status** reflects recent activity (**Active**, **Idle**, **Stale**, or **Dormant**).

## Enroll a new device

To add a second computer or phone to an existing vault:

1. Install Baluard on the new device and connect it to the same [git provider](@/sync/git-providers.md), [folder sync](@/sync/folder-sync.md), or [peer-to-peer sync](@/sync/peer-to-peer-sync.md) source.
2. Unlock with your master password (or use your [24-word recovery phrase](@/vault/recovery-phrase.md) if enrolling from scratch).
3. Sync once so the new device appears in **Settings -> Devices**.

## Revoke a lost or stolen device

If a laptop or phone is lost, stolen, or retired:

1. Open **Settings -> Devices** on a trusted device.
2. Click **Revoke** next to the device you want to remove and confirm. Baluard rotates the vault keys so the revoked device cannot decrypt future updates.
3. **Rotate git credentials:** If the vault syncs through GitHub, GitLab, or Codeberg, open your repository settings on that provider and remove the revoked device's deploy key or personal access token (PAT), then check **I have rotated the git credentials** in Baluard.

If desktop revocation fails, you can run `baluard --direct device revoke <id>` from the CLI.

## Good to know

- Revoking a device stops it from reading future changes, but anything the device already synced while it had access could still be cached on its local disk until wiped. If a device was stolen while unlocked or with Quick Unlock active, change your most critical account passwords too.
- On a **Shared Space**, existing members can enroll their own additional devices without needing another admin approval.
