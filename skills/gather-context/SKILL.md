---
name: gather-context
description: Use when the user wants to quickly understand a codebase or project before doing work. Scans structure, conventions, dependencies, and patterns. Produces a concise summary, not files.
---

Quickly understand a codebase by scanning its structure, conventions, dependencies, and patterns. The output is a concise summary delivered in chat — no files created.

**Announce at start:** "Using gather-context skill to scan the project."

## When to Use

- Starting work on an unfamiliar codebase
- Coming back to a project after a break
- Before brainstorming or planning, when context is needed fast
- When the user says "what's going on in this project?" or "catch me up"

## Checklist

Create a task for each item and complete them in order. Run scans in parallel where possible.

### 1. Project identity

- Find the package manifest (`package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `.csproj`, `Directory.Build.props`, etc.)
- Identify: name, language, framework, runtime version
- Read `README.md` or `docs/SPEC.md` for the project description

### 2. Structure

- List top-level directories and files
- Drill into each major directory to understand purpose
- Note entry points (`main.go`, `src/index.ts`, `cmd/`, `apps/`, `packages/`)
- Identify monorepo layout if present (workspaces, packages, apps)

### 3. Commands

- Check `package.json` scripts, `Makefile`, `justfile`, `Taskfile.yml`, `.csproj` targets, or equivalent
- Identify: dev server, build, test, lint, format, typecheck
- Note the pre-commit gate (which commands must pass)

### 4. Dependencies

- Scan runtime and dev dependencies
- Identify the key libraries the project relies on
- Note version constraints or pinned versions

### 5. Conventions and patterns

- Read `AGENTS.md` or equivalent config if it exists
- Check linter/formatter configs
- Identify coding patterns: state management, auth flow, data layer, error handling
- Note any non-obvious conventions (naming, file organization, import style)

### 6. Recent activity

- Check recent git log (last 5-10 commits) to understand what's been happening
- Check for uncommitted changes

## Output Format

Present a concise summary in chat. Keep it scannable.

```
## Context: <project name>

**What it is:** <1 sentence>
**Stack:** <language, framework, key deps>
**Structure:** <brief layout description>

**Commands:**
- `cmd` — what it does

**Key patterns:**
- <pattern> — <where it lives>

**Recent activity:**
- <last few commits or active work>
```

If the user asked about something specific, focus the summary on that area. Skip sections that aren't relevant to what they're about to do.

## Key Principles

- **Fast, not exhaustive.** This is a quick scan, not a deep audit. Target 2-3 minutes.
- **Focused on what matters next.** If the user is about to build a feature, emphasize the files and patterns they'll touch. If they're just exploring, give the broad picture.
- **No files created.** The output is a chat summary. If the user wants persistent context, that's what the sync-agents skill is for.
- **Skippable.** If context is already clear from the conversation, say so and skip the scan.
