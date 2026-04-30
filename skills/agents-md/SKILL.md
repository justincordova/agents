---
name: agents-md
description: Use when the user asks to create or update an AGENTS.md file, or when setting up agent context for a project. Generates a structured onboarding document for AI agents working in a codebase.
---

# Agents MD

## Overview

Generate or update `AGENTS.md` — a structured onboarding file that gives AI agents enough context to work effectively in a codebase without reading every file. Think of it as a "README for agents."

**Announce at start:** "Using agents-md skill to generate AGENTS.md."

## When to Use

- User says "create AGENTS.md", "update AGENTS.md", "generate agent context"
- Setting up a new project for AI-assisted development
- Refreshing a stale AGENTS.md after significant changes

## Output Location

Write to `AGENTS.md` in the project root (same directory as `package.json`, `go.mod`, etc.).

## Discovery Phase

Before writing anything, scan the codebase to extract all sections. Run these in parallel where possible:

### 1. Project identity
- Read `package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, or equivalent
- Identify: name, language, framework, runtime version
- Read `README.md` or `docs/SPEC.md` for the one-line project description

### 2. Repo layout
- List top-level directories and files
- Drill into each major directory to understand purpose
- Read key entry points (`main.go`, `src/index.ts`, `cmd/`, `apps/`, `packages/`)
- Note monorepo structure if present (workspaces, packages, apps)

### 3. Commands
- Check `package.json` scripts, `Makefile`, `justfile`, `Taskfile.yml`, or equivalent
- Identify: dev server, build, test, lint, format, typecheck, migration
- Determine the pre-commit gate (which commands must pass before committing)

### 4. Tech stack
- Scan `package.json` dependencies, `go.mod` requires, `Cargo.toml` dependencies
- Read config files: `tsconfig.json`, `biome.json`, `.eslintrc`, `.golangci.yml`, `tailwind.config.*`, `vite.config.*`, `docker-compose.yml`
- Build a table mapping each layer to its tool

### 5. Architectural patterns
- Read source files to identify key patterns (auth flow, data sync, state management, etc.)
- Look for shared abstractions: interfaces, base classes, middleware chains
- Note any non-obvious conventions (naming, file organization, error handling)

### 6. Module structure
- For each major source directory, list files with a one-line comment per file
- Group by domain/feature, not alphabetically
- Include only files agents would need to know about (skip generated files, build artifacts)

### 7. Known gotchas
- Look for `TODO`, `FIXME`, `HACK` comments in source
- Check for non-obvious dependencies (env vars that must be set, services that must be running)
- Note version-specific quirks (e.g., "library X v4 doesn't support Y")
- Check for platform-specific code (build tags, conditional imports)
- Note any counter-intuitive patterns that an agent might "fix" incorrectly

### 8. Conventions and non-negotiables
- Read `CLAUDE.md`, `.editorconfig`, linter configs
- Identify hard rules (e.g., "no logging to stdout", "use stdlib slog only")
- Note assertion libraries, testing patterns, code style mandates

## Template

Use this structure. Omit sections that don't apply to the project. Add sections for patterns unique to the project.

```markdown
# {ProjectName} — Agent Context

{One-paragraph description. What it does, what stack, what architecture.}

## Repo layout

```
{project}/
├── {dir}/          # {purpose}
├── {dir}/
│   └── {file}      # {purpose}
├── {config-file}   # {purpose}
```

## Commands

```bash
{command}     # {description}
```

The pre-commit gate is: {which commands}. All must pass before committing.

## Tech stack

| Layer | Choice |
|---|---|
| {Layer} | {Tool/Library} |

## Key architectural patterns

### {Pattern name}

{2-4 sentences explaining the pattern and where it lives in the codebase.}

## {Module name} structure (`{path}/`)

```
{file}    — {one-line description}
```

## Known gotchas

- **{Topic}**: {what to watch out for}

## Further reading

- **`docs/{file}`** — {what it covers}
```

## Writing Rules

- **File references use paths, not descriptions.** Write `apps/server/src/sync/authorize.ts` not "the authorization file."
- **Every module entry gets a one-liner.** No empty lines between files in a module listing.
- **Commands include descriptions.** Every bash command has a `# comment`.
- **Tech stack table is complete.** Include test framework, linter, ORM, state management — anything an agent would need to know.
- **Gotchas are specific.** "tldraw v4: use `createTLStore()` with no args" not "be careful with tldraw."
- **No padding.** If a section would be empty, omit it entirely.
- **Module structures use tree format** with `— ` separators (em dash + space) for file descriptions, or `# ` comments for directories.
- **Keep under 400 lines.** AGENTS.md is loaded into agent context — every line competes with the conversation. Be ruthless about cutting.

## Process

1. Run discovery phase (all scans)
2. Draft AGENTS.md following the template
3. If an existing `AGENTS.md` exists, read it first and note what changed vs the current codebase
4. Present the draft to the user with a summary of what's included
5. Wait for approval before writing
6. Write the file

## Updating an Existing AGENTS.md

When updating rather than creating from scratch:

1. Read the existing `AGENTS.md`
2. Run discovery phase to find what changed
3. Update only the sections that drifted — don't rewrite the whole file
4. Present a diff summary: "Updating 3 sections: Commands (added `just lint`), Tech stack (added Glamour), Module structure (new `internal/topics/`)"
5. Wait for approval before saving
