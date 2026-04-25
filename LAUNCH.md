# Launch

Use this as the canonical public copy. Keep claims plain: unofficial, local-first, and no extra hosted relay server.

## Main Post

```text
I built Codex Relay.

Text your Mac's Codex from Telegram.

Telegram DM -> local LaunchAgent -> Codex CLI -> Telegram reply.

No VNC. No extra hosted relay server.

https://github.com/dicnunz/codex-relay
```

Attach: `assets/codex-relay-demo.mp4`

## Install Reply

```text
Install:

git clone https://github.com/dicnunz/codex-relay.git
cd codex-relay
./scripts/install.sh

Then DM your bot:
/alive
/health
/tools
/latency
/jobs
/automations
send a screenshot and ask what changed

Unofficial. Local-first. Uses your normal Codex/OpenAI account.
```

## Short Reply

```text
It is a small Mac relay: Telegram DM in, local LaunchAgent runs Codex CLI, Telegram reply out. It does not host your tasks or pretend to be the official Codex app UI.
```

## Latency Reply

```text
Same latency as a local Codex run, plus Telegram. Bridge/status commands are quick; real repo, browser, image, and tool tasks usually take tens of seconds or more.
```

## Thread Reply

```text
Yeah, I wanted the phone path without VNC or maintaining a web app. I made a small local relay: Telegram DM -> LaunchAgent -> installed Codex CLI on the Mac -> Telegram reply when Codex finishes. Unofficial/local-first: github.com/dicnunz/codex-relay
```

## Safety Reply

```text
The important boundary is the allowlist. Only the configured Telegram user/chat can call Codex, and the bot token/config stay local. Still, it is a path to Codex on your Mac, so use it only with a Telegram account and Mac you trust.
```

## Checklist

- Use the generated demo only as an explainer, or replace it with real sanitized Telegram/Codex footage.
- Keep the post plain. No "AGI", "always-on agent", "instant", or fake autonomy language.
- Reply with install commands.
- Keep the latency reply nearby.
- Say plainly that it is unofficial and local-first.
- Do not imply OpenAI affiliation.
