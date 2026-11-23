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
  # Drop links to skills that were renamed or removed from this repo.
  for existing in "$dest_dir"/*; do
    if [ -L "$existing" ] && [ ! -e "$existing" ] && [[ "$(readlink "$existing")" == "$REPO"/skills/* ]]; then
      rm "$existing"
      echo "  removed stale $existing"
    fi
  done
}

echo "Claude Code (~/.claude):"
link "$REPO/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$REPO/RTK.md"    "$HOME/.claude/RTK.md"
link "$REPO/rules"     "$HOME/.claude/rules"
link_skills "$HOME/.claude/skills"

# Claude Code exposes every skill as /<name>, and a same-named skill shadows a
# command, so commands/ is only linked for OpenCode.
if [ -L "$HOME/.claude/commands" ] && [ "$(readlink "$HOME/.claude/commands")" = "$REPO/commands" ]; then
  rm "$HOME/.claude/commands"
  echo "  removed $HOME/.claude/commands (skills already provide these)"
fi

command -v rtk >/dev/null 2>&1 || \
  echo "  note: rtk is not installed — RTK.md's guidance will not apply"

echo
echo "OpenCode (~/.config/opencode):"
OPENCODE="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
link "$REPO/AGENTS.md" "$OPENCODE/AGENTS.md"
link "$REPO/RTK.md"    "$OPENCODE/RTK.md"
link "$REPO/commands"  "$OPENCODE/commands"
link "$REPO/rules"     "$OPENCODE/rules"
link_skills "$OPENCODE/skills"

# OpenCode does not expand AGENTS.md's @-imports; it loads extra files from the
# "instructions" array in opencode.json instead.
grep -q '"instructions"' "$OPENCODE/opencode.json" 2>/dev/null || \
  echo "  note: add to $OPENCODE/opencode.json so rules/ and RTK.md load:" \
       '"instructions": ["~/.config/opencode/rules/*.md", "~/.config/opencode/RTK.md"]'

# Earlier versions linked into ~/.opencode, which OpenCode does not read.
for old in "$HOME/.opencode/AGENTS.md" "$HOME/.opencode/commands" "$HOME/.opencode/rules" "$HOME"/.opencode/skills/*; do
  if [ -L "$old" ] && [[ "$(readlink "$old")" == "$REPO"/* ]]; then
    rm "$old"
    echo "  removed stale $old"
  fi
done

echo
echo "Done."
