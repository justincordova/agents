---
name: spec
description: Use when starting a new project or when design decisions need to be documented or updated. Creates and maintains the project-level specification.
---

# Writing Specs

## Overview

Create and maintain `docs/SPEC.md` — the single source of truth for the project's design decisions, architecture, and constraints. This is NOT an implementation plan. It's the "what and why" document that plans will later reference.

**Announce at start:** "Using spec skill to update the project specification."

**Save to:** `docs/SPEC.md`

## What the Spec Is

A living document that captures the current state of the project's design. SPEC.md is updated via sync-docs (which merges implemented design docs) or via direct edits through this skill. Think of it as a product brief + technical design that evolves with the project.

## Spec Document Structure

```markdown
# [Project Name]

## Vision
[2-3 sentences. What is this? Why does it exist? What problem does it solve?]

## Goals
- [What success looks like — measurable if possible]
- [Who the users are and what they need]
- [Key outcomes]

## Non-Goals
- [What this project explicitly does NOT cover]
- [Scope boundaries — helps prevent scope creep]

## Architecture
[High-level technical approach. Key technologies, patterns, infrastructure. Not implementation details — just the big structural decisions.]

### Key Components
- [Component 1]: [what it does]
- [Component 2]: [what it does]

### Data Flow
[How data moves through the system. Can be prose, can be a simple diagram.]

## Key Decisions
| Decision | Choice | Rationale |
|----------|--------|-----------|
| [e.g., Database] | [e.g., PostgreSQL] | [Why this over alternatives] |

## Edge Cases & Constraints
- [Known gotchas, edge cases, constraints]
- [Performance requirements]
- [Security considerations]

## Open Questions
- [Things that haven't been decided yet]
- [Things that need user input]

## References
- [Links to docs, inspirations, existing systems, etc.]
```

## Invocation Modes

The spec skill is invoked in two situations.

### Mode 1: Direct edit

Triggered when SPEC.md needs changes but no design doc is involved. Common cases:
- User invokes the skill directly to update SPEC.md
- The user wants to explicitly edit the spec outside of sync-docs

1. **Read SPEC.md**
2. **Apply targeted edits** from user instructions
3. **Present diff** to the user for approval
4. **Save**

### Mode 2: Initial project spec (greenfield)

Triggered by brainstorm when no SPEC.md exists yet. The SPEC.md *is* the design artifact for project initialization.

1. **Interview** — ask questions one at a time to fill gaps (vision, goals, non-goals, architecture, key decisions)
2. **Draft the spec**
3. **Present for review**
4. **Revise and save**

Note: design doc merging is handled by sync-docs, not by the spec skill. When sync-docs runs, it merges any implemented design docs into SPEC.md and deletes them.

## Writing Good Specs

**Do:**
- Be specific about goals but not about implementation
- Include non-goals — they're as important as goals
- Document key decisions and WHY you made them
- Keep architecture high-level — boxes and arrows, not code
- Call out edge cases and risks early
- Leave open questions as open questions (don't guess)
- Update existing sections when decisions change — don't leave stale info

**Don't:**
- Include implementation tasks or step-by-step plans (that's for the plan skill)
- Include code snippets (unless illustrating a contract or API shape)
- Get bogged down in edge cases — list them, don't solve them
- Duplicate information across sections

## When to Update

Update `docs/SPEC.md` whenever:
- The user directly invokes the spec skill to make changes (Mode 1)
- Starting a new project with no SPEC.md (brainstorm triggers Mode 2)
- sync-docs merges an implemented design doc into SPEC.md (handled by sync-docs, not this skill)

The spec should always reflect the CURRENT state of the project's design, not historical decisions that were overridden.

**Never updated from brainstorm or plan.** Brainstorm writes a design doc. Plan reads it. SPEC.md gets updated when the user runs sync-docs or directly invokes the spec skill.

## After the Spec

Once SPEC.md is updated:

- **Mode 1 (direct edit):** "SPEC.md updated."
- **Mode 2 (greenfield):** "Initial spec saved at `docs/SPEC.md`. Ready for `/plan` on the first feature."
