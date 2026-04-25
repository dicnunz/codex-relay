# Phone Remote Runbook

Keep the Mac open, awake, online, and signed into Codex. Then talk to the Telegram bot like a terse remote for real Codex work, not like an instant chat app.

This is better than VNC when the goal is to command Codex, not manually drive a tiny mirrored desktop. It is also smaller than maintaining another web service: no phone terminal, no extra product surface.

## Good Mental Model

```text
Phone prompt -> Telegram bot -> Mac LaunchAgent -> Codex CLI -> Telegram reply
```

The default normal prompt path uses your configured Codex model and reasoning effort through the local Codex app CLI.

## Prompts That Fit

```text
check the app or browser state I already have open and summarize the next action
open my portfolio repo and tell me the next best fix
use available local tools to inspect whether the target app is running
make this folder easier to understand
generate a cover image for this idea and send me the file path
send a screenshot/photo and ask what changed or what to do next
run the tests here and tell me the smallest useful fix
```

Best prompts include a folder, a stopping point, and whether public actions are allowed.

## Thread Flow

```text
/alive
/health
/screenshot
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

- `/ping`, `/alive`, `/health`, `/screenshot`, `/status`, `/where`, `/list`, `/new`, and `/cd` should feel quick.
- `/jobs`, `/cancel`, and `/history` should work while Codex is busy.
- Normal prompts wait for Codex to finish.
- Normal prompts use your configured Codex model and reasoning effort.
- Image, browser, repo-editing, test-running, and desktop/app-control prompts can take tens of seconds or minutes. Desktop/app-control behavior depends on what your local Codex runtime exposes.
- If the request is public or irreversible, ask Codex to draft and stop before posting, pushing, paying, deleting, or changing accounts.

## Runtime

- Service: `~/Library/LaunchAgents/com.codexrelay.agent.plist`
- Runtime dir: `~/Library/Application Support/CodexRelay`
- Status: `./scripts/status.sh`
- Stop LaunchAgent: `./scripts/uninstall.sh`
- Runtime files remain unless removed separately from `~/Library/Application Support/CodexRelay`

## Limits

This is a local Codex runtime, not a visible Codex Mac app thread. It can use the same signed-in Codex CLI/plugin setup, but it does not mirror the desktop chat UI.

Telegram photos and image documents are saved in the private runtime state directory and attached to the next Codex prompt.

It is unofficial, uses your normal Codex/OpenAI account limits, and can only use tools exposed by the local Codex runtime on that Mac.
