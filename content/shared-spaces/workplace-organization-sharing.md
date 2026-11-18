+++
title = "Workplace and organization sharing"
description = "Department folders, role-based access, multi-admin approvals, and offboarding in a zero-server organization vault."
weight = 3
template = "page.html"

[extra]
+++

An **Organization Space** lets a company or team manage shared credentials in a private git repository you control, with no third-party SaaS vault server and no per-seat cloud lock-in.

**Heads up: everyone in this Space needs an account on the same git provider for this vault.**

## Access control without a central server

- **Department and project folders (collections):** Organize credentials into folders such as `Engineering`, `Production`, `Finance`, or `Marketing`. Editors and Viewers only receive cryptographic keys for the folders they are granted. **Important:** Admins and the Owner can decrypt all folders in the Space; folder-level isolation restricts Editors and Viewers, not Admins.
- **Roles:**
  - **Owner:** Full control over the Space, ownership transfer, and destructive actions.
  - **Admin:** Manages members, folders, and member join approvals.
  - **Editor:** Creates and updates entries in granted folders.
  - **Viewer:** Reads entries in granted folders without write permissions.
- **Signed history:** Every commit in the Space repository is signed by an authorized member device and verified by peers on pull.

## Multi-admin safeguards and continuity

- **Quorum approvals:** Organization Spaces can require multiple admins to approve sensitive changes (such as removing an admin or changing Space governance), preventing one compromised account from taking over unilaterally.
- **Space Recovery Kit:** Store the Space Recovery Kit (a dedicated 24-word offline phrase for the Space) safely offline according to your company's continuity policy. Recovery requires both this kit phrase and read access to the Space's Git repository. If an admin leaves or ownership changes, Baluard reissues a new kit phrase that must be recorded again.
- **Provider 2FA and scoped tokens:** Require [two-factor authentication (2FA)](@/sync/provider-2fa.md) on every member's git provider account. For organization deployments, prefer fine-grained tokens or a GitHub App over classic personal access tokens with broad `repo` scope.

## Honest expectations for offboarding

Because Baluard has no central server:

- **Reads happen locally:** Once a member decrypts an entry on their device, there is no server-side read audit log, and revoking them later cannot erase what they already copied.
- **Offboarding checklist:**
  1. Remove the member from the Space and revoke their collaborator seat on your git provider.
  2. Rotate keys on all folders they could access.
  3. **Rotate the underlying passwords, API keys, and tokens** stored in those folders.
