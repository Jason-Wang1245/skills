#!/usr/bin/env bash
# Symlink every skill in this repo into each harness's personal skills folder.
# Safe to re-run. Never overwrites a real (non-symlink) folder.
#   ./scripts/link.sh          link all skills
#   ./scripts/link.sh --prune  also remove links to skills deleted from the repo
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO/skills"

# ~/.claude/skills -> Claude Code (Copilot CLI and VS Code also read it)
# ~/.agents/skills -> Codex, Copilot CLI, VS Code
TARGETS=("$HOME/.claude/skills" "$HOME/.agents/skills")

PRUNE=0
[[ "${1:-}" == "--prune" ]] && PRUNE=1

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  for dir in "$SRC"/*/; do
    name="$(basename "$dir")"
    dest="$target/$name"
    want="$SRC/$name"
    if [[ -L "$dest" ]]; then
      [[ "$(readlink "$dest")" == "$want" ]] && continue
      ln -sfn "$want" "$dest"; echo "relinked $dest"
    elif [[ -e "$dest" ]]; then
      echo "skip     $dest (real folder exists; not touching it)" >&2
    else
      ln -s "$want" "$dest"; echo "linked   $dest"
    fi
  done

  if (( PRUNE )); then
    for link in "$target"/*; do
      [[ -L "$link" ]] || continue
      case "$(readlink "$link")" in
        "$SRC"/*) [[ -e "$link" ]] || { rm "$link"; echo "pruned   $link"; } ;;
      esac
    done
  fi
done
