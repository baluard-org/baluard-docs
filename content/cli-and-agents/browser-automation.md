+++
title = "Browser automation with secrets"
description = "Let an AI agent fill web forms with vault values while the secret values stay out of the agent's context."
weight = 6
template = "page.html"

[extra]
+++

AI agents can drive a browser: fill forms, complete checkouts, log in to sites. If you paste a card number or a password into the agent's prompt, the value lands in the model context and the session transcript. It also lands in every log that stores the conversation. Baluard gives you two patterns that keep the value out of the agent. Both use the same `baluard://` references as every other agentic command (see [Agentic workflows with the CLI](@/cli-and-agents/agentic-workflows.md)).

## Pattern 1: inject into the process environment (recommended)

`baluard run` wraps your whole automation command and injects approved fields as environment variables. The value exists only inside the child process. The agent and the model never see it, and `stdout` and `stderr` come back with leaked secret bytes scrubbed.

```bash
baluard run \
  --env CARD_NUMBER=baluard://Personal/Visa/number \
  --env CARD_EXP_MONTH=baluard://Personal/Visa/exp_month \
  --env CARD_EXP_YEAR=baluard://Personal/Visa/exp_year \
  --need "complete checkout on shop.example.com" \
  -- my-browser-automation fill-checkout
```

The daemon shows you an approval prompt before it starts the child. The grant binds to the requesting process tree and expires after 15 minutes.

## Pattern 2: capture values inside a script (code mode)

Many agent harnesses can run a script that calls tools. The model writes the script. The script holds the values in its own variables. Only the final summary returns to the model.

The shape is the same in every harness. The API names depend on your tool:

```js
// One script, written by the agent. The model never sees the values.
const num = (await shell("baluard read baluard://Personal/Visa/number")).trim();
const exp = (await shell("baluard read baluard://Personal/Visa/exp_year")).trim();
await browser.click({ selector: 'iframe[title="Card number input"]' });
await browser.type({ text: num });
await browser.click({ selector: "#expiry" });
await browser.type({ text: exp });
return "card form filled";
```

`baluard read` prints one field value and works in your unlocked session. It runs in daemon mode only.

Pattern 1 keeps the value out of both the model context and the execution trace. Pattern 2 keeps it out of the model context. But each tool call inside the script stays visible in the human-readable execution trace. If that trace gets shared or stored, prefer pattern 1.

## Card field names

A `card` entry exposes these fields to references:

| Field | Reference suffix |
|-------|-----------------|
| Cardholder | `cardholder_name` |
| Brand | `brand` |
| Card number | `number` |
| Expiry month | `exp_month` |
| Expiry year | `exp_year` |
| CVV/CVC | `code` |

`totp` and `custom:<name>` also work on any item type. SSH keys, signing keys, and private key fields stay blocked for agent grants.

## Keep the value out of traces

The value stays out of the model context in both patterns. It can still land in places a human reads later. Three rules:

1. Prefer `baluard run`. The value exists only in the child environment, not in any tool call or script line.
2. Pipe through stdin, not argv. Command arguments show in `ps` output, shell history, and tool traces:

   ```bash
   printf '%s' "$CARD_NUMBER" | my-browser-automation fill --stdin
   ```

3. Do not screenshot filled fields. A screenshot sends the image back to the model, and the model reads it. Take screenshots before you fill, or crop to empty fields.

## Approvals

Both patterns use the standard approval flow. The desktop app shows a dialog. For headless use, run `baluard agent pending` and `baluard agent approve` in a second terminal. See [Approving requests](@/cli-and-agents/agentic-workflows.md#approving-requests-desktop-and-headless-cli) for the full flow and exit codes.

One warning: `baluard agent auto-approve --yolo` removes the approval gate for every later request on this device. Do not use it for browser sessions on sites you do not control.

These patterns need no MCP server and no plugin. Any agent that can run shell commands can use them.
