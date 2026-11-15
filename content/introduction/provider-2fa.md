+++
title = "Two-factor authentication (2FA) and your git provider"
description = "Why 2FA belongs on your git provider (GitHub, GitLab, or Codeberg), not inside your Baluard vault."
weight = 7
template = "page.html"

[extra]
+++

If you sync your Baluard vault using one of the supported providers—**GitHub**, **GitLab**, or **Codeberg**—turn on **two-factor authentication (2FA)** on that git account.

In Baluard, 2FA for your remote backup lives on your **git service**, not inside the vault itself.

## Why 2FA is not inside the vault

With traditional cloud password managers, a company server stores your vault and checks a 6-digit code before letting you download it.

Baluard works differently:

- There is no Baluard server. Your vault lives as encrypted files on your own devices.
- Unlocking the vault already requires two things: **your master password** (something you know) and **your enrolled device**—or your [24-word recovery phrase](@/introduction/recovery-phrase.md) in an emergency—(something you have).
- Putting a 6-digit 2FA code inside a local vault would not add real security. Anyone who already has both your device and your master password can unlock everything on that device anyway.

Because there is no Baluard server, there is no remote login to protect with a 6-digit code inside the app.

## Why your git provider needs 2FA

When you turn on sync, your git provider stores a copy of your encrypted vault repository. Even though your provider cannot read your passwords (everything is encrypted before it leaves your device), protecting your git account with 2FA still matters:

- **Prevent deletion:** Someone who breaks into your GitHub, GitLab, or Codeberg account could delete your vault repository and wipe out your remote backup.
- **Stop offline guessing:** An attacker with access to your git account could download your encrypted files and try to guess your master password offline.
- **Keep control of your account:** Without 2FA, a leaked or reused password on your git provider is enough for someone to take over the account that hosts your backups.

## How to set it up

1. Sign in to the git provider you chose (**GitHub**, **GitLab**, or **Codeberg**).
2. Open your account **Security** settings and enable **Two-factor authentication (2FA)**.
3. Use an **authenticator app** (or a **hardware security key** / passkey) rather than SMS whenever possible.
4. Save your git provider's **recovery codes** in a safe place offline—just like your [24-word recovery phrase](@/introduction/recovery-phrase.md)—so you never get locked out of your backup host if you lose your phone.

For a deeper comparison of supported hosts, see [Choosing a git provider](@/introduction/git-providers.md).
