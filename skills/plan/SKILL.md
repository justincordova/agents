---
name: plan
description: Use when you have a spec and need to create step-by-step implementation instructions before touching code
---

# Writing Plans

## Overview

Create implementation plans from a spec or requirements. The plan breaks the project into an ordered task list — what to build, in what order, and what each piece depends on.

**Announce at start:** "Using writing-plans skill to create the implementation plan."

**Save plans to:** `docs/plans/<feature-name>-plan.md`

## Philosophy

This skill is about **direction**, not dictation. The plan tells you WHAT to build and in what ORDER. The engineer executing the plan decides HOW — exact code, exact file paths, exact test assertions.

Think of it as an architect's blueprint: here's what we're building, here's the order, here are the key decisions. The builder figures out the rest.

## Plan Document Structure

```markdown
# [Feature Name] Plan

> **Goal:** [One sentence — what are we building]
> **Spec:** [Link or path to docs/SPEC.md if one exists]

## Task 1: [What to build]
- **What:** [Description of the deliverable]
- **Why:** [Why this comes first — dependencies or logical ordering]
- **How:** [High-level approach — patterns to follow, libraries to use, things to reference]
- **Verify:** [How to know it works]

## Task 2: [What to build]
- **What:** ...
- **Why:** ...
- **How:** ...
- **Verify:** ...

## Task N: ...
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
- **How** — high-level approach, patterns to follow, references to existing code
- **Verify** — how to confirm it works

**What NOT to include — these are anti-patterns:**

| Anti-Pattern | Why It's Bad |
|-------------|-------------|
| Exact code snippets | The executing engineer writes the code. Including it means you're implementing, not planning. |
| Exact file paths | Discover these during execution. Hardcoding paths that don't exist yet leads to confusion. |
| Exact test assertions | The engineer designs tests based on the feature, not a script to follow blindly. |
| "Create file X, add function Y" | This is implementation. Say "build the auth module" not "create src/auth.ts and export login()." |
| Step-by-step coding instructions | "First import X, then create interface Y, then..." — this is coding, not planning. |

**What TO include:**
- References to existing patterns ("follow the pattern in `src/auth/`")
- Key decisions or constraints ("use Redis for caching, not in-memory")
- Integration points ("this API must match the contract in `docs/api.md`")
- Things to watch out for ("the legacy schema uses snake_case, our new code uses camelCase")

## Execution Handoff

After saving the plan:

"Plan saved to `docs/plans/<filename>.md`. Want me to start executing it, or would you like to review it first?"

If executing: use the executing-plans skill.
