#!/usr/bin/env bash
# Zip skills for upload to the Claude desktop app (Settings > Capabilities > Skills).
#   ./scripts/package.sh            zip every skill
#   ./scripts/package.sh ask katex  zip only these
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO/dist"

names=("$@")
if (( ${#names[@]} == 0 )); then
  for d in "$REPO"/skills/*/; do names+=("$(basename "$d")"); done
fi

for name in "${names[@]}"; do
  [[ -f "$REPO/skills/$name/SKILL.md" ]] || { echo "no such skill: $name" >&2; exit 1; }
  out="$REPO/dist/$name.zip"
  rm -f "$out"
  (cd "$REPO/skills" && zip -qr "$out" "$name" -x '*.DS_Store')
  echo "$out"
done
