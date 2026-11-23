---
name: obsidian
description: Use when creating, editing, or organizing notes in the Obsidian vault — daily notes, meeting notes, project notes, or links between them. Covers naming, structure, linking, and when a note is worth writing at all.
---

# Obsidian Notes

## Vault Location

The vault is `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/obi/` (iCloud, macOS only). Don't create notes outside it unless explicitly asked. On other machines there is no vault — say so instead of creating one.

It's organized PARA-style — put each note in the matching folder:

- `projects/<project>/` — active projects with a goal and an end
- `areas/` — ongoing responsibilities
- `resources/` — reference material and things learned
- `archive/` — finished or inactive notes
- `daily/` — daily notes; `meetings/` — meeting notes
- `templates/` — note templates; use the matching one when it exists

## Naming Conventions

- Match the existing names in the folder you're writing to. Current convention is readable titles with spaces: `API Rate Limiting Design.md`
- Be descriptive: `API Rate Limiting Design.md`, not `notes.md`
- Date-prefix daily notes: `2026-04-17.md`
- Date-prefix meeting notes: `2026-04-17 Design Review.md`

## Structure

- One idea per note. If a note covers two things, split it.
- Lead with context: what is this, why does it exist.
- Use headings for scanning. Keep paragraphs short.

## Linking

- Link liberally: `[[note-name]]` for any concept or project mentioned.
- Don't orphan notes. Every note should link to or be linked from something.
- Use MOCs (Maps of Content) for broad topics that tie many notes together.

## Project Notes

- Create a project note for any project that spans more than one session.
- Include: goal, key decisions, architecture overview, links to related notes.
- Update the project note as the project evolves — it's the living summary.

## Meeting Notes

- Capture decisions and action items, not transcripts.
- Format action items as checkboxes: `- [ ] Action item here`
- Link to project notes and people notes.

## When to Create Notes

- After a design decision is made
- When learning something non-obvious
- When a debugging session reveals something worth remembering
- When a project's scope or direction changes
- When context is getting large and needs to be offloaded

## When NOT to Create Notes

- For trivial information easily googled
- For things already well-documented elsewhere
- During active implementation (notes are for after, not during)
