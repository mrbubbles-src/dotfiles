---
title: Novari Review Workflow Guidance
description: You revised review workflow guidance after ongoing Novari PR review friction, focusing on how automatic PR review should relate to additional independent reviews. You edited local skill guidance, then asked Codex to add the relevant part to repository AGENTS.md files.
applications: [com.google.Chrome, com.openai.codex, com.apple.finder, com.coteditor.CotEditor, com.raycast.macos]
---

## Memory summary

The user continued refining the Novari Education PR review workflow after earlier concerns that repeated review loops were consuming time and usage while automatic PR review was already active. In Chrome, the user asked in the ChatGPT project conversation `Novari Education - Testfläche neu verdrahten` whether the workflow should be reflected in the `orchestrate` skill or in `AGENTS.md`, then requested exact wording for both. They then used CotEditor to edit `SKILL.md` for the local `orchestrate` skill, adding or revising a section about PR review reuse and related coordination behavior. After that, they switched back to Codex and asked it to add the corresponding section to the `AGENTS.md` files in the relevant repositories.

### Relevant prior context

The immediately preceding summary shows the user was coordinating Novari backend and portal PR review work across `novari-education-backend` PR #219 and `novari-education-portal` PR #185. The user had pushed back on redundant review loops while PR review was already active and was concerned that ongoing review cycles were consuming usage after a reset. Earlier context also established that `Ready to Merge` had been clarified as readiness status only, not authorization to merge.

### Important non-obvious context about the user

`Novari Education - Testfläche neu verdrahten`: ChatGPT project conversation used to discuss Novari workflow and agent guidance changes.

`orchestrate` skill: local skill guidance was opened and edited in CotEditor as `SKILL.md`; the visible section was about reusing active automatic PR review instead of repeatedly starting separate full reviews.

`AGENTS.md`: the user asked Codex to add the new PR-review workflow guidance to AGENTS.md files in the repositories, likely to align repo-local agent behavior with the revised skill guidance.

`novari-education-website`: Finder showed this repository selected during the handoff, suggesting it may have been one of the target repos for AGENTS.md updates.

`com.raycast.macos`: the user used Raycast’s emoji/symbol picker while drafting a short response in the Chrome ChatGPT conversation.

## Recording summary

### ChatGPT workflow discussion

At 20:30, Chrome was on the ChatGPT project conversation `Novari Education - Testfläche neu verdrahten`. The user switched briefly to the Codex desktop app and Finder windows associated with `orchestrate` and `code-reviewer`, then returned to Chrome.

The user typed in German that the new workflow should probably be reflected in the `orchestrate` skill, because if they test future work with labels and direct PR review, it should be made clear that another extra review is not necessarily required. They added the alternative that this might belong in `AGENTS.md`. They then asked ChatGPT to write exactly how this should be expressed in the skill and in AGENTS.md.

### Local skill edit

The user switched to CotEditor with a file titled `SKILL.md`. The visible file was the `orchestrate` skill, with frontmatter naming `orchestrate` and a description saying it is the default coordination mode for concrete task-oriented requests.

In CotEditor, the user pasted a new section concerning pull request review workflow/reuse. The visible content described the general idea that an active automatic PR reviewer can serve as the primary independent review for coherent PR-based work, with additional independent review reserved for concrete reasons. The user saved the file, then appeared to undo some earlier insertion and paste a different or additional block of related review/model-selection guidance before saving again. The exact pasted directive text is not retained because it is agent-instruction content.

### Codex handoff

After saving the skill file, the user switched back to the Codex desktop app and typed a German request asking Codex to add the relevant part to the repository AGENTS.md files. They pasted a section titled `Pull Request Review Workflow` into the Codex prompt as source material. The pasted content concerned opening PRs before implementation is fully complete, using automatic PR review incrementally, working in coherent blocks, and avoiding redundant second full reviews unless there is a concrete reason. The exact instruction text is not retained.

Finder then showed a `novari` window and a selected `novari-education-website` folder, followed by quick switching between Finder windows named `orchestrate`, `code-reviewer`, and `Desktop`, then back to Codex and Chrome.

### Closing Chrome message

At the end of the window, the user returned to Chrome and began drafting a short German thank-you message in the same Novari ChatGPT conversation. They used Raycast’s emoji/symbol picker, first inserted a symbol, replaced it with another emoji, and continued typing that they were curious and hoped it might work. The message appeared still in progress at the end of the segment.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T20-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T20-30-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T20-20-00-UpjY-10min-memory-summary.md