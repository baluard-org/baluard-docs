+++
title = "Android app and mobile autofill"
description = "Install Baluard on Android, connect your vault, and set up system autofill, passkeys, and quick-settings accessibility fill."
weight = 5
template = "page.html"

[extra]
+++

Baluard runs natively on Android with local vault encryption, biometric unlock, git and folder sync, passkeys, and system-wide autofill.

## Install on Android

You can install the Android app from any of three sources:

- **Google Play:** Install directly from the [Google Play listing](https://play.google.com/store/apps/details?id=app.baluard.mobile).
- **F-Droid:** With F-Droid installed on your phone, open `https://packages.baluard.app/fdroid/repo/` and tap **Add to F-Droid**, or add that URL under **Settings -> Repositories** in F-Droid.
- **Direct APK:** Download the signed APK from the [GitHub releases page](https://github.com/baluard-org/baluard/releases/latest).

## Connect your vault

On first launch, you can create a new vault or bring an existing one onto your phone:

- **Git provider:** Sign in to GitHub, GitLab, or Codeberg to clone your existing vault repository, then enroll the phone with your master password or 24-word recovery phrase.
- **Folder sync or peer-to-peer:** Pair with a synced folder on your device (see [Folder sync](@/sync/folder-sync.md)) or sync directly with your desktop over [Peer-to-peer sync](@/sync/peer-to-peer-sync.md).
- **Biometric unlock:** After unlocking with your master password, Baluard offers to enable biometric quick unlock so autofill and daily unlocks use your fingerprint or face instead of running the full password derivation every time.

## Set up Android Autofill

1. Open Baluard on your phone and go to **Settings -> Autofill**.
2. Tap **Autofill services** and choose **Baluard** in the Android system autofill picker.
3. Under **Display autofill suggestions**, choose **Inline (shows in keyboard)** or **Popup (shows over input field)**.
4. If you use **Chrome**, **Brave**, or **Vivaldi** on Android, tap the browser integration option in **Settings -> Autofill** so the browser hands autofill requests to third-party managers like Baluard.

When your vault is locked, autofill shows an **Unlock Baluard** prompt. Tapping it verifies your biometrics and reveals matching logins for the app or website. If a login includes a 2FA verification code, Baluard copies the code to your clipboard automatically when you fill.

### Passkeys on Android

In **Settings -> Autofill**, tap **Passkeys (sign in with saved passkeys)** -> **Open** to select Baluard as your device's passkey provider in Android settings. Note that vaults guarded by a hardware security key do not support mobile autofill.

### Suggest web logins in apps and equivalent domains

- **Suggest web logins in apps:** When an Android app matches a website login in your vault, Baluard asks if you want to **Trust** that app once before filling website credentials inside it. Manage trusted and blocked apps in **Settings -> Autofill**.
- **Equivalent domains:** Add comma-separated domain groups (for example, a company portal and its public site) so logins saved for one domain autofill on the others.

## Accessibility fill fallback (Quick Settings tile)

Some Android apps and browsers ignore the standard Android Autofill framework. Baluard includes an opt-in fallback triggered only when you ask for it:

1. In Baluard, go to **Settings -> Autofill** and turn on **Use accessibility**, then tap **Allow** on the disclosure.
2. Tap **Open Accessibility settings** and enable Baluard in Android's Accessibility menu.
3. Edit your Android Quick Settings shade and add the **Baluard** fill tile.

When you reach a login screen where normal autofill does not appear, pull down Quick Settings and tap the Baluard tile. Baluard reads only the current screen's login fields, shows a picker, fills your chosen entry, and copies any TOTP code. Nothing seen on screen is stored or sent anywhere.

## Sync settings on Android

Open **Settings -> Sync** to control how your phone syncs with your remote repository, folder, or paired desktop:

- **Sync when I unlock the vault:** Pulls and pushes when you unlock your vault.
- **Sync after every change I make:** Automatically syncs after you add, edit, or delete an entry.
- **Sync when app returns to foreground:** Refreshes the vault when you switch back to Baluard.
- **Background sync:** Runs periodic background syncs (every configured number of minutes). This uses more battery, so most users can leave it off.
- **Sync over Wi-Fi only (advisory):** Avoids automatic syncs on cellular data.
- **Manual sync and diagnostics:** Tap **Sync now** to run a sync immediately, or open **Vault diagnostics** to inspect last sync time and status.

### Direct peer-to-peer sync

In **Settings -> Sync**, you can also enable **Direct peer-to-peer sync** to sync directly with your enrolled devices without a cloud account. Copy **This device address**, enter a **Peer device address**, and tap **Sync peer**.

> [!WARNING]
> P2P-only has no off-device backup: losing all enrolled devices loses your vault unless you also pair it with a Git or folder backup.

## Shared Spaces on Android

Shared Spaces work directly on Android so you can join a Space, manage members, and organize shared folders from your phone:

- **Sharing (`Settings -> Sharing -> Manage people`):** View members and their roles (**Owner**, **Admin**, **Member**, **Viewer**). Admins can paste an invite reply or approve/deny **Join requests** (with the out-of-band secret check), handle **Access requests** (granting read or edit access), and issue reset codes.
- **Shared folders (`Settings -> Shared folders -> Manage folders`):** Create, rename, or delete shared folders, and publish or clear the **Ask catalog** so members see folder names when requesting access.
- **Space policy (`Settings -> Space`):** Admins can configure **Who may invite members** (Admins + owner or Owner only), **Let viewers export**, **Guest sharing**, and the 24-word **Recovery kit**.
- **Activity (`Settings -> Activity -> View activity`):** Review items that need attention, recent shared-item activity, and any refused updates on the device.
