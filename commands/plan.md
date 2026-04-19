---
description: Create step-by-step implementation plans from specs
---

Load the plan skill, then create an implementation plan for: $ARGUMENTS

Follow the plan skill guidelines:
- Direction not dictation — what to build, in what order, what depends on what
- Tasks are meaningful units (30 min to 2 hours), not micro-steps
- Each task: What, Why, How, Verify
- No exact code or file paths — the executing engineer writes the code
- Reference existing patterns, key decisions, integration points, things to watch out for
- Use phases only when there are real stage gates (hard dependencies between groups)
- Save to docs/plans/<feature-name>-plan.md

After saving, ask: "Want me to start executing, or would you like to review it first?"
