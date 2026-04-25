# Phone Remote Runbook

Keep the Mac open, awake, online, and signed into Codex. Then talk to the Telegram bot like a terse remote for real Codex work, not like an instant chat app.

This is better than VNC when the goal is to command Codex, not manually drive a tiny mirrored desktop. It is also smaller than a PWA/app-server setup: no Cloudflare Access, no phone terminal, no product surface to maintain.

## Good Mental Model

```text
Phone prompt -> Telegram bot -> Mac LaunchAgent -> Codex CLI -> Telegram reply
```

The default normal prompt path uses `gpt-5.5` with `xhigh` reasoning through the local Codex app CLI.

## Prompts That Fit

```text
go on Atlas and check what assignments are due
open my portfolio repo and tell me the next best fix
use Computer Use to check if Atlas is running
make this folder easier to understand
generate a cover image for this idea and send me the file path
send a screenshot/photo and ask what changed or what to do next
run the tests here and tell me the smallest useful fix
```

Best prompts include a folder, a stopping point, and whether public actions are allowed.

## Thread Flow

```text
/alive
/tools
/try
/jobs
/automations
/history

/new school
/cd Documents
check what class files look important this week

/new portfolio
/cd Projects/my-repo
make the README feel pinned-worthy
```

## Response Timing

- `/ping`, `/alive`, `/status`, `/where`, `/list`, `/new`, and `/cd` should feel quick.
- `/jobs`, `/cancel`, and `/history` should work while Codex is busy.
- Normal prompts wait for Codex to finish.
- Normal prompts use `gpt-5.5` with `xhigh` reasoning.
- Image, browser, Computer Use, repo-editing, and test-running prompts can take tens of seconds or minutes.
- If the request is public or irreversible, ask Codex to draft and stop before posting, pushing, paying, deleting, or changing accounts.

## Runtime

- Service: `~/Library/LaunchAgents/com.codexrelay.agent.plist`
- Runtime dir: `~/Library/Application Support/CodexRelay`
- Status: `./scripts/status.sh`
- Stop: `./scripts/uninstall.sh`

## Limits

This is a local Codex runtime, not a visible Codex Mac app thread. It can use the same signed-in Codex CLI/plugin setup, but it does not mirror the desktop chat UI.

Telegram photos and image documents are saved in the private runtime state directory and attached to the next Codex prompt.

It is unofficial, uses your normal Codex/OpenAI account limits, and can only use tools exposed by the local Codex runtime on that Mac.
