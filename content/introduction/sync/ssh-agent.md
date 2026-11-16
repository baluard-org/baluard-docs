+++
title = "The SSH agent"
description = "Let terminal tools and git sign with your vault's SSH keys on Linux and macOS."
weight = 4
template = "page.html"

[extra]
+++

Your vault can store SSH key pairs, but a stored key does not sign anything by itself. Baluard ships an SSH agent that speaks the standard agent protocol from the daemon: terminal tools and git can request signatures with your vault keys while the private keys never leave the vault. This page covers turning it on and pointing your system at it. The agent socket is a Unix feature today, so this page is Linux and macOS; Windows is covered in the limits below.

## Turn it on

Two switches control the agent, and both start off:

- **Settings, "SSH agent":** the master switch for this device. It is device-local on purpose: turning it on here does not turn it on on your other machines.
- **"Serve via SSH agent" on each SSH key entry:** only marked keys are ever served. This flag lives in the entry itself and syncs with your vault.

A third toggle, "Approve signing automatically", skips the approval prompt. It starts off: with it off, every signature request pops up in the desktop app and names the entry that wants to sign. You approve or deny from there, and a denied or expired request fails on the requesting side.

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

Replace `1000` with your user id (check with `id -u`). On macOS the path is the one from the export above, quoted because of the spaces: `IdentityAgent "~/Library/Application Support/baluard/baluard-agent.sock"`. The two setups coexist: the system agent keeps serving its own keys, and the `Host` stanza routes Baluard's keys for that host only.

## Check that it works

```bash
ssh-add -l
```

With the master switch on and at least one key marked, this lists the fingerprints of your vault keys. An empty list or a failure usually means the vault is locked or a switch is off. Then try the real thing against your provider:

```bash
ssh -T git@github.com
```

## Limits worth knowing

- The vault must be unlocked. A locked vault refuses to list keys or sign.
- Keys with encrypted private material are refused outright: the agent never prompts for a passphrase.
- Approval prompts are device-local: a request is approved on the machine that signs.
- Windows: the agent socket is not available yet. You can export a key from its entry (Show private key) and load it into Windows' own OpenSSH agent service with `ssh-add`.
