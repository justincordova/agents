---
name: writing-skills
description: Use when creating new skills, editing existing skills, or improving skill quality
---

# Writing Skills

## Overview

Skills are reference guides for proven techniques and patterns. They help future sessions find and apply effective approaches. Write them to be discovered, not just read.

**Core principle:** A skill is only useful if a future session can find it and follow it. Optimize for discovery first.

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious
- You'd reference this across projects
- Pattern applies broadly
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in AGENTS.md)
- Things enforceable by tooling (linters, compilers)

## Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    supporting-file.*     # Only if needed
```

Keep supporting files only for heavy reference (100+ lines) or reusable tools/scripts. Everything else stays inline.

## SKILL.md Structure

```markdown
---
name: skill-name-with-hyphens
description: Use when [specific triggering conditions and symptoms]
---

# Skill Name

## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
Bullet list with symptoms and use cases.
When NOT to use.

## Core Pattern
Before/after comparison or key pattern.

## Quick Reference
Table or bullets for scanning common operations.

## Implementation
Inline code for simple patterns.
Link to file for heavy reference.

## Common Mistakes
What goes wrong + fixes.
```

## Writing Good Descriptions

The `description` field is the most important part of your skill. It's what sessions use to decide whether to load your skill.

**Rules:**
- Start with "Use when..." 
- Include specific triggers, symptoms, situations
- Write in third person
- Keep under 500 characters (hard limits: 1,024 in the Agent Skills spec; Claude Code truncates `description` + `when_to_use` at 1,536 in its listing)
- Say what the skill covers and when to use it, but don't spell out its step-by-step process

**Why no step-by-step in description:** Testing showed that when descriptions summarize the workflow, sessions follow the description instead of reading the full skill. The description becomes a shortcut that skips the actual instructions. Naming the output ("produces a design doc") is fine; listing the steps that get there is not.

```yaml
# BAD: Summarizes workflow
description: Use when executing plans - dispatches subagent per task with code review

# GOOD: Just triggering conditions
description: Use when executing implementation plans with independent tasks

# BAD: Too vague
description: Helps with async testing

# GOOD: Specific triggers
description: Use when tests have race conditions, timing dependencies, or pass/fail inconsistently
```

## Naming Conventions

- `name` must equal the directory name. OpenCode derives the skill ID from the path (`name` is only a display label), Claude Code uses it as the `/command`, and `validate.sh` enforces the match.
- Lowercase kebab-case, 1–64 characters: `^[a-z0-9]+(-[a-z0-9]+)*$`
- Short and action-oriented: `plan`, `code-review`, `condition-based-waiting` — not `async-helpers`
- Pick a unique name: a skill named like a built-in (`plan`, `code-review`) replaces that built-in in Claude Code

## Frontmatter

Unknown fields are ignored by both tools, so tool-specific fields are safe to include.

| Field | Claude Code | OpenCode | Use |
|---|---|---|---|
| `name` | ✓ | display label | Required here; must match the directory |
| `description` | ✓ | ✓ | Required — without it OpenCode doesn't advertise the skill |
| `disable-model-invocation: true` | ✓ | ✓ | User-invoked only (e.g. `/sync-docs`); the model won't auto-load it |
| `when_to_use` | ✓ | — | Extra trigger text, counted with `description` |
| `allowed-tools` | ✓ | — | Pre-approved tools while the skill is active |
| `argument-hint` | ✓ | — | Hint shown after `/name` |

## Content Guidelines

### Be Concise

The context window is shared. Every token competes with conversation history.

- Assume the model is smart — don't explain basics
- One excellent example beats many mediocre ones
- Use cross-references instead of repeating content
- Challenge each paragraph: "Does this justify its token cost?"

### Set Appropriate Freedom

Match specificity to the task's fragility:

- **High freedom** (general direction): Multiple valid approaches, context-dependent decisions
- **Medium freedom** (patterns with parameters): Preferred pattern exists, some variation OK
- **Low freedom** (exact scripts): Fragile operations, consistency critical, specific sequence required

### Progressive Disclosure

Keep SKILL.md under 500 lines. Split into separate files when approaching that limit.

```
skill-name/
  SKILL.md          # Overview + patterns (loaded when triggered)
  reference.md      # API docs (loaded as needed)
  examples.md       # Usage examples (loaded as needed)
  scripts/          # Executable tools (executed, not loaded)
```

All reference files should link directly from SKILL.md. Keep references one level deep — no chains of files referencing files.

### For Longer Reference Files

Include a table of contents at the top so partial reads still reveal the full scope.

### Match the Form to the Failure

Before writing guidance, name the failure you're fixing. The form that fixes one failure type backfires on another.

| Failure | Right form | Wrong form |
|---|---|---|
| Knows the rule, breaks it under pressure | Prohibition + the rationalizations to reject | Soft guidance ("prefer…", "consider…") |
| Complies, but the output has the wrong shape | Positive recipe: state what the output IS — its parts, in order | Prohibition list ("don't restate", "never narrate") |
| Omits a required element | A required slot in the template they fill in | Prose reminders near the template |
| Behavior should depend on a condition | Conditional on something observable ("if a design doc exists, read it") | Unconditional rule + exemption clauses |

Whichever form you pick, avoid nuance clauses: "Don't X unless it matters" reopens the negotiation. Express a real exception as its own conditional. Exemption clauses ("this limit doesn't apply to code blocks") don't scope reliably — restructure so the rule can't reach the exempt part.

Adapted from [obra/superpowers](https://github.com/obra/superpowers/tree/main/skills/writing-skills).

## Testing Skills

Before deploying a skill, verify it works:

### Micro-Test the Wording

For guidance meant to change behavior, test the wording before running full scenarios:

1. Run a fresh-context sample with the realistic surrounding context (the full skill, not the line in isolation) and a task that tempts the failure.
2. Always run a no-guidance control. If the control doesn't show the failure, there's nothing to fix — don't write the guidance.
3. Run 5+ reps per variant and read every result yourself. When wording lands, reps converge on the same shape; five different interpretations means it isn't binding yet.

### Quick Test
1. Start a fresh session with the skill loaded
2. Give it a realistic task that should trigger the skill
3. Observe: Did it find the skill? Did it follow it correctly?

### Pressure Test (for discipline-enforcing skills)
1. Create a scenario where following the skill is costly (time, effort, rework)
2. Add realistic pressures: deadlines, sunk cost, authority figures
3. Force an explicit A/B/C choice
4. Observe: Does the session follow the rule under pressure?

If the session fails, the skill needs stronger language, explicit counters for the rationalizations you observed, or clearer structure.

### Iteration
1. Observe real usage with the skill
2. Note where sessions struggle or ignore instructions
3. Refine based on observed behavior, not assumptions

## Common Patterns

### Workflow Pattern
Break complex operations into sequential steps. Use checklists that sessions can track.

```markdown
## Workflow

Progress:
- [ ] Step 1: Analyze inputs
- [ ] Step 2: Create plan
- [ ] Step 3: Validate
- [ ] Step 4: Execute
- [ ] Step 5: Verify
```

### Feedback Loop Pattern
For quality-critical tasks, run validator -> fix errors -> repeat.

```markdown
## Process

1. Make changes
2. Validate: `python validate.py`
3. If errors: fix and go to step 2
4. Only proceed when validation passes
```

### Template Pattern
Provide output templates. Match strictness to need — exact format for APIs, flexible guidance for analysis.

## Anti-Patterns

| Don't | Why |
|-------|-----|
| Narrative storytelling | Not reusable |
| Multi-language examples | Mediocre quality, maintenance burden |
| Code in flowcharts | Can't copy-paste, hard to read |
| Generic labels (step1, helper2) | Labels should have meaning |
| Time-sensitive info | Will become outdated |
| Inconsistent terminology | Confusing |
| Deep reference chains | Partial reads miss information |

## In This Repo

Skills live in `~/agent` (this config repo) and are symlinked into both tools:

1. Create `skills/<name>/SKILL.md`, with `name:` equal to `<name>`.
2. Add a `| **<name>** | … |` row to the Skills table in `README.md` — CI fails without it.
3. Optional: add `commands/<name>.md` ("Load the <name> skill…") for an OpenCode slash command. Claude Code already exposes every skill as `/<name>`.
4. Run `./scripts/validate.sh`, then `./install.sh` to link the new skill.
5. Third-party skills are vendored, not hand-written: add them to `scripts/update-vendored-skills.sh` and `THIRD_PARTY.md`, and don't edit the copies.

## Checklist

Before deploying:
- [ ] Description starts with "Use when..." with specific triggers
- [ ] Description in third person, no step-by-step summary
- [ ] Name matches the directory, lowercase kebab-case
- [ ] Guidance form matches the failure type
- [ ] Overview is 1-2 sentences with core principle
- [ ] One excellent example (not multi-language)
- [ ] Common mistakes section
- [ ] SKILL.md under 500 lines
- [ ] Supporting files only for tools or heavy reference
- [ ] References one level deep from SKILL.md
- [ ] Tested with a realistic task
