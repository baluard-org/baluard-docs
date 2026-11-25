+++
title = "The Windows SmartScreen warning"
description = "Why Windows shows 'Windows protected your PC' when you install Baluard, and how to continue."
weight = 8
template = "page.html"
aliases = ["introduction/windows-smartscreen", "introduction/install/windows-smartscreen"]

[extra]
+++

## What you see

When you run the Baluard installer on Windows, Microsoft Defender SmartScreen may stop it with a blue dialog:

> Windows protected your PC
>
> Microsoft Defender SmartScreen prevented an unrecognized app from starting. Running this app might put your PC at risk.

If you click **More info**, the dialog shows the app name and `Publisher: Unknown publisher`.

## Why it happens

Baluard's Windows installer is not code-signed yet, and the installer is listed in the release notes as a known gap. SmartScreen builds a reputation for installers from digital signatures and download statistics. An unsigned installer starts with no reputation, so Windows shows this warning the first time anyone runs it.

The warning is not a report of a virus or malware. It is Windows saying "I do not know this file yet." It appears for many small and new projects that do not carry a code-signing certificate.

## Install anyway

1. Click **More info** in the blue SmartScreen dialog.
2. Click **Run anyway**. The installer starts.
3. Follow the installer as usual.

You only need to do this once per downloaded file. If you download a new release later, Windows may show the same warning for that file.

## Check the installer before you run it

You do not have to trust the download blindly. Every release publishes a `SHA256SUMS` file, and that file is signed with Baluard's minisign key.

To check the installer on Windows, open PowerShell in the folder where you downloaded it and run:

```powershell
Get-FileHash .\Baluard-amd64-setup.exe
```

Compare the hash it prints with the `Baluard-amd64-setup.exe` line in `SHA256SUMS` from the same release page. If the two values match, the file you have is the file we published.

The signature on `SHA256SUMS` proves the list itself was not tampered with. The manual verification steps for that are in [Installation](@/install/installation.md), in the manual tarball section, and they work the same way on Windows.

## After the install

SmartScreen may also show a smaller "Do you want to allow this app to make changes to your device?" prompt from User Account Control during installation. Click **Yes**. That prompt is the standard installer elevation question, not a SmartScreen reputation warning.

The installer puts Baluard in `%LOCALAPPDATA%\Programs\Baluard`, under your user account, with no system-wide changes.
