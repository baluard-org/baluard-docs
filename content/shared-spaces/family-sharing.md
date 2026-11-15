+++
title = "Family sharing"
description = "One shared household vault for guardians, partners, and children, with separate visibility for shared and private items."
weight = 1
template = "page.html"

[extra]
+++

A **Family Space** gives your household one shared vault without forcing everyone to see everything. Streaming accounts, Wi-Fi passwords, and utility bills live in one place, while sensitive guardian records stay hidden from children.

## How a Family Space is organized

- **Guardians (Admins):** Adults who manage the Space, invite or remove members, approve member joins, and can access all folders, including guardian-only ones.
- **Children and other members (Editors or Viewers):** Members who see the **Shared** folder plus any personal folder created for them, without seeing guardian-only items (like household finances or tax logins). Children can also be marked with the **Minor** flag, which prevents them from claiming ownership, using the recovery kit, or approving governance actions.
- **Protected `Shared` folder:** Created automatically for everyday household logins so everyone in the family has what they need.

## Everyday convenience

- **Merged view:** You do not have to switch vaults back and forth. Your personal vault and your Family Space appear together in search and autofill.
- **No extra master password:** Each family member uses their own Baluard identity and device unlock, with no shared master password to pass around.
- **Code-based invites:** Invite family members with a short invite code; entering the code approves their join automatically.

## Lost devices and emergencies

- **Stolen phone or tablet:** An admin can revoke the lost device, replace the member's access, and rotate keys on affected folders so the lost device cannot decrypt future updates.
- **Space Recovery Kit:** A Family Space has no master password. Instead, the **Space Recovery Kit** generates a dedicated 24-word offline phrase for that Space. Store it safely offline (just like important family papers): emergency recovery requires both this kit phrase and read access to the Space's Git repository.
- **Reissue after departure:** If a guardian leaves or ownership changes, Baluard automatically reissues the Space Recovery Kit with a new 24-word phrase. The old phrase stops working, so guardians must write down the new one.

## Good to know

Admins can see everything in the Family Space, while non-admin members only decrypt the folders granted to them. Remember that anyone who could previously view a password could have copied it. If someone leaves the household and should no longer have access, change the shared account passwords too.
