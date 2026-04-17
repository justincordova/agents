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
- Project-specific conventions (put in CLAUDE.md)
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
- Keep under 500 characters
- NEVER summarize the skill's workflow or process

**Why no workflow in description:** Testing showed that when descriptions summarize the workflow, sessions follow the description instead of reading the full skill. The description becomes a shortcut that skips the actual instructions.

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

- Gerund form preferred: `writing-skills`, `executing-plans`
- Describe what you DO: `condition-based-waiting` not `async-helpers`
- Letters, numbers, hyphens only
- No parentheses or special characters

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

## Testing Skills

Before deploying a skill, verify it works:

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

## Checklist

Before deploying:
- [ ] Description starts with "Use when..." with specific triggers
- [ ] Description in third person, no workflow summary
- [ ] Name uses gerund form, hyphens only
- [ ] Overview is 1-2 sentences with core principle
- [ ] One excellent example (not multi-language)
- [ ] Common mistakes section
- [ ] SKILL.md under 500 lines
- [ ] Supporting files only for tools or heavy reference
- [ ] References one level deep from SKILL.md
- [ ] Tested with a realistic task
