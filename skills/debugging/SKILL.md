---
name: debugging
description: Use when something is broken, behaving unexpectedly, or producing wrong output. Systematic root-cause analysis methodology.
---

# Debugging

## Overview

Systematic debugging: reproduce → isolate → root cause → fix → verify. Not "add print statements and hope."

**Core principle:** Don't guess. Observe. Narrow the space of possible causes until the answer is obvious.

## When to Use

- Something is broken or behaving unexpectedly
- Tests are failing and you don't know why
- Performance is degraded
- Something works locally but not in production/ci
- Error messages are confusing or unhelpful

## The Process

### 1. Reproduce

Get a minimal, reliable reproduction.

- Can you make it happen on demand?
- What's the simplest case that triggers it?
- Does it happen every time or intermittently?

If you can't reproduce it, you can't fix it. Stop here and gather more information.

**Intermittent bugs:** Timing issues, race conditions, state dependencies. Try to identify what makes it happen sometimes but not always. Note the conditions.

### 2. Isolate

Narrow down where the bug lives.

**Binary search approach:**
- Bisect the code path. Which half contains the bug?
- Add strategic logging/checkpoints, not print statements everywhere.
- Check assumptions at boundaries: "Is the input what I expect here?"

**Common isolation techniques:**
- **Input elimination:** Strip inputs to the minimum that still triggers the bug
- **Code path elimination:** Comment out branches, does it still happen?
- **Version bisection:** `git bisect` to find the commit that introduced it
- **Dependency isolation:** Does it happen without that library? With a different version?

### 3. Root Cause

Once isolated, understand WHY.

**Ask these questions:**
- What did the developer intend?
- What actually happens?
- At what point do those diverge?

**Common root causes by category:**

| Symptom | Likely Root Cause |
|---------|-------------------|
| Works locally, fails in CI | Environment diff (env vars, file paths, timezone, OS) |
| Intermittent failures | Race condition, uninitialized state, flaky external dep |
| Wrong output, no error | Bad assumption about data shape, off-by-one, wrong operator |
| Error in library code | You're using it wrong — check the contract |
| Works once, fails on repeat | State not reset, mutation of shared data |
| Performance degradation | N+1 query, growing data structure, missing index |

**Don't stop at the symptom.** "The variable was null" is a symptom. "The API returns null when the record doesn't exist and we didn't handle that case" is a root cause.

### 4. Fix

- Fix the root cause, not the symptom.
- Add a test that reproduces the bug first (if applicable).
- Keep the fix minimal. Don't refactor while debugging.
- Add a comment if the fix is non-obvious (future you will thank you).

### 5. Verify

- The original reproduction case now works
- Edge cases around the fix work
- No regressions in related functionality
- If it was intermittent — can you still trigger it?

## Anti-Patterns

| Don't | Do Instead |
|-------|-----------|
| Change random things until it works | Form a hypothesis, test it |
| Add console.log everywhere | Add strategic checkpoints at boundaries |
| Fix the symptom | Find and fix the root cause |
| Assume you know what's wrong | Verify your assumptions |
| Refactor while debugging | Fix the bug, refactor later |
| Skip the reproduction step | Reproduce first, always |
| Blame the framework/library | Verify your usage first |

## When to Ask for Help

- You've been stuck for 30+ minutes on the same issue
- You've tried two different isolation approaches and neither worked
- The bug might be in code you don't understand (kernel, runtime, compiler)
- You keep making the same fix and it keeps not working
