+++
title = "Find logs for bug reports"
description = "Where Baluard writes daemon.log on Windows, Linux, and macOS, and how to collect it for a bug report."
weight = 9
template = "page.html"

[extra]
+++

When something breaks in the desktop app or CLI, the background service writes errors and sync events to a file named `daemon.log`. Attaching the relevant lines from `daemon.log` to a bug report helps pinpoint what failed.

## Log locations by platform

| Platform | Path |
| --- | --- |
| Windows | `%LOCALAPPDATA%\baluard\logs\daemon.log` |
| Linux | `~/.local/state/baluard/daemon.log` |
| macOS | `~/Library/Logs/baluard/daemon.log` |

If you set `BALUARD_LOG_DIR` in your environment, Baluard writes `daemon.log` inside that folder instead.

### Windows

Press **Win + R**, paste the path below, and press **Enter** to open the log folder in File Explorer:

```text
%LOCALAPPDATA%\baluard\logs
```

Note that Baluard stores its logs, `registry.json`, and local vaults under `%LOCALAPPDATA%\baluard\`, not `%APPDATA%\baluard\`.

### Linux

If `XDG_STATE_HOME` is set, Baluard writes to `$XDG_STATE_HOME/baluard/daemon.log`. Otherwise it uses `~/.local/state/baluard/daemon.log` (or `~/.local/share/baluard/daemon.log` on systems without a state directory).

To print the last 100 lines in a terminal:

```bash
tail -n 100 "${XDG_STATE_HOME:-$HOME/.local/state}/baluard/daemon.log"
```

### macOS

Open **Finder**, press **Cmd + Shift + G**, paste the path below, and press **Return**:

```text
~/Library/Logs/baluard
```

Or print the last 100 lines in Terminal:

```bash
tail -n 100 ~/Library/Logs/baluard/daemon.log
```

## Before you share a log

`daemon.log` does not store your master password, recovery phrase, or decrypted vault entries. It can include local file paths, vault slugs, and repository or remote URLs, so review the lines you copy before posting them in a public issue.
