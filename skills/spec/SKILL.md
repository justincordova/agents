---
name: spec
description: Use when starting a new project or major feature to create a comprehensive project overview document before planning implementation
---

# Writing Specs

## Overview

Create a spec.md — a big-picture project overview that captures the vision, scope, architecture, and key decisions before you start planning. This is NOT a step-by-step plan. It's the "what and why" document that the plan will later reference.

**Announce at start:** "Using writing-spec skill to create the project spec."

**Save specs to:** `docs/SPEC.md`

## What a Spec Is

A spec is the source of truth for WHAT you're building and WHY. It's the document you hand to someone and they understand the full picture. The writing-plans skill will later break this into implementation tasks.

Think of it as a product brief + technical design combined.

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

## Overview

[A narrative walkthrough of the project. If someone reads nothing else, this section should give them the full picture. 1-3 paragraphs.]

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
| [e.g., Auth] | [e.g., JWT] | [Why] |

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

1. **Gather context** — read any existing docs, design docs, brainstorming notes
2. **Interview if needed** — ask the user questions to fill gaps (one at a time)
3. **Draft the spec** — write each section, keep it concise
4. **Present for review** — show the user, get feedback
5. **Revise** — incorporate feedback
6. **Save** — write to `docs/SPEC.md`

## Writing Good Specs

**Do:**
- Be specific about goals but not about implementation
- Include non-goals — they're as important as goals
- Document key decisions and WHY you made them
- Keep architecture high-level — boxes and arrows, not code
- Call out edge cases and risks early
- Leave open questions as open questions (don't guess)

**Don't:**
- Write implementation details (that's for the plan)
- Include code snippets (unless illustrating a contract or API shape)
- Get bogged down in edge cases — list them, don't solve them
- Make decisions that should be deferred to the plan phase

## After the Spec

Once the spec is approved:

"Spec saved to `docs/SPEC.md`. Next step: use the writing-plans skill to create an implementation plan from this spec."

Offer to invoke writing-plans next.
