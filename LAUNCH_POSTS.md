# Launch Posts

## Primary X Post

```text
I built a Telegram remote for Codex on your Mac.

Text the bot. Your Mac runs the real Codex CLI locally and replies when the job is done.

No hosted relay. No new agent platform.

https://github.com/dicnunz/codex-relay
```

Attach: `assets/codex-relay-demo.mp4`

## Alternate Short

```text
Codex Relay turns Telegram into a remote for Codex on your Mac.

Your phone sends the task.
Your Mac runs Codex locally.
Telegram gets the final answer back.

https://github.com/dicnunz/codex-relay
```

## First Reply

```text
Install:

git clone https://github.com/dicnunz/codex-relay.git
cd codex-relay
./scripts/install.sh

Then DM your bot:
/alive
/tools
send a screenshot and ask what changed
```

## Latency Reply

Use this if someone asks "how fast is it?" or "why does it take a while?":

```text
It is not trying to be instant chat. Telegram is just the remote; the Mac still starts Codex, runs gpt-5.5 with xhigh reasoning, uses tools, and then sends the final reply back. A trivial probe on my Mac was about 5-6s. Real repo/browser/image tasks can take tens of seconds or minutes.
```

Short version:

```text
Same latency as a local Codex run, plus Telegram. Trivial gpt-5.5 xhigh probe was ~5s here; real tool work is usually tens of seconds or more.
```

## Launch Checklist

- Use the generated demo video, not a raw UI accident.
- First frame must make the flow obvious: Telegram -> Codex CLI -> Mac.
- Keep the post plain. No "AGI", "always-on agent", "instant", or fake autonomy language.
- Reply with install commands.
- Keep the latency reply nearby.
- Pin the repo after posting.
- If asked, say plainly that it is unofficial and local-first.
