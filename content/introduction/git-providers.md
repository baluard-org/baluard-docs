+++
title = "Choosing a git provider"
description = "Where a Baluard vault can live: GitHub, GitLab, Codeberg, your own server, or none. Size limits, pros, and cons."
weight = 3
template = "page.html"

[extra]
+++

A Baluard vault is a git repository, and sync sends that repository to a host of your choice. Every host has its own rules about how much you can store. This page compares the three providers Baluard connects to out of the box, plus the options that need no account at all.

Your provider only ever sees ciphertext, so none of the limits below expose anything you store. The trade-offs are about quotas, account security, and ownership. What your provider can see is covered in [Syncing your vault](@/introduction/syncing-your-vault.md#what-your-provider-can-see).

## The short version

| Provider | What a vault repo gets | Cost | Self-host |
|----------|------------------------|------|-----------|
| GitHub | No enforced repo cap; single files blocked over 100 MB, 2 GB per push | Free | No |
| GitLab.com | 10 GiB per project on the free tier, repository plus LFS | Free | Yes (self-managed) |
| Codeberg | 100 MiB total for private repos; 750 MiB git storage otherwise | Free, donation-funded | Yes (Forgejo) |
| Your own server | Your disk | None | It is one |
| USB drive, or no sync | Your disk | None | Not applicable |

A typical vault is a few megabytes, and Baluard caps attachments at 2 MB per file ([Attachments](@/introduction/attachments.md)). The limits still matter because they bind the whole repository, history included, and vault history only grows.

## GitHub

The default for most people. Baluard signs you in with the OAuth device flow: type a short code on github.com, and no token pasting is involved.

Pros:

- Free unlimited private repositories.
- No enforced size cap on the repository itself. GitHub recommends staying under 10 GB on disk, blocks single files over 100 MB, and enforces a 2 GB limit per push. A vault stays far below all three.
- One-click sign-in: nothing to paste, no secret shipped inside Baluard.
- The largest ecosystem and a long uptime record.

Cons:

- Proprietary service owned by Microsoft, under United States jurisdiction.
- The connection asks for the broad `repo` scope, and the resulting tokens do not expire on their own.

Current numbers: [Repository limits](https://docs.github.com/en/repositories/creating-and-managing-repositories/repository-limits) on GitHub Docs.

## GitLab

Pros:

- Open core with a self-managed edition. Baluard connects to your own GitLab instance through the instance URL override, with no GitLab.com quotas in the way.
- Device-flow sign-in on GitLab 17.1 and later, including self-managed instances.
- 10 GiB per project on the free tier, repository and LFS combined, and 500 GiB on paid plans.

Cons:

- Past the free 10 GiB the project goes read-only until storage is purchased.
- Pushes are capped at 5 GiB each.
- The connection needs the broad `api` scope; narrower repository scopes cannot create the repo.
- Access tokens expire after two hours. Baluard refreshes them automatically, but this adds moving parts GitHub does not have.

Current numbers: [Storage](https://docs.gitlab.com/user/storage_usage_quotas/) and [GitLab.com settings](https://docs.gitlab.com/user/gitlab_com/) on GitLab Docs.

## Codeberg

Codeberg is a nonprofit that runs Forgejo, free software with no tracking or ads.

Pros:

- Nonprofit, donation-funded, and built entirely on free software.
- 750 MiB of git storage per account, plus a further 1.5 GiB for LFS, packages, releases, and attachments.
- The same Forgejo software runs at home, and Baluard can point at your instance instead of codeberg.org.

Cons:

- Private repositories, and public repositories for personal use, share a 100 MiB total. A vault repo is private, so 100 MiB is the practical ceiling. Most vaults fit; a long history with many attachments may not. Larger public projects can request an exception.
- Forgejo OAuth tokens carry no scopes, so a token grants full account access. Baluard flags this at connect time.
- Access tokens expire after one hour; Baluard refreshes them automatically.

Current numbers: the [storage quota announcement](https://blog.codeberg.org/new-storage-limits-on-codeberg-what-you-need-to-know.html) on the Codeberg blog, effective May 2025.

## Your own server

Any git remote reachable over SSH works, with no provider account and no quota beyond your disk. Self-hosted GitLab and Forgejo instances work through the provider flows above with an instance URL override. You own availability, updates, and backups, which is the price of owning the storage.

## No provider at all

Sync is optional. A vault can live on a USB drive or stay on a single machine, and the git notebook is still there for history and recovery.
