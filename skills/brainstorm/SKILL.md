---
name: brainstorm
description: "Use when a task involves genuine design decisions — new features, new components, unclear scope, or multiple viable approaches. Skip for mechanical changes where the design is obvious. Produces an approved design doc as the session-boundary artifact."
---

# Brainstorm

## Overview

Turn ideas into fully formed designs through collaborative dialogue. Understand the project, ask questions one at a time, propose approaches, present the design, get approval, write the design doc.

<HARD-GATE>
Do NOT write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it.
</HARD-GATE>

## When to Use Brainstorm

**Use brainstorm when:**
- Building a new feature, component, or abstraction
- Multiple approaches exist and trade-offs need exploring
- Scope is unclear
- The user asks for help with a design decision
- Starting a new project (greenfield — see mode below)

**Skip brainstorm when:**
- The change is mechanical (rename, config tweak, add a log line)
- The design is obvious and singular (only one sensible way to do it)
- The user already knows exactly what they want and just needs it built
- Iterating on already-designed work with no new decisions

When skipped, go straight to execute.

## Mode: Greenfield vs Normal

**Check first:** does `docs/SPEC.md` exist?

- **No SPEC.md → Greenfield mode.** This is project initialization. Skip the design doc step. Hand off directly to the spec skill in interview mode — the SPEC.md *is* the design doc for initialization. Jump to "Greenfield Transition" below.
- **SPEC.md exists → Normal mode.** Follow the full checklist below.

## Checklist (Normal Mode)

Create a task for each item and complete them in order:

1. **Explore project context** — check files, docs, recent commits, read `docs/SPEC.md`
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to complexity, get user approval after each section
5. **Write design doc** — save the approved design to `docs/designs/<feature-name>.md`
6. **Transition** — hand off to the developer. Design doc is the session-boundary artifact. Plan is optional — only when the developer explicitly asks for it or the design is complex enough to warrant one.

## Process Flow

```
Explore context → Ask questions → Propose approaches → Present design → User approves? → Write design doc → Done (developer decides next step)
                                                                        ↓
                                                             Revise and re-present
```

## The Process

**Understanding the idea:**
- Check the current project state first (files, docs, recent commits)
- Read `docs/SPEC.md` to understand current design decisions
- Check `docs/designs/` for any in-flight feature design docs — SPEC.md may not reflect these yet
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible
- Focus on: purpose, constraints, success criteria
- Always give recommendations backed by best practices — scalable architecture, good UI/UX patterns, clean reusable code, separation of concerns, industry conventions. Don't just ask bare questions, offer informed opinions

**Exploring approaches:**
- Propose 2-3 different approaches with trade-offs
- Lead with your recommendation and explain why

**Presenting the design:**
- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- Ask after each section whether it looks right
- Cover: architecture, components, data flow, error handling, testing

## After the Design (Normal Mode)

Once the design is approved, write it to `docs/designs/<feature-name>.md`. This file is the session-boundary artifact — a new agent session can pick up the plan step from here without needing the brainstorming context.

**Design doc structure:**

```markdown
# <Feature Name>

## Context
[1-2 paragraphs. What is this? Why are we building it? How does it fit the existing system?]

## Goals
- [What success looks like]
- [Key outcomes]

## Non-Goals
- [What this explicitly does NOT cover]

## Design
[Architecture, components, data flow. Scale detail to complexity — a few paragraphs for simple features, more for complex ones.]

## Key Decisions
| Decision | Choice | Rationale |
|----------|--------|-----------|

## Rejected Alternatives
- [Approach X] — [why rejected]
- [Approach Y] — [why rejected]

## Edge Cases & Constraints
- [Known gotchas, performance, security]

## Open Questions
- [Anything unresolved — should be empty by the time brainstorm ends]
```

Include the "Rejected Alternatives" section so a fresh agent reading the design doc later knows what was already ruled out and why.

**Do NOT update SPEC.md from brainstorm.** SPEC.md is only updated via sync-docs or the spec skill.

**Transition:**
- Tell the user: "Design saved to `docs/designs/<feature>.md`."
- Do NOT suggest or push for `/plan`. The developer decides when a plan is needed.
- If the design is straightforward, the developer can go straight to execute using the design doc as context.
- If the design is complex, the developer will invoke `/plan` themselves (possibly with a stronger model).
- Only invoke the plan skill if the developer explicitly asks for it.

## Greenfield Transition

When no `docs/SPEC.md` exists:

- Skip writing a design doc
- Hand off to the spec skill (Mode 2: initial spec interview)
- Tell the user: "No SPEC.md found. Handing off to spec skill to create the initial project spec — that becomes the design foundation."
- The spec skill interviews the user and writes SPEC.md directly
- Once SPEC.md exists, subsequent features go through normal mode

## Key Principles

- **One question at a time** — don't overwhelm
- **Multiple choice preferred** — easier to answer
- **YAGNI** — strip unnecessary features
- **Explore alternatives** — always propose 2-3 approaches
- **Incremental validation** — get approval before moving on
- **Be flexible** — go back and clarify when something doesn't make sense
