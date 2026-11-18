+++
title = "Connect the CLI to an existing vault"
description = "First run of the Baluard CLI: start the daemon, connect a git provider, clone your vault, enroll the machine, and set up the SSH agent."
weight = 9
template = "page.html"
aliases = ["introduction/connect-existing-vault"]

[extra]
+++

This page walks the first run of the `baluard` CLI on a new machine against a vault that already exists on a git provider. You need three things before you start: the CLI installed, your master password, and the 24-word recovery phrase of the vault. The recovery phrase is required because a new machine has no key in the vault yet, and the master password alone cannot add one. This is the second factor for disaster recovery.

## Start the daemon

The CLI talks to a daemon on this machine. The daemon serves the vault sessions and the SSH agent endpoint. Start it once:

```bash
baluard ssh serve
```

On Linux this launches the daemon as a systemd user service for the session. On macOS and Windows it starts a detached process that logs to the baluard state directory. To make the daemon permanent, install the service instead:

```bash
baluard ssh install
```

`baluard ssh install` writes and enables a systemd user unit. It starts the daemon now and on every boot. To reverse it, run `baluard ssh uninstall`. You can check the state at any time:

```bash
baluard ssh status
```

## Connect your git provider

The CLI reads the provider account from a one-time connection. The connection uses your browser:

```bash
baluard provider connect github
```

Type the short code shown on screen at github.com/login/device. Confirm with `baluard provider status github`. GitLab and Codeberg work the same way.

## Clone your vault

List the vaults your account can see, then clone the one you want:

```bash
baluard provider vault-repos github
baluard sync clone github owner/baluard-vault
```

Replace `owner/baluard-vault` with the repository name from the list. A vault repository carries a marker inside, so `vault-repos` lists only real Baluard vaults, not every repository on the account.

The clone lands under `~/.local/share/baluard/vaults/` with a local name, the slug. The slug is the name you use in `--vault` flags on this machine. It can differ from the repository name.

## Enroll this machine

A fresh clone has no key for this machine, so it cannot unlock yet. Enroll it with the recovery phrase:

```bash
baluard device enroll-with-phrase --vault baluard-vault
```

Enter the 24 words when asked, then confirm, then enter the master password. Enrollment writes a new device key and seals it with your master password. The vault on your other devices is not touched, and nothing replaces their keys.

## Unlock and sync

Unlock with your master password, then send the enrollment to the provider so your other devices see this machine:

```bash
baluard unlock --vault baluard-vault
baluard sync push --vault baluard-vault
```

Keep using the same command shape after an unlock: if you unlocked with `--vault`, pass the same flag to the commands that follow, or unlock once without the flag to work against the active vault.

## Check the vault

```bash
baluard list --vault baluard-vault
baluard sync status --vault baluard-vault
```

`list` shows your entries. `sync status` compares this clone with the provider and reports pending changes. After an unlock, the same commands usually work without the flag too: the CLI keeps the session for plain commands when the system keyring is available. Passing the flag always works.

## Set up the SSH agent

The daemon serves your vault SSH keys on an agent endpoint. Keys serve only when three things hold: the vault is unlocked, the SSH agent switch is on for this machine, and the key entry has "Serve via SSH agent" marked. Mark keys in the desktop app, or add new keys from the CLI with `--serve-via-agent`. Marked keys changed on another device arrive here with `baluard sync pull`.

Turn the switch on for this machine (it asks for the master password again):

```bash
baluard ssh policy --enable
```

`baluard ssh policy` alone prints the current state. By default every signature asks for approval in the desktop app; add `--auto-approve` if you want git to sign without asking.

Show the endpoint on this machine:

```bash
baluard ssh status
```

Point OpenSSH at it for one shell (Linux):

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/baluard/baluard-agent.sock"
```

Or persist for one host in `~/.ssh/config` (Linux path shown):

```
Host github.com
    IdentityAgent /run/user/1000/baluard/baluard-agent.sock
    IdentitiesOnly yes
```

Replace `1000` with your user id (`id -u`). On macOS, run `baluard ssh status` and copy the lines it prints: the path is `~/Library/Application Support/baluard/baluard-agent.sock` and needs quotes around it. Then check the agent lists your keys:

```bash
ssh-add -l
```

An empty list with an unlocked vault means the switch is off or no key is marked. `Could not open a connection` means the daemon is down or the socket path is wrong: run `baluard ssh status` and copy the lines it prints. The [SSH agent](@/introduction/sync/ssh-agent.md) page covers the failure cases in detail.

## Keep the daemon running

`baluard ssh serve` starts the daemon for this session. After a reboot the daemon is down until something starts it. Run `baluard ssh install` once to start it at every boot, or start it by hand with `baluard ssh serve` when you need it.
