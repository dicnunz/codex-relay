#!/bin/zsh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
OUT="$ROOT/assets/codex-relay-demo.mp4"
POSTER="$ROOT/assets/codex-relay-demo-poster.png"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

write_slide() {
  local file="$1"
  local title="$2"
  local subtitle="$3"
  local phone1="$4"
  local phone2="$5"
  local mac1="$6"
  local mac2="$7"
  local footer="$8"

  cat > "$file" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="1280" height="1280" viewBox="0 0 1280 1280">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#111827"/>
      <stop offset="1" stop-color="#052e2b"/>
    </linearGradient>
  </defs>
  <rect width="1280" height="1280" fill="url(#bg)"/>
  <rect x="54" y="48" width="1172" height="624" rx="28" fill="#0b1220" stroke="#1f3b4d"/>
  <text x="86" y="104" fill="#e0f2fe" font-family="Arial, sans-serif" font-size="44" font-weight="800">$title</text>
  <text x="86" y="144" fill="#67e8f9" font-family="Arial, sans-serif" font-size="25">$subtitle</text>

  <rect x="86" y="188" width="360" height="352" rx="26" fill="#020617" stroke="#334155"/>
  <rect x="86" y="188" width="360" height="56" rx="26" fill="#1e293b"/>
  <text x="118" y="224" fill="#e0f2fe" font-family="Arial, sans-serif" font-size="24" font-weight="700">Telegram</text>
  <rect x="118" y="278" width="254" height="58" rx="20" fill="#2563eb"/>
  <text x="140" y="315" fill="#ffffff" font-family="Menlo, monospace" font-size="22">$phone1</text>
  <rect x="180" y="370" width="222" height="94" rx="20" fill="#155e75"/>
  <text x="204" y="408" fill="#ecfeff" font-family="Menlo, monospace" font-size="19">$phone2</text>

  <text x="486" y="370" fill="#67e8f9" font-family="Arial, sans-serif" font-size="58" font-weight="800">-&gt;</text>

  <rect x="586" y="188" width="608" height="352" rx="26" fill="#020617" stroke="#334155"/>
  <rect x="586" y="188" width="608" height="56" rx="26" fill="#1e293b"/>
  <text x="618" y="224" fill="#e0f2fe" font-family="Arial, sans-serif" font-size="24" font-weight="700">Mac running Codex</text>
  <text x="618" y="304" fill="#93c5fd" font-family="Menlo, monospace" font-size="25">$mac1</text>
  <text x="618" y="364" fill="#bbf7d0" font-family="Menlo, monospace" font-size="25">$mac2</text>
  <rect x="618" y="430" width="328" height="52" rx="20" fill="#0e7490"/>
  <text x="642" y="464" fill="#ecfeff" font-family="Arial, sans-serif" font-size="24" font-weight="700">Local. Private. Live.</text>

  <text x="86" y="628" fill="#f8fafc" font-family="Arial, sans-serif" font-size="34" font-weight="700">$footer</text>
</svg>
SVG
}

write_slide "$TMP/slide1.svg" \
  "Codex Relay" \
  "Run Codex on your Mac from Telegram" \
  "/alive" \
  "Mac is live" \
  "gpt-5.5 ready" \
  "LaunchAgent running" \
  "Mac open on desk. You are on your phone."

write_slide "$TMP/slide2.svg" \
  "Tool Check" \
  "The phone talks to the real local runtime" \
  "/tools" \
  "Computer Use ok" \
  "Telegram running" \
  "ChatGPT Atlas running" \
  "Phone chat controls local Codex tools."

write_slide "$TMP/slide3.svg" \
  "Real Task" \
  "Ask from bed. The Mac does the work." \
  "check due work" \
  "working..." \
  "Reading live app state" \
  "Returning answer" \
  "Not hosted. Your Mac does the work."

write_slide "$TMP/slide4.svg" \
  "Codex Runtime" \
  "Same serious tools from a phone chat" \
  "spawn subagent" \
  "README title" \
  "Subagent available" \
  "Result: Codex Relay" \
  "Not a chatbot gimmick. Codex does the work."

write_slide "$TMP/slide5.svg" \
  "Install" \
  "Small repo. Local setup. No cloud relay." \
  "git clone" \
  "./scripts/install.sh" \
  "github.com/dicnunz/codex-relay" \
  "BotFather token then /start" \
  "github.com/dicnunz/codex-relay"

for i in 1 2 3 4 5; do
  qlmanage -t -s 1280 -o "$TMP" "$TMP/slide$i.svg" >/dev/null 2>&1
  ffmpeg -y -v error -i "$TMP/slide$i.svg.png" \
    -vf "crop=1280:720:0:0,format=rgba" "$TMP/frame$i.png"
done

ffmpeg -y -v error \
  -loop 1 -t 4.5 -i "$TMP/frame1.png" \
  -loop 1 -t 4.5 -i "$TMP/frame2.png" \
  -loop 1 -t 4.5 -i "$TMP/frame3.png" \
  -loop 1 -t 4.5 -i "$TMP/frame4.png" \
  -loop 1 -t 5.0 -i "$TMP/frame5.png" \
  -filter_complex "[0:v]fps=30,format=yuv420p[v0];[1:v]fps=30,format=yuv420p[v1];[2:v]fps=30,format=yuv420p[v2];[3:v]fps=30,format=yuv420p[v3];[4:v]fps=30,format=yuv420p[v4];[v0][v1][v2][v3][v4]concat=n=5:v=1:a=0,format=yuv420p[v]" \
  -map "[v]" -c:v libx264 -preset veryfast -crf 22 -movflags +faststart "$OUT"

cp "$TMP/frame2.png" "$POSTER"

echo "wrote $OUT"
echo "wrote $POSTER"
