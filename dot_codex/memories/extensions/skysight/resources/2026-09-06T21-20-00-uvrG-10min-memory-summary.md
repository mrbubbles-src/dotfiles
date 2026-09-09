---
title: Bubbles Training Guidance Setup
description: You shifted from Novari PR coordination back into the bubbles-training repo. You used a ChatGPT conversation to refine the repo’s training guidance, then created and saved local AGENTS.md and HANDOFF.md files in VS Code.
applications: [com.openai.codex, com.google.Chrome, com.apple.dock, com.microsoft.VSCode]
---

## Memory summary

The user spent this window turning the recently revived `bubbles-training` practice repo into a more structured training workspace. They switched between ChatGPT/Codex, Chrome, and VS Code, drafted or copied guidance from a ChatGPT conversation, and created local repository guidance/handoff artifacts under `/Users/mrbubbles/dev/private/playground/bubbles-training`. The end state was that `AGENTS.md` and `HANDOFF.md` existed as untracked files on `main...origin/main`; an intermediate `TRAINING_RULES.md` file was started in VS Code but was not present in the final local repo status.

### Relevant prior context

The immediately preceding summaries show the user had just revived `/Users/mrbubbles/dev/private/playground/bubbles-training` for manual MERN-style practice, created `new-chat-prompt.md`, initialized and committed the repo, pushed or checked it as the private GitHub repository `mrbubbles-src/bubbles-training`, and opened the older handoff file `docs/codex-handoffs/2026-05-02-mern-cardio-training.md`. The same prior context also shows a parallel Novari Education PR-review coordination thread, but this 21:20 window mostly continued the `bubbles-training` setup thread.

### Important non-obvious context about the user

`/Users/mrbubbles/dev/private/playground/bubbles-training`: local practice repository being prepared for learning-oriented coding exercises and follow-up agent review.

`/Users/mrbubbles/dev/private/playground/bubbles-training/AGENTS.md`: newly created untracked repo guidance file; local read-only check showed 68 lines at summarization time.

`/Users/mrbubbles/dev/private/playground/bubbles-training/HANDOFF.md`: newly created untracked handoff file; local read-only check showed 12 lines at summarization time.

`/Users/mrbubbles/dev/private/playground/bubbles-training/docs/codex-handoffs/2026-05-02-mern-cardio-training.md`: older handoff file the user was considering whether to keep or fold into newer guidance.

`main...origin/main`: final observed git branch state for `bubbles-training`, with `AGENTS.md` and `HANDOFF.md` untracked.

## Recording summary

### ChatGPT And Codex Context

The window opened in the Codex desktop app sidebar, where Novari Education chats and project entries were visible. The user then returned to a Chrome ChatGPT conversation titled `Novari Education - Testfläche neu verdrahten`, which had also been used in the previous window while coordinating the `bubbles-training` setup. The user copied selected text from the conversation and later asked about whether the separate training-rules and older codex-handoff material were still needed or could be folded into the newer repo guidance. Exact chat/prompt text is omitted because it was agent-directed workflow content.

### VS Code Work In bubbles-training

At about 21:22Z the user switched to VS Code with the `bubbles-training` workspace open. VS Code showed the repository on Git branch `main` with synchronize controls available.

The user opened the Explorer and created or opened a file named `TRAINING_RULES.md`, then pasted copied content into it and saved it. Shortly afterward they worked with `AGENTS.md` instead; the visible Markdown headings included repository/training workflow sections, but the instruction contents are omitted. The final repo status did not show `TRAINING_RULES.md`, so it appears to have been an intermediate artifact rather than part of the final state captured at summarization time.

The user created or opened `HANDOFF.md` in the repo root, pasted content into it, edited several early lines including references around `solution-round-one`, and saved it. VS Code marked `HANDOFF.md` as untracked.

The user returned to `AGENTS.md`, edited the lower part of the file, added or corrected a reference to `HANDOFF.md`, selected all content, copied it, and saved. VS Code marked `AGENTS.md` as untracked. The Explorer also showed the older `docs/codex-handoffs` folder, tying the new handoff work to the existing historical handoff file.

### Final State

A read-only repo check after the recording showed:

`## main...origin/main`

`?? AGENTS.md`

`?? HANDOFF.md`

A read-only line count showed `AGENTS.md` at 68 lines and `HANDOFF.md` at 12 lines. The last observed active app was Chrome on the ChatGPT conversation.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T21-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T21-20-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T21-10-00-gRBM-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T21-00-00-aKgr-10min-memory-summary.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/AGENTS.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/HANDOFF.md
- /Users/mrbubbles/dev/private/playground/bubbles-training/docs/codex-handoffs/2026-05-02-mern-cardio-training.md