---
name: execute
description: Use when you have a written implementation plan to execute with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks in smart batches based on logical cohesion, report for review between batches.

**Announce at start:** "Using executing-plans skill to implement this plan."

## The Process

### Step 1: Load and Review Plan

1. Read the plan file
2. Review critically — identify questions or concerns
3. If concerns: raise them before starting
4. If no concerns: create task list and proceed

### Step 2: Determine Batches

Group tasks into batches based on **logical cohesion**, not a fixed count:

- Tasks that are **related** (same feature, same component, same domain area) = **one batch**, regardless of how many
- Tasks that are **unrelated** (different components, different concerns) = **separate batches**
- If the plan has phases with stage gates, each phase boundary is a natural batch break

**Examples:**

| Tasks | Batch Decision | Why |
|-------|---------------|-----|
| 8 tasks all building auth | 1 batch | All same domain |
| 6 auth tasks + 2 DB schema tasks | 2 batches | Different domains |
| 3 completely unrelated tasks | 3 batches | No cohesion |
| Phase 1: 5 tasks, Phase 2: 4 tasks | 2 batches (or more within phases) | Phase boundary is a natural break |

Present your batch grouping to the user before executing. Explain the grouping logic if it's not obvious.

### Step 3: Execute Batch

For each task:
1. Mark as in_progress
2. Follow the steps described in the plan
3. Run verifications as specified
4. Mark as completed

### Step 4: Report

When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 5: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 6: Wrap Up

After all tasks complete and verified:
- Run full test suite
- Run build
- Report completion

## When to Stop and Ask

**STOP immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## Key Principles

- Review plan critically first
- Follow plan steps — don't skip ahead
- Don't skip verifications
- Batch by cohesion, not count
- Between batches: report and wait for feedback
- Stop when blocked, don't guess
- Don't commit unless explicitly asked
