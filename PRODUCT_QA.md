# Product QA

## Quality Bar

Codex Relay should feel like a clean Mac remote, not a novelty bot.

The product is ready to show only when these are true:

- The LaunchAgent is running.
- The installed runtime script matches the repo.
- `./scripts/doctor.sh` passes.
- The configured Codex app CLI can run `gpt-5.5`.
- Telegram images are saved privately and attached to Codex.
- The demo video is readable in the first three seconds.
- The README explains latency as real Codex runtime, not instant chat latency.
- Local latency probe on 2026-04-25: trivial `gpt-5.5` xhigh Codex CLI request returned in about 4.8-6.3 seconds before Telegram delivery.
- The README explains power and risk without hype.

## Verified Locally

- LaunchAgent loaded: `com.codexrelay.agent`.
- Runtime script matches the repo copy.
- `./scripts/doctor.sh` passes.
- Local `gpt-5.5` image check works through `/Applications/Codex.app/Contents/Resources/codex`.
- Real Telegram image round trip works: Telegram photo + caption -> private attachment save -> Codex `--image` -> Telegram reply.
- Generated demo is 1280x720 H.264.

## Latency QA

Expected behavior:

- `/ping`, `/alive`, `/status`, `/where`, and thread commands should return quickly because they do not call Codex.
- Normal prompts show Telegram typing while Codex is running.
- Normal prompts use `gpt-5.5` with xhigh reasoning.
- Final replies arrive only after the Codex CLI run finishes.
- Longer waits are normal for image analysis, browser/Computer Use work, repo edits, tests, package installs, or prompts that require tool calls.
- A task that exceeds `CODEX_TELEGRAM_TIMEOUT_SECONDS` stops with a timeout message.

Public answer:

```text
It is not instant chat. Telegram is just the remote; the Mac still starts Codex, runs the model, uses tools, and then sends the final reply back. Simple checks can be quick, but real repo/browser/image tasks often take tens of seconds or minutes. The default timeout is 10 minutes.
```

## Current Human-Only Checks

- Repost to X only after the final post text is confirmed.

## Launch Bar

Public launch should include:

1. Clean demo video.
2. Plain one-post explanation.
3. GitHub link.
4. Install reply.
5. Latency reply ready.
6. No exaggerated claims.
