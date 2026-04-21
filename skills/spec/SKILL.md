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

A living document that captures the current state of the project's design. It's updated whenever design decisions change — during brainstorming, after retros, or when pivoting. Think of it as a product brief + technical design that evolves with the project.

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

## Process

1. **Check if SPEC.md exists** — if yes, read it to understand current state
2. **Gather context** — read any existing docs, brainstorming notes, recent commits
3. **Interview if needed** — ask the user questions to fill gaps (one at a time)
4. **Update the spec** — add new sections for new features, update existing sections if decisions changed
5. **Present changes** — show the user what changed, get feedback
6. **Revise** — incorporate feedback
7. **Save** — write to `docs/SPEC.md`

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
- A new feature is being designed (brainstorm skill triggers this)
- A design decision changes
- New constraints or edge cases are discovered
- Non-goals or scope boundaries shift

The spec should always reflect the CURRENT state of the project's design, not historical decisions that were overridden.

## After the Spec

Once the spec is updated:

"Spec updated at `docs/SPEC.md`. Next step: use the plan skill to create an implementation plan."

Offer to invoke plan next.
