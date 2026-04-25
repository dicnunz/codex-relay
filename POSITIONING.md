# Positioning

## One-Line Pitch

Private Telegram remote for Codex on your Mac.

## Homepage Sentence

Text your bot from your phone. Your Mac runs the local Codex app CLI and sends the final answer back when the run finishes.

## Product Truth

- Telegram is the remote.
- Codex is the engine.
- The Mac does the work.
- The repo is small enough to inspect.
- Setup is honest: BotFather bot creation, `/start` allowlist, LaunchAgent.
- Latency is honest: status commands are quick; real Codex/tool work takes as long as the local run takes.
- Defaults are explicit: configured model, reasoning effort, local config, normal account limits.

## Why It Can Travel

Most agent demos are abstract. This one is concrete: you are on your phone, your laptop is somewhere else, and Codex still runs on the Mac that has your files, tools, apps, and configured permissions.

## VNC Wedge

VNC is better when you need raw pixel-level desktop control. Codex Relay is better when you want to ask Codex to do the Mac task and send back a receipt.

## App Server Wedge

A PWA behind Cloudflare Access can work, but then the user owns an app-server product. Codex Relay keeps the surface smaller: Telegram bot token, local LaunchAgent, local Codex CLI, allowlisted user.

## Useful For

- "I am away from my laptop, but I need Codex to check a repo."
- "Here is a screenshot. Tell me what changed."
- "Check my Codex automations."
- "Run the obvious local verification before I get back."
- "Draft the fix/post/doc, then stop before anything public."

## Audience

- Codex users who already trust their Mac setup.
- People who want a remote control, not another hosted automation platform.
- Builders who understand that local tool access is powerful and should be scoped.

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
Same latency as a local Codex run, plus Telegram. Fast for bridge/status commands; real Codex, repo, image, browser, and Computer Use tasks wait for the configured model and tools to finish.
```

## Safer Claim

```text
Codex Relay does not make Codex more powerful. It makes the Codex install on your Mac reachable from Telegram.
```

## Best Demo

Show:

```text
/alive
/jobs
/automations
send screenshot: "what changed?"
/tools
one real Mac/repo task
```

Then stop. The product is strongest when it looks simple.
