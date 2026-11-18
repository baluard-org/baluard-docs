+++
title = "Team and friends sharing"
description = "Share passwords with a partner, roommate, side-project co-founder, or small group without a central server."
weight = 2
template = "page.html"

[extra]
+++

Whether you are splitting rent and bills with a roommate, building a side project with a co-founder, or sharing tools with a small group of friends, Baluard gives you a clean way to share without passing passwords over chat.

**Heads up: everyone in this Space needs an account on the same git provider for this vault.**

## Two ways to share

### 1. Pair Space (two people)

If two people need to share everything in one Space (for example, two co-founders or partners), a **Pair Space** keeps setup minimal. A Pair Space shares all entries directly without folders, caps membership at two people, and has one **Owner** and one **Editor** or **Viewer** (no Admin role).

### 2. Group or small-team Space (3+ people)

For three or more people, use a **team-shaped Space** with folders and roles:

- **Shared folders:** Create separate folders for different topics (for example, `Hosting`, `Social`, or `House`). Give Editors and Viewers access only to the folders they need. Admins can decrypt all folders.
- **Roles:** Make trusted organizers **Admins**, contributors **Editors**, and read-only collaborators **Viewers**.
- **Provider permissions:** Baluard pairs cryptographic folder access with your git provider's repository permissions so Viewers cannot push unexpected changes.

## How syncing works

Each member must have an account on the same [git provider](@/sync/git-providers.md) host and connect the Space to the shared private repository. Every change is signed by the member's device before it is pushed, and other devices verify that signature when they pull.

If two friends edit different entries offline at the same time, git merges both cleanly. If both edit the same field, Baluard lets you resolve it field by field.

## When someone leaves the group

1. Remove the person from the Space and revoke their repository access on your git provider.
2. Rotate the keys: in a Pair Space, Baluard rotates the Space Root Key; in a team-shaped Space, Baluard rotates keys on the folders they had access to.
3. **Change the passwords** for any shared accounts they previously viewed, since they could have copied them while they were a member.
