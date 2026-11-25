+++
title = "Legacy Contact"
description = "Give someone you trust a read-only recovery kit that opens only after you stop unlocking your vault."
weight = 10
template = "page.html"

[extra]
+++

Baluard has no central server and no support team that can hand over your data. **Legacy Contact** is how you plan for that in advance: you choose one person you trust and give them a recovery kit that lets them open a read-only copy of your vault if you stop unlocking it.

Legacy Contact is available in the **desktop app** and **CLI**. Mobile setup and contact unlock are not available yet.

## How it works

1. **You create a kit.** In **Settings -> Legacy Contact**, you pick a waiting window (14 to 365 days), optionally write a personal note, and generate a four-word passphrase. Baluard produces a single `.bldlegacy` file called the **kit letter**.
2. **You hand over the pieces separately.** You give your contact the kit letter file and share the passphrase through a different channel. Until the waiting window passes, they cannot open anything.
3. **Normal use resets the clock.** Every time any of your enrolled devices unlocks your vault, it quietly records a check-in. There are no prompts or extra steps.
4. **After enough days of silence, the kit can open.** If none of your devices have unlocked the vault for the number of days you chose, your contact can open the `.bldlegacy` file in the Baluard desktop app with the passphrase.
5. **Access is strictly read-only.** Baluard fetches a private copy of your vault, verifies the kit has not been tampered with, and opens it read-only. Your contact can view and copy entries, but cannot edit, delete, or push changes. Before the waiting window ends, opening is refused and shows how many days remain.

### What you can do while a kit is armed

- **Show the kit again:** re-exports the exact same `.bldlegacy` file if your contact lost it. The passphrase is never stored anywhere; if the passphrase is lost, replace the kit and pick a new one.
- **Turn off:** disables the kit without rotating your vault keys. You can set it up again later.
- **Refuse request:** once the waiting window has elapsed, a banner appears in **Settings -> Legacy Contact**. Refusing closes the kit permanently and rotates your vault keys so any copy of the old kit becomes useless.
- **Replace:** retires the old kit, rotates your vault keys, and creates a new kit.

## How to set it up

### Prerequisites

- Your vault must be connected to a git provider (**GitHub**, **GitLab**, or **Codeberg**).
- Your connected sync account must have **repository admin permission** so Baluard can register a read-only deploy key for your contact. If your token lacks permission, reconnect your sync account first.

### In the desktop app

1. Unlock your vault and open **Settings -> Legacy Contact**.
2. Choose how many days of silence must pass before the kit opens (**14**, **30**, **90**, or **365 days**).
3. Under **Who is the kit for?**, enter your contact's name (stored only in your own settings).
4. Optionally write **A note to them**. This note appears in plain text at the top of the kit letter so your contact knows what the file is for.
5. Click **Create passphrase** to generate a four-word passphrase, save it somewhere safe, and check **I saved the passphrase somewhere safe**.
6. Click **Create the kit**.
7. Click **Download** to save the `.bldlegacy` file (or **Copy text**).
8. Send the file to your contact and share the passphrase through a **separate** channel.

### From the command line

You can also manage Legacy Contact from the CLI while your vault is unlocked:

```bash
baluard legacy arm --days 30 --contact "Ana" --letter "For emergencies"
baluard legacy status
baluard legacy resend
baluard legacy disarm
baluard legacy deny
baluard legacy replace --days 30 --contact "Ana"
```

## How your contact opens the vault

Your contact does **not** need a Baluard account, a git provider account, or technical knowledge. They only need:

- A computer with the **Baluard desktop app** installed.
- The `.bldlegacy` **kit letter** file.
- The **kit passphrase**.

To open the vault:

1. Open Baluard and click **Open with a kit letter** on the lock screen.
2. Click **Choose the kit letter** and select the `.bldlegacy` file.
3. Read the personal note (if you included one), type the **Kit passphrase**, and click **Open the vault**.
4. Baluard downloads and verifies the vault copy and opens it read-only.

## Recommendations and honest limits

- **Always separate the file and the passphrase.** Anyone who holds both the `.bldlegacy` file and the passphrase can open the vault once the waiting window passes. Send the file one way (for example, email or a shared drive) and the passphrase another way (in person, on paper, or over a separate messaging app).
- **Understand what the waiting window protects.** The waiting window is enforced by the Baluard app to prevent accidental or premature opening, not by cryptography; someone with modified software could bypass the timer if they already hold both the file and the passphrase. What *is* cryptographic: an unreleased, denied, or replaced kit opens nothing.
- **Pick at least 14 days (30 or 90 is safer).** A longer window ensures a vacation, a broken phone, or a week offline does not make your kit openable early.
- **Keep an offline encrypted backup too.** Legacy Contact relies on your git repository remaining reachable. If you rename the repository, switch providers, or your provider account is closed, the kit stops working. Create a new kit if you move your repository.
- **Do not use Legacy Contact for your own lockout.** Legacy Contact is for someone else. To recover your own vault after forgetting your master password or losing your devices, use your [24-word recovery phrase](@/vault/recovery-phrase.md) instead.
