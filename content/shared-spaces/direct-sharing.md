+++
title = "Direct sharing (Contacts and Outboxes)"
description = "Share individual entries or live-mirrored folders with trusted contacts without creating a Shared Space."
weight = 4
template = "page.html"

[extra]
+++

If you only need to send a few passwords to someone without setting up a full [Shared Space](@/shared-spaces/_index.md), you can share directly using **Contacts** and **Outboxes**.

## Add and verify contacts

Before sharing directly, exchange contact cards in **Settings -> Contacts**:

1. Under **My card**, click **Copy contact code** and send it to the other person.
2. When they send you theirs, paste it under **Add a contact** and click **Add**.
3. **Verify out of band:** Compare **My verification code** and **Their verification code** over a call, in person, or on another trusted channel. When both match, click **Codes match** to mark the contact as **Verified**.

If a contact shows "Old card: ask them to share it again to receive items", ask them to send a fresh contact code from their current Baluard version.

## Live mirror folders (Outboxes)

In **Settings -> Outboxes**, you can mirror selected entries into a shared folder (such as a synced Dropbox, Nextcloud, or Syncthing folder) so recipients always see up-to-date copies:

- **Share to a folder:** Under **Mirror items**, pick the entries and recipients, choose a **Folder** path, and click **Mirror**. If you pick multiple recipients, Baluard creates a separate subfolder for each recipient inside that folder.
- **Updates:** When you edit a mirrored entry, Baluard updates the recipient's copy. You can also click **Sync mirrors now** to push updates immediately.
- **Stop mirroring:** Click **Stop** on any mirrored folder to stop future updates. Copies the recipient already received stay on their device.
- **Receive a folder:** Under **Received folders**, click **Add** and select the shared folder path someone sent you. Click **View items** to read or copy the shared entries.

## Good to know

- Everything shared through Contacts and Outboxes is encrypted for the recipient's contact key before it touches the folder.
- Removing a contact in **Settings -> Contacts** does not delete items they already received.
- Direct sharing works best for occasional handoffs or small sets of logins. For ongoing team, family, or household collaboration with roles and shared folders, create a [Shared Space](@/shared-spaces/_index.md) instead.
