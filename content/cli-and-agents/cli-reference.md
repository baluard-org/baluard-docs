+++
title = "Everyday CLI vault reference"
description = "Create, unlock, search, edit, sync, and manage vaults and entries from the terminal with baluard."
weight = 3
template = "page.html"

[extra]
+++

The `baluard` CLI gives you full vault access from the terminal. Use it to create or switch vaults, add and search entries, copy two-factor codes, generate passwords, and run sync or health checks.

## Daemon mode vs. `--direct`

By default, `baluard` talks to `baluard-daemon` over a Unix socket so your unlocked session stays in memory across commands. Pass `--direct` to bypass the daemon and call the core vault library directly against a vault directory.

Global flags available on all commands:

- `--vault <slug>`: target a specific registered vault by slug.
- `--vault-path <path>`: vault directory path when using `--direct` (defaults to the current directory `.`).
- `--direct`: run without `baluard-daemon`.
- `--socket <path>`: override the daemon Unix socket path.

## Create, unlock, and switch vaults

```bash
baluard init --name "Personal" --profile desktop-std
baluard unlock
baluard lock
```

`baluard init` accepts `--profile` (`mobile-low`, `desktop-std`, or `desktop-high`), `--slug`, `--auto-lock <minutes>`, `--theme`, `--lang`, and `--family` (creates a Shared Space).

Manage multiple registered vaults with `baluard vaults`:

```bash
baluard vaults list
baluard vaults switch work
baluard vaults set-default personal
baluard vaults close work
baluard vaults add /path/to/vault
baluard vaults detach work
```

- `switch` changes the active vault in the running daemon (prompting for the master password if that vault is locked).
- `close` removes a vault from the daemon's in-memory map and zeroizes its keys without unregistering it.
- `detach` removes the vault from Baluard's registry while leaving files on disk (pass `--delete-from-disk` only if you want to erase the directory permanently).

## Add, search, read, and edit entries

### Add entries

Use `baluard add <type>` for `login`, `card`, `secure-note` (alias `note`), `identity`, `ssh-key` (alias `ssh`), `bank-account`, `drivers-license`, `passport`, and `json` (raw JSON):

```bash
baluard add login --name "GitHub" --username "ada" --uri "https://github.com"
baluard add note --name "Wi-Fi" --notes "Guest network"
baluard add card --name "Company Card" --brand "Visa" --exp-month "08" --exp-year "2028"
baluard add ssh --name "Deploy key" --serve-via-agent
```

When `--password` or `--private-key` is omitted on `add login` or `add ssh`, the CLI prompts interactively so secrets do not sit in shell history.

### List, search, and read

```bash
baluard list
baluard list --archived --json
baluard search "GitHub"
baluard search "GitHub" --all
baluard get "GitHub" --decrypt
baluard totp "GitHub"
```

- `baluard list` and `baluard search` return entry metadata (`id`, `name`, `type`, `username`). Pass `--all` on `search` to search every unlocked vault, or `--vault <slug>` to search one specific vault.
- `baluard get <id-or-name> --decrypt` prompts for your master password and prints the decrypted entry.
- `baluard totp <id-or-name>` prints the live 2FA code for an entry that has a TOTP seed.

### Edit, organize, and remove

```bash
baluard edit <id> --name "GitHub Work" --favorite true --tags "work,dev"
baluard archive <id>
baluard unarchive <id>
baluard delete <id>
```

Use `baluard folder` and `baluard tag` to manage folders and tags, `baluard trash` to inspect or restore deleted items, and `baluard attachment` for file attachments.

## Password generator and health check

Generate a random password or Diceware-style passphrase without leaving the terminal:

```bash
baluard generate password --length 24
baluard generate password --length 20 --no-symbols
baluard generate passphrase --words 6 --sep "-"
```

When a vault is unlocked, generated values are added to generator history just like in the desktop app.

Run a password health check on the active vault to flag weak, reused, or old passwords:

```bash
baluard health
```

## Sync from the CLI

```bash
baluard sync status
baluard sync pull
baluard sync push
baluard sync commit
baluard sync log --limit 10
```

You can also connect a remote with `baluard sync remote <url>` or `baluard sync remote --folder <path>`, and clone an existing vault with `baluard sync clone <provider> <owner/repo>` or `baluard sync clone-url <url>`.

## Next

- [Agentic workflows with the CLI](@/cli-and-agents/agentic-workflows.md): inject secrets into commands and config files without exposing them.
- [MCP server (`baluard mcp`)](@/cli-and-agents/mcp-server.md): expose read-only vault lookups to coding tools over stdio or HTTP.
