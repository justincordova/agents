# CLAUDE.md

## Developer

Justin Cordova

## Planning Workflow

**New features (design decisions needed):**
brainstorm → design doc → plan → execute → (iterate) → sync-docs when ready

**Small iterations (bugfixes, tweaks, mechanical changes):**
(skip brainstorm) → plan (lightweight) → execute

**Greenfield (no SPEC.md yet):**
brainstorm → spec (interview mode, writes initial SPEC.md) → plan → execute

Rules:
- **Brainstorm is optional.** Use it when the work involves genuine design decisions, multiple viable approaches, or unclear scope. Skip it for mechanical changes where the design is obvious.
- **Always write a plan, even if it's three lines.** Execute always loads from a plan file. This is the session-boundary artifact for small iterations.
- **Design docs are the session-boundary artifact for new features.** Brainstorm writes `docs/designs/<feature>.md`. A new session can pick up at the plan step without losing context.
- **SPEC.md is only updated when the user decides to reconcile.** Either via sync-docs (which merges implemented design docs into SPEC.md and deletes them) or via direct spec skill invocation. Never updated automatically from brainstorm, plan, or execute.
- **SPEC.md has one owner — the spec skill.** Brainstorm never writes to SPEC.md (except via greenfield handoff). Plan never writes to SPEC.md. Execute never writes to SPEC.md. sync-docs can edit SPEC.md directly when reconciling drift.
- **sync-docs is on-demand, not automatic.** Run it when you want to reconcile docs after iterating — typically after 3-5 small changes have accumulated, or after a feature ships and stabilizes.
- **Plans are disposable.** Create, execute, done. For changes, write a new plan.
- Plans live in `docs/plans/<feature-name>-plan.md`. Design docs live in `docs/designs/<feature-name>.md` and persist until sync-docs merges them into SPEC.md.
- When reading SPEC.md, always check `docs/designs/` for in-flight features that SPEC.md may not reflect yet.

## Git Conventions

Commits are feature-scoped and written by the developer. Claude does NOT author
or suggest commit messages unless explicitly asked.

Format: `type(scope): description`

Common types:
- `feat` — new feature
- `fix` — bug fix
- `refactor` — code restructure with no behavior change
- `chore` — maintenance, deps, config
- `docs` — documentation only
- `test` — test additions or changes
- `style` — formatting only

Rules:
- **Never** append "Generated with Claude Code", "Co-authored by Claude", or any
  AI attribution footer to commit messages
- **Never** suggest or auto-generate commit messages unless explicitly asked
- One commit per logical feature or change — not per file, not per session, not per minor task
- Description is lowercase, no trailing period
- Keep the subject line under 72 characters

### Pre-Commit Gate

Before any commit, the project must build and pass. Run in order:
1. Build the project (e.g. `go build ./...`, `npm run build`, etc.)
2. Run tests (e.g. `go test ./...`, `npm test`, etc.)
3. Run type checking / linting if applicable

If anything fails, fix it. Do not commit broken code.

---

## Code Style

- Prefer small, focused diffs. Never refactor unrelated code in the same change.
- Match the existing style of the file you are editing — do not impose conventions.
- If a file has no precedent for something, follow the nearest pattern in the repo.
- No commented-out code. Remove it or don't write it.
- Explicit is better than clever. Readability first.

---

## General Rules

- During brainstorming, ask clarifying questions if the task is ambiguous.
- During brainstorming, share best practice recommendations relevant to the question being asked.
- Never touch files outside the scope of the current task.
- If context is getting large, say so — don't silently degrade.
- Treat every task as if a senior engineer will review it tomorrow.

---

## Rules

@rules/obsidian.md
@rules/code-quality.md

@RTK.md
