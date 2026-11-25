+++
title = "Everyday vault tools"
description = "Switch between multiple vaults, use the password generator, run a security check, and understand Baluard's entry types."
weight = 16
template = "page.html"

[extra]
+++

Once your vault is set up, Baluard gives you multi-vault switching, nine structured entry types, a built-in password and passphrase generator, and an on-demand security check.

## Multi-vault switching and merged view

If you keep both a personal vault and one or more Shared Spaces, use the vault switcher at the top of the sidebar to move between them.

Each registered vault shows one of three states:

- **Unlocked (green dot):** Keys are in memory. Clicking it switches immediately.
- **Locked (amber dot):** Registered and open in the daemon, but locked. Clicking it prompts for that vault's master password.
- **Closed (gray dot):** Registered on disk, not loaded in memory. Clicking it opens and unlocks it.

### Merged view across open vaults

When multiple vaults are unlocked at the same time, Baluard merges entries from your other unlocked vaults into the main list and search results (excluding **Trash**, **Archive**, and the **No folder** filter). Entries from another vault stay labeled with their source vault so you can search across personal and shared vaults without switching every time.

### Closing vs. detaching a vault

- **Close:** Unloads the vault from memory and zeroizes its keys while keeping it in your vault switcher list.
- **Detach:** Removes the vault from Baluard's registry. By default, the vault folder stays on disk so you can re-attach it later; deleting from disk requires explicit confirmation inside the detach dialog.

## Entry types

Baluard supports nine entry types:

- **Login:** Username, password, website URIs, live TOTP two-factor codes, passkeys, and custom fields.
- **Card:** Cardholder name, brand, card number, expiration month/year, and security code.
- **Identity:** Name, title, company, email, phone, and mailing address fields.
- **Secure Note:** Markdown-capable encrypted notes.
- **SSH Key:** Public key, private key, fingerprint, and opt-in SSH agent toggle.
- **Signing Key:** Cryptographic signing key metadata and material.
- **Bank Account:** Account holder, routing/account numbers, and bank details.
- **Driver's License:** License number, issuing authority, and dates.
- **Passport:** Passport number, nationality, and issue/expiration dates.

## Password generator

Open the **Password Generator** from the toolbar or directly from the password field while adding or editing an entry:

- **Password mode:** Set character length (default `16`) and toggle uppercase letters, numbers, and symbols.
- **Passphrase mode:** Set word count (default `5`), word separator (default `-`), and optional capitalization, number, or symbol.
- **History:** Copying a generated value or clicking **Regenerate** saves it to the vault's generator history so you can recover a value you just generated. Open the history panel to copy earlier entries or clear the list.

## Security check

Run an on-demand audit of your vault passwords in **Settings -> General & Security -> Security check -> Run check**.

Baluard scans the active vault locally and groups findings into three categories:

- **Weak passwords:** Passwords that are too short, common, use a single repeated character, or follow simple sequences.
- **Reused passwords:** Passwords shared across multiple entries.
- **Old passwords:** Passwords that have not been rotated in a long time.

If everything passes, Baluard reports that no issues were found.
