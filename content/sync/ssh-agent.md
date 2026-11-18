+++
title = "The SSH agent"
description = "Let terminal tools and git sign with your vault's SSH keys on Linux, macOS, and Windows."
weight = 4
template = "page.html"

aliases = ["introduction/sync/ssh-agent"]

[extra]
+++

Your vault can store SSH key pairs, but a stored key does not sign anything by itself. Baluard ships an SSH agent that speaks the standard agent protocol from the daemon: terminal tools and git can request signatures with your vault keys while the private keys never leave the vault. This page covers turning it on and pointing your system at it.

## Turn it on

Two switches control the agent, and both start off:

- **Settings, "SSH agent":** the master switch for this device. It is device-local on purpose: turning it on here does not turn it on on your other machines.
- **"Serve via SSH agent" on each SSH key entry:** only marked keys are ever served. This flag lives in the entry itself and syncs with your vault.

From the terminal, the master switch has its own command:

```bash
baluard ssh policy --enable
```

This asks for the master password again: turning the agent on for a device is a gated change. `baluard ssh policy` alone prints the current state as JSON. Add `--auto-approve` to sign without asking on every use, or `--no-auto-approve` to go back to asking. With approval on, every signature request names the entry that wants to sign and waits for your decision in the desktop app; if nobody answers in time, the requesting side sees the signature fail.

Mark keys for serving in the desktop app (new keys can also take `--serve-via-agent` when you add them from the CLI). A flag changed on another device reaches this machine with the next `baluard sync pull`; the agent picks it up on the next request, no restart needed.

A third toggle, "Approve signing automatically", skips the approval prompt. It starts off: with it off, every signature request pops up in the desktop app and names the entry that wants to sign. You approve or deny from there, and a denied or expired request fails on the requesting side.

## Manage the daemon from the CLI

The endpoint exists while the daemon runs. The CLI starts it and wires the machine for you:

```bash
baluard ssh status
baluard ssh serve
baluard ssh install
```

`status` prints the endpoint path and the exact `SSH_AUTH_SOCK` and `IdentityAgent` lines for this machine. `serve` starts the daemon on demand. `install` writes an opt-in systemd user unit so the daemon starts at boot. The full first-run walk-through, including pointing a new machine at an existing vault, is on [Connect the CLI to an existing vault](@/install/connect-existing-vault.md).

## Point your tools at the agent

The agent answers on a socket named `baluard-agent.sock` next to Baluard's own socket. Tools that read `SSH_AUTH_SOCK`, git included, sign through Baluard once it points there.

On Linux:

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/baluard/baluard-agent.sock"
```

On macOS:

```bash
export SSH_AUTH_SOCK="$HOME/Library/Application Support/baluard/baluard-agent.sock"
```

Put the matching line in your shell's startup file (`~/.bashrc`, `~/.zshrc`) so every new terminal picks it up.

Prefer to keep your system agent for everything except one host? Add an `IdentityAgent` line in `~/.ssh/config` instead:

```
Host github.com
    IdentityAgent /run/user/1000/baluard/baluard-agent.sock
    IdentitiesOnly yes
```

Replace `1000` with your user id (check with `id -u`). The stanza needs the literal path because ssh_config does not expand environment variables, so the `$XDG_RUNTIME_DIR` form from the export above does not work here. On macOS the path is the one from the export above, quoted because of the spaces: `IdentityAgent "~/Library/Application Support/baluard/baluard-agent.sock"`. The two setups coexist: the system agent keeps serving its own keys, and the `Host` stanza routes Baluard's keys for that host only.

Coming from another agent manager that used a fixed socket path? A symlink from the old path to the Baluard socket keeps the existing config working without touching every stanza:

```bash
ln -s "$XDG_RUNTIME_DIR/baluard/baluard-agent.sock" ~/.ssh/agent.sock
```

## Windows

Windows needs no pointing: Baluard serves the same named pipe that Windows OpenSSH clients look at (`\\.\pipe\openssh-ssh-agent`), so `ssh`, `ssh-add`, and git sign through Baluard as soon as the switch is on. The pipe exists while the daemon runs; it leaves nothing behind when Baluard exits.

Only one program can own the pipe at a time. Windows ships its own OpenSSH Authentication Agent service, and it is disabled by default, so most machines need nothing. If Baluard's key list is empty and the service is running, set its startup type to Disabled: open Services, pick OpenSSH Authentication Agent, set Startup type to Disabled, and restart the Baluard app.

Git for Windows ships its own ssh that ignores the pipe. Point git at the Microsoft OpenSSH client once and agent signing works everywhere:

```bash
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

There is no per-key `IdentityAgent` choice on Windows: Baluard's keys and the keys of any other running agent share the one pipe, and the agent that owns it serves them all.

## Check that it works

```bash
ssh-add -l
```

With the master switch on and at least one key marked, this lists the fingerprints of your vault keys. What the command answers tells you where to look:

- **`The agent has no identities.`** The switch is off or no key is marked. Check with `baluard ssh policy`, mark the keys, and pull if the marks were changed on another device.
- **`Could not open a connection to your authentication agent.`** The daemon is down or `SSH_AUTH_SOCK` points somewhere else. Run `baluard ssh status` and copy the export line it prints.
- **A signature failure on sign, with the list working.** The vault locked in the meantime, or an approval request expired unanswered.

A host that authenticates with some keys but not one specific key usually pins that key in `~/.ssh/config` with `IdentitiesOnly yes`. If the pinned key is missing from `ssh-add -l`, its Serve flag is off: mark it, run `baluard sync pull`, and the next attempt offers it. Then try the real thing against your provider:

```bash
ssh -T git@github.com
```

## Limits worth knowing

- The vault must be unlocked. A locked vault refuses to list keys or sign.
- Keys with encrypted private material are refused outright: the agent never prompts for a passphrase.
- Approval prompts are device-local: a request is approved on the machine that signs.
