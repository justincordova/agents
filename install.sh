#!/usr/bin/env bash
#
# Symlink this repo's agent config into Claude Code and OpenCode.
# Safe to re-run — existing links are replaced in place.
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

# Skills are linked one directory at a time so standalone skills installed
# outside this repo can live alongside them.
link_skills() {
  local dest_dir="$1" skill
  mkdir -p "$dest_dir"
  for skill in "$REPO"/skills/*/; do
    link "${skill%/}" "$dest_dir/$(basename "$skill")"
  done
}

echo "Claude Code (~/.claude):"
link "$REPO/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$REPO/RTK.md"    "$HOME/.claude/RTK.md"
link "$REPO/commands"  "$HOME/.claude/commands"
link "$REPO/rules"     "$HOME/.claude/rules"
link_skills "$HOME/.claude/skills"

command -v rtk >/dev/null 2>&1 || \
  echo "  note: rtk is not installed — RTK.md's guidance will not apply"

echo
echo "OpenCode (~/.opencode):"
link "$REPO/AGENTS.md" "$HOME/.opencode/AGENTS.md"
link "$REPO/commands"  "$HOME/.opencode/commands"
link "$REPO/rules"     "$HOME/.opencode/rules"
link_skills "$HOME/.opencode/skills"

echo
echo "Done."
