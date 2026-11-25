+++
title = "The Linux AppImage"
description = "Run and manage the Baluard AppImage on Linux: FUSE, app menus, updates, and immutable distributions."
weight = 2
template = "page.html"

aliases = ["introduction/install/linux-appimage"]

[extra]
+++

Baluard ships two Linux formats: deb and rpm packages, and a single-file AppImage. The packages install from a repository and integrate everything for you; see [Installation](@/install/installation.md). The AppImage needs no repository, no sudo, and no install step: download, mark executable, run. This page covers the AppImage.

## Download and run

Get `Baluard-amd64.AppImage` from the [releases page](https://github.com/baluard-org/baluard/releases/latest). Some browsers and file managers save it without the execute bit. Fix it in a terminal:

```bash
chmod +x ~/Downloads/Baluard-amd64.AppImage
~/Downloads/Baluard-amd64.AppImage
```

Or use your file manager: right-click the file, open Properties, and allow executing it. The exact wording differs between file managers.

## If it does not start: FUSE

AppImages launch through FUSE. Most desktop distributions include it; some minimal installs do not. The typical error is:

> dlopen(): error loading libfuse.so.2

Install the FUSE 2 library with your package manager:

```bash
sudo apt install libfuse2      # Debian 12, Ubuntu 22.04
sudo apt install libfuse2t64   # Debian 13+, Ubuntu 24.04+
sudo dnf install fuse          # Fedora
sudo pacman -S fuse2           # Arch
```

Without sudo you can still run the AppImage. Any AppImage can unpack and run itself without FUSE:

```bash
./Baluard-amd64.AppImage --appimage-extract-and-run
```

Startup is slower and it uses more disk. Fine as a fallback.

## Add Baluard to your app menu

An AppImage is only a file. It does not create a menu entry or an icon by itself, and it stays wherever you saved it. An AppImage manager fixes that: it keeps AppImages in one folder, wires the menu entry and the icon, and removes everything on uninstall.

We recommend:

- [AppManager](https://github.com/kem-a/AppManager/releases): a general AppImage installer and manager. It installs an AppImage with a menu entry and an icon, and uninstalls cleanly. It ships as an AppImage itself.
- [Gear Lever](https://flathub.org/en/apps/it.mijorus.gearlever): if you run an immutable distribution or prefer Flatpak. It organizes AppImages into a managed folder, integrates them into the app grid, and keeps the previous version as a backup before an update.

## Updates

The AppImage updates itself. Baluard checks for a new version in the background, shows a prompt, and installs after your confirmation. Every update is signature-verified, and a failed signature aborts it.

The deb and rpm packages check for updates too, but they notify only; your package manager owns the install. The AppImage is the only Linux format that updates itself.

AppManager and Gear Lever can also watch GitHub for new releases. Use one updater, not both at the same time.

## Immutable distributions

On Fedora Silverblue, openSUSE Aeon, and similar systems, the deb and rpm packages need image layering, and this site does not document that route. The AppImage runs from your home directory with no system changes. Install Gear Lever from Flathub and manage Baluard like any other AppImage.

## Browser extension

The browser extension is in development. Its desktop bridge registers itself automatically: the deb and rpm packages ship the registration files system-wide, and the AppImage writes them to your browser's user settings on first launch. No manual step is needed in either format.

## Check the download first

The AppImage skips the installer warnings of Windows and macOS, so the download hash is your main check. Every release publishes a `SHA256SUMS` file signed with Baluard's minisign key:

```bash
sha256sum ~/Downloads/Baluard-amd64.AppImage
```

Compare the output with the `Baluard-amd64.AppImage` line in `SHA256SUMS` from the same release page. If they match, the file you have is the file we published. The minisign steps that verify the list itself are in [Installation](@/install/installation.md).
