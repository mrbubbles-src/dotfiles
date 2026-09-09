---
title: Training Starter Packaging
description: You updated the bubbles-training repository rules, committed the documentation change, and then prepared a smaller starter-training copy. You briefly checked a Novari-related ChatGPT browser tab, Mail, and the Codex desktop app before returning to package the starter folder.
applications: [com.apple.finder, com.apple.mail, com.google.Chrome, com.microsoft.VSCode, com.openai.codex]
suggestion:
  type: skill
  name: Training starter packaging
  description: Turn my process for cleaning a training repo copy and packaging it into a starter ZIP into a reusable workflow.
---

## Memory summary

The user continued work in `/Users/mrbubbles/dev/private/playground/bubbles-training`, focusing on the local training repository guidance. They opened `src/exercises.ts`, then worked in `AGENTS.md`, saved changes, and the repository log shows a new commit during this window: `f5c09d3 docs: expand exercise structure and progression guidelines`. After that, the user used Finder to duplicate the training repository into a `starter-training` folder, inspect or clean items inside it, and create `starter-training.zip` in the playground folder.

### Relevant prior context

The immediately preceding 21:40Z summary shows the user had just finished checking the `bubbles-training` setup, including `package.json`, `src/exercises.ts`, `HANDOFF.md`, and `new-chat-prompt.md`. Earlier work in the same thread had created and packaged a cleaned training copy named `jacky-training.zip`, which makes this window’s `starter-training` copy look like a continuation of packaging or preparing training starter artifacts.

### Important non-obvious context about the user

`/Users/mrbubbles/dev/private/playground/bubbles-training`: active local TypeScript/Bun training repository where the user edited and committed guidance.

`AGENTS.md`: the file edited in this window; current local content includes expanded sections for exercise structure/progression, visual exercise briefs, training workflow, handoff, training environment, exercise review, and repository state. The exact agent-facing rules are omitted here because they are instruction-like content.

`f5c09d3`: commit created during the window with subject `docs: expand exercise structure and progression guidelines`; current `main` and `origin/main` point to it.

`/Users/mrbubbles/dev/private/playground/starter-training`: observed Finder folder created by duplicating/renaming a copy of `bubbles-training` near the end of the window.

`/Users/mrbubbles/dev/private/playground/starter-training.zip`: observed Finder archive created from `starter-training` at the end of the window.

`com.openai.codex`: Codex desktop app was briefly visible with a Novari project/chat list and a scheduled task labeled `Novari Main-PRs beobachten`.

## Recording summary

### Bubbles Training Guidance Edit

The recording began in VS Code with `new-chat-prompt.md — bubbles-training` visible. The user selected `src/exercises.ts`, opened it briefly, then closed or cleared the editor and selected `AGENTS.md`.

In `AGENTS.md`, the user navigated around the file and pasted or typed short fragments related to image generation and skills/plugins. They corrected several typos and edits manually, then saved the file. A later repository read shows no remaining uncommitted diff in `AGENTS.md`, and `git log` shows the relevant commit created at local time `2026-09-06 23:57:39 +0200`: `f5c09d3 docs: expand exercise structure and progression guidelines`.

The user opened VS Code Source Control and the Git menu after saving. The menu navigation moved through branch and remote actions, and the branch list included `solutions-round-one` with commit `562e022 docs: update training prompt for clarity and structure`. The current branch after the window is `main`, tracking `origin/main`.

### Brief App Switches

The user switched to a Chrome ChatGPT tab with a Novari Education-related title. The browser showed high memory usage and microphone recording status in the window title; no substantive web content is preserved.

The user briefly switched to Apple Mail, showing the `Novari Manuel` inbox, then returned to Chrome and VS Code. Later they opened the Codex desktop app, where a Novari project/chat context and a scheduled task named `Novari Main-PRs beobachten` were visible. They typed part of an image-related skill name in the Codex input, corrected it, selected text, and returned to VS Code without an observed submitted prompt.

### Starter Folder Creation And Archive

Near 21:59Z, the user switched to Finder. The Finder window showed the `playground` folder with `bubbles-training` and then a duplicate folder named `bubbles-training Kopie`.

The user renamed the duplicate to `starter-training`. Inside `starter-training`, they selected entries including `.git` and `src`, then returned to the parent `playground` view where `starter-training` appeared much smaller than the original `bubbles-training` folder. The exact cleanup result inside the folder is not fully reconstructable from the event stream, but the interaction indicates they inspected or removed items before packaging.

The user opened the Finder context menu for `starter-training` and chose the German compression action. The final observed Finder state showed `bubbles-training`, `starter-training`, and a newly created `starter-training.zip` in `/Users/mrbubbles/dev/private/playground`.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T21-50-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T21-50-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T21-40-00-KIlt-10min-memory-summary.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/AGENTS.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/src/exercises.ts
- /Users/mrbubbles/dev/private/playground/bubbles-training/.git log for commit f5c09d3