---
name: retro
description: Use after completing a meaningful feature or significant change. Reviews what was built against what was planned, captures lessons, and triggers spec/docs updates when reality diverged from design.
---

# Retro

## Overview

A retro is a short, honest look back at a completed feature. It answers three questions:

1. Did what we built match what we planned?
2. What did we learn?
3. Does the project specification need to change as a result?

The output is NOT a blog post. It's a signal — either "all good, move on" or "SPEC.md needs updating" or "there's a gotcha worth capturing."

**Announce at start:** "Using retro skill to review what was just built."

## When to Run

**Run retro after:**
- A feature ships or a plan finishes executing
- A significant refactor lands
- A bug fix that revealed a deeper design issue

**Skip retro for:**
- Trivial fixes (typos, one-line configs)
- Work that was purely mechanical (dep bumps, rename-only refactors)
- Anything where there's nothing to learn

If in doubt, ask the user whether a retro is worth running.

## Checklist

Create a task for each item and complete them in order:

1. **Load context** — read the plan file from `docs/plans/`, recent commits, and `docs/SPEC.md`
2. **Compare plan vs. reality** — identify where implementation diverged from the plan
3. **Surface lessons** — anything the next feature should benefit from knowing
4. **Check SPEC.md drift** — did design decisions change during execution?
5. **Trigger follow-ups** — invoke spec skill if SPEC.md needs changes, sync-docs skill if other docs drifted
6. **Report** — a short summary to the user

## The Questions

Work through these in order. Keep answers tight.

**What did we plan to build?** One or two sentences. Reference the plan file.

**What did we actually build?** One or two sentences. Reference the commits or files.

**Where did reality diverge from the plan?** List the divergences. For each:
- Was the divergence a better decision or a forced workaround?
- Does it invalidate anything in `docs/SPEC.md`?

**What did we learn?** Only list lessons that would change how you'd approach the next feature. Do not list generic platitudes. If there's nothing, say so.

**What should change?**
- SPEC.md updates needed? → hand off to spec skill
- Other docs stale? → hand off to sync-docs skill
- Plan skill or brainstorm skill itself need improvement? → note it, ask the user
- Nothing? → say so explicitly

## Output Format

Write the retro directly in chat. Do NOT create a file. If the user wants a record, they can save it themselves.

Format:

```
## Retro: <feature name>

**Planned:** <1-2 sentences>
**Built:** <1-2 sentences>

**Divergences:**
- <divergence> — <better decision | forced workaround | neutral>

**Lessons:**
- <lesson that would change future work>

**Follow-ups:**
- [ ] Update SPEC.md — <what section, why>
- [ ] Update <other doc> — <what, why>
- [ ] <any other action>
```

If a section is empty, write "None." Do not invent content to fill sections.

## Hand-offs

After presenting the retro:
- If SPEC.md needs updates → "Handing off to spec skill to update SPEC.md."
- If other docs need updates → "Handing off to sync-docs skill."
- If nothing needs changing → "Retro complete. Nothing to update."

## Key Principles

- **Honest, not performative** — if nothing was learned, say so. Don't manufacture insights.
- **Short** — a retro should take 2-5 minutes to read and respond to
- **Actionable or nothing** — every lesson should map to a concrete change in behavior or docs
- **SPEC.md is the source of truth** — if the project's design changed, SPEC.md must change too
