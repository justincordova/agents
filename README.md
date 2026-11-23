# agents

A structured AI coding workflow — skills, commands, and rules that make AI think before it builds.

Give an agent a prompt and hope for the best, or make it understand the problem before writing code, propose approaches before committing to one, and execute in reviewable chunks. This is the second one.

Shared between [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and [OpenCode](https://opencode.ai) — one config, symlinked into both tools.

## The workflow

The workflow branches on whether the work involves design decisions.

```
New features (design decisions needed):
  brainstorm → design doc → (plan only if complex) → execute → (iterate) → sync-docs when ready

Small iterations (bugfixes, tweaks, mechanical changes):
  (skip brainstorm) → execute

Greenfield (no SPEC.md yet):
  brainstorm → spec (interview mode) → (plan only if requested) → execute

Issue-driven work:
  /analyze-issue → (plan only if requested) → execute
```

The rules that govern this — when to brainstorm, when a plan is warranted, who is allowed to write to SPEC.md — live in [AGENTS.md](AGENTS.md). That is the canonical copy and the agent reads it directly, so it isn't restated here.

What's worth explaining is why the shape is what it is.

**Brainstorm is optional, but it's a hard gate when it runs.** Mechanical work skips it entirely. When there are real design decisions, the agent explores the problem, asks clarifying questions one at a time, proposes 2-3 approaches with trade-offs, and gets the design approved before any code is written.

**Design docs are the session boundary.** A doc in `docs/designs/` is what lets you end a session after brainstorming and resume cleanly in a new one — the context that mattered is on disk instead of buried in a transcript.

**Execute groups tasks into batches by logical cohesion** — related tasks stay together regardless of count, unrelated tasks get separate batches. The agent stops and reports between batches. You give feedback. It continues. No 50-step fire-and-forget.

**Code review reads every file completely,** mentally simulates execution under adverse conditions, traces data flow for security issues, and reports findings ranked by severity. No edits — report only.

## What's in here

### Skills

Skills define *how the agent behaves* — behavioral context loaded when a task matches.

| Skill | What it does |
|---|---|
| **brainstorm** | Collaborative design through questions, approaches, and approval gates. Produces a design doc. |
| **spec** | Owns `docs/SPEC.md`. Two modes: direct edit or initial spec interview. Merging design docs is sync-docs' job. |
| **plan** | Detailed implementation plans with three input modes: design doc, user instructions, or greenfield SPEC.md. |
| **execute** | Smart batch execution grouped by logical cohesion |
| **sync-docs** | On-demand reconciliation of docs with the codebase |
| **analyze-issue** | Fetch GitHub issues, break down requirements, produce an impl spec |
| **code-review** | Systematic review — correctness, security, concurrency, design |
| **debugging** | Structured debugging — reproduce, isolate, fix, verify |
| **testing** | Test strategy and implementation following project conventions |
| **sync-agents** | Generate or update AGENTS.md — structured onboarding context for AI agents |
| **gather-context** | Quick codebase scan — structure, conventions, deps, patterns. Chat summary, no files. |
| **writing-skills** | Create and edit skills for both tools |
| **find-skills** | Discover and install community skills |
| **frontend-design** | Production-grade frontend interfaces with distinctive, non-generic aesthetics. Entry point for frontend work — routes to the third-party design skills below. |
| **agent-browser** | Browser automation via CLI |
| **obsidian** | Vault conventions — note naming, structure, linking, when to write one |

#### Third-party design skills

Vendored from upstream so they sync with everything else — sources, commits, and licenses in [THIRD_PARTY.md](THIRD_PARTY.md). Don't edit them in place; refresh with `./scripts/update-vendored-skills.sh`.

| Skill | What it does |
|---|---|
| **impeccable** | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) — design critique, audit, polish, and steering commands (`bolder`, `quieter`, `typeset`, …) plus an AI-slop detector |
| **emil-design-eng** | [Emil Kowalski](https://github.com/emilkowalski/skills)'s design-engineering philosophy — interaction polish and invisible details |
| **animate** | Build one web animation with the right curve, duration, and properties |
| **choreograph** | Coordinate several elements animating together |
| **gestures** | Drag, swipe, and sheet interactions that track the finger |
| **apple-design** | Apple's interface and fluid-motion principles, translated for the web |
| **animation-performance** | Fix animations that drop frames |
| **animation-vocabulary** | Name a motion effect from a vague description |
| **review-animations** | Strict review of motion code |
| **improve-animations** | Audit a codebase's motion and write prioritized fix plans |
| **find-animation-opportunities** | Find places that should animate (and reject those that shouldn't) |
| **remove-animations** | Remove motion the interface doesn't need |
| **mobile-native** | Make a web app feel native on a phone |
| **break-ui** | Stress-test UI with worst-case data |
| **pick-ui-library** | Pick a trusted library instead of hand-rolling components |
| **prototype** | Build several variants behind a live picker |
| **learn-taste** | Turn a session's design corrections into rules in `DESIGN.md` |
| **ask-emil** | Router — which of Emil's skills fits the situation |

### Commands

Slash commands are saved prompt templates — shortcuts that trigger the corresponding skill. They're installed for OpenCode only; Claude Code already exposes every skill as `/<name>`.

`/brainstorm` `/spec` `/plan` `/execute` `/sync-docs` `/sync-agents` `/gather-context` `/code-review` `/analyze-issue` `/writing-skills`

Not every skill has a command. **debugging**, **testing**, **find-skills**, **frontend-design**, **agent-browser**, **obsidian**, and the third-party design skills are triggered by the task itself — you don't announce that you're debugging, you just describe the bug.

### Rules

Rules are pulled into *every* project's context — via `@rules/` in AGENTS.md for Claude Code, and the `instructions` array in `opencode.json` for OpenCode (which doesn't expand `@` imports) — so this stays deliberately small:

- **code-quality** — testing philosophy, review standards, error handling, logging

Anything that only applies to certain work belongs in a skill, where it loads on demand. That's why note-taking conventions live in the **obsidian** skill rather than here — no reason to carry vault rules into a Rust build.

### AGENTS.md

The foundational config — developer info, planning workflow, git conventions (conventional commits, no AI attribution, pre-commit gate), code style, and general rules. Shared across both tools.

### RTK.md

Usage notes for [rtk](https://github.com/rtk-ai/rtk), a token-optimizing CLI proxy that filters command output. Taken from rtk's hook-mode awareness text (`hooks/rtk-awareness-high.md` upstream) — refresh it from there when rtk updates. Machine-specific and entirely optional — if you don't have `rtk` installed, nothing here applies and the rest of the config works unchanged.

## Setup

Clone anywhere — the installer resolves paths from its own location.

```bash
git clone git@github.com:justincordova/agents.git ~/agent
~/agent/install.sh
```

This symlinks `AGENTS.md`, `RTK.md`, `rules/`, and each skill into both `~/.claude` and `~/.config/opencode`, plus `commands/` into OpenCode. Skills are linked one directory at a time so standalone skills can live alongside these. The script is idempotent — re-run it after pulling to pick up new skills.

OpenCode doesn't expand AGENTS.md's `@rules/…` and `@RTK.md` imports, so add them to your global `opencode.json` (the installer reminds you if they're missing):

```json
"instructions": ["~/.config/opencode/rules/*.md", "~/.config/opencode/RTK.md"]
```

## Validation

```bash
./scripts/validate.sh
```

This repo is markdown held together by convention, and the tools silently ignore anything they can't parse — a typo'd skill name just means the skill never loads. `validate.sh` checks the contracts: skill `name:` matches its directory, every command points at a skill that exists, frontmatter is present, and the README describes what's actually on disk. It runs in CI on every push and PR.

## Why

Most AI coding configs are an AGENTS.md with some rules and a prayer. This is a workflow — brainstorm before building, execute in batches, review at every checkpoint, and never let the agent run unsupervised.
