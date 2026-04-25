# Security

Codex Relay is a local remote-control bridge. Treat it like SSH into your Mac through Telegram.

## What Stays Local

- Telegram bot token in `.env` and runtime config.
- Thread state in `~/Library/Application Support/CodexRelay/state`.
- Telegram image attachments in the private runtime state directory until retention pruning.
- Mac screenshots captured by `/screenshot` in the private runtime state directory.
- Codex work runs on your Mac through your installed Codex CLI.

## Main Risk

Anyone who can message the allow-listed Telegram account or steal the bot token can ask Codex to act on the Mac.

This is a remote-control surface, not a sandboxed hosted assistant. Keep the allowlist and token private.

## Defaults

- `.env` is gitignored.
- Runtime config is written with private file permissions.
- Setup allow-lists one Telegram user and chat.
- Group chats are disabled unless `CODEX_TELEGRAM_ALLOW_GROUP_CHATS=true`.
- `/screenshot` captures the current Mac screen and sends it to the allow-listed Telegram chat.
- `/policy` prints the operating boundary directly in Telegram.
- The default Codex sandbox is `danger-full-access`.
- The default approval policy is `never`.
- The default task timeout is 600 seconds.

## Recommendations

- Use a dedicated Telegram bot.
- Do not share the bot token.
- Keep the Mac account locked when unattended in public.
- Keep the bot allowlist narrow.
- Rotate the bot token with `@BotFather` if it leaks.
- Use `./scripts/uninstall.sh` to stop the service.

## Operational Limits

- Codex Relay waits for the local Codex CLI run to finish before sending the final answer.
- Telegram typing status means the bridge is still waiting on Codex; it is not proof that Codex will succeed.
- Long-running tasks can still time out, fail, or stop at Codex/OpenAI/macOS confirmation boundaries.
- Public posting, account changes, payments, and anything irreversible should stay human-confirmed.

## Reporting

Open a GitHub issue with reproduction steps. Do not include tokens, logs with secrets, or private Codex transcripts.
