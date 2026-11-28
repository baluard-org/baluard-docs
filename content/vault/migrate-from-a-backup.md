+++
title = "Migrate to another password manager"
description = "Turn a backup zip and your 24-word recovery phrase into a plaintext export, without installing Baluard or restoring the vault."
weight = 16
template = "page.html"

[extra]
+++

Moving away from Baluard used to mean installing the app, restoring a backup, and exporting by hand. The `backup-extract` command shortens that to one step: give it a backup zip, and it writes every entry and every attachment as plaintext files that other password managers can import. It never touches your vault, never joins anything, and never touches the network.

## What you need

- A backup zip of the vault. This can be a snapshot from the [Unraid backup box](@/vault/unraid-backup-server.md) or any zip of the vault folder, including a `mirror` snapshot.
- Your [24-word recovery phrase](@/vault/recovery-phrase.md). The backup carries no device keys, so the phrase is the only way to open it on a fresh machine.
- Your master password. The command verifies it when the backup carries the check that allows it, so a leaked password alone is never enough to open a stolen backup.
- The Baluard command-line tool (`baluard`). On Linux it ships with the app packages; on other systems, download the CLI archive from the [releases page](https://github.com/baluard-org/baluard/releases).

An encrypted `.bldbak` file alone is not enough: it stores entry metadata but no attachment files. Extract from a zip of the vault folder instead.

## Run the extract

```bash
baluard backup-extract baluard-vault-20261128-030000.zip --out migrated/
```

The command asks for the recovery phrase and the master password, then writes the output folder. For scripts, the `BALUARD_RECOVERY_PHRASE` and `BALUARD_PASSWORD` environment variables answer the prompts, with the usual warning that environment variables can be read by other processes on the machine.

## What you get

- `entries.json` — every entry, structured so most password managers import it directly. If yours has no generic JSON import, its Bitwarden import option reads this same format.
- `attachments/` — every attachment file, decrypted, grouped by entry.
- `manifest.json` — counts and SHA-256 checksums for every file, so you can verify the copy.
- `README.txt` — the same plaintext warning this page gives, in the folder itself.

Import `entries.json` in the other app, check a few entries, and you are done.

## Delete the plaintext copy

The output folder holds your passwords in readable form. After importing elsewhere:

1. Check a few entries in the new app.
2. Delete the output folder, and empty the trash if the desktop keeps one.
3. Keep the backup zip itself. It is encrypted, it is your copy, and future versions of Baluard can always extract from it again.

## Notes

- The extract is fully offline. No account, no sync, no server contact of any kind.
- The command never enrolls the machine as a vault device and never writes to the backup, so using it on a backup of a vault you do not own leaves no trace anywhere.
- The output folder and every file in it are created readable only by your user (mode 0700/0600).
- The `backup-extract` command ships in the next Baluard release; the rest of this page describes it as it will behave there.
