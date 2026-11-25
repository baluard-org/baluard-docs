+++
title = "Quick unlock and hardware protection"
description = "Unlock faster with biometrics or a 6-digit PIN, or bind your vault to a device security chip or hardware security key."
weight = 12
template = "page.html"

[extra]
+++

By default, Baluard locks your vault behind your master password alone. You can make daily unlocks faster with **Quick Unlock** or a **PIN**, or make offline disk-theft attacks impossible by binding your vault to your **device security chip** or a **hardware security key**.

## Quick Unlock (biometrics and OS keychain)

**Quick Unlock** stores an unlock secret in your operating system's keychain, protected by your device's biometrics or OS unlock.

- **Turn it on:** Open **Settings -> General & Security** and enable **Quick Unlock**.
- **Linux note:** Quick Unlock requires a system Secret Service keyring (such as GNOME Keyring or KWallet). If it is missing, Baluard displays the install command for your distribution.
- **Shared-device warning:** Anyone whose biometrics are enrolled on the device, or who can unlock your OS user session, can open the vault when Quick Unlock is on.

## Unlock with PIN

You can set a **6-digit PIN** in **Settings -> General & Security** -> **Unlock with PIN** so you do not have to type a long master password on every unlock.

A PIN is less secure than your master password and protects only this local device. You will still need your master password after a full restart or if the PIN is disabled.

## Guard with this device's security chip

If your computer has a hardware security chip (such as Apple Secure Enclave or a TPM), you can bind your vault to it in **Settings -> General & Security** -> **Guard with this device's security chip**.

- **What it stops:** A stolen disk or offline backup alone cannot open your vault, even if an attacker knows your master password.
- **Confirm on every unlock:** Turn on **Confirm on every unlock** if you also want the chip to ask for your fingerprint or face every time the vault opens, stopping someone who knows your password from opening it on your machine.
- **Recovery:** If the device's security chip fails or biometrics are reset, use your [24-word recovery phrase](@/vault/recovery-phrase.md) to rejoin the vault.

## Guard with your security key

You can protect a vault with a physical FIDO2 security key (such as a YubiKey) in **Settings -> General & Security** -> **Guard with your security key**.

- **How it works:** Baluard asks you to touch the blinking key when enabling the guard and when unlocking. Opening the vault requires both your master password and the physical key, so a stolen disk or backup alone cannot be decrypted offline.
- **Recovery:** If you lose the security key, use your [24-word recovery phrase](@/vault/recovery-phrase.md) to regain access.
- **Mobile limit:** Vaults guarded by a hardware security key do not support mobile autofill on Android.

## Per-entry master password re-prompt

For especially sensitive entries (such as bank logins or recovery codes), you can turn on master password re-prompt when editing the entry. Baluard will ask you to confirm your master password before revealing or copying those fields, even while the vault is unlocked.
