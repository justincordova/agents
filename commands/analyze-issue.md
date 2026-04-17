---
description: Fetch a GitHub issue and create an implementation specification
---

Load the analyze-issue skill, then analyze the issue: $ARGUMENTS

Follow the analyze-issue skill process:
1. Extract issue number and repo (detect from git remote if not specified)
2. Fetch issue details with `gh issue view`
3. Read all comments and understand full context
4. Analyze requirements, scope, constraints, edge cases
5. Write implementation spec to `docs/issues/<number>-<slug>.md`
6. Ask what's next: write a plan, start building, or discuss
