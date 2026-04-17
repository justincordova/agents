---
name: execute
description: Use when you have a written implementation plan to execute with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks in batches, report for review between batches.

**Announce at start:** "Using executing-plans skill to implement this plan."

## The Process

### Step 1: Load and Review Plan

1. Read the plan file
2. Review critically — identify questions or concerns
3. If concerns: raise them before starting
4. If no concerns: create task list and proceed

### Step 2: Execute Batch

**Default: First 3 tasks**

For each task:
1. Mark as in_progress
2. Follow the steps described in the plan
3. Run verifications as specified
4. Mark as completed

### Step 3: Report

When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 4: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 5: Wrap Up

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
- Between batches: report and wait for feedback
- Stop when blocked, don't guess
- Don't commit unless explicitly asked
