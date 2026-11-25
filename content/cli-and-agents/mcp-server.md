+++
title = "MCP server (baluard mcp)"
description = "Connect coding tools like Claude Code or Cursor to Baluard over MCP with read-only, human-approved access."
weight = 7
template = "page.html"

[extra]
+++

Baluard can act as a Model Context Protocol (MCP) server so coding tools such as Claude Code or Cursor can look up logins and two-factor codes when needed. Access is read-only and controlled by the same approval policy as other agent workflows.

## Two ways to connect

You can connect an MCP client in either of two ways:

1. **Stdio transport (`baluard mcp serve`):** Your coding tool spawns `baluard mcp serve` as a subprocess. On the first call, `baluard-daemon` identifies the parent process and asks you to approve the volatile session (60-second wait). Pass `--vault <slug>` to pin the session to a specific vault instead of the active vault.
2. **Local HTTP endpoint (paired in Desktop):** The desktop app runs a local HTTP MCP server (default port `17990`, endpoint `http://127.0.0.1:17990/mcp`). Pair an agent in **Settings -> Agents -> MCP agents** to get a one-time Bearer token and a ready-to-paste user-level JSON snippet. See [MCP agents in the desktop app](@/vault/mcp-agents.md).

## Configure `baluard mcp serve` (stdio)

Add `baluard` to your coding tool's user-level MCP configuration:

```json
{
  "mcpServers": {
    "baluard": {
      "command": "baluard",
      "args": ["mcp", "serve"]
    }
  }
}
```

To pin the session to a specific vault slug:

```json
{
  "mcpServers": {
    "baluard": {
      "command": "baluard",
      "args": ["mcp", "serve", "--vault", "work"]
    }
  }
}
```

At startup, `baluard mcp serve` strips inherited `BALUARD_*` environment variables so the client cannot redirect the daemon socket or reuse your personal CLI session token.

## Tools exposed to the agent

The MCP server exposes three read-only tools:

| Tool | Purpose | Approval |
|------|---------|----------|
| `search_items` | Search entries by name or username (`query`, max 20 results). Returns IDs, names, usernames, and site URIs without secrets. | Allowed once the session is active |
| `get_login` | Read username, password, and custom fields for one `item_id` (never returns TOTP seeds). | Requires your approval per read |
| `get_totp` | Read the current two-factor code for one `item_id`. | Requires your approval per read |

Write operations, SSH private keys, and raw TOTP seeds are never exposed over MCP.

## Approving or auto-approving requests

When an agent calls `get_login` or `get_totp`, Baluard prompts you in the desktop app (or via `baluard agent pending` / `baluard agent approve <id>` in a headless terminal).

If you are running an unattended session and want temporary auto-approval:

- **For HTTP-paired agents:** Toggle **Auto-approve** in **Settings -> Agents -> MCP agents**, pick a duration (`5`, `15`, `30`, or `60` min), and confirm with your master password.
- **From the CLI:** Run `baluard agent auto-approve --on --duration 5m` (and `baluard agent auto-approve --off` or `baluard agent revoke` to stop it).
