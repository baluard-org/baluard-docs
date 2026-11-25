+++
title = "Exporting and offline backups"
description = "Create encrypted backups (.bldbak) or export your vault data for migration, printing, or offline storage."
weight = 13
template = "page.html"

[extra]
+++

Your vault already syncs to your git repository or synced folder, but keeping an offline export lets you store a cold backup on a USB drive, print emergency credentials, or move your data to another tool.

## Export formats

Open **Settings -> Data Import / Export** and choose one of three options under **Export Vault Data**:

- **Encrypted backup (`.bldbak`):** Password-protected archive of your vault. Baluard generates or lets you set a dedicated backup passphrase. This passphrase is the only way to open the `.bldbak` file (it is separate from your master password and Baluard never stores it).
- **Baluard backup (JSON):** Plaintext export of everything in your vault for full backup or moving between devices.
- **Spreadsheet (`.csv`):** Logins only, useful for printing or importing into spreadsheet tools and other apps.

## Store an encrypted backup safely

1. Under **Export Vault Data**, select **Encrypted backup**.
2. Save or write down the backup passphrase somewhere safe (for example, alongside your [24-word recovery phrase](@/vault/recovery-phrase.md)).
3. Confirm **I saved this passphrase somewhere safe** and save the `.bldbak` file to your offline drive or backup location.

If you ever need to restore from an encrypted backup, open **Settings -> Data Import / Export**, choose **Encrypted backup (`.bldbak`)** as the import source, and enter the backup passphrase you saved when creating it.

## Plaintext exports (JSON and CSV)

Plaintext JSON and CSV files contain your passwords in readable form. If you export in plaintext:

- Never send the file over email, chat, or unencrypted cloud storage.
- Delete the plaintext file from your Downloads or Desktop folder as soon as you finish moving or printing it.

## Shared Space limits

In a **Shared Space**, **Viewers** cannot export a copy of the vault unless an admin turns on **Let viewers export** in Space settings.
