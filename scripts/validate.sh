#!/usr/bin/env bash
#
# Validate the structural contracts this repo depends on.
#
# Everything here is markdown held together by convention: skill frontmatter
# must match directory names, commands must point at skills that exist, and the
# README must describe what is actually on disk. Nothing enforces that at
# runtime — the tools just silently ignore what they can't parse. This does.
#
set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO"

fails=0
fail() {
  echo "FAIL: $*"
  fails=$((fails + 1))
}

# Print the value of a YAML frontmatter field, or nothing if absent.
frontmatter() {
  awk -v key="$2" '
    NR == 1 && $0 != "---" { exit }
    NR > 1 && $0 == "---"  { exit }
    NR > 1 && index($0, key ":") == 1 {
      sub("^" key ": *", "")
      gsub(/^"|"$/, "")
      print
      exit
    }
  ' "$1"
}

echo "skills/"
for dir in skills/*/; do
  name="$(basename "$dir")"
  file="${dir}SKILL.md"

  if [ ! -f "$file" ]; then
    fail "skills/$name: no SKILL.md"
    continue
  fi

  fm_name="$(frontmatter "$file" name)"
  fm_desc="$(frontmatter "$file" description)"

  [ -n "$fm_desc" ] || fail "$file: missing 'description' in frontmatter"

  if [ -z "$fm_name" ]; then
    fail "$file: missing 'name' in frontmatter"
  elif [ "$fm_name" != "$name" ]; then
    fail "$file: name '$fm_name' does not match directory '$name'"
  fi
done

echo "commands/"
for file in commands/*.md; do
  [ -n "$(frontmatter "$file" description)" ] || fail "$file: missing 'description'"

  skill="$(sed -n 's/.*[Ll]oad the \([a-z][a-z-]*\) skill.*/\1/p' "$file" | head -1)"
  if [ -z "$skill" ]; then
    fail "$file: does not reference a skill (expected \"Load the <name> skill\")"
  elif [ ! -d "skills/$skill" ]; then
    fail "$file: references skill '$skill', which does not exist"
  fi
done

echo "README.md"
readme_skills="$(sed -n 's/^| \*\*\([a-z][a-z-]*\)\*\* |.*/\1/p' README.md | sort)"
disk_skills="$(basename -a skills/*/ | sort)"
if [ "$readme_skills" != "$disk_skills" ]; then
  fail "README skill table does not match skills/"
  diff <(echo "$readme_skills") <(echo "$disk_skills") | sed 's/^/       /'
fi

readme_cmds="$(grep -oE '`/[a-z][a-z-]*`' README.md | tr -d '`/' | sort -u)"
disk_cmds="$(basename -a -s .md commands/*.md | sort)"
if [ "$readme_cmds" != "$disk_cmds" ]; then
  fail "README command list does not match commands/"
  diff <(echo "$readme_cmds") <(echo "$disk_cmds") | sed 's/^/       /'
fi

echo "shell scripts"
for script in install.sh scripts/*.sh; do
  bash -n "$script" || fail "$script: syntax error"
  [ -x "$script" ] || fail "$script: not executable"
done

echo
if [ "$fails" -eq 0 ]; then
  echo "All checks passed."
else
  echo "$fails check(s) failed."
  exit 1
fi
