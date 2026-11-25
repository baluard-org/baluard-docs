+++
title = "MCP agents in the desktop app"
description = "Pair coding agents in Settings -> Agents -> MCP agents, approve or auto-approve reads, and revoke tokens."
weight = 15
template = "page.html"

[extra]
+++

The desktop app runs a local HTTP MCP endpoint so coding tools (such as Claude Code or Cursor) can look up vault entries with your approval. Manage pairings and approvals in **Settings -> Agents -> MCP agents**.

For the stdio transport (`baluard mcp serve`) and the list of exposed read-only tools, see [MCP server (`baluard mcp`)](@/cli-and-agents/mcp-server.md).

## Check the local endpoint

When your vault is unlocked, **Settings -> Agents -> MCP agents** shows the local server status:

- **Running:** `Agent endpoint running on port <port>` (default `17990`, bound to `127.0.0.1`).
- **Failed:** If the port could not bind, the section shows the error message.

## Pair an agent

1. Open **Settings -> Agents -> MCP agents**.
2. Enter a descriptive label (for example, `Claude Code on this laptop`) and click **Pair an agent**.
3. Copy the one-time Bearer token and the generated JSON config snippet.

The snippet configures the agent with the local URL (`http://127.0.0.1:<port>/mcp`) and `Authorization: Bearer <token>`.

> [!IMPORTANT]
> Copy the token before closing the pairing card. Baluard stores only a hash of the token and cannot display it again. Paste the snippet into your agent's **user-level** configuration, never a project-level config file, because the token inherits the file's permissions.

## Session approvals vs. auto-approve

By default, every secret read (`get_login` or `get_totp`) opens an approval prompt in the desktop app showing the agent name, entry, and requested field.

If you want an agent to read entries without prompting for a short window:

1. Under **Paired agents**, pick a duration from the dropdown (`5 min`, `15 min`, `30 min`, or `60 min`).
2. Turn on **Auto-approve**.
3. Read the warning and confirm with your master password.

While auto-approve is active, the row shows how many minutes remain (`auto-approve ends in <n> min`). Anyone holding that pairing token gets the same access until the timer expires.

## Stop auto-approve or revoke an agent

- **Stop auto-approve early:** Turn off the **Auto-approve** toggle on that paired agent's row.
- **Remove access completely:** Click **Revoke** on the agent's row. This immediately invalidates its Bearer token and stops any active auto-approve window.
