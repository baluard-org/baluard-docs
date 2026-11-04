+++
title = "Installation"
description = "Install Baluard from the signed package repositories or direct downloads."
weight = 1
template = "page.html"

[extra]
+++

Baluard is in beta. The current release is 0.1.0 for Linux desktop, with browser extensions and mobile builds in development.

## Debian and Ubuntu (APT)

The apt repository uses the deb822 format (default on Ubuntu 24.04+ and Debian 13+). The armored key is used directly, no dearmor step:

```bash
sudo curl -fsSL -o /usr/share/keyrings/baluard-archive-keyring.asc https://baluard.app/repo/baluard-release.asc
curl -fsSL https://baluard.app/repo/baluard.sources | sudo tee /etc/apt/sources.list.d/baluard.sources
sudo apt update && sudo apt install baluard
```

## Fedora (DNF)

Fedora 41+ with dnf 5:

```bash
sudo dnf config-manager addrepo --from-repofile=https://baluard.app/repo/baluard.repo
sudo dnf install baluard
```

On RHEL and clones (dnf 4), add the repository with:

```bash
sudo dnf config-manager --add-repo=https://baluard.app/repo/baluard.repo
```

## Direct download

Signed release artifacts (AppImage, Windows installer, and source) are on the [GitHub releases page](https://github.com/baluard-org/baluard/releases/latest).

## Verify the repository signing key

The package repositories are signed. Before trusting repository imports, verify the signing key fingerprint:

```
223310EA BF1A B6FE E6BD DF3E 2A53 1D54 E6D7 4804
```
