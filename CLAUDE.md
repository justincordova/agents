# CLAUDE.md

## Developer

Justin Cordova

## Planning Workflow

**All work:**
brainstorm → spec → plan → execute → retro

**Small tasks (bugfixes, config changes):**
brainstorm → plan (lightweight) → execute

Rules:
- Always brainstorm first, even for small tasks. Understand before building.
- Always write a plan, even if it's three lines. Execute always loads from a plan file.
- Use the brainstorm skill, then follow the appropriate path.
- `docs/SPEC.md` is a living document. The spec skill owns it. Brainstorm hands off to spec whenever design decisions change — during brainstorming, after retros, when pivoting.
- Plans are disposable — create, execute, done. For changes, write a new plan.
- Plans live in `docs/plans/<feature-name>-plan.md`.
- After execution, run retro for any meaningful feature. Skip retro for trivial fixes.

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
