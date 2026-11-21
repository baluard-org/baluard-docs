+++
title = "Installation"
description = "Install Baluard from the signed package repositories or direct downloads."
weight = 1
template = "page.html"
aliases = ["introduction/installation", "introduction/install/installation"]

[extra]
+++

Baluard is in beta. The current release is 0.7.1 for Linux, Windows, and macOS desktop, with browser extensions and mobile builds in development.

## Debian and Ubuntu (APT)

The apt repository uses the deb822 format (default on Ubuntu 24.04+ and Debian 13+). The armored key is used directly, no dearmor step:

```bash
sudo curl -fsSL -o /usr/share/keyrings/baluard-archive-keyring.asc https://packages.baluard.app/baluard-release.asc
curl -fsSL https://packages.baluard.app/baluard.sources | sudo tee /etc/apt/sources.list.d/baluard.sources
sudo apt update && sudo apt install baluard
```

## Fedora (DNF)

Fedora 41+ with dnf 5:

```bash
sudo dnf config-manager addrepo --from-repofile=https://packages.baluard.app/baluard.repo
sudo dnf install baluard
```

On RHEL and clones (dnf 4), add the repository with:

```bash
sudo dnf config-manager --add-repo=https://packages.baluard.app/baluard.repo
```

## Direct download

Signed release artifacts are on the [GitHub releases page](https://github.com/baluard-org/baluard/releases/latest): the AppImage for Linux, `Baluard-amd64-setup.exe` for Windows, and `Baluard-macos-aarch64-non-notarized.zip` for macOS (Apple Silicon; unzip and drag to Applications).

On Windows, Defender SmartScreen shows a "Windows protected your PC" warning because the installer is unsigned. See [The Windows SmartScreen warning](windows-smartscreen/).

On macOS, Gatekeeper blocks the first launch because the build is not notarized. See [The macOS Gatekeeper warning](macos-gatekeeper/).

On Linux, the AppImage needs no installer, but it does need FUSE to start, and it does not add itself to your app menu. See [The Linux AppImage](linux-appimage/).

## Command-line only (mise)

The CLI can be installed with [mise](https://mise.jdx.dev/) without sudo or a package repository. This installs the `baluard` and `baluard-daemon` commands from the signed GitHub release archives.

```bash
mise use -g github:baluard-org/baluard    # install
mise upgrade github:baluard-org/baluard   # update
mise uninstall github:baluard-org/baluard # remove
```

Notes:

- Pinning a version with `@x.y.z` does not resolve. mise prepends `v` to release tags and Baluard tags carry no prefix. Use `mise upgrade` to move between releases.
- Newly published releases stay hidden behind mise's supply-chain freshness window for a while before `mise upgrade` offers them.

## Command-line only (manual tarball)

Download the archive and the signed checksums from the [latest release](https://github.com/baluard-org/baluard/releases/latest) (`Baluard-cli-amd64.tar.gz` for Linux, `Baluard-cli-darwin-arm64.tar.gz` for Apple Silicon, `Baluard-cli-windows-x86_64.tar.gz` for Windows).

```bash
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/Baluard-cli-amd64.tar.gz
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/updater.pub
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/SHA256SUMS
curl -LO https://github.com/baluard-org/baluard/releases/latest/download/SHA256SUMS.sig
base64 -d SHA256SUMS.sig > SHA256SUMS.minisig
minisign -V -p updater.pub -x SHA256SUMS.minisig -m SHA256SUMS
sha256sum -c SHA256SUMS
```

`sha256sum -c` reports one failing line for the desktop artifacts you did not download; the CLI archive line must pass. Extract the archive: `baluard` and `baluard-daemon` land side by side. Put them on your `PATH`.

## Keeping the CLI current

`baluard self-update` downloads the latest release, verifies the signed `SHA256SUMS`, and replaces the `baluard` and `baluard-daemon` binaries in place. It never downgrades, and it refuses mise-managed installs (use `mise upgrade` there).

The CLI also checks for a new release at most once every 24 hours and prints a notice on stderr until the CLI is current. Scripts, CI, and agents are exempt. Set `BALUARD_NO_UPDATE_CHECK=1` to opt out.

## Verify the repository signing key

The package repositories are signed. Before trusting repository imports, verify the signing key fingerprint:

```
223310EA BF1A B6FE E6BD DF3E 2A53 1D54 E6D7 4804
```
