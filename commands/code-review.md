---
description: Run a thorough code review with security analysis
---

Load the code-review skill, then perform a systematic review of $ARGUMENTS.

Follow the code-review skill methodology:
1. Read all relevant files completely — do not skim
2. Mentally simulate execution under adverse conditions (empty/null input, concurrent requests, failing dependencies)
3. Trace all external input data flows for security issues
4. Check: correctness, error handling, security, concurrency, resource management, data correctness, design

Output a report with:
- **Critical** — broken behavior, data loss, security vulnerability
- **Important** — incorrect logic, unhandled errors, performance
- **Suggestion** — improvements, naming, style

For each finding: file and line number, what the code does vs what it should do, concrete fix.

No edits — report only.
