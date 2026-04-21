---
name: brainstorm
description: "Use before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."
---

# Brainstorm

## Overview

Turn ideas into fully formed designs through collaborative dialogue. Understand the project, ask questions one at a time, propose approaches, present the design, get approval.

<HARD-GATE>
Do NOT write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it.
</HARD-GATE>

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short, but you MUST present it and get approval.

## Checklist

Create a task for each item and complete them in order:

1. **Explore project context** — check files, docs, recent commits, read `docs/SPEC.md` if it exists
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to complexity, get user approval after each section
5. **Hand off to spec skill** — if design decisions changed, invoke the spec skill to update `docs/SPEC.md`
6. **Transition** — ask user what's next: write a plan or start building

## Process Flow

```
Explore context → Ask questions → Propose approaches → Present design → User approves? → Hand off to spec → Transition
                                                                       ↓
                                                            Revise and re-present
```

## The Process

**Understanding the idea:**
- Check the current project state first (files, docs, recent commits)
- Read `docs/SPEC.md` if it exists to understand current design decisions
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

## After the Design

This skill produces NO files directly. The output is alignment between you and the user — a shared understanding of what to build and how.

**Hand off to spec skill:**
- If the approved design introduced new decisions or changed existing ones, invoke the spec skill to update `docs/SPEC.md`
- The spec skill owns that file — do not edit SPEC.md directly from brainstorm
- If the change is purely implementation-level (no design decisions), skip this step

**Transition:**
- Ask the user what they want to do next:
  1. Write a plan (plan skill) — standard path, always preferred
  2. Write a lightweight plan — for trivial edits, a 3-10 line plan is fine, but always write one

## Key Principles

- **One question at a time** — don't overwhelm
- **Multiple choice preferred** — easier to answer
- **YAGNI** — strip unnecessary features
- **Explore alternatives** — always propose 2-3 approaches
- **Incremental validation** — get approval before moving on
- **Be flexible** — go back and clarify when something doesn't make sense
