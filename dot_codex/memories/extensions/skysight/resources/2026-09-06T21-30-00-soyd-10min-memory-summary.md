---
title: Bubbles Training Package Setup
description: You finalized the bubbles-training repo guidance, committed and pushed it, then created a cleaned copy for another learner. You also created a solutions branch and archived the copied training folder as jacky-training.zip.
applications: [com.apple.finder, com.google.Chrome, com.microsoft.VSCode]
suggestion:
  type: skill
  name: Training repo packaging
  description: Turn my process for preparing a coding-training repo, learner prompt, clean folder copy, and zip archive into a reusable workflow.
---

## Memory summary

The user continued setting up `/Users/mrbubbles/dev/private/playground/bubbles-training` as a structured coding-training repository. In Chrome, they refined the repo guidance and learner prompt with ChatGPT, then moved into VS Code to update `AGENTS.md`, `HANDOFF.md`, and `new-chat-prompt.md`. They committed the guidance changes on `main`, pushed them so `origin/main` matched local `main`, created a `solutions-round-one` branch at the same commit, then used Finder to duplicate the repo, remove heavy/version-control material from the copy, rename it to `jacky-training`, and compress it to `jacky-training.zip`.

### Relevant prior context

The immediately preceding summary shows the user had just created `AGENTS.md` and `HANDOFF.md` in the `bubbles-training` repo after using ChatGPT to refine training guidance. Before this window, those files were still untracked, and the repo setup work was connected to older MERN-style practice material under `docs/codex-handoffs/2026-05-02-mern-cardio-training.md`.

### Important non-obvious context about the user

`/Users/mrbubbles/dev/private/playground/bubbles-training`: active local training repo for JavaScript/TypeScript/MERN fundamentals practice.

`AGENTS.md`: repository guidance file added during this setup; exact prompt-like contents are omitted, but it covers the training workflow and agent behavior around exercises/reviews.

`HANDOFF.md`: short root-level handoff file added for the training workflow.

`new-chat-prompt.md`: learner/new-chat prompt file updated in the final commit.

`solutions-round-one`: branch created in VS Code and pointing at the same commit as `main`.

`562e022`: final observed commit, `docs: update training prompt for clarity and structure`, on both `main` and `solutions-round-one`.

`jacky-training`: Finder-created copy of the training repo, with `.git` and `node_modules` absent in the observed final folder.

`/Users/mrbubbles/dev/private/playground/jacky-training.zip`: compressed archive created from the cleaned `jacky-training` copy.

## Recording summary

### ChatGPT Guidance Refinement

The window began in Chrome on a ChatGPT conversation titled `Novari Education - Testfläche neu verdrahten`, but the actual activity continued the `bubbles-training` setup thread. The user pasted or discussed draft repository guidance and asked about adjusting the prompt so that new exercise tasks would be prepared on `main`, with a separate branch created afterward for working on the new tasks. Exact observed prompt/rules text is omitted because it was agent-directed workflow content.

### VS Code Repo Work

The user switched to VS Code with the `bubbles-training` workspace open. They selected `HANDOFF.md`, opened source control, interacted with branch/delete-branch UI briefly, then saved. They copied content from Chrome, opened `AGENTS.md`, selected all, pasted, and saved; VS Code marked `AGENTS.md` as untracked at that moment.

They then opened `new-chat-prompt.md`, pasted copied prompt content, edited around a numbered item, returned to Chrome to clarify the branch workflow wording, copied the generated text, pasted it into `new-chat-prompt.md`, made a small edit, and saved.

The user attempted to delete or close `new-chat-prompt.md` from the editor view, then moved to Source Control. They staged changes, entered the commit message `innitial commit`, then used VS Code commit controls. The UI showed a generated commit option and then a push action for 3 commits to `origin/main`.

A read-only check after the recording showed the repo clean at:

`main...origin/main`

Recent commits were:

`562e022 docs: update training prompt for clarity and structure`

`46b68e0 innitial commit`

`97be0c9 chore: remove outdated codex handoff documentation for MERN training`

`4e172a0 initial commit`

The commit history showed `46b68e0` added `AGENTS.md` and `HANDOFF.md`, `97be0c9` deleted `docs/codex-handoffs/2026-05-02-mern-cardio-training.md`, and `562e022` modified `new-chat-prompt.md`.

### Branch And Package Creation

After committing/pushing, the user used VS Code’s branch checkout UI to create `solutions-round-one`. A read-only branch check showed `main` and `solutions-round-one` both pointing to `562e022`, with `main` tracking `origin/main`.

The user then revealed the repo in Finder at `/Users/mrbubbles/dev/private/playground/bubbles-training`, duplicated the folder, opened the copy, and removed large/version-control material. The final observed copied folder was renamed `jacky-training`. A read-only listing showed it contains the training source files, `AGENTS.md`, `HANDOFF.md`, `new-chat-prompt.md`, `.cursor`, `.vscode`, `src`, and `tests`, while `.git` and `node_modules` were absent.

The user compressed `jacky-training` in Finder. A read-only archive listing confirmed `/Users/mrbubbles/dev/private/playground/jacky-training.zip` exists and contains the cleaned training folder files.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T21-30-00Z/events.jsonl
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T21-20-00-uvrG-10min-memory-summary.md
- /Users/mrbubbles/dev/private/playground/bubbles-training
- /Users/mrbubbles/dev/private/playground/bubbles-training/AGENTS.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/HANDOFF.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/new-chat-prompt.md
- /Users/mrbubbles/dev/private/playground/jacky-training
- /Users/mrbubbles/dev/private/playground/jacky-training.zip