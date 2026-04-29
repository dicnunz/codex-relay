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
  mkdir -p "$TMP/codex-mission-control"
  git -C "$ROOT" ls-files -co --exclude-standard -z | while IFS= read -r -d '' file_path; do
    [[ -e "$ROOT/$file_path" ]] || continue
    mkdir -p "$TMP/codex-mission-control/$(dirname "$file_path")"
    cp -p "$ROOT/$file_path" "$TMP/codex-mission-control/$file_path"
  done
else
  printf "mode: git clone\n"
  git clone --quiet "$SOURCE" "$TMP/codex-mission-control"
fi

cd "$TMP/codex-mission-control"

python3 -m py_compile mission_control.py codex_relay.py scripts/configure.py scripts/smoke_test.py
PYTHONPATH="$PWD" python3 scripts/smoke_test.py
./cmc --hub "$TMP/hub" init >/dev/null
./cmc --hub "$TMP/hub" discover "$PWD" >/dev/null
./cmc --hub "$TMP/hub" status >/dev/null
./cmc --hub "$TMP/hub" doctor >/dev/null
./cmc --hub "$TMP/hub" instructions >/dev/null
./cmc --hub "$TMP/hub" adopt >/dev/null
./cmc --hub "$TMP/hub" claim BROWSER TEST "fresh clone" >/dev/null
if ./cmc --hub "$TMP/hub" claim BROWSER OTHER "fresh clone" >/dev/null 2>&1; then
  printf "expected second BROWSER claim to fail\n" >&2
  exit 1
fi
./cmc --hub "$TMP/hub" release BROWSER TEST >/dev/null
./cmc --hub "$TMP/hub" packet --mission TEST --action inspect --target repo --object readme --proof proof.txt --risk none --why demo --stop done >/dev/null
./scripts/demo.sh
if command -v swiftc >/dev/null 2>&1; then
  ./scripts/build_menu_bar.sh >/dev/null
fi

ISO_HOME="$TMP/home"
mkdir -p "$ISO_HOME"
HOME="$ISO_HOME" \
CODEX_RELAY_LABEL="com.codexrelay.fresh.$RANDOM" \
CODEX_MISSION_CONTROL_HOME="$ISO_HOME/Codex Mission Control" \
CMC_ADOPT_AGENTS=yes \
CMC_INSTALL_RELAY=no \
./scripts/install.sh >/dev/null
"$ISO_HOME/.local/bin/cmc" --version >/dev/null
"$ISO_HOME/.local/bin/cmc" --hub "$ISO_HOME/Codex Mission Control" doctor >/dev/null

printf "ok: fresh clone works without Telegram secrets\n"
