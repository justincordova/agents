---
name: update-docs
description: Use after completing work to keep documentation in sync with codebase changes. Updates SPEC.md, technical docs, CLAUDE.md, and README.md as needed.
---

# Update Docs

## Overview

Keep documentation in sync with the codebase. After completing work — across iterations, after features ship, after refactors — documentation drifts. This skill scans recent changes and updates all affected docs in one pass.

**Announce at start:** "Using update-docs skill to sync documentation."

## When to Use

**Triggered explicitly:** When you say "update docs" or "sync the docs."

**Suggested by the agent** after completing significant work that:
- Changes documented behavior or APIs
- Adds/removes features described in docs
- Changes tooling, build steps, or project conventions
- Alters architecture or data flow

## The Process

### Step 1: Scan Recent Changes

1. Check `git diff` and recent commits to understand what changed
2. Identify the scope: is this a small fix, a new feature, a refactor, or an architectural shift?

### Step 2: Identify Affected Docs

Scan the repo for documentation files and determine which ones are impacted. Common docs:

| Doc | When to Update |
|-----|---------------|
| `docs/SPEC.md` | Architecture, scope, goals, or key decisions changed |
| `TESTING.md` | Test approach, frameworks, or commands changed |
| `MANUAL_TESTING.md` | Manual test steps or flows changed |
| `LOGGING.md` | Logging approach, format, or tooling changed |
| `CLAUDE.md` | Project conventions, tooling, or workflow changed |
| `README.md` | Anything a user cloning the repo would need to know |

### Step 3: Update Each Doc

For each affected doc, make targeted updates:

**SPEC.md (`docs/SPEC.md`):**
- Update architecture if structural decisions changed
- Update goals/non-goals if scope shifted
- Update key decisions table if choices changed
- Do NOT rewrite the whole spec — only update what shifted

**Technical docs (`TESTING.md`, `LOGGING.md`, etc.):**
- Update to match current behavior
- Remove sections describing removed features
- Add sections for new capabilities

**CLAUDE.md:**
- ONLY update if project conventions, tooling, or workflow changed
- Keep it concise — this file is loaded into memory
- Add new rules or constraints, remove stale ones
- Never pad or bloat — every line should earn its place
- Do NOT use this to document features or behavior — that belongs in other docs

**README.md:**
- Write from the **user perspective** — someone cloning the repo for the first time
- Update: how to install, configure, run, use
- Do NOT turn it into a changelog or developer notebook
- Keep it practical: what does this project do, how do I use it

### Step 4: Present Changes

Show what you're updating and why:

```
Updating 3 docs:

- docs/SPEC.md: architecture section — switched from REST to tRPC
- TESTING.md: updated test commands to use vitest instead of jest
- README.md: updated install steps to include new env variable

Skipping CLAUDE.md — no convention changes.
```

Wait for approval before saving.

### Step 5: Save

Write all approved changes. Do NOT commit unless asked.

## Key Principles

- Only update what changed — don't rewrite untouched sections
- CLAUDE.md stays lean — it's loaded into every session
- README is user-facing — think "first-time cloner"
- Plans are historical — never update them
- Present changes before saving — no surprise rewrites
- Don't commit unless explicitly asked
