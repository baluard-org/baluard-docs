+++
title = "Import from Bitwarden"
description = "Move your Bitwarden vault to Baluard: export a plaintext .json, back up attachments, import, and re-attach your files."
weight = 3
template = "page.html"

[extra]
+++

Baluard imports the Bitwarden `.json` plaintext export: logins with URIs and match detection, TOTP seeds, notes, cards, identities, secure notes, SSH keys, custom fields, password history, favorites, and folders. Passkeys come across as view-only entries, because Bitwarden cannot export a passkey's private key; re-register those with the services that use them.

Encrypted Bitwarden exports (`.json (Encrypted)` and the mobile password-protected form) do not work. The import reads plaintext only. Bitwarden's `.csv` export also imports (`bw-csv`), but it is lossier, so prefer the `.json`.

## Export from Bitwarden

The export contains everything in your vault in readable form, so treat the file with care: never send it by email or chat, and delete it when you are done.

From the Bitwarden web app:

1. Select Tools, then Export.
2. Under Export from, select My vault.
3. Under File format, select `.json` (the plaintext one, not `.json (Encrypted)`).
4. Select Export and confirm with your master password.

From the command line, run `bw sync` first, then:

```sh
bw export --format json --output bitwarden.json
```

The CLI defaults to `.csv`, so the `--format json` flag matters.

## Back up your attachments first

Bitwarden attachments are not inside the `.json` export. Export them separately, or they stay behind.

From the same Export screen, run a second export with the `.zip (with attachments)` format. Unzip it somewhere safe and keep it until every attachment is re-attached in Baluard. The zip also carries a copy of the vault `.json`, so the folder works as a full pre-migration backup on its own.

## Import into Baluard

Import runs through the CLI against an unlocked vault. Start the Baluard desktop app and unlock your vault, then run:

```sh
baluard import bw-json bitwarden.json
```

The vault stays unlocked and running while the import lands; entries appear in the desktop app as they are created. Imports are capped at 50 MB, which covers most vaults many times over.

If you manage a vault without the desktop app, the same command works against a running `baluard-daemon` after `baluard unlock`.

## Re-attach your files

Open the unzipped attachment backup and add the files back by hand, one entry at a time. Match them to entries by name; Bitwarden stores attachments per item, and the `.json` keeps the item names intact.

## Delete the export

The plaintext `.json` and the unzipped attachment folder hold every secret you own in readable form. Delete both when the migration is done, and empty the trash of your file manager so the file is really gone. Keep the zip only if you want a long-term Bitwarden-format backup; it is as sensitive as the vault itself.
