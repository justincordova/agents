---
name: plan
description: Use when you have a spec and need to create a detailed implementation plan before touching code
---

# Writing Plans

## Overview

Create a detailed implementation plan from the spec. The plan must be specific enough that an executing agent can implement it without making architectural or design decisions. Include file paths, code shapes, patterns to follow, and exact test expectations.

**Announce at start:** "Using plan skill to create the implementation plan."

**Save plans to:** `docs/plans/<feature-name>-plan.md`

## When to Use This Skill

This skill is **only invoked by the developer** via `/plan`. It is never triggered automatically by brainstorm or any other skill. Use it when:
- A design doc exists and the implementation is complex enough to warrant a detailed plan
- The developer wants a stronger model to review the design and produce an execution plan

## Philosophy

The plan is a handoff document. It's written after brainstorming, then executed by any agent. The executing agent should be able to follow the plan without guessing about architecture, file locations, or implementation approach. Be specific and detailed.

## Inputs: Three Starting Modes

The plan skill handles three starting situations. Detect which applies, then follow the matching input list.

### Mode A: Design doc exists (post-brainstorm)

Used when brainstorm ran and produced a design doc. The standard path for new features.

1. **`docs/designs/<feature-name>.md`** — the approved design. Primary input.
2. **`docs/SPEC.md`** — for patterns, conventions, constraints.
3. **Other files in `docs/designs/`** — check for in-flight features that SPEC.md doesn't reflect yet. Avoid conflicts with their design decisions.
4. **Relevant code** — files the plan will touch.

### Mode B: No design doc (small iteration)

Used when the user skipped brainstorm because the work is mechanical or obvious. The user has described what they want directly in chat.

1. **The user's instructions in the current conversation** — this is the design.
2. **`docs/SPEC.md`** — for patterns, conventions, constraints.
3. **`docs/designs/`** — check for in-flight features that SPEC.md doesn't reflect yet.
4. **Relevant code** — files the plan will touch.

If the user's instructions are ambiguous or imply design decisions, stop and ask whether brainstorm is needed before continuing.

### Mode C: Greenfield first feature

Used when the spec skill just created an initial SPEC.md and you're planning the first feature. No design doc exists because SPEC.md *is* the design.

1. **`docs/SPEC.md`** — primary input, recently created by spec skill.
2. **Relevant code** — usually minimal; this is a new project.

## Which Mode Triggers the SPEC.md Merge?

Only **Mode A** triggers a spec merge — it's the only mode with a design doc to merge.

- Mode B: no design doc → no merge → skip straight to execute handoff.
- Mode C: SPEC.md already up to date (spec skill just wrote it) → skip merge → straight to execute handoff.

## Plan Size: Scale to the Work

Match plan weight to task weight. Defaulting to a full plan for every task is token waste.

- **Lightweight plan (3-10 lines)** — use when: Mode B, single file touched, one obvious task, no dependencies. Write one task with What + How + Verify. Skip Why when there's no ordering to justify.
- **Standard plan** — most features in Mode A. Multiple tasks, each with What/Why/How/Verify.
- **Phased plan** — cross-cutting work with real stage gates (see "When to Use Phases").

## Plan Document Structure

```markdown
# [Feature Name] Plan

> **Goal:** [One sentence — what are we building]
> **Spec:** [Link or path to docs/SPEC.md]

## Task 1: [What to build]
- **What:** [Description of the deliverable]
- **Why:** [Why this comes first — dependencies or logical ordering]
- **How:** [Detailed approach — files to create/modify, code shapes, patterns to follow, imports to use]
- **Verify:** [How to know it works — specific commands, expected test outcomes]

## Task 2: [What to build]
- **What:** ...
- **Why:** ...
- **How:** ...
- **Verify:** ...
```

### When to Use Phases

Only introduce phases when there are **real stage gates** — points where one group of work must be complete before another can start. Examples:

- Backend API must exist before frontend can integrate
- Database schema must be migrated before ORM models can be built
- Shared library must be published before consumers can use it

```markdown
## Phase 1: Backend API

**Gate:** API endpoints deployed and tested

### Task 1: ...
### Task 2: ...

## Phase 2: Frontend Integration

**Depends on:** Phase 1

### Task 3: ...
```

Do NOT use phases just to organize tasks into groups. If tasks are sequential but have no hard dependencies between groups, keep the list flat.

## Task Granularity

Each task should be a **meaningful unit of work** (30 min to 2 hours), not a micro-step.

**Good tasks:**
- "Build the user model and database migration"
- "Create the authentication API endpoints"
- "Build the dashboard UI component"
- "Write integration tests for the checkout flow"

**Bad tasks (too granular):**
- "Write a failing test for the user model"
- "Run the test to verify it fails"
- "Write the user model code"
- "Run the test to verify it passes"

## Writing Good Plans

**What each task needs:**
- **What** — clear description of the deliverable
- **Why** — why this order matters (dependencies)
- **How** — detailed approach including:
  - Files to create or modify (with paths)
  - Code shapes — interfaces, function signatures, data structures
  - Patterns to follow from existing code (with file references)
  - Dependencies and imports
  - Any constraints from the spec
- **Verify** — how to confirm it works (specific commands, expected output)

**What TO include:**
- File paths where code should live
- Interface/type definitions and function signatures
- References to existing patterns ("follow the pattern in `src/auth/`")
- Key decisions or constraints from the spec ("use Redis for caching, not in-memory")
- Integration points ("this API must match the contract in `docs/api.md`")
- Things to watch out for ("the legacy schema uses snake_case, our new code uses camelCase")
- Exact commands for verification

**What NOT to include:**
- Vague instructions ("make it work", "add tests")
- Decisions that should have been made during brainstorming/spec
- Narrative or prose — just give the tasks, the spec already has the why
- Repeating spec content — don't copy-paste architecture or decisions, just reference the spec
- Edge case exploration — list those in the spec, the plan just handles them in tasks
- Multiple approaches — that's brainstorming. The plan has ONE approach, the decided one
- Open questions — resolve them before writing the plan

## Self-Review Before Handoff

Before presenting the plan to the user, walk through this checklist. Fix anything that fails.

- [ ] **Every task has all four fields** — What, Why, How, Verify
- [ ] **Every task references a file path** — no "add a module somewhere"
- [ ] **Every task is verifiable** — "run X, expect Y" not "make sure it works"
- [ ] **No open questions remain** — unresolved decisions belong in brainstorm, not the plan
- [ ] **No multiple-approach language** — the plan has ONE approach, the decided one
- [ ] **Dependencies are explicit** — if Task 3 needs Task 1's output, say so in "Why"
- [ ] **Spec references, not spec duplication** — link to `docs/SPEC.md` instead of copying
- [ ] **Phases only if there's a real stage gate** — otherwise flat list

If any item fails and you can't fix it from context, stop and ask the user rather than guessing.

## Execution Handoff

"Plan saved to `docs/plans/<filename>.md`. Want me to start executing, or would you like to review first?"

If executing: use the execute skill.

SPEC.md updates happen later, on-demand, via sync-docs. The design doc stays in `docs/designs/` until then — it's the source of truth for the current feature while work is in progress.
