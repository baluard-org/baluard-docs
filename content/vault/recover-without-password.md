+++
title = "Recover a vault without your password"
description = "Locked out? Your 24-word recovery phrase re-opens the vault on a fresh device and lets you set a new master password."
weight = 7
template = "page.html"

[extra]
+++

Forgot your master password? Your 24-word recovery phrase opens the vault again — without the old password. Recovery runs entirely on your device: no account, no support ticket, nobody at Baluard involved. You set a new master password as part of the flow and keep using the vault as before.

## You need three things

1. **Your 24-word phrase.** The words you wrote down when the vault was created (or the current ones, if you rotated the phrase later). One phrase guards each vault — personal vaults and Spaces alike.
2. **The vault folder on this device.** Recovery opens the folder that is on disk. Clone the vault from your git provider, or copy it from a backup, so the folder exists here.
3. **The words are enough.** Recovery works right on the device in your hand: your unlock there is replaced with the new password. It also works on a fresh clone of the vault on a new machine.

## In the desktop app

1. On the unlock screen, choose **Forgot your master password?** — the welcome screen has the same entry under **Recover a vault with your phrase**.
2. Pick your vault from the list. If the list is empty, add the vault folder first; the screen offers the folder picker.
3. Type the 24 words.
4. Choose a new master password and name the device.
5. Unlock with the new password. That is the whole flow.

## In the mobile app

From the welcome screen, tap **Recover with a recovery kit**, pick the vault folder, enter your 24 words, and set the new password.

## From the command line

Register the fresh clone, then recover it by slug:

```bash
baluard vaults add /path/to/vault-clone
baluard vaults recover-kit <slug>
```

The command asks for the recovery phrase, the new master password, and a device name. When it finishes it prints:

```
Device recovered (<device-id>).
Unlock with your master password, then pull to catch up.
```

## What recovery does

- The recovered device joins the vault with the new password. On a personal vault you are the owner again. On a Space you rejoin as an admin beside the other active admins — and as the owner if you were the only one.
- Devices that were already enrolled keep working, and they keep unlocking with the password they were set up with. If you think someone learned your old password, remove those devices from the device list in the app.
- The phrase stays valid after recovery, so keep the paper copy. If you rotate the phrase later, the new words replace the old ones.

## When recovery refuses

- A wrong phrase changes nothing — the vault stays exactly as it was until the words check out.
- Recovering on a device that already has the vault replaces that device's unlock; your old device key files are kept as backups next to the vault (never deleted).
- Very old personal vaults, created before vaults kept a member directory, have no recovery path yet; recovery refuses on them.
- If the phrase itself is lost, the vault stays locked forever. There is no back door. See [Your 24-word recovery phrase](@/vault/recovery-phrase.md) for how to store it so this never happens.
