#!/bin/zsh
set -eu

LABEL="${CODEX_RELAY_LABEL:-com.codexrelay.agent}"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

launchctl bootout "gui/$(id -u)" "$PLIST" >/dev/null 2>&1 || true
rm -f "$PLIST"
echo "Stopped Codex Relay and removed the LaunchAgent plist. Runtime files remain in ~/Library/Application Support/CodexRelay."
