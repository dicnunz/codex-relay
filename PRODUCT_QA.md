# Product QA

This is the pre-launch quality bar for Codex Relay.

## What Made The Category Feel Cool

OpenClaw's pull was not a novelty bot. It made a local machine feel reachable through normal chat, stayed online as a background gateway, kept state, worked through messaging surfaces, and could act on real tools instead of only talking.

Codex Relay should be narrower and cleaner:

- Telegram is the remote.
- Codex is the engine.
- The Mac is the computer being operated.
- The first run should show `/alive`, `/tools`, `/try`, then a real task.

## Verified Locally

- `/alive`: instant live status with thread, model, folder, and routing.
- `/capabilities`: honest capability and safety scope.
- `/try`: first-run prompt menu.
- `/new viralqa`: created a named Telegram-backed Codex thread.
- `/cd <repo>`: set a per-thread repo folder.
- Normal task: Codex read live repo state and reported branch, latest commit, README assets, video asset, and weakness.
- Subagent task: Telegram-launched Codex spawned a subagent and read the README title.
- `/tools`: Computer Use ok, Telegram running, ChatGPT Atlas running.

## Current Weakness

The first magic moment still comes after Telegram BotFather setup. The honest fix is strong onboarding, not pretending there is no credential step.

## Launch Bar

Do not post until the public demo shows:

1. `/alive`
2. `/tools`
3. one real repo or Mac-app task
4. the result coming back to Telegram
5. the GitHub install command
