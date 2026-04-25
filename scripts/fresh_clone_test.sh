#!/bin/zsh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
SOURCE="${1:-$ROOT}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

printf "Fresh clone test\n"
printf "source: %s\n" "$SOURCE"

if [[ "$SOURCE" == "$ROOT" && -n "$(git -C "$ROOT" status --short)" ]]; then
  printf "mode: current working tree copy\n"
  mkdir -p "$TMP/codex-relay"
  git -C "$ROOT" ls-files -co --exclude-standard -z | while IFS= read -r -d '' file_path; do
    mkdir -p "$TMP/codex-relay/$(dirname "$file_path")"
    cp -p "$ROOT/$file_path" "$TMP/codex-relay/$file_path"
  done
else
  printf "mode: git clone\n"
  git clone --quiet "$SOURCE" "$TMP/codex-relay"
fi

cd "$TMP/codex-relay"

python3 -m py_compile codex_relay.py scripts/configure.py scripts/smoke_test.py
PYTHONPATH="$PWD" python3 scripts/smoke_test.py
./scripts/demo.sh

printf "ok: fresh clone works without Telegram secrets\n"
