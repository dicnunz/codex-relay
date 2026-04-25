#!/bin/zsh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
APP="$("$ROOT/scripts/build_menu_bar.sh")"
open "$APP"
printf "Opened %s\n" "$APP"
