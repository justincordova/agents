---
name: sync-docs
description: Use on-demand to reconcile documentation with the current state of the codebase. Handles two cases — catching drift from past work and consolidating doc updates after iterating on a feature multiple times. Never runs automatically.
---

# Sync Docs

## Overview

Reconcile documentation with the current state of the codebase. This skill is invoked on-demand, never automatically. It handles two main cases:

1. **Drift correction** — catching up docs that have fallen behind past work (features shipped without doc updates, refactors that weren't reflected in SPEC.md, etc.)
2. **Iterative reconciliation** — after iterating on a feature 3-5 times without touching docs, run sync-docs once to consolidate all the changes into a single coherent update instead of rewriting SPEC.md after every iteration

**Announce at start:** "Using sync-docs skill to sync documentation."

## When to Use

**Triggered explicitly:** When the user says "update docs," "sync the docs," or similar. Never triggered automatically.

**Good times to run it:**
- After iterating on a feature multiple times, when the design has stabilized
- When coming back to a project after a break and the docs feel stale
- Before a release or milestone, to make sure docs reflect reality
- When preparing a project for handoff

**Do NOT run it:**
- After every small commit (that's what batching avoids)
- In the middle of active iteration (wait until the design settles)
- When the plan skill has just finished — that flow already merges the design doc into SPEC.md

## The Process

### Step 1: Scan Recent Changes

1. Check `git diff` and recent commits to understand what changed
2. Identify the scope: is this a small fix, a new feature, a refactor, or an architectural shift?

### Step 2: Identify Affected Docs

Scan the repo for documentation files and determine which ones are impacted. Common docs:

| Doc | When to Update |
|-----|---------------|
| `docs/SPEC.md` | Architecture, scope, goals, or key decisions changed |
| `docs/designs/*.md` | In-flight design docs that have been implemented — merge into SPEC.md and delete |
| `TESTING.md` | Test approach, frameworks, or commands changed |
| `MANUAL_TESTING.md` | Manual test steps or flows changed |
| `LOGGING.md` | Logging approach, format, or tooling changed |
| `AGENTS.md` | Repo structure, commands, tech stack, or architectural patterns changed |
| `AGENTS.md` | Project conventions, tooling, or workflow changed |
| `README.md` | Anything a user cloning the repo would need to know |

### Step 3: Update Each Doc

For each affected doc, make targeted updates:

**SPEC.md (`docs/SPEC.md`):**
- If design docs exist in `docs/designs/`, merge them into SPEC.md first — they represent in-flight features that are now implemented
- Update architecture if structural decisions changed
- Update goals/non-goals if scope shifted
- Update key decisions table if choices changed
- Do NOT rewrite the whole spec — only update what shifted

**Design docs (`docs/designs/*.md`):**
- If a design doc has been fully implemented (code exists, feature works), merge its design decisions into SPEC.md and delete the design doc
- If a design doc is still in-flight (feature not yet shipped), leave it alone — it's the active source of truth for that feature
- When merging: integrate the design doc's sections into the appropriate SPEC.md sections. Don't just append.

**Technical docs (`TESTING.md`, `LOGGING.md`, etc.):**
- Update to match current behavior
- Remove sections describing removed features
- Add sections for new capabilities

**AGENTS.md:**
- ONLY update if one exists — do not create one during sync (use the sync-agents skill for creation)
- Update when: repo layout changed, commands changed, new dependencies added, architectural patterns shifted, new modules created, or gotchas discovered
- Do NOT rewrite the whole file — update only the sections that drifted
- Load the sync-agents skill's template if you need to add new sections that don't exist yet
- Keep under 400 lines — cut aggressively, every line competes with agent context

**AGENTS.md:**
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

Skipping AGENTS.md — no convention changes.
```

Wait for approval before saving.

### Step 5: Save

Write all approved changes. Do NOT commit unless asked.

## Key Principles

- Only update what changed — don't rewrite untouched sections
- AGENTS.md updates are section-targeted — don't regenerate the whole file
- AGENTS.md stays lean — it's loaded into every session
- README is user-facing — think "first-time cloner"
- Plans are historical — never update them
- Present changes before saving — no surprise rewrites
- Don't commit unless explicitly asked
