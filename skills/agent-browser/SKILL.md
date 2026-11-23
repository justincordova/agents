---
name: agent-browser
description: Use when the user requests browser interaction or visual inspection, or approves it after you propose it for a specific issue that requires real-browser evidence (layout, focus, navigation, client-side runtime behavior). Do not trigger merely because a project is a web app or frontend code changed. Routine development checks, repeatable e2e tests (use Playwright Test), and static web research do not require this skill.
allowed-tools: Bash(npx agent-browser:*), Bash(agent-browser:*)
---

# Browser Automation with agent-browser

Fast native CLI driving Chrome/Chromium via CDP, with accessibility-tree snapshots and compact `@eN` element refs. Install: `brew install agent-browser` (or `npm i -g agent-browser`), then `agent-browser install` to download Chrome.

## When to Use During Development

Browser use must answer a specific question that source inspection, existing tests, or command-line checks cannot adequately answer. Before opening a browser, briefly state that question and the observable pass condition.

Use it for:
- User-requested browser walkthroughs, screenshots, or visual checks.
- Substantial new UI or layout changes whose acceptance depends on rendered appearance; inspect the affected view once after implementation.
- Reproducing or verifying browser-specific bugs: responsive overflow, focus/keyboard behavior, client-side navigation, or runtime failures not covered by existing tests.
- A targeted end-to-end interaction when existing automated coverage cannot establish the relevant outcome.
- Website tasks that require live interaction, such as filling forms or accessing dynamic content unavailable through page fetching.

Do not use it automatically for copy edits, small styling tweaks with clear behavior, refactors, backend/API work, configuration, or every frontend change. Prefer source inspection, build/type/lint checks, and relevant existing tests. Prefer search or page-fetching tools for static web research.

### Scope and Stopping Rule

- Check only the affected flow, view, and relevant viewport(s). Do not tour unrelated pages or test a device matrix without a requirement or concrete concern.
- Prefer text/DOM snapshots or targeted assertions for behavior. A snapshot is a textual element tree, not an image; use screenshots only when pixels, geometry, or visual appearance are the evidence needed, or the user asks for them.
- Do not take screenshots after every action. For a visual check, start with one relevant capture; take more only for a distinct requirement, a discovered problem, or verification after fixing that problem.
- Stop once the stated pass condition is established. Repeat only after a relevant change, failure, or unresolved concern; do not re-check solely for extra confidence or completion evidence.
- Refresh element refs only when needed for subsequent interaction; this is not a requirement to visually re-inspect each state.

## Usage Guide

This skill holds the *when*; the CLI holds the *how*. Before running any other `agent-browser` command, load the workflow guide served by the installed CLI — it always matches the installed version, unlike a copied guide:

```bash
agent-browser skills get core             # the snapshot/ref loop, waits, common tasks, troubleshooting
```

The core guide ends with a table of references for detailed commands and flags. Use `agent-browser skills get core --full` only when you need every reference at once; it is several times larger.

For tasks outside ordinary web pages, load the matching guide:

```bash
agent-browser skills get electron         # Electron desktop apps (VS Code, Slack, Discord, Figma, ...)
agent-browser skills get dogfood          # exploratory testing / QA — only when the user asks for it
agent-browser skills get derive-client    # record a HAR, derive a standalone API client for a site
agent-browser skills list                 # everything available on the installed version
```

The rules above still apply to everything these guides describe: answer the stated question, then stop.
