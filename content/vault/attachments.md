+++
title = "Attachments"
description = "How file attachments are stored, the 2 MB per-file limit, and how reclaiming space works."
weight = 5
template = "page.html"
aliases = ["introduction/attachments", "introduction/vault/attachments"]

[extra]
+++

Entries can carry files: a PDF export of a recovery sheet, a scanned document, a photo of a serial number. The file is encrypted on your device before it is stored, under the same key that protects the entry it belongs to.

## The size limit

A file can be at most 2 MB, and the app accepts files up to 1.9 MB. The reason is storage buckets: every file is stored in a padded slot so the true length stays hidden, and 2 MB is the largest slot. A file that is a few kilobytes long uses a small slot; anything over 250 KB uses the largest one. The limit is hard, and there is no setting to raise it.

If you need something bigger, keep the file outside Baluard and store a note pointing to where it lives. A password manager is the wrong place for large documents anyway: every device that unlocks the vault must be able to download and decrypt what the vault contains.

## Where the files live

Attachments do not sit inside the vault history. They travel on a separate encrypted side channel next to it. This keeps the main history lean: cloning the vault onto a new device is fast, and files are fetched on demand when you open an entry that has one.

Each stored file is pinned to its encrypted bytes by a fingerprint, so a device can always tell whether the copy it received is intact. If a file is missing on one device because it has not synced yet, opening the entry fetches it from the side channel instead of failing.

## Deleting a file is not the same as reclaiming the space

This is the one idea worth pausing on, because it is where git habits differ from a file manager.

Baluard keeps a git notebook of every change (the [sync guide](/introduction/syncing-your-vault/) covers this). The notebook is what makes recovery possible: delete an entry by accident, and an earlier state still exists. The same protection applies to attachments. Remove a file from an entry, and the encrypted copy stays in the shared storage, because older states of the vault may still reference it.

That is deliberate. The cost is that deleted files keep taking up space until you tidy up.

## Freeing space

Settings, then Sync, then Attachment storage, then **Free up space** (desktop and mobile). One tap; Baluard does the rest:

1. It looks at every entry you have, including the trash, and collects the fingerprints of files that are still referenced.
2. Every side-channel file whose fingerprint appears in that list is kept. Everything else is removed from the shared storage entirely, in one step, and the removal is signed by this device.
3. You get a short report: how many files were reclaimed, how much space that freed, and how many were kept.

Two rules protect you during this. Compaction only removes files no entry references, so a live attachment is never touched. And it refuses to run until every entry on this device is readable and every referenced file has finished syncing, so it can never decide with an incomplete picture.

## When another device tidies up

Storage is shared, so a cleanup on your phone concerns your laptop. When a device frees space, every other device shows a notice that says who cleaned up (a verified device, not just a name), how many files were removed, and how much space that freed.

On desktop, the notice is a full-screen banner. You can keep reading and autofilling while it is up, but saving changes pauses until you press **Get updates**. Your unsent changes stay queued and go out as soon as the updates arrive; nothing is discarded. The app then removes the stale local copies of the tidied files, and the banner goes away.

On mobile, the same notice is a full-screen dialog with the same rules.

Why pause at all? Because tidying rewrites the shared storage. If a device kept working from an outdated view and pushed new data, the cleanup could be quietly undone and the space would never actually be reclaimed. The pause is what makes the cleanup stick for everyone.

## What your provider can see

The same rule as the rest of the vault applies: only ciphertext leaves your device. A provider sees that attachments exist, and sees coarse size groups (a few kilobytes, up to 250 KB, or the 2 MB bucket), because storage slots are padded. Contents, names, and which entry a file belongs to stay invisible without your master password and your device keys.
