---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics.
---

Build frontend interfaces that look intentionally designed, not generated. Every implementation should feel like a designer made deliberate choices — not just "not ugly," but cohesive and purposeful.

Works across any UI framework: web (React, Vue, Svelte, plain HTML/CSS), mobile (SwiftUI, Jetpack Compose, Flutter, React Native), desktop (Electron, Tauri), or anything else. Adapt the guidance below to the platform.

## Modes

This skill has two modes. Detect which to use based on the user's input:

**Autopilot** — the user describes what to build without specifying aesthetic direction. Pick the best-fitting design yourself, explain your choices briefly, and build it. The user can always ask for revisions.

**Collaborative** — the user wants to explore options before building. They might say "I want to see some options" or "what directions could this go?" Present 2-3 design directions, recommend one, get their pick, then build.

Default to autopilot. Only enter collaborative mode when the user signals they want input on the design direction.

## Checklist

Create a task for each item and complete them in order:

### 1. Scan existing conventions

Before proposing anything, check what's already in the project:

- **Platform and framework**: What UI framework, language, and runtime? Check package manifests, build files, or project structure.
- **Styling approach**: What styling system is in use? (Tailwind, CSS modules, styled-components, SwiftUI modifiers, Compose modifiers, etc.) Match whatever exists.
- **Existing design tokens**: Look for theme files, color/spacing scales, design system constants. Use them.
- **Component patterns**: How are existing UI elements structured? Follow the same conventions.
- **Existing typefaces**: Already loading fonts or using specific system fonts? Use them before introducing new ones.

If the project has established patterns, follow them. Only introduce new patterns when there's nothing to build on.

### 2. Gather context (collaborative mode only)

Ask the user questions one at a time to understand the interface. Prioritize multiple choice when possible.

Good questions:
- Who uses this and what are they trying to accomplish?
- Any brand guidelines, existing color palette, or reference designs to match?
- What platforms/viewport sizes matter most?
- Any hard constraints on dependencies, bundle size, or performance?
- What existing components or pages should this feel consistent with?

Skip questions where the answer is already clear from context or the existing codebase.

### 3. Propose design directions (collaborative mode only)

Present 2-3 distinct aesthetic directions with trade-offs. Each should have:
- A name (so the user can reference it easily)
- A short description of the look and feel
- Key design choices (typography, color palette, layout approach, motion)
- What it does well and what it trades off

Always recommend one direction and explain why it fits this particular context better.

**Example:**

> **Direction A: Clean Technical** (recommended)
> Crisp spacing, monospace accents, neutral palette with one bold accent color. Feels precise and professional. Good for developer tools, dashboards. Trades warmth for clarity.
>
> **Direction B: Warm Editorial**
> Serif headings, cream background, generous line height, subtle entrance animations. Feels human and readable. Good for content-heavy pages. Trades information density for comfort.
>
> **Direction C: Bold Maximal**
> High contrast, oversized typography, saturated color blocks, animated transitions. Feels energetic and memorable. Good for landing pages and marketing. Trades subtlety for impact.

Wait for the user to pick a direction before continuing to implementation.

### 4. Implement

Once the user approves a direction, write production-grade, working code. Not wireframes, not placeholders.

Adapt the following to the platform and framework in use:

**Typography:**
- Choose typefaces with character. Pair a display font with a body font. Two max per surface.
- Establish a clear type scale. Headings should look like headings.
- On platforms with limited font options (native mobile), use weight, size, and spacing to create hierarchy.

**Color:**
- Use the project's theming system (CSS variables, design tokens, color resources) — don't hardcode.
- A palette needs a dominant color, an accent, and clear foreground/background contrast.
- 2-3 colors usually enough. Avoid evenly-distributed "rainbow" palettes.

**Motion (when it adds value):**
- Use the platform's native animation primitives first. Only reach for libraries when primitives fall short.
- A few well-timed animations beat many scattered ones.
- Respect platform accessibility settings for reduced motion.

**Layout:**
- Use the platform's layout system (CSS Grid/Flexbox, SwiftUI stacks/grids, Compose Row/Column, Flutter Flex).
- Account for the target viewport sizes. Responsive by default.
- Generous spacing almost always looks better than cramped spacing.

**Depth and texture (when it fits the direction):**
- Shadows, gradients, grain, blur, patterns — use when they serve the design.
- Flat and solid is fine when the direction calls for clean and minimal.

### 5. Verify

After implementing, check:
- **No runtime errors**: builds/runs without errors
- **Responsive**: holds up at the smallest and largest target viewport sizes
- **Accessible**: sufficient contrast, semantic markup, alt text, focus/keyboard navigation
- **No dead code**: remove unused imports, placeholder text, commented-out styles
- **Consistent with project conventions**: matches the patterns found in step 1

### 6. Present

Show the user what you built. If it's a single file, share it directly. If it's multiple files, summarize what goes where and highlight the key design decisions made.

## Anti-Patterns

| Don't | Why |
|-------|-----|
| Install new styling/animation libraries without checking what's there | Conflicting approaches in one codebase |
| Hardcode colors or spacing | Can't maintain, doesn't scale |
| Default to Inter/Roboto/system fonts as primary typeface | Looks like every other AI-generated page |
| Default to purple gradient on white | Most common AI design cliché |
| Add animation to everything | Distracting, hurts performance |
| Copy the same aesthetic across unrelated projects | Each design should respond to its context |
| Use placeholder text when real content is available or easy to write | Makes design feedback harder |

## Key Principles

- **Context-first.** Read the existing codebase before making choices. Fit the project, don't fight it.
- **Propose, don't assume.** Present options. The user picks the direction.
- **Deliberate over safe.** A strong opinion that's wrong is easier to adjust than no opinion at all.
- **Platform-aware.** Adapt the approach to the framework and platform, don't force web patterns onto native UI or vice versa.
- **Details compound.** Typography, spacing, color, motion — none of them save a bad design alone, but neglecting any of them drags down a good one.
- **Show, don't describe.** Working code beats design descriptions. Build it, let the user react.
