+++
title = "Shared Spaces"
description = "Share passwords and secrets with family, friends, or a workplace team, without a central server."
weight = 6
sort_by = "weight"

[extra]
+++

A **Shared Space** is an encrypted vault you share with other people through a private git repository. Just like your personal vault, there is no Baluard server in the middle: encryption happens on each person's device, and your git provider only stores ciphertext. All members of a Space must have accounts on the same git provider host.

Every Shared Space gives you:

- **Shared folders (collections):** In team, family, and organization Spaces, group entries by who should see them (for example, household bills, a project's API keys, or a department's logins). Editors and Viewers only receive keys for the folders they are granted; Admins can decrypt all folders.
- **Roles:** Control who can manage the Space (**Owner** and **Admin**), who can add or edit entries (**Editor**), and who can only read (**Viewer**).
- **One-time invite and approval:** Invite people using their contact card or an invite code. Depending on Space settings, an admin approves new member joins or the invite code approves them automatically. Existing members can enroll their own additional devices without admin approval.
- **Space Recovery Kit:** A dedicated 24-word emergency backup for the Space so a household or organization does not lose access if an owner's device is lost.

Choose the guide that matches how you share:

1. [Family sharing](@/shared-spaces/family-sharing.md): one shared household vault for partners, guardians, and children.
2. [Team and friends sharing](@/shared-spaces/team-friends-sharing.md): sharing with a partner, roommate, side project, or small group.
3. [Workplace and organization sharing](@/shared-spaces/workplace-organization-sharing.md): company-wide access control, shared folders by department, multi-admin approvals, and offboarding.
