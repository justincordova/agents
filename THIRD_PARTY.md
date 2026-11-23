# Third-party skills

These skills are vendored from upstream so they sync across machines with the rest of this repo. Don't edit them in place — `scripts/update-vendored-skills.sh` overwrites them. Put customizations in our own skills (routing lives in `skills/frontend-design`).

| Source | Commit | License | Skills |
|---|---|---|---|
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | `64eb3de` | MIT — [licenses/emilkowalski-skills.LICENSE](licenses/emilkowalski-skills.LICENSE) | animate, animation-performance, animation-vocabulary, apple-design, ask-emil, break-ui, choreograph, emil-design-eng, find-animation-opportunities, gestures, improve-animations, learn-taste, mobile-native, pick-ui-library, prototype, remove-animations, review-animations |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | `b49177d` | Apache 2.0 — [licenses/impeccable.LICENSE](licenses/impeccable.LICENSE), [NOTICE](licenses/impeccable.NOTICE.md) | impeccable (the `.opencode` build; engine binary downloads to `~/.impeccable` on first run) |

Not vendored from emilkowalski/skills: `write-swift`, `animate-expo`, `ask-sonner`. Add one to `EMIL_SKILLS` in the update script to include it.

To update:

```bash
./scripts/update-vendored-skills.sh
git diff --stat
```

Then update the commit hashes above.
