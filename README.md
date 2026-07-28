# agents

A structured AI coding workflow — skills, agents, and commands that make AI think before it builds.

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
  brainstorm → spec (interview mode) → plan → execute

Issue-driven work:
  /analyze-issue → plan → execute
```

**Brainstorm is optional.** Use it when there are real design decisions to make. Skip it for mechanical changes.

**Design docs** (`docs/designs/<feature>.md`) are the session-boundary artifact for new features. Write one during brainstorm, pick up from it in a fresh session. Design docs persist until sync-docs merges them into SPEC.md.

**Plans are always opt-in.** After brainstorm produces a design doc, the developer decides whether to write a plan. Simple implementations go straight to execute. Small iterations skip plans entirely. Only invoke `/plan` when the design is complex enough to warrant one — typically with a stronger model.

**SPEC.md** is only updated when the user decides to reconcile — via sync-docs (which merges implemented design docs) or via direct spec skill invocation. Never automatically.

**Sync-docs** is on-demand. Run it when docs feel stale after iterating. It merges design docs into SPEC.md, catches drift, and reconciles all project documentation in one pass.

**Brainstorm** is the non-negotiable step. The agent explores the problem, asks clarifying questions one at a time, proposes 2-3 approaches with trade-offs, and presents a design for approval. No code gets written until the user approves.

**Execute** groups tasks into batches by logical cohesion — related tasks stay together regardless of count, unrelated tasks get separate batches. The agent stops and reports between batches. You give feedback. It continues. No 50-step fire-and-forget.

**Code review** uses a dedicated subagent that reads every file completely, mentally simulates execution under adverse conditions, traces data flow for security issues, and reports findings ranked by severity. No edits — report only.

## What's in here

### Skills

Skills define *how the agent behaves* — behavioral context loaded when a task matches.

| Skill | What it does |
|---|---|
| **brainstorm** | Collaborative design through questions, approaches, and approval gates. Produces a design doc. |
| **spec** | Owns `docs/SPEC.md`. Three modes: merge a design doc, direct edit, or initial spec interview. |
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
| **frontend-design** | Production-grade frontend interfaces with distinctive, non-generic aesthetics |
| **agent-browser** | Browser automation via CLI |

### Commands

Slash commands are saved prompt templates — shortcuts that trigger the corresponding skill.

`/brainstorm` `/spec` `/plan` `/execute` `/sync-docs` `/sync-agents` `/gather-context` `/code-review` `/analyze-issue` `/writing-skills`

Not every skill has a command. **debugging**, **testing**, **find-skills**, **frontend-design**, and **agent-browser** are triggered by the task itself — you don't announce that you're debugging, you just describe the bug.

### Agents

One subagent — **code-reviewer** — that can be dispatched for parallel code review. Merged security analysis into it since it's the same skillset.

### Rules

Domain-specific rules loaded via `@rules/` in AGENTS.md:
- **code-quality** — testing philosophy, review standards, error handling, logging
- **obsidian** — vault conventions for note-taking

### AGENTS.md

The foundational config — developer info, planning workflow, git conventions (conventional commits, no AI attribution, pre-commit gate), code style, and general rules. Shared across both tools.

### RTK.md

Usage notes for [rtk](https://github.com/reachingforthejack/rtk), a token-optimizing CLI proxy that filters command output. Machine-specific and entirely optional — if you don't have `rtk` installed, nothing here applies and the rest of the config works unchanged.

## Setup

Clone anywhere — the installer resolves paths from its own location.

```bash
git clone git@github.com:justincordova/agents.git ~/agent
~/agent/install.sh
```

This symlinks `AGENTS.md`, `agents/`, `commands/`, `rules/`, and each skill into both `~/.claude` and `~/.opencode`. Skills are linked one directory at a time so standalone skills can live alongside these. The script is idempotent — re-run it after pulling to pick up new skills.

## Validation

```bash
./scripts/validate.sh
```

This repo is markdown held together by convention, and the tools silently ignore anything they can't parse — a typo'd skill name just means the skill never loads. `validate.sh` checks the contracts: skill `name:` matches its directory, every command points at a skill that exists, frontmatter is present, and the README describes what's actually on disk. It runs in CI on every push and PR.

## Why

Most AI coding configs are an AGENTS.md with some rules and a prayer. This is a workflow — brainstorm before building, execute in batches, review at every checkpoint, and never let the agent run unsupervised.
