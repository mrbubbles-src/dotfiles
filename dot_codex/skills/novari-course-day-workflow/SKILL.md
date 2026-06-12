---
name: novari-course-day-workflow
description: Generate, review, or revise Novari assignment module days in /Users/mrbubbles/dev/novari/assignments. Use when working on course-day folders, Module_XX assignments, Agent A/B/C/D course generation passes, curriculum spreadsheet alignment, German README task text, starter files, Musterlösungen, assets, or browser-tested training exercises.
---

# Novari Course Day Workflow

Use this skill for `/Users/mrbubbles/dev/novari/assignments` course-building work.

## Required Sources

Read these before changing or judging a day:

1. `AGENTS.md`
2. `__COURSE_GENERATION_SPEC.md`
3. `_REF-DO-NOT-DELETE_` for the curriculum
4. `_WRITING-STYLE-REF-DO-NOT-DELETE_` for tone
5. `_EXAMPLE-TASKS-DO-NOT-DELETE_` for quality bar
6. The exact target day folder and nearby previous days

The curriculum is the ground truth. Column D says what is taught on that exact day; column E says the learning goals. Do not introduce concepts, tooling, files, or structure that belong to later days.

## Workflow

Use the Agent A/B/C/D process when generating or revising full days:

- Agent A: generate 8-10 varied task ideas for the exact day.
- Agent B: choose the best 3 main ideas plus 1 bonus and explain why they fit the curriculum and sequence.
- Agent C1/C2: independently build or revise task folders, starter files, assets, and Musterlösungen.
- Agent D: review curriculum fit, difficulty curve, starter thinness, responsiveness, writing quality, and technical correctness.

When subagents are unavailable, simulate the same passes sequentially and label the output by pass.

## Quality Rules

- Write normal German text with ä, ö, ü.
- Tasks are complete exercises, not steps.
- Each day needs 2-3 full tasks and 1 bonus.
- The course must feel connected across days; reuse earlier concepts when useful.
- Vary problem type, context, result format, and thinking mode.
- Avoid filler, repeated card grids, placeholder replacement, and nearly finished starters.
- Make README files clear about goal, expected outcome, and constraints.
- Keep starter files intentionally thinner than the Musterlösung.
- Musterlösungen must feel like real small websites or interfaces, not CSS demos.
- Musterlösungen must be mobile-first and work down to small mobile widths.
- Use generated or real visual assets when they materially help the task; do not use lazy decorative SVG placeholders as a substitute for helpful assets.

## File Checklist

Each task normally includes:

- `README.md`
- starter files
- `assets/` when useful
- `musterloesung/` with a complete working solution

Use ASCII in file and folder names when there is a technical reason, but use proper German umlauts in normal prose.

## Browser Validation

Use the in-app Browser plugin when the user or local rules ask for Browser/browser-use validation. Verify more than "page loads":

- task is understandable and solvable
- Musterlösung functions
- mobile layout is readable and stable
- hierarchy remains clear on small widths
- no horizontal overflow or broken interactions

If a layout breaks, fix it before calling the day done.
