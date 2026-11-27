+++
title = "Scheduled backups on Unraid"
description = "Run the baluard-unraid container on your Unraid server to back up your vaults to a share on a schedule."
weight = 15
template = "page.html"

[extra]
+++

Your vault syncs to a git repository, but the sync only happens when one of your devices is online. The baluard-unraid container pulls your vaults from the git remote on a schedule and keeps snapshots on an Unraid share, even when every computer and phone is offline. It runs on the NAS itself: install the container once, add one small config file per vault, and forget about it.

The image and the full configuration reference live at [github.com/baluard-org/baluard-unraid](https://github.com/baluard-org/baluard-unraid).

## What you need

- An Unraid server (the container is amd64).
- Your vault synced to GitHub, GitLab, or Codeberg.
- A read-only token the container can clone with. On GitHub, create a fine-grained personal access token with **Contents: read** on the vault repositories. Nothing more.

## Install the container

1. Download `template/baluard-unraid.xml` from the repository and copy it to your Unraid flash drive as `/boot/config/plugins/dockerMan/templates-user/my-baluard-unraid.xml`.
2. In the Unraid **Docker** tab, **Add Container** and pick the `my-baluard-unraid` template.
3. Map the two paths:
   - `/config` to `/mnt/user/appdata/baluard-unraid` (config, vault clones, logs).
   - `/backups` to the share where the snapshots should land, for example `/mnt/user/backups`.
4. Set **Git Token** to the read-only token from the step above, and **Timezone** to yours, so the schedule runs when you expect.
5. Apply. The container needs no ports and no web UI.

## Add a vault

Create one `.env` file per vault in the `vaults.d` folder of the appdata directory. This is the smallest useful example:

```ini
VAULT_URL=https://github.com/you/baluard-family.git
```

That is it: the default format is a zip of the vault folder, scheduled daily at 03:00, keeping the last 5 snapshots in `/backups/<repo-name>/`. The next scheduled run picks the file up; no restart needed.

A fuller example with every option lives in [`config/vaults.d.example/`](https://github.com/baluard-org/baluard-unraid/tree/main/config/vaults.d.example) in the repository.

## Backup formats

Each vault picks its format with `VAULT_FORMAT`:

| Format | What lands on the share | Master password needed | Restore |
| --- | --- | --- | --- |
| `zip` (default) | Zip of the vault folder, git history included | No | Unzip, then open the folder with Baluard |
| `bldbak` | Encrypted export, restorable into any Baluard vault | Yes | Import the file, enter the backup passphrase |
| `json` | Plaintext export of all entries | Yes | Import the file |

The content of your vault is encrypted at rest, which is why `zip` never needs your master password: the container only ever handles encrypted bytes. We recommend leaving `zip` as the format unless you have a specific reason.

Two honest warnings:

- `bldbak` and `json` need the master password in the config file, and the first run against a fresh clone also needs the [24-word recovery phrase](@/vault/recovery-phrase.md) once, because the backup box enrolls as a device of the vault. After that first run, only the master password is used.
- `json` writes readable passwords to the share. Anyone who can read the share can read them. Avoid this format unless you understand and accept it.

## Schedule and retention

The container-level schedule is `daily` (03:00), `weekly` (Sundays 03:00), `monthly` (1st, 03:00), or any custom cron expression through `BALUARD_CRON`. A vault can follow its own cadence with `VAULT_SCHEDULE`.

Retention keeps the newest N snapshots per vault, 5 by default, configurable with `BALUARD_RETENTION` or per vault with `VAULT_RETENTION`. Cleanup only ever deletes files the container created, named `<repo-name>-<date>-<time>.ext`, inside the vault's own folder.

## Restore a snapshot

**From a zip:** unzip it on any machine and open the folder with Baluard (`baluard open <folder>`, or through the desktop app). The zip carries the vault's git history, so nothing is lost.

**From a `.bldbak`:** import it through **Settings -> Data Import / Export** in the desktop app with the backup passphrase, exactly like any other encrypted backup.

**From a JSON export:** import it the same way. It contains readable entries, so treat the file as sensitive while it exists.

## Updates and failures

With the default `BALUARD_AUTO_UPDATE=true`, the container checks the official Baluard releases before each run and updates its copy of the CLI in place, checksum-verified against the release signatures. The image tag acts as the version floor.

If a vault fails, the others still run, the job exits non-zero, and with `BALUARD_WEBHOOK_URL` set the container sends a `{vault, status, time}` JSON message to your webhook (Discord, Slack, ntfy, or anything that accepts JSON). Logs are in `docker logs` and in `/config/logs`.

## Security notes

- The default `zip` mode stores no master password anywhere. The container cannot read a single entry; it archives encrypted bytes.
- If you use `bldbak` or `json`, keep the permissions of the `.env` files tight (600): they hold the master password, and optionally the recovery phrase.
- The image verifies the Baluard CLI download against the official release `SHA256SUMS` at build time, and every update against the same signatures.
- Snapshots on the share are only as private as your network and share settings. The git remote is already the first copy of your vault; treat these snapshots as the second, and consider a third (cloud or cold storage) for anything that truly matters.
