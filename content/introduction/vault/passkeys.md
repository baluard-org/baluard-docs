+++
title = "Passkeys in your browser"
description = "Sign in to sites with the passkeys stored in your vault, through the browser extension."
weight = 7
template = "page.html"

[extra]
+++

A passkey is a sign-in credential that lives on your devices instead of a password. Baluard stores passkeys inside your login entries, encrypted and synced like everything else in your vault. The browser extension lets you use them on websites: when a site asks for a passkey, Baluard answers with one from your vault.

Passkeys are optional. Baluard works fine without them, and sites that still use passwords keep working as always.

## Turn it on

1. [Install the browser extension](https://baluard.app) and pair it with the desktop app. Passkeys need the app: the signing happens there, and the browser never sees your passkey's private key.
2. Open the extension popup and go to settings.
3. Turn on **Offer passkeys**.

While the setting is on, the toolbar icon shows a PK mark on sites where Baluard can answer passkey requests.

The setting starts off because the extension answers passkey requests on every site you visit while it is on. The switch is global, not per site: turn it on only if you use passkeys with Baluard.

If the settings page says "This browser cannot offer passkeys", your browser lacks the API Baluard needs. Update the browser, or manage your passkeys from the entry view in the desktop app.

## How a sign-in feels

When a site asks for a passkey, a small Baluard window opens:

- **Sign in:** if your vault has a passkey for the site, Baluard asks which one to use, then signs you in.
- **Save a new one:** if you register a new passkey, Baluard offers to store it in an existing entry or a new one.
- **Already stored:** if the site already has a passkey in your vault, Baluard tells you and offers to use it instead.
- **Nothing stored:** if you have no passkey for the site, Baluard tells you, and the site's usual sign-in methods stay available.

If your vault is locked, Baluard asks you to unlock the app first, then try again. On many sites the passkey also appears as a suggestion in the username field, so you can pick it without leaving the form.

When Baluard cannot answer a request, it steps aside and your browser's own passkey flow takes over. A site that demands a hardware security key keeps working.

## Limits worth knowing

- Passkeys work in the browser where the extension runs, paired with the desktop app. There is no phone-as-passkey flow: Baluard does not relay sign-ins between your phone and your computer.
- Passkeys imported from Bitwarden arrive as view-only entries. Bitwarden's export carries no private keys, so those passkeys cannot sign; register them again with each site.
- The signing happens in the Baluard app. If the vault is locked, passkey sign-ins wait for an unlock. If the app is not running, Baluard steps aside and your browser's own passkey flow answers instead.
