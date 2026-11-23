---
name: frontend
description: Use when building new UI or reshaping an existing interface's visual design — pages, components, apps, on web, mobile, or desktop. Entry point for frontend work. Sets aesthetic direction, typography, color, layout, and copy so the result doesn't read as a templated default, and routes to impeccable and Emil Kowalski's skills for critique, polish, and motion.
---

Build frontend interfaces that look intentionally designed, not generated. Approach each brief as the design lead at a studio known for giving every client a distinct visual identity: make deliberate, opinionated choices about palette, typography, and layout that are specific to this brief, and take aesthetic risk when it's justified.

Works across any UI framework: web (React, Vue, Svelte, plain HTML/CSS), mobile (SwiftUI, Jetpack Compose, Flutter, React Native), desktop (Electron, Tauri), or anything else. Adapt the guidance below to the platform.

Core design guidance adapted from [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/frontend-design) (Apache 2.0).

## Modes

This skill has two modes. Detect which to use based on the user's input:

**Autopilot** — the user describes what to build without specifying aesthetic direction. Pick the best-fitting design yourself, explain your choices briefly, and build it. The user can always ask for revisions.

**Collaborative** — the user wants to explore options before building. They might say "I want to see some options" or "what directions could this go?" Present 2-3 design directions, recommend one, get their pick, then build.

Default to autopilot. Only enter collaborative mode when the user signals they want input on the design direction.

## Companion Skills

This skill is the entry point for frontend work and owns building new UI. When a task, or a step within it, narrows to one of the specialties below, read that skill's `SKILL.md` (a sibling directory, e.g. `../animate/SKILL.md`) and follow it for that part. Load only what the task needs — not every companion on every build.

| Situation | Skill |
|---|---|
| Critique or score an existing design; technical audit (a11y, performance, responsive); final polish pass | `impeccable` — `critique`, `audit`, `polish` |
| Steer an existing design: bolder, quieter, distill, colorize, typeset, layout, delight | `impeccable` — the matching command |
| Production hardening (errors, i18n, overflow), first-run flows and empty states, UX copy | `impeccable` — `harden`, `onboard`, `clarify` |
| Capture product context or the visual system (`PRODUCT.md`, `DESIGN.md`) | `impeccable` — `init`, `document` |
| The task needs a component dependency (toast, dialog, drawer, command menu, drag and drop, charts) | `pick-ui-library` |
| One web animation or transition | `animate` |
| Several elements animating together (stagger, hero entrance, view swap) | `choreograph` |
| Drag, swipe, sheets, snap points | `gestures` |
| Interaction polish: press/hover states, popover origin, tooltip timing | `emil-design-eng` |
| Spring physics, Apple-style motion and materials | `apple-design` |
| A web app that must feel native on phones | `mobile-native` |
| Stress-test a component with worst-case data | `break-ui` |
| Animations that drop frames | `animation-performance` |
| Review motion in a diff | `review-animations` |
| App-wide motion: audit it, find missing motion, or remove excess | `improve-animations`, `find-animation-opportunities`, `remove-animations` |
| The user wants several live variants to flip between | `prototype` |

When guidance conflicts: the user's brief and the project's existing conventions win, then this skill for overall direction. For motion specifics (easing, duration, properties), Emil's skills override the general Motion notes below. Companion steps that ask for screenshots or rendered checks follow the browser verification rules in AGENTS.md.

## Checklist

Create a task for each item and complete them in order:

### 1. Scan existing conventions

Before proposing anything, check what's already in the project:

- **Platform and framework**: What UI framework, language, and runtime? Check package manifests, build files, or project structure.
- **Styling approach**: What styling system is in use? (Tailwind, CSS modules, styled-components, SwiftUI modifiers, Compose modifiers, etc.) Match whatever exists.
- **Existing design tokens**: Look for theme files, color/spacing scales, design system constants, `DESIGN.md`. Use them.
- **Component patterns**: How are existing UI elements structured? Follow the same conventions.
- **Existing typefaces**: Already loading fonts or using specific system fonts? Use them before introducing new ones.

If the project has established patterns, follow them. Only introduce new patterns when there's nothing to build on.

### 2. Ground the design in the subject

Distinctive choices come from the subject's world — its industry, materials, and vernacular. A toy for 8–11-year-olds and a dashboard for financial analysts should look nothing alike.

If the brief doesn't say what the product is, who it's for, and what this screen's primary job is, infer one concrete answer from the codebase and context. In autopilot, state that assumption when you explain your choices; in collaborative mode, confirm it. Build with the brief's real content throughout.

### 3. Gather context (collaborative mode only)

Ask the user questions one at a time to understand the interface. Prioritize multiple choice when possible.

Good questions:
- Who uses this and what are they trying to accomplish?
- Any brand guidelines, existing color palette, or reference designs to match?
- What platforms/viewport sizes matter most?
- Any hard constraints on dependencies, bundle size, or performance?
- What existing components or pages should this feel consistent with?

Skip questions where the answer is already clear from context or the existing codebase.

### 4. Plan the design

Draft a compact token plan before writing code:

- **Color**: the core palette as 4–6 named hex values (or the existing tokens you'll use).
- **Type**: the typefaces and their roles.
- **Layout**: a one-sentence concept plus a rough ASCII wireframe, including alignment (left, centered, justified).
- **Principles**: the two or three ideas that make this surface specific to its brief.

In an established design system, the plan is mostly which existing tokens and components you'll use, plus the one or two places this surface gets its character.

**Collaborative mode:** present 2-3 distinct directions, each as a named plan with what it does well and what it trades off. Always recommend one and explain why it fits this context. Wait for the user's pick before continuing.

> **Direction A: Clean Technical** (recommended)
> Crisp spacing, monospace accents, neutral palette with one bold accent color. Feels precise and professional. Good for developer tools, dashboards. Trades warmth for clarity.
>
> **Direction B: Warm Editorial**
> Serif headings, generous line height, one orchestrated entrance. Feels human and readable. Good for content-heavy pages. Trades information density for comfort.

### 5. Review the plan against the brief

Before building, check the plan against what generated design currently clusters around:

1. A warm cream background (near `#F4F1EA`) with a high-contrast serif display and a terracotta or clay accent (near `#D97757`).
2. A near-black background with a single acid-green or vermilion accent.
3. A broadsheet layout: hairline rules, zero border-radius, dense newspaper columns.
4. The SaaS-card kit: content chopped into identical rounded cards, one radius on everything, the same soft grey shadow under each, gradient washes as decoration.
5. Template chrome on any subject: a tracked-out ALL-CAPS eyebrow above every heading, meta strings joined with `·`, `WORD — fragment` labels, tinted near-black (`#0B0B0B`, `#111`) standing in for black, monospace for small data labels, `→` appended to every link and button.

Each is legitimate for some briefs, but they are defaults, not choices. Where the brief or the existing design system pins down a direction, follow it exactly — including when it asks for one of these looks. Where an axis is free, don't spend that freedom on a default. If part of the plan is what you'd produce for any similar page, revise it and say what you changed and why.

### 6. Implement

Write production-grade, working code from the plan. Not wireframes, not placeholders.

**Hierarchy and composition:**
- Open with the most characteristic thing in the subject's world, in the form that suits it: a headline, an image, a live demo, an interactive moment. A big number with a small label, supporting stats, and a gradient accent is the default hero — use it only if it's truly the best option.
- Spend your boldness in one place. Let one element be the memorable thing; keep everything around it quiet and disciplined, and cut decoration that doesn't serve the brief. Before finishing, remove one accessory.
- Visual structure is information. Outlines, borders, numbering, eyebrows, and dividers should encode something about the content. Use numbered markers (01 / 02 / 03) only when the content is actually a sequence.

**Typography:**
- Typography carries the personality. One family is fine; if you use two, make them clearly distinct.
- Choose typefaces deliberately, not the families you'd reach for on any project. Set a clear type scale with intentional weights, widths, and spacing. When type is the headline or visual element, make the treatment itself part of the design.
- Keep line lengths under ~80 characters. Serif body text can run slightly longer and wants slightly more line-height than sans.
- Avoid the commonest generated tells: accenting one word in a headline with italic, bold, or color; all-caps labels; unnecessary labels above content.
- On platforms with limited font options (native mobile), create hierarchy with weight, size, and spacing.

**Color:**
- Use the project's theming system (CSS variables, design tokens, color resources) — don't hardcode.
- A palette needs a dominant color, an accent, and clear foreground/background contrast. Avoid evenly distributed "rainbow" palettes.

**Motion:**
- Ambient motion is for drawing attention, so use it sparingly: one orchestrated moment (a page-load sequence or one reveal) beats scattered effects. Fade-and-slide-up on every section and hover transitions on every card read as generated.
- Motion that answers a person's action (opening, expanding, confirming) is welcome when it shows what changed.
- Use the platform's native animation primitives first. Respect reduced-motion settings. For anything beyond simple transitions, use the motion companion skills.

**Layout:**
- Use the platform's layout system (CSS Grid/Flexbox, SwiftUI stacks/grids, Compose Row/Column, Flutter Flex). Responsive by default.
- On the web, keep selector specificity flat and predictable — section-level and element-level classes easily cancel each other out, especially on padding and margin between sections.

**Depth and texture (when it fits the direction):**
- Shadows, gradients, grain, blur, patterns — use when they serve the design. Flat and solid is fine when the direction calls for it.

**Copy:**
- Words are design content. Ask what the screen needs to say before writing anything, and give each element one job.
- Write from the user's perspective in plain language: users manage *notifications*, not *webhook config*. Describe what something does rather than selling it.
- Use active voice, sentence case, no filler. A CTA says exactly what happens ("Save changes," not "Submit"), and an action keeps its name through the flow: "Publish" produces "Published."
- Errors say what went wrong and how to fix it — no apologies, never vague. An empty state is an invitation to act.

### 7. Verify

After implementing, check from source and build output:
- **No runtime errors**: builds/runs without errors
- **Responsive**: layout code handles the smallest and largest target viewport sizes (if real-browser evidence is needed, propose agent-browser per AGENTS.md)
- **Accessible**: sufficient contrast, semantic markup, alt text, visible keyboard focus, reduced motion respected
- **Faithful to the plan**: reread the code against the plan and the step 5 list; fix anything that drifted back to a default
- **No dead code**: remove unused imports, placeholder text, commented-out styles
- **Consistent with project conventions**: matches the patterns found in step 1

### 8. Present

Show the user what you built. If it's a single file, share it directly. If it's multiple files, summarize what goes where and highlight the key design decisions, including any subject assumption from step 2.

## Anti-Patterns

| Don't | Why |
|-------|-----|
| Install new styling/animation libraries without checking what's there | Conflicting approaches in one codebase |
| Hardcode colors or spacing | Can't maintain, doesn't scale |
| Reach for the same typefaces you'd use on any project | Type carries the personality; defaults read as generated |
| Spend a free axis on a step 5 default | Most common generated looks |
| Add animation to everything | Distracting, hurts performance |
| Copy the same aesthetic across unrelated projects | Each design should respond to its context |
| Use placeholder text when real content is available or easy to write | Makes design feedback harder |

## Key Principles

- **Context-first.** Read the existing codebase before making choices. Fit the project, don't fight it.
- **Subject-driven.** Distinctive choices come from the subject's world, not from a house style.
- **Opinionated by default.** In autopilot, commit to a direction and explain it; offer options only in collaborative mode.
- **Restraint.** One memorable element, everything else disciplined.
- **Platform-aware.** Adapt the approach to the framework and platform, don't force web patterns onto native UI or vice versa.
- **Show, don't describe.** Working code beats design descriptions. Build it, let the user react.
