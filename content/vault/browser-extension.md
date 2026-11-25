+++
title = "Browser extension"
description = "Connect Chrome or Firefox to your local Baluard app to autofill logins, copy verification codes, and use passkeys."
weight = 10
template = "page.html"

[extra]
+++

The Baluard browser extension connects **Chrome** (and Chromium-based browsers) or **Firefox** to your local Baluard desktop app so you can fill logins, copy verification codes, and sign in with passkeys without copying and pasting from the app.

## What it does

- **Autofill logins:** Shows entries matching the current website in the toolbar popup and via an optional Baluard button inside login fields. Entries only fill when you click them, never automatically on page load.
- **Verification codes (TOTP):** Copy 2FA codes from the popup, fill a code field inline, or copy the verification code automatically right after filling a login.
- **Clipboard auto-clear:** Passwords, usernames, and verification codes copied from the extension are wiped from your clipboard after a set delay (1 minute by default).
- **Passkeys:** Optionally answer website passkey sign-in and registration prompts with passkeys stored in your vault. See [Passkeys in your browser](@/vault/passkeys.md) for details.
- **Merged Spaces:** Entries from your personal vault and any unlocked Spaces appear together. If a Space is locked, you can request an unlock directly from the popup.

## How it works

The extension is a thin bridge client, not a standalone vault. It holds **no master password and no vault keys**.

- **Local bridge:** Your browser talks to the local Baluard daemon through a native messaging host (`baluard-nmh`) installed alongside the desktop app.
- **Strict origin matching:** The extension compares the page's exact origin (scheme, host, and port) against your saved entry URLs. A login saved for `https://example.com` will not fill on `http://example.com` or on a different port.
- **Private tab checks:** To show the matching-entry count on the toolbar badge, the extension checks the active tab URL against the local daemon over local IPC. Nothing is sent to any remote server.
- **Desktop app required:** Because all decryption happens in the desktop app, the extension only works while the Baluard desktop app is running and unlocked.

## How to set it up

1. **Install the Baluard desktop app.** The desktop installer (and the Linux AppImage on first launch) automatically registers the native messaging host for Chrome, Chromium browsers, and Firefox.
2. **Install the browser extension** in Chrome or Firefox from [baluard.app](https://baluard.app).
3. **Start pairing in the desktop app:** Open Baluard, unlock your vault, go to **Settings -> Browser connect**, and click **Add browser extension**. The app shows an 8-character **Pairing code**.
4. **Connect from the browser:** Click the Baluard icon in your browser toolbar, click **I have Baluard installed**, enter the 8-character pairing code, and click **Connect to Baluard**.
5. **Approve the request:** Return to the Baluard desktop app and click **Approve**.

You can view connected browsers or disconnect one anytime by clicking **Revoke** in **Settings -> Browser connect**.

## How to use it

- **Fill from the toolbar:** Click the Baluard icon in your browser toolbar to see logins matching the current site. Click **Fill**, or use the copy buttons for the username, password, or verification code.
- **Fill inline:** Click the small Baluard button inside a username, password, or verification code field and pick the entry you want to fill.
- **Adjust extension settings:** Open the gear icon in the extension popup to configure:
  - **Show fill suggestions on login forms:** Toggle the inline Baluard button on form fields.
  - **Copy verification codes when filling:** Automatically copy the TOTP code when you fill a login.
  - **Clear clipboard after:** Choose `10 seconds`, `30 seconds`, `1 minute`, `2 minutes`, or `Never`.
  - **Offer passkeys:** Toggle browser passkey interception.
  - **Make Baluard the default password manager:** Turn off the browser's built-in prompt to save passwords so only Baluard handles them.

If the popup says **Vault locked** or **Open the Baluard app**, open and unlock the desktop app to resume filling.
