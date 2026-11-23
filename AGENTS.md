# AGENTS.md

## Developer

Justin Cordova

## Planning Workflow

**New features (design decisions needed):**
brainstorm → design doc → (plan only if complex) → execute → (iterate) → sync-docs when ready

**Small iterations (bugfixes, tweaks, mechanical changes):**
(skip brainstorm) → execute

**Greenfield (no SPEC.md yet):**
brainstorm → spec (interview mode, writes initial SPEC.md) → (plan only if requested) → execute

Rules:
- **Brainstorm is optional.** Use it when the work involves genuine design decisions, multiple viable approaches, or unclear scope. Skip it for mechanical changes where the design is obvious.
- **Plans are always opt-in.** After brainstorm produces a design doc, the developer decides whether to write a plan. Simple implementations go straight to execute using the design doc as context. Small iterations go straight to execute with no plan at all. Only write a plan when the developer explicitly invokes `/plan` — typically for complex designs, possibly using a stronger model.
- **Design docs are the session-boundary artifact for new features.** Brainstorm writes `docs/designs/<feature>.md`. A new session can pick up from here — either going to plan or straight to execute.
- **SPEC.md is only updated when the user decides to reconcile.** Either via sync-docs (which merges implemented design docs into SPEC.md and deletes them) or via direct spec skill invocation. Never updated automatically from brainstorm, plan, or execute.
- **SPEC.md has one owner — the spec skill.** Brainstorm never writes to SPEC.md (except via greenfield handoff). Plan never writes to SPEC.md. Execute never writes to SPEC.md. sync-docs can edit SPEC.md directly when reconciling drift.
- **sync-docs is on-demand, not automatic.** Run it when you want to reconcile docs after iterating — typically after 3-5 small changes have accumulated, or after a feature ships and stabilizes.
- **Plans are disposable.** Create, execute, done. For changes, write a new plan.
- Plans live in `docs/plans/<feature-name>-plan.md`. Design docs live in `docs/designs/<feature-name>.md` and persist until sync-docs merges them into SPEC.md.
- When reading SPEC.md, always check `docs/designs/` for in-flight features that SPEC.md may not reflect yet.
- Issue briefs from analyze-issue live in `docs/issues/<number>-<slug>.md` and are a valid input to execute.

## Git Conventions

Commits are feature-scoped.

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
- One commit per logical feature or change — not per file, not per session, not per minor task
- Description is lowercase, no trailing period
- Keep the subject line under 72 characters

### Versioning

Track three independent things; do not conflate them.

- **Commits (fine grain).** Conventional Commits (`type(scope): description`, above)
  are the detailed version history. One per logical change.
- **Milestone tags (coarse grain).** Tag meaningful milestones with annotated git
  tags using `0.x` pre-release SemVer: each shipped phase/milestone is a minor bump
  (`v0.1.0`, `v0.2.0`, …), fixes within a milestone are patch bumps, and `v1.0.0` is
  the project's stated definition-of-done. Use `git tag -a vX.Y.Z -m "..."` so the
  tag records what landed. Prefer this over maintaining a separate CHANGELOG for
  solo projects. Tag only when the milestone's gate/exit criteria are actually green.
- **Data/save-format version (if the project persists state).** A monotonic integer
  inside the serialized format, independent of git tags and SemVer. Bump it only on a
  breaking schema change, and ship a forward migration. It changes for different
  reasons than releases, so never tie it to a git tag.

When a project has phase/milestone structure, record the specific
milestone→tag mapping in a project-local `docs/VERSIONING.md`, not here.

### Pre-Commit Gate

Before any commit, the project must build and pass. Run in order:
1. Build the project (e.g. `go build ./...`, `npm run build`, `dotnet build`, etc.)
2. Run tests (e.g. `go test ./...`, `npm test`, `dotnet test`, etc.)
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

### Browser Verification During Development

- Do not use browser automation or the `agent-browser` skill unless the user explicitly requests browser interaction or visual verification.
- If a specific issue cannot be resolved without real-browser evidence (layout, focus, navigation, client-side runtime behavior), propose using `agent-browser` and wait for approval.
- For repeatable end-to-end coverage, write or run the project's Playwright Test suite instead of using `agent-browser`.
- Do not start a local development server, simulator, or device solely for verification. Prefer source inspection and build, type, lint, and test checks.
- These rules override third-party skills (e.g. `impeccable`) that instruct you to screenshot or render the result.

### Frontend Work

- Start frontend tasks with the `frontend-design` skill. It routes to `impeccable` and Emil Kowalski's skills (`animate`, `choreograph`, `gestures`, etc.) when a task narrows to their specialty. When the user names one of those skills directly, use it.

---

## Rules

@rules/code-quality.md

@RTK.md
