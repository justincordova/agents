---
name: code-review
description: Use when reviewing code for quality, bugs, security, and correctness. Load before any code review, whether reviewing your own work or someone else's.
---

# Code Review

## Overview

Thorough code review methodology: correctness, security, error handling, concurrency, and design. Think like a senior engineer reading this for the first time.

**Core principle:** Read everything before writing anything. Understand what it's trying to do, trace what it actually does, find where those diverge.

## The Process

### 1. Establish Context

- What language, framework, and stack?
- What kind of code is this? (API, CLI, library, frontend, data pipeline)
- What is this code supposed to do?
- What changed? (diff, PR description, commit messages)

### 2. Read Everything

Read every file completely. Do not skim.

For each function, ask:
1. What is this supposed to do?
2. What does it actually do?
3. Under what conditions do 1 and 2 diverge?

### 3. Mentally Simulate Execution

Run it in your head under adverse conditions:
- Empty, null, zero, or malformed input
- Two requests at the same time
- Slow or failing dependencies (database, API, filesystem)
- The 1000th call. Large datasets. Deep recursion.
- Attacker-controlled input
- Error paths — does cleanup still run?

### 4. Trace Data Flow

For any external input (user input, request body, env var, file, network):
- Where does it go?
- Is it validated?
- Does it reach a query, command, file path, log, or response unmodified?

## What to Look For

### Correctness
- Does the code do what it claims?
- Variables mutated inside loops corrupting logic
- Conditions that can never be true
- Off-by-one errors
- Return values silently discarded

### Error Handling
- Every operation that can fail must handle it, propagate it, or document why it's safe to ignore
- Silent failures and swallowed exceptions are bugs
- Partial failures leaving inconsistent state are serious bugs

### Security
- Trace user input: does it reach a query, shell command, file path, or response without sanitization?
- Auth checks: does it verify identity AND ownership?
- Can auth be bypassed by hitting a different route or HTTP method?
- Are secrets, tokens, or PII being logged?
- Passwords hashed properly? (bcrypt/argon2, not MD5/SHA1)
- Hardcoded credentials anywhere?
- Input validation: type checked, length bounded, format validated

### Concurrency
- Shared state with unsynchronized access?
- Races between response and background work?
- Leaked goroutines/threads?

### Resource Management
- Anything opened must be closed
- Cleanup runs on error paths
- No resource leaks inside loops

### Data Correctness
- Floats for money or precision values
- Timezone-naive datetimes
- Integer overflow
- ReDoS on user-controlled regex

### Design
- Is this solving the right problem?
- Is the abstraction appropriate?
- Would this be hard to test, extend, or understand in 6 months?

## Output Format

**Critical** — broken behavior, data loss, security vulnerability, crash risk
**Important** — incorrect logic, unhandled errors, performance problems
**Suggestion** — improvements, naming, style

For each finding:
- File and line number
- What the code does vs. what it should do
- Concrete fix

Only report findings grounded in actual code with a specific line. Do not speculate.

Open with a brief summary: stack, what the code does, overall quality. Close with highest-priority items first.

Do not make edits. Report only.
