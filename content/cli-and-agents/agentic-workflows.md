+++
title = "Agentic workflows with the CLI"
description = "Let AI coding agents and scripts run commands with your vault secrets without exposing secret values."
weight = 5
template = "page.html"

aliases = ["introduction/vault/agentic-workflows", "vault/agentic-workflows"]

[extra]
+++

Baluard lets AI coding agents and automation scripts use your credentials to run commands or render configuration files without ever seeing the plaintext secrets. The `baluard` CLI sends a reference request to `baluard-daemon`, which asks for your approval, spawns the command itself, injects the approved fields, and scrubs any leaked secret bytes from `stdout` and `stderr` before returning output.

## Discovering entries without secrets

Agents can search and list entry metadata (`id`, `name`, `type`, `username`) in JSON without decrypting any secrets:

```bash
baluard list --json
baluard search "Stripe" --json
```

## Secret references

References use `baluard://[vault/]item/field`:

- **Two segments (`baluard://GitHub/password`):** resolves `item` in the active vault by exact UUID, unique 4+ character hex prefix, or case-insensitive title.
- **Three segments (`baluard://work/GitHub/password`):** targets a specific vault by slug or display name.
- **Escaping:** encode `/` as `%2F` and `%` as `%25` inside a segment.
- **Allowed item types and fields:** `login`, `secure_note`, `card`, `identity`, `bank_account`, `drivers_license`, and `passport` (`username`, `password`, `totp` live code, `notes`, `custom:<name>`, and scalar string fields). SSH keys, signing keys, and private key fields are blocked.

If a title or prefix matches multiple entries, the CLI exits with code `2` and lists the candidate IDs so the caller can disambiguate.

## Common use cases

### 1. Pass credentials to a command (`baluard run --env`)

```bash
baluard run --env GH_TOKEN=baluard://GitHub/password --need "publish release" -- gh release create v1.0.0
```

Piped `stdin` is forwarded to the command (up to 1 MiB), `stdout` and `stderr` stream live with secrets scrubbed (raw, base64, percent-encoded, and JSON-escaped forms), and `SIGINT`, `SIGTERM`, and `SIGHUP` are forwarded to the child process group. Use `--timeout` (for example `--timeout 5m`, default `60s`, max `1h`) for longer builds or deploys.

### 2. Use a `.env.tpl` file or inherited environment variables

Put `baluard://` references alongside non-secret defaults in a template env file:

```dotenv
# .env.tpl
NODE_ENV=production
STRIPE_KEY=baluard://Stripe/custom:api_key
```

Run the command with one combined approval prompt:

```bash
baluard run --env-file .env.tpl --need "run integration tests" -- npm test
```

Precedence from lowest to highest: inherited environment variables whose values start with `baluard://`, `--env-file` entries in order, and `--env` flags.

### 3. Render a config file (`baluard inject`)

When a tool requires secrets inside a config file instead of environment variables, use `baluard inject`:

```bash
baluard inject -i config.tpl -o config.json --need "write local config"
```

Only `{% raw %}{{ baluard://... }}{% endraw %}` placeholders are replaced; other `{% raw %}{{ ... }}{% endraw %}` syntax (such as Helm or Jinja) is left intact. Output files are written atomically with mode `0600`. Baluard tracks injected files and refuses to overwrite a hand-edited target file unless you pass `--force`. Omit `-o` (or pass `-o -`) to write to `stdout`.

### 4. Read a single value in your own unlocked session (`baluard read`)

For interactive shell use when your vault is already unlocked:

```bash
baluard read baluard://GitHub/totp
```

## Approving requests (Desktop and headless CLI)

- **Desktop app:** When an agent runs `baluard run` or `baluard inject`, a credential approval dialog opens. If the vault is locked, the lock screen displays a banner noting the waiting agent; unlocking immediately opens the approval dialog.
- **Headless CLI (SSH or server):** Approve from another terminal where your vault is unlocked:

```bash
baluard agent pending
baluard agent approve <request_id>
baluard agent deny <request_id>
```

- **Grants and audit:** Approved grants are bound to the requesting process tree and expire after 15 minutes. You can inspect or revoke active grants with `baluard agent list` and `baluard agent revoke`.
- **Time-boxed auto-approval:** To temporarily skip prompts on this device (defaults to 5 minutes when `--duration` is omitted):

```bash
baluard agent auto-approve --on
baluard agent auto-approve --on --duration 30m
baluard agent auto-approve --on --yolo   # indefinite until --off
baluard agent auto-approve --off
```

## Exit codes

- `0`: success (for `baluard run`, returns the child exit code or `128 + signal`).
- `1`: entry not found or general error.
- `2`: ambiguous item reference (candidate list printed).
- `3`: vault is locked.
- `4`: request denied or expired.
- `5`: per-peer request rate limit exceeded.
