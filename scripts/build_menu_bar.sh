#!/bin/zsh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
APP="$ROOT/build/CodexRelayMenu.app"
BIN="$APP/Contents/MacOS/CodexRelayMenu"
RES="$APP/Contents/Resources"

command -v swiftc >/dev/null 2>&1 || {
  printf "swiftc is required. Install Apple command line tools first: xcode-select --install\n" >&2
  exit 1
}

mkdir -p "$APP/Contents/MacOS" "$RES"
printf "%s\n" "$ROOT" > "$RES/repo-path.txt"

cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key>
  <string>CodexRelayMenu</string>
  <key>CFBundleIdentifier</key>
  <string>com.codexrelay.menu</string>
  <key>CFBundleName</key>
  <string>Codex Relay</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSMinimumSystemVersion</key>
  <string>12.0</string>
  <key>LSUIElement</key>
  <true/>
  <key>NSHighResolutionCapable</key>
  <true/>
</dict>
</plist>
PLIST

swiftc "$ROOT/native/CodexRelayMenu.swift" -framework AppKit -o "$BIN"
chmod 700 "$BIN"
printf "%s\n" "$APP"
