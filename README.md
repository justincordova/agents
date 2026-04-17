# agents

A structured AI coding workflow — skills, agents, and commands that make AI think before it builds.

Give an agent a prompt and hope for the best, or make it understand the problem before writing code, propose approaches before committing to one, and execute in reviewable chunks. This is the second one.

Shared between [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and [OpenCode](https://opencode.ai) — one config, symlinked into both tools.

## The workflow

Every task goes through brainstorming first. Then the path splits:

```
New projects / major features:
  brainstorm → spec → plan → execute (subagents for parallel work)

Bugfixes, small features, maintenance:
  brainstorm → plan → execute

Issue-driven work:
  /analyze-issue → plan → execute
```

**Brainstorm** is the non-negotiable step. The agent explores the problem, asks clarifying questions one at a time, proposes 2-3 approaches with trade-offs, and presents a design for approval. No code gets written until the user approves.

**Execute** happens in batches of 3 tasks with a review checkpoint between each batch. The agent stops and reports. You give feedback. It continues. No 50-step fire-and-forget.

**Code review** uses a dedicated subagent that reads every file completely, mentally simulates execution under adverse conditions, traces data flow for security issues, and reports findings ranked by severity. No edits — report only.

## What's in here

### Skills

Skills define *how the agent behaves* — behavioral context loaded when a task matches.

| Skill | What it does |
|---|---|
| **brainstorm** | Collaborative design through questions, approaches, and approval gates |
| **spec** | Comprehensive project specs before any planning |
| **plan** | Step-by-step implementation plans from specs |
| **execute** | Batch execution with review checkpoints |
| **analyze-issue** | Fetch GitHub issues, break down requirements, produce an impl spec |
| **code-review** | Systematic review — correctness, security, concurrency, design |
| **debugging** | Structured debugging — reproduce, isolate, fix, verify |
| **testing** | Test strategy and implementation following project conventions |
| **writing-skills** | Create and edit skills for both tools |
| **find-skills** | Discover and install community skills |
| **agent-browser** | Browser automation via CLI |

### Commands

Slash commands are saved prompt templates — shortcuts that trigger the corresponding skill.

`/brainstorm` `/spec` `/plan` `/execute` `/review` `/analyze-issue` `/writing-skills`

### Agents

One subagent — **code-reviewer** — that can be dispatched for parallel code review. Merged security analysis into it since it's the same skillset.

### Rules

Domain-specific rules loaded via `@rules/` in CLAUDE.md:
- **code-quality** — testing philosophy, review standards, error handling, logging
- **obsidian** — vault conventions for note-taking

### CLAUDE.md

The foundational config — developer info, planning workflow, git conventions (conventional commits, no AI attribution, pre-commit gate), code style, and general rules. Shared across both tools.

## Setup

```bash
git clone git@github.com:justincordova/agents.git ~/agent

# Claude Code
ln -s ~/agent/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/agent/RTK.md ~/.claude/RTK.md
ln -s ~/agent/skills ~/.claude/skills
ln -s ~/agent/agents ~/.claude/agents
ln -s ~/agent/commands ~/.claude/commands
ln -s ~/agent/rules ~/.claude/rules

# OpenCode
ln -s ~/agent/skills ~/.opencode/skills
ln -s ~/agent/agents ~/.opencode/agents
ln -s ~/agent/commands ~/.opencode/commands
```

## Why

Most AI coding configs are a CLAUDE.md with some rules and a prayer. This is a workflow — brainstorm before building, execute in batches, review at every checkpoint, and never let the agent run unsupervised.
