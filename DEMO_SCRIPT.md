# Demo Script

Goal: show a phone handing real work to Codex on a Mac, without VNC, a phone terminal, a PWA/app server, a hosted relay account, or official OpenAI affiliation.

Generated assets:

```bash
./scripts/record_demo.sh
```

Outputs:

```text
assets/codex-relay-demo.mp4
assets/codex-relay-demo-poster.png
assets/social-card.svg
assets/demo-transcript.svg
```

## Story

```text
Telegram is the remote.
Your Mac runs the local Codex app CLI.
The reply comes back when Codex finishes.
Images, apps, shell, Computer Use, automations, and subagents work when your local Codex runtime exposes them.
```

## Shot List

1. `/alive`: show the Mac route, folder, model, and uptime.
2. `/jobs`: show that long Mac work has a job id, status, and cancel path.
3. Screenshot/image prompt: show Telegram image support and private attachment handling.
4. `/automations`: show the exact feature people are asking for, without pretending it bypasses local Codex limits.
5. Real folder task: `/cd Projects/my-repo`, then ask for a focused README or test pass.
6. Install frame: show BotFather token, allowlist, LaunchAgent, and `./scripts/doctor.sh`.

## Proof Beats

- Show `gpt-5.5` and `xhigh` as defaults, not as a benchmark claim.
- Show a real wait between request and answer; do not cut it to look instant.
- Show one useful task, not a pile of unrelated tricks.
- Show "not VNC, not PWA" as the wedge, not as a dunk.
- Show the GitHub URL only after the flow is clear.

## On-Screen Copy Rules

- Say "remote", not "agent platform".
- Say "when Codex finishes", not "instantly".
- Say "local Codex runtime exposes them", not "all tools always work".
- Say "unofficial", not "OpenAI project".
- Keep the GitHub URL and install command readable for at least three seconds.

## Voiceover

```text
Codex Relay is a Telegram remote for Codex on your Mac.

You text the bot. A local LaunchAgent calls the Codex app CLI. Codex works on the Mac with gpt-5.5 and xhigh reasoning by default, then replies in Telegram when the run finishes.

Status commands are quick. Real repo, image, browser, and tool tasks take as long as the local Codex run takes.

It can take screenshots from Telegram, work in folders, run tools, inspect automations, and use whatever your local Codex install exposes.

No VNC tiny-screen driving. No PWA app server to maintain. No hosted relay account. Unofficial, local-first, and deliberately small.
```
