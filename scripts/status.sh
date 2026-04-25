#!/bin/zsh
set -eu

LABEL="${CODEX_RELAY_LABEL:-com.codexrelay.agent}"
RUNTIME="$HOME/Library/Application Support/CodexRelay"

if output="$(launchctl print "gui/$(id -u)/$LABEL" 2>/dev/null)"; then
  printf "%s\n" "$output" | sed -n '1,45p'
else
  printf "LaunchAgent not loaded: %s\n" "$LABEL"
fi
echo
if [[ -x "$RUNTIME/codex_relay.py" ]]; then
  "$RUNTIME/codex_relay.py" --check-config
else
  printf "Runtime script missing: %s/codex_relay.py\n" "$RUNTIME"
  exit 1
fi
