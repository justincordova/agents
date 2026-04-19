---
description: Sync documentation with recent codebase changes
---

Load the update-docs skill, then sync documentation: $ARGUMENTS

Follow the update-docs skill process:
1. Scan recent changes via git diff and recent commits
2. Identify which docs are affected (SPEC.md, TESTING.md, CLAUDE.md, README.md, etc.)
3. Make targeted updates — only change what shifted, don't rewrite untouched sections
4. Present changes with what and why — wait for approval before saving
5. Save approved changes — do NOT commit unless asked
