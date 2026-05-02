---
name: sync-agents
description: Use when the user asks to create or update an AGENTS.md file, or when setting up agent context for a project. Generates a concise onboarding document for AI agents working in a codebase.
---

# Sync Agents

## Overview

Generate or update `AGENTS.md` — a concise onboarding file that gives AI agents
the **minimum** context needed to work effectively. The agent has tools to
explore the codebase — AGENTS.md should only contain what those tools can't
easily discover: conventions, gotchas, architectural decisions, and process.

**Announce at start:** "Using sync-agents skill to update AGENTS.md."

## Core Principle

**AGENTS.md is not documentation.** It's a cheat sheet for things that are
non-obvious, counter-intuitive, or expensive to discover by reading code.
If an agent can figure it out by reading a file, don't put it in AGENTS.md.

## What NOT to include

- **Module structure listings** — agents can use `gather-context`, glob, and
  directory reads to discover files. Listing every file wastes context tokens.
- **Full API route catalogs** — agents can grep for route definitions.
- **Database schema tables** — agents can read the schema file.
- **Things already in other docs** — link to them, don't duplicate them.
- **Obvious conventions** — "use TypeScript" when every file is `.ts` is noise.
- **README content** — AGENTS.md is not a README.

## What TO include

- One-line project description + architecture
- Repo layout (top-level dirs only, one word each)
- Commands (dev, build, test, lint, typecheck)
- Pre-commit gate
- Tech stack table (only non-obvious choices or specific versions that matter)
- **Key architectural patterns** — things an agent would get wrong if it guessed
- **Known gotchas** — things that look wrong but are correct, or correct but break things
- **Conventions and non-negotiables** — rules that differ from standard practice
- **Links to docs** — one section pointing at SPEC.md, TODO.md, etc.

## Template

```markdown
# {ProjectName} — Agent Context

{One paragraph: what it does, what stack, what architecture.}

## Repo layout

{Top-level dirs only. No nested trees. No file-level descriptions.}

## Commands

{Only the commands an agent needs to run. Group by purpose.}

The pre-commit gate is: {commands}. All must pass before committing.

## Tech stack

| Layer | Choice |
|---|---|
{Only layers where the choice matters or is non-obvious.}

## Key architectural patterns

{2-4 patterns max. Only things that are non-obvious or easy to get wrong.
Each pattern: name + 2-3 sentences.}

## Known gotchas

{Only things an agent would break or "fix" incorrectly.}

## Further reading

- **`docs/{file}`** — {what it covers}
```

## Writing Rules

- **No hard line limit**, but keep it tight. Known gotchas and architectural
  patterns will grow naturally — that's fine. The enemy is filler: module
  listings, duplicated content, obvious conventions. Cut those ruthlessly.
- **No module structure listings.** Agents have `gather-context`, glob, and
  directory reads for that.
- **No duplication.** If it's in another doc, link to it.
- **Gotchas are specific and rare.** "tldraw v4: `createTLStore()` with no args"
  not "be careful with libraries."
- **Patterns explain why, not what.** "readOnly arrives via stateless message
  in the connected hook, not onAuthenticated" not "there's a readOnly system."
- **Omit empty sections.** If there are no gotchas, don't include the heading.

## Process

1. Read existing `AGENTS.md` if present
2. Scan codebase for what changed (commands, deps, patterns, gotchas)
3. Update only sections that drifted — don't rewrite the whole file
4. Present a diff summary to the user
5. Wait for approval before saving

## Updating an Existing AGENTS.md

1. Read the existing file
2. Compare against current codebase state
3. Update only what drifted — add new patterns/gotchas, remove stale ones,
   update commands if scripts changed
4. Trim any sections that violate the rules above (module listings, duplication)
5. Present diff summary: "Updating 3 sections: Commands (added `db:migrate`),
   Tech stack (added Stripe), Gotchas (added webhook ordering). Removed server
   module listing (agent can discover it)."
6. Wait for approval before saving
