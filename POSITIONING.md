# Positioning

## One-Line Pitch

Telegram remote for Codex on your Mac.

## Product Truth

- Telegram is the remote.
- Codex is the engine.
- The Mac does the work.
- The repo is small enough to inspect.
- Setup is honest: BotFather token, `/start`, allowlist, LaunchAgent.
- Latency is honest: status commands are quick; real Codex/tool work takes as long as the local run takes.

## Why It Can Travel

Most agent demos are abstract. This one is obvious: you are on your phone, your laptop is across the room, and Codex still has hands on the Mac.

## Useful For

- "I am away from my laptop, but I need Codex to check a repo."
- "Here is a screenshot. Tell me what changed."
- "Run the obvious local verification before I get back."
- "Draft the fix/post/doc, then stop before anything public."

## Do Not Claim

- Official OpenAI project.
- A Codex app UI mirror.
- Unlimited model usage.
- Zero setup.
- Instant replies for real Codex work.
- Bypassing confirmations, logins, MFA, or macOS privacy.
- A replacement for broader desktop automation tools.

## Latency Line

```text
Same latency as a local Codex run, plus Telegram. Fast for bridge/status commands; real Codex, repo, image, browser, and Computer Use tasks wait for `gpt-5.5` with xhigh reasoning to finish.
```

## Best Demo

Show:

```text
/alive
send screenshot: "what changed?"
/tools
one real Mac/repo task
```

Then stop. The product is strongest when it looks simple.
