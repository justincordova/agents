#!/usr/bin/env bash
#
# Refresh the third-party skills vendored into skills/ from their upstream repos.
# Overwrites the vendored copies wholesale — local edits to them are lost, so
# customize behavior in our own skills (e.g. frontend) instead.
# Review the diff and update THIRD_PARTY.md before committing.
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

EMIL_SKILLS=(
  animate
  animation-performance
  animation-vocabulary
  apple-design
  ask-emil
  break-ui
  choreograph
  emil-design-eng
  find-animation-opportunities
  gestures
  improve-animations
  learn-taste
  mobile-native
  pick-ui-library
  prototype
  remove-animations
  review-animations
)

sync_dir() {
  local src="$1" dest="$2"
  rm -rf "$dest"
  cp -R "$src" "$dest"
  echo "  $dest"
}

echo "emilkowalski/skills:"
git clone -q --depth 1 https://github.com/emilkowalski/skills "$TMP/emil"
for skill in "${EMIL_SKILLS[@]}"; do
  sync_dir "$TMP/emil/skills/$skill" "$REPO/skills/$skill"
done
cp "$TMP/emil/LICENSE" "$REPO/licenses/emilkowalski-skills.LICENSE"
echo "  commit $(git -C "$TMP/emil" rev-parse --short HEAD)"

echo
echo "pbakaus/impeccable (OpenCode build):"
git clone -q --depth 1 https://github.com/pbakaus/impeccable "$TMP/impeccable"
sync_dir "$TMP/impeccable/.opencode/skills/impeccable" "$REPO/skills/impeccable"
cp "$TMP/impeccable/LICENSE" "$REPO/licenses/impeccable.LICENSE"
cp "$TMP/impeccable/NOTICE.md" "$REPO/licenses/impeccable.NOTICE.md"
echo "  commit $(git -C "$TMP/impeccable" rev-parse --short HEAD)"

echo
echo "Done. Review with 'git diff --stat', then update the commits in THIRD_PARTY.md."
