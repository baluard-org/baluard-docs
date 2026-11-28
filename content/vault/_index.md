+++
title = "Your vault"
description = "Bring data in, keep files inside entries, and guard the recovery phrase."
weight = 4
sort_by = "weight"
template = "section.html"

[extra]
+++

Everything in Baluard lives in one encrypted vault file tree that only your devices can read. This section covers bringing data in from Bitwarden, storing file attachments, and protecting the one secret that can rebuild the vault.

1. [Import from Bitwarden](@/vault/importing-from-bitwarden.md): move an existing Bitwarden vault, attachments included.
2. [Attachments](@/vault/attachments.md): the 2 MB per-file limit and how reclaiming space works.
3. [Your 24-word recovery phrase](@/vault/recovery-phrase.md): why it is your safety net in case of catastrophe and how to store it forever.
4. [Recover a vault without your password](@/vault/recover-without-password.md): locked out? Get back in with the 24-word phrase.
5. [Passkeys in your browser](@/vault/passkeys.md): sign in to sites with the passkeys stored in your vault.
6. [Find logs for bug reports](@/vault/logs-for-bug-reports.md): where `daemon.log` lives on Windows, Linux, and macOS.
7. [Legacy Contact](@/vault/legacy-contact.md): hand a trusted person a read-only recovery kit that opens only after you stop unlocking your vault.
8. [Browser extension](@/vault/browser-extension.md): connect Chrome or Firefox to your desktop app to autofill logins, copy codes, and use passkeys.
9. [Quick unlock and hardware protection](@/vault/quick-unlock-and-hardware-protection.md): unlock with biometrics or a PIN, or guard your vault with a security chip or hardware key.
10. [Device management](@/vault/device-management.md): enroll additional devices and revoke lost or stolen ones.
11. [Exporting and offline backups](@/vault/exporting-and-backups.md): create encrypted `.bldbak` backups or export vault data.
12. [MCP agents in the desktop app](@/vault/mcp-agents.md): pair coding agents in Settings, manage approvals, and revoke tokens.
13. [Everyday vault tools](@/vault/everyday-vault-tools.md): multi-vault switching, entry types, password generator, and security check.
14. [Scheduled backups on Unraid](@/vault/unraid-backup-server.md): run the baluard-unraid container on your NAS to snapshot your vaults to a share on a schedule.
15. [Migrate to another password manager](@/vault/migrate-from-a-backup.md): turn a backup zip into a plaintext export with the `backup-extract` command.
