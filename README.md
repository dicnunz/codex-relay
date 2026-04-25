# Codex Relay

[![ci](https://github.com/dicnunz/codex-relay/actions/workflows/ci.yml/badge.svg)](https://github.com/dicnunz/codex-relay/actions/workflows/ci.yml)

Text your Mac from Telegram. Codex does the work locally.

<p align="center">
  <img src="assets/social-card.svg" alt="Codex Relay: Telegram remote for Codex on your Mac" width="100%">
</p>

Text your bot from your phone. A LaunchAgent on your Mac runs the local Codex app CLI, waits for the run to finish, and sends the final answer back to Telegram.

That is the product: Telegram is the remote, Codex is the engine, and your Mac is the machine doing the work.

Use this when screen sharing is the wrong shape and you do not want to maintain another web service. You text the task; the Mac does the work.

> Unofficial project. Not affiliated with OpenAI or Telegram.

## Before You Install

This is a powerful local remote-control surface. The default setup lets your allow-listed Telegram DM ask Codex to act on your Mac with your configured sandbox and approval settings.

Use a dedicated bot and keep the token private. Stop the LaunchAgent with:

```bash
./scripts/uninstall.sh
```

Runtime files remain under `~/Library/Application Support/CodexRelay` unless you remove them separately.

## Quickstart

You need the Codex Mac app signed in, a Telegram account, and a dedicated bot token from `@BotFather`. The installer verifies the token, gives you a one-time `/start` code, allow-lists your DM, and starts the LaunchAgent.

```bash
git clone https://github.com/dicnunz/codex-relay.git
cd codex-relay
./scripts/install.sh
```

Manual setup is creating a bot with `@BotFather`, pasting its token, then sending the installer's `/start` code so it can allow-list your Telegram user. The token stays in your local `.env`.

Then DM your bot:

```text
/alive
/health
/policy
/screenshot
/tools
/latency
send a screenshot and ask what changed
```

Optional Mac control surface:

```bash
./scripts/menu_bar.sh
```

That builds and opens a small native menu-bar app for status, doctor, restart, update, and copying the best first Telegram commands.

## Explainer

[Watch the explainer](assets/codex-relay-demo.mp4)

<p align="center">
  <img src="assets/codex-relay-demo-poster.png" alt="Codex Relay demo poster" width="760">
</p>

```text
/alive
/screenshot
/tools
/jobs
send a screenshot and ask what changed
/cd Projects/my-repo
make this repo launch-ready without pushing
```

The demo is meant to make one thing obvious: Telegram is only the remote. The real work happens on the Mac through your installed Codex CLI, in the folder and sandbox you configured.

<p align="center">
  <img src="assets/demo-transcript.svg" alt="Codex Relay Telegram transcript" width="760">
</p>

## What It Is

| It is | It is not |
| --- | --- |
| A private Telegram remote for local Codex on your Mac | An official OpenAI app |
| A macOS LaunchAgent that calls the Codex app CLI | A hosted agent platform |
| A way to send tasks, images, repo work, and local Mac requests from your phone | A VNC screen mirror |
| A small local bridge with allow-listed Telegram access | A bypass for logins, MFA, limits, or confirmations |

## Why Use It

Codex Relay is useful when a task is worth handing to the Mac even though you are not at the keyboard:

- Check a repo while you are away from the laptop.
- Ask for `/screenshot` and see what is on the Mac without opening VNC.
- Send a screenshot and ask what changed.
- Run a small fix, test, or doc pass in a known folder.
- Ask Codex to inspect local files, apps, or browser state when your Codex runtime exposes those tools.
- Check Codex automations from your phone with `/automations`.

It is not instant chat. A `/ping` is immediate, but a normal request waits for Codex CLI startup, your configured model and reasoning effort, local tool work, and Telegram delivery. Small text tasks can feel quick; image, browser, repo, test-running, and desktop/app-control tasks can take tens of seconds or minutes. Desktop/app-control behavior depends on what your local Codex runtime exposes. The default task timeout is 600 seconds.

## What It Does

- Configured Codex model and reasoning effort through the Codex app CLI.
- Private Telegram bot allow-listed to your Telegram user.
- Background jobs with `/jobs`, `/cancel`, and `/history`.
- Fast local bridge checks with `/health`.
- Plain safety boundary with `/policy`.
- Mac screenshots returned to Telegram with `/screenshot`.
- Latency and mode controls with `/latency`, `/brief`, and `/verbose`.
- Named Codex threads: `/new`, `/use`, `/list`, `/reset`.
- Per-thread folders: `/cd`, `/where`, `/home`.
- Telegram photos and image documents passed to Codex with `--image`.
- `/automations` shortcut for a guardrailed Codex automation inspection.
- Mac-side files, repos, shell, images, and whatever tools your local Codex runtime exposes.
- macOS LaunchAgent so the relay stays running after setup.
- Optional native macOS menu-bar controller for status, doctor, restart, and update.
- Local config only. No extra hosted relay account.

## Architecture

```text
Telegram DM -> local LaunchAgent -> Codex app CLI -> your Mac -> Telegram reply
```

The relay does not mirror the visible Codex desktop chat UI. It invokes your local Codex CLI with the configured model, workdir, sandbox, approval mode, and optional image attachment.

## Install Details

Requirements:

- macOS
- Python 3 available as `python3`
- Codex Mac app installed and signed in
- Telegram account
- A Telegram bot token from `@BotFather`
- Apple command line tools if you want the optional menu-bar app

The installer:

1. Finds the Codex app CLI.
2. Asks for your Telegram bot token.
3. Verifies the bot with Telegram.
4. Waits for you to send the one-time `/start` code.
5. Allow-lists your Telegram user.
6. Installs and starts the LaunchAgent.
7. Runs `doctor.sh` so setup failures are caught immediately.

It also runs a small preflight first so obvious local blockers fail before you paste credentials.

After install, DM your bot:

```text
/alive
/health
/screenshot
/tools
/latency
/new repo
/cd Projects/my-repo
read this repo and tell me the next best fix
```

## Commands

```text
/alive        live route, model, folder, uptime
/status       current thread and runtime config
/health       fast local bridge checks, no Codex run
/policy      safety boundary and allowed surface
/screenshot   send the Mac screen back to Telegram
/latency      last Codex run timing and timeout
/jobs         running jobs and last run
/cancel id    stop a running job
/history      recent run receipts, no prompt/response logs
/automations  inspect Codex automations through Codex
/tools        quick Codex tool probe
/try          useful first prompts
/new name     new Codex thread
/use name     switch threads
/list         list threads
/where        show active folder
/cd path      set active folder
/home         set folder to ~
/brief        terse replies for this thread
/verbose      detailed replies for this thread
/update       show local update command
/reset        clear the current Codex session
/ping         bridge check
```

Normal messages go to the active thread. Captions on Telegram images become the prompt; image files are saved privately and attached to Codex.

## Message Style

By default, Codex Relay sends clean Telegram messages instead of explicit reply bubbles quoting your last message. Turn threaded replies back on only if you want that chat style:

```env
CODEX_TELEGRAM_REPLY_TO_MESSAGES=true
```

Normal messages use `CODEX_TELEGRAM_MODEL` and `CODEX_TELEGRAM_REASONING_EFFORT` from `.env`. The sample config defaults to `gpt-5.5` and `xhigh`; change those only if you intentionally want a different reasoning profile.

`/status` shows the active reasoning setting, last run status, and latency after Codex replies.

Use `/brief` for phone-friendly answers and `/verbose` when you want debugging detail or a handoff summary. The setting is stored per thread.

## Verify

```bash
./scripts/doctor.sh
./scripts/status.sh
./scripts/status_ui.sh
./scripts/menu_bar.sh
./scripts/demo.sh
./scripts/fresh_clone_test.sh
```

Use `doctor.sh` as the pass/fail install check. Use `status.sh` for diagnostics. `doctor.sh` checks the Mac environment, Codex CLI, local config, LaunchAgent, runtime copy, Python syntax, and smoke tests.

`status_ui.sh` opens a private local status page generated from `status.sh`. `menu_bar.sh` builds and opens the optional native macOS menu-bar controller. `fresh_clone_test.sh` clones the repo into a temp folder and proves the no-secrets demo path works from a clean checkout.

Runtime files:

```text
~/Library/Application Support/CodexRelay
~/Library/LaunchAgents/com.codexrelay.agent.plist
```

Update later with:

```bash
./scripts/update.sh
```

CI runs the same syntax, smoke, and local demo checks on macOS.

## Safety

Codex Relay is intentionally powerful. If you expose your Telegram bot, you are exposing a path to Codex on your Mac.

- `.env` is private and gitignored.
- Runtime config is copied with `0600` permissions.
- Only the allow-listed Telegram user/chat can run Codex.
- Group chats are disabled unless `CODEX_TELEGRAM_ALLOW_GROUP_CHATS=true`.
- Images are stored in the private runtime state directory and pruned by retention settings.
- `/policy` shows the same boundary inside Telegram.
- High-risk actions can still hit Codex/OpenAI/macOS confirmations.
- It cannot bypass logins, MFA, macOS privacy prompts, site safety barriers, account limits, or mandatory confirmations.

Use it only with a Telegram account and Mac you trust.

## Honest Limits

- It uses your normal Codex/OpenAI account limits.
- Telegram and Codex/OpenAI are still in the path; this only avoids adding another hosted relay server.
- It does not mirror the visible Codex desktop chat UI.
- It waits for Codex to finish before sending the final answer.
- It is not a generic agent platform.
- Computer Use and plugin behavior depend on what your local Codex runtime exposes.
- The bot will feel as capable as the Codex install on that Mac, not more.
- It is not an official OpenAI project.

## Why This Exists

Codex is already useful on a Mac. Codex Relay just makes it reachable from the chat app already on your phone.

Small surface. Local runtime. Real Codex.
