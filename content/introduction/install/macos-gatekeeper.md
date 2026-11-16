+++
title = "The macOS Gatekeeper warning"
description = "Why macOS says it cannot verify Baluard, and how to open it anyway."
weight = 3
aliases = ["introduction/macos-gatekeeper"]
template = "page.html"

[extra]
+++

## What you see

The first time you open Baluard on macOS, Gatekeeper stops it. The exact wording varies with the macOS version, but the message is one of these:

> "Baluard" cannot be opened because it is from an unidentified developer.

> "Baluard" cannot be opened because Apple cannot check it for malicious software.

macOS may also say the app "is damaged and can't be opened". All of these mean the same thing, described below.

## Why it happens

The Baluard macOS build is signed with an ad-hoc signature and is not notarized. Notarization means Apple scanned a copy of the app for known malware and approved it; it requires a paid Apple Developer account, and the macOS build lists this as a known gap.

So the warning is not a report of a virus. It is Apple saying "I have not looked at this app yet." Small and open-source projects ship unnotarized builds for exactly this reason.

## Open Baluard anyway

Since macOS 15 Sequoia, the old right-click and Open trick no longer works. The confirmation lives in System Settings:

1. Try to open Baluard from Applications. In the warning dialog, click **Done**. Do not click Move to Trash.
2. Open **System Settings**, go to **Privacy & Security**, and scroll down to the **Security** area. Next to "Baluard was blocked to protect your Mac", click **Open Anyway**.
3. Confirm with your password, then click **Open Anyway** one more time in the final dialog.
4. Baluard opens. macOS remembers the choice, so from now on it opens like any other app.

The **Open Anyway** button appears for about an hour after the blocked attempt. If it is not there, try to open Baluard once more and go back to step 2.

When you install a newer Baluard version later, macOS may ask again. The steps are the same.

## From the Terminal instead

If you prefer the Terminal, one command does the same as the steps above. macOS marks every downloaded file as quarantined, and that mark is what triggers the check:

```bash
xattr -dr com.apple.quarantine "/Applications/Baluard.app"
```

## Check the download first

The warning is your only check on an app Apple has not reviewed, so use it before you click Open Anyway. Every release publishes a `SHA256SUMS` file, and that file is signed with Baluard's minisign key.

Verify the zip you downloaded against it:

```bash
shasum -a 256 ~/Downloads/Baluard-macos-aarch64-non-notarized.zip
```

Compare the output with the `Baluard-macos-aarch64-non-notarized.zip` line in `SHA256SUMS` from the same release page. If they match, the file you have is the file we published. The manual minisign steps for verifying the list itself are in [Installation](installation.md), and they work the same way on macOS.

Then the usual rules: download only from the official [GitHub releases](https://github.com/baluard-org/baluard/releases/latest) or [baluard.app](https://baluard.app), never from a mirror or a link someone sent you. Baluard is open source under GPL-3.0, so the code you run is the code you can read.
