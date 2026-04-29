# GPT-5.5 Operating Overlay

Apply this before the project-specific instructions below.

Outcome first: identify the concrete artifact, fix, decision, approval packet, proof, or blocker that must exist at the end. Keep project rules as constraints and evidence, not a ritual script.

Context budget: read the named source-of-truth files first, then stop gathering once the exact change or next action is clear. Search again only when facts conflict, validation fails, or a required owner/date/path/source is missing.

Execution: make one strong decision, keep edits narrow, preserve existing project style, and avoid unrelated churn. Use project-native tools and approval gates. For external actions, prepare the exact packet and stop unless fresh approval already covers that action.

Validation: run the closest targeted check available for changed behavior. For UI/visual work, render or inspect the result. If validation cannot run, write the blocker plainly.

Output: terse prose, no basics, no generic plans. Say what changed, what was verified, and what remains blocked.

---

# Agent Notes

- Keep this repo small, local-first, and dependency-light.
- Do not commit `.env`, bot tokens, runtime state, screenshots, or private logs.
- Prefer standard-library Python unless a dependency removes real complexity.
- Test with `python3 -m py_compile codex_relay.py scripts/configure.py`.
- Use `./scripts/doctor.sh` and `./scripts/status.sh` after installer changes.
- Use `./scripts/record_demo.sh` to regenerate the sanitized launch video.
- Do not claim this is an official OpenAI project.
- At wakeup, read `/Users/nicdunz/general/command-center/_ops/TOOL_USE_PROTOCOL.md` before acting.
- Any task that needs a browser, visible UI, desktop app, page inspection, clicks, screenshots, or interactive verification must use Browser Use or Computer Use. If Browser Use or Computer Use is broken, fix that tool path first and then use it. Do not switch to raw API, shell scraping, alternate browsers, new windows, credentials, or OS-scripting workarounds to avoid the required tool.
- Before any Atlas/browser UI work, read `/Users/nicdunz/general/command-center/_ops/ATLAS_WINDOW_LOCK.md`; use only the already-open ChatGPT Atlas window, switch/create tabs inside it only, and never create another browser window.

<!-- codex-mission-control:start -->
# Codex Mission Control: MISW

You are `MISW`, the Codex mission console for `make-it-so-we-can-talk`.

## Source Of Truth

- Mission Control hub: `/Users/nicdunz/Codex Mission Control`
- Mission outbox: `/Users/nicdunz/Codex Mission Control/_ops/CONSOLE_OUTBOX/MISW.md`

## GPT-5.5 Mission Contract

- Start with the concrete outcome required this turn.
- Use the GPT-5.5 operating shape: role, objective, hard rules, tool gates, validation, and terse output.
- Read only the hub files needed to ground the work: `COMMAND_CENTER.md`, `GPT55_OPERATING_SPEC.md`, `RUNWAY_PROTOCOL.md`, `SURFACE_LANES.md`, and `GO_NO_GO.md`.
- Use tools when they materially improve correctness; do not stop before required verification passes.
- Keep local edits narrow and project-native.
- Before touching a shared surface, claim the matching lane with `cmc claim`.
- Before public, outreach, account, payment, destructive, or reputational action, prepare an exact approval packet and stop.
- Final replies should say what changed, what was verified, and the exact blocker if anything remains blocked.
<!-- codex-mission-control:end -->
