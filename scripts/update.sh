#!/bin/zsh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
cd "$ROOT"

printf "Updating Codex Relay...\n"
git pull --ff-only
"$ROOT/scripts/install_launch_agent.sh"
"$ROOT/scripts/doctor.sh"
printf "\nOptional Mac control surface:\n./scripts/menu_bar.sh\n"
printf "\nOptional local status page:\n./scripts/status_ui.sh\n"
printf "\nUpdated and running.\n"
