---
name: execute
description: Use when you have a written implementation plan to execute with review checkpoints
---

# Executing Plans

## Overview

Execute implementation work. Can load from a plan file (if one exists) or from a design doc, or just follow the developer's direct instructions for small iterations.

**Announce at start:** "Using execute skill to implement this plan."

**Plans live in:** `docs/plans/`
**Design docs live in:** `docs/designs/`

## The Process

### Step 1: Load Context

Determine which starting mode applies:

1. **Plan file exists** — read the plan file from `docs/plans/`
2. **Design doc exists (no plan)** — read the design doc from `docs/designs/`
3. **Small iteration (no plan, no design doc)** — use the developer's instructions directly

In all cases, read `docs/SPEC.md` for context on design decisions. Review critically — identify questions or concerns. If concerns: raise them before starting. If no concerns: create task list and proceed.

### Step 2: Determine Batches

A batch ends wherever a human reviewer would want a checkpoint. Use these rules in order:

**Always end a batch before any of these:**

1. **Database or schema change** — migrations, new tables, destructive alters
2. **Public API contract change** — new endpoints, changed signatures, removed fields
3. **New dependency** — adding a package, service, or infrastructure component
4. **Cross-cutting refactor** — changes that touch 5+ files across different modules
5. **Phase boundary in the plan** — if the plan defines phases, each phase is at least one batch
6. **Anything with destructive or hard-to-reverse effects** — data migration, file deletion, force push

**Otherwise, group tasks into the same batch when:**

- They touch the same module, feature, or component
- They share test files or integration points
- Splitting them would leave the codebase in a broken intermediate state

**Default:** when in doubt, make the batch smaller. Small batches = faster feedback loops = less wasted work when something's wrong.

**Examples:**

| Tasks | Batch Decision | Why |
|-------|---------------|-----|
| 8 tasks all building auth module | 1 batch | Same component, no destructive effects |
| 6 auth tasks + 2 DB schema tasks | 2 batches | Schema change is a checkpoint trigger |
| 4 tasks: add dep, build service, add route, write tests | 2 batches (dep alone, then the rest) | New dependency is a checkpoint trigger |
| 3 unrelated bugfixes in different modules | 3 batches | No cohesion, each worth reviewing separately |
| Phase 1 (5 tasks) + Phase 2 (4 tasks) | 2+ batches, never combined | Phase boundary is a hard break |

Present your batch grouping to the user before executing. Call out which checkpoint rule triggered each split.

### Step 3: Execute Batch

For each task:
1. Mark as in_progress
2. Follow the steps described in the plan
3. Run verifications as specified
4. Mark as completed

### Step 4: Report

When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 5: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 6: Wrap Up

After all tasks complete and verified:
- Run full test suite
- Run build
- Report completion
- If docs feel stale or the feature involved multiple iterations, suggest running sync-docs. Otherwise say nothing — sync-docs is on-demand, not automatic.

## When to Stop and Ask

**STOP immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## Key Principles

- Review plan critically first
- Reference SPEC.md for design context
- Follow plan steps — don't skip ahead
- Don't skip verifications
- Batch by cohesion, not count
- Between batches: report and wait for feedback
- Stop when blocked, don't guess
- Don't commit unless explicitly asked
