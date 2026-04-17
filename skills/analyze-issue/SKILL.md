---
name: analyze-issue
description: "Use when the user mentions analyzing a GitHub issue, fixing an issue, or references an issue number. Fetches issue details, analyzes requirements, and creates an implementation specification."
---

# Analyze Issue

## Overview

Fetch a GitHub issue, understand its full context, and produce a structured implementation specification ready for planning.

**Announce at start:** "Using analyze-issue skill to break down this issue."

## When This Skill Activates

- User says "analyze issue" or "look at issue" or "fix issue #N"
- User references a GitHub issue number
- User says something like "check the issue" or "what's issue 42 about"

## The Process

### Step 1: Fetch Issue

1. Extract issue number and repo from user input
2. If no repo specified, detect from current git remote
3. Run `gh issue view <number> --repo <owner/repo> --json title,body,labels,assignees,milestone,comments`
4. If issue not found, ask user to clarify

### Step 2: Understand Context

1. Read the issue title, body, labels, and all comments
2. Identify: what's broken / what's requested / what's the expected behavior
3. Check for linked PRs, related issues, or cross-references
4. Look at the codebase for affected files (search for relevant terms)

### Step 3: Analyze Requirements

Break the issue down into:
- **Problem**: What's wrong or missing (in your own words)
- **Scope**: Which files/modules/areas are affected
- **Constraints**: Any requirements from labels, comments, or project conventions
- **Edge cases**: What could go wrong or be overlooked
- **Dependencies**: Does this depend on other work?

### Step 4: Produce Implementation Spec

Write a structured spec to `docs/issues/<number>-<slug>.md`:

```markdown
# Issue #<number>: <title>

## Problem
<1-3 sentences>

## Requirements
- <numbered list of what must be true when done>

## Affected Areas
- `<file_or_module>` — <what needs to change>

## Implementation Approach
<2-5 sentences describing the approach>

## Edge Cases
- <what to watch out for>

## Acceptance Criteria
- [ ] <testable outcome>
- [ ] <testable outcome>
```

### Step 5: Transition

Ask user what's next:
1. **Write a plan** (writing-plans skill) — create step-by-step implementation instructions
2. **Start building** — for straightforward issues
3. **Discuss** — if something is unclear or needs design decisions

## Key Principles

- Always fetch the full issue including comments — context is in the discussion
- Detect repo from git remote when possible — don't make user type it
- Write specs to `docs/issues/` — keep them discoverable
- Check the codebase before proposing an approach — avoid assumptions
- Ask before implementing — the spec is a checkpoint, not a starting gun
