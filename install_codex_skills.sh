#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd -P)"
SOURCE_SKILLS_DIR="$SCRIPT_DIR/.agents/skills"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"

SKILLS=(
  "nemesis-auditor"
  "feynman-auditor"
  "state-inconsistency-auditor"
)

mkdir -p "$CODEX_SKILLS_DIR"

for skill in "${SKILLS[@]}"; do
  src="$SOURCE_SKILLS_DIR/$skill"
  dst="$CODEX_SKILLS_DIR/$skill"

  if [ ! -d "$src" ]; then
    echo "Missing skill source: $src" >&2
    exit 1
  fi

  if [ -L "$dst" ]; then
    existing_target="$(readlink "$dst")"
    if [ "$existing_target" = "$src" ]; then
      echo "Already linked: $dst -> $src"
      continue
    fi

    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "Refusing to overwrite non-symlink path: $dst" >&2
    exit 1
  fi

  ln -s "$src" "$dst"
  echo "Linked: $dst -> $src"
done

echo "Nemesis Auditor skills are installed. Restart Codex if they do not appear."
