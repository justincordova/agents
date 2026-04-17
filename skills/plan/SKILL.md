---
name: plan
description: Use when you have a spec and need to create step-by-step implementation instructions before touching code
---

# Writing Plans

## Overview

Create implementation plans from a spec or requirements. The plan breaks the project into logical phases with clear goals — not line-by-line code instructions. Think of it as a roadmap: what to build, in what order, and what each piece depends on.

**Announce at start:** "Using writing-plans skill to create the implementation plan."

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>-plan.md`

## Philosophy

This skill is about **direction**, not dictation. The plan tells you WHAT to build and in what ORDER. It does NOT contain exact code, exact file paths, or exact test assertions. The engineer executing the plan makes those decisions.

Think of it as an architect's blueprint, not a builder's step-by-step assembly guide.

## Plan Document Structure

```markdown
# [Project Name] Implementation Plan

> **Goal:** [One sentence — what are we building]
> **Spec:** [Link or path to spec.md if one exists]

## Phase 1: [Phase Name]

**Goal:** [What this phase accomplishes]

### Task 1: [What to build]
- **What:** [Description of the component/feature to build]
- **Why:** [Why this comes first — dependencies or logical ordering]
- **How:** [Approach at a high level — patterns to follow, libraries to use, things to reference in the codebase]
- **Verify:** [How to know it works — what to test, what to run]

### Task 2: [What to build]
- **What:** ...
- **Why:** ...
- **How:** ...
- **Verify:** ...

## Phase 2: [Phase Name]

**Goal:** ...

### Task N: ...
...

## Phase N: Integration & Polish

**Goal:** Bring everything together, end-to-end testing

### Task X: Wire everything up
- **What:** Connect all components
- **Verify:** Run full test suite, manual smoke test
```

## Task Granularity

Each task should be a **meaningful unit of work** (30 min to 2 hours), not a micro-step. Good examples:

- "Build the user model and database migration"
- "Create the authentication API endpoints"
- "Build the dashboard UI component"
- "Write integration tests for the checkout flow"
- "Set up CI/CD pipeline"

Bad examples (too granular):
- "Write a failing test for the user model"
- "Run the test to verify it fails"
- "Write the user model code"
- "Run the test to verify it passes"
- "Commit the user model"

## Writing Good Plans

**What each task needs:**
- **What** — clear description of the deliverable
- **Why** — why this order matters (dependencies)
- **How** — high-level approach, patterns to follow, references to existing code
- **Verify** — how to confirm it works

**What NOT to include:**
- Exact code snippets (the executing engineer writes the code)
- Exact file paths (discover these during execution)
- Exact test assertions (the engineer designs tests)
- Commit instructions (commit when it makes sense, not after every micro-step)

**What to DO include:**
- References to existing patterns in the codebase ("follow the pattern in `src/auth/`")
- Key decisions or constraints ("use Redis for caching, not in-memory")
- Integration points ("this API must match the contract in `docs/api.md`")
- Things to watch out for ("the legacy schema uses snake_case, our new code uses camelCase")

## Execution Handoff

After saving the plan:

"Plan saved to `docs/plans/<filename>.md`. Want me to start executing it, or would you like to review it first?"

If executing: use the executing-plans skill.
