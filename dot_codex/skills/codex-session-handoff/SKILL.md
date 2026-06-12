---
name: codex-session-handoff
description: Use when the user asks to create a repo/session handoff, archive-prep note, continuation document, reactivation prompt, or fresh-chat restart context for Codex work.
---

# Codex Session Handoff

## Overview

Create a concise but complete handoff document that lets a fresh Codex chat continue a repo/session without relying on old chat history.

Use this skill when the user mentions archiving Codex history, handing off work, preserving session state, creating a continuation prompt, or saving a "what happened / what next" document.

## Gather Evidence

Use the current chat plus the repo itself. Do not invent details.

1. Identify the working location.
   - Prefer `git rev-parse --show-toplevel` for the repo root.
   - Record `pwd` if there is no Git repo.
   - Record branch with `git branch --show-current` and current commit with `git rev-parse --short HEAD` when available.

2. Inspect current state.
   - Run `git status --short`.
   - Use `git diff --name-only` and `git diff --stat` to identify touched files when appropriate.
   - Check recently mentioned files, plans, docs, tests, or issue notes from the current session.
   - Read `AGENTS.md` and nearby project instructions if they are relevant and not already loaded.

3. Capture actual work.
   - List files touched separately from files only investigated.
   - Include commands/tests already run from the chat or terminal output.
   - Include known errors, warnings, skipped checks, failing checks, and blockers.
   - If a detail is not known, write `Unknown` or `Not captured`, not a guess.

## Save Location

Save the handoff repo-locally unless the user says otherwise, with one special case for projectless Codex chats.

Selection order:

1. If the active work is a Codex chat workspace under `/Users/mrbubbles/Documents/Codex`, save to `/Users/mrbubbles/Documents/Codex/codex-handoffs/`.
   - This applies to generated chat/session folders such as `/Users/mrbubbles/Documents/Codex/YYYY-MM-DD/...`.
   - Do not create the handoff inside the individual chat folder.
   - If the chat is only being used to work on a real repo outside `/Users/mrbubbles/Documents/Codex`, save in that repo instead.
2. Existing repo-local handoff/archive convention, for example `docs/codex-handoffs/`, `documentation/codex-handoffs/`, `.codex/handoffs/`, or `docs/handoffs/`.
3. Otherwise create `docs/codex-handoffs/` in the repo root.

Filename:

```text
YYYY-MM-DD-topic.md
```

Use the current date and a short lowercase kebab-case topic based on the active goal, such as `2026-05-25-markdown-hardening.md`.

## Handoff Template

Use this structure unless the repo already has a better handoff template:

````markdown
# Codex Handoff: <topic>

Date: <YYYY-MM-DD>
Repo: <absolute repo path>
Branch: <branch or Unknown>
Commit: <short SHA or Unknown>
Working tree: <clean / dirty summary>

## Current Goal

<One or two sentences describing the active objective and stopping condition.>

## Completed

- <Concrete completed item.>

## Files Touched Or Investigated

Touched:

- `<path>` - <what changed and why>

Investigated:

- `<path>` - <what was learned>

## Commands And Checks Run

- `<command>` - <result>

## Known Errors, Warnings, Or Failing Checks

- <Error/check/blocker, with command or source if known.>

## Open Decisions

- <Decision still needed, owner if obvious, and impact.>

## Constraints, Preferences, And Do-Not-Touch Areas

- <Repo instructions, user preferences, active write scopes, files/areas to avoid.>

## Next Steps

1. <Concrete next step.>
2. <Concrete next step.>
3. <Concrete next step.>

## Reactivation Prompt

```text
Continue this work from the handoff document:
<absolute path to this handoff>

Work in repo:
<absolute repo path>

Start by reading the handoff and any repo instructions such as AGENTS.md. Verify the current branch and working tree with git status before editing. Do not rely on old chat context; treat the handoff and repository as the source of truth.

Current goal:
<same goal summary>

Important constraints:
<short bullet-style constraints inline or "See handoff">

Begin with the next steps listed in the handoff, and report any mismatch between the handoff and the current repo state before changing files.
```
````

## Quality Rules

- Keep it practical and scannable; the handoff is for continuation, not a diary.
- Prefer absolute repo path in the header and relative file paths inside repo sections.
- Include 3-7 next steps. Fewer than 3 usually means the work is done or poorly understood.
- Include only commands that actually ran or were explicitly planned but not run.
- Mark stale or uncertain information clearly.
- Mention dirty worktree state so the next chat does not overwrite user changes.
- Do not include secrets, tokens, credentials, private keys, or sensitive personal data.
- If the task is non-repo work, adapt the path and save location to the current workspace.
