# Demo Script

Goal: show a phone handing real work to Codex on a Mac, with no hosted relay.

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
Your Mac runs the real Codex CLI locally.
The reply comes back when Codex finishes.
Images, files, apps, shell, Computer Use, and subagents work when your local Codex runtime exposes them.
```

## Shot List

1. `/alive`: show the Mac route, folder, model, and uptime.
2. Screenshot/image prompt: show Telegram image support and private attachment handling.
3. Real folder task: `/cd Projects/my-repo`, then ask for a focused README or test pass.
4. `/tools`: show tool access depends on the local Codex runtime.
5. Install frame: show BotFather token, allowlist, LaunchAgent, and `./scripts/doctor.sh`.

## On-Screen Copy Rules

- Say "remote", not "agent platform".
- Say "when Codex finishes", not "instantly".
- Say "local Codex runtime exposes them", not "all tools always work".
- Keep the GitHub URL and install command readable for at least three seconds.

## Voiceover

```text
Codex Relay is a Telegram remote for Codex on your Mac.

You text the bot. A local LaunchAgent calls the Codex app CLI. Codex works on the Mac and replies in Telegram when the run finishes.

Status commands are quick. Real repo, image, browser, and tool tasks take as long as the local Codex run takes.

It can take screenshots from Telegram, work in folders, run tools, and use whatever your local Codex install exposes.

No hosted relay. No new agent platform. Just your phone, your Mac, and Codex.
```
