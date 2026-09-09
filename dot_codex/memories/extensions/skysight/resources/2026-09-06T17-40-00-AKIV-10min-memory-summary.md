---
title: Novari PR Labels And AGENTS Handoff
description: You finished adding Novari PR-state labels in GitHub and applied them to active pull requests. You then moved the context into a Novari ChatGPT project to prepare AGENTS.md guidance for Website, LMS, Portal, and Backend.
applications: [com.google.Chrome, com.openai.codex]
---

## Memory summary

The user continued standardizing Novari Education GitHub PR-state labels and moved from label creation into documenting the workflow for repository agents. In this window, they finished creating the `[in Human Review]` label on `Novari-Education/novari-education-website`, refreshed active backend and portal PRs, adjusted their labels, and then used the ChatGPT/Codex app plus a Chrome ChatGPT project conversation to hand over context for adding AGENTS.md rules across Website, LMS, Portal, and Backend. The rule topic was the meaning and use of the new PR-state labels in relation to review state, merge readiness, and auto-merge behavior.

### Relevant prior context

The immediately preceding summaries show the user had been defining and syncing PR-state labels across `Novari-Education/novari-education-backend`, `novari-education-portal`, `novari-education-lms`, `novari-education-website`, and Novari organization repository defaults. `novari-education-backend` was used as the source of truth for label names, descriptions, and colors. A reusable repository-label setup suggestion had already been recorded earlier, so this window does not add another suggestion.

### Important non-obvious context about the user

`Novari-Education/novari-education-website`: the user completed adding the `[in Human Review]` label here at the start of this window; the active label count changed from 13 to 14.

`Novari-Education/novari-education-backend`: the user refreshed PR #219, titled `feat: promote logging, billing, and account workflows to main`, and opened its label picker.

`Novari-Education/novari-education-portal`: the user refreshed PR #185, titled `feat: promote portal logging, billing and account workflows`, and applied or adjusted `[not Ready to Merge]`.

`Novari Education - Testfläche neu verdrahten`: ChatGPT project conversation used for the handoff about adding AGENTS.md rules.

`89351.png`: visible as an attachment in the Codex app during the handoff, likely a screenshot of the label setup.

## Recording summary

### GitHub label setup and PR labeling

The window opened on GitHub’s Labels page for `Novari-Education/novari-education-website`. The user pasted the `[in Human Review]` label description, selected the red color `#b60205`, and clicked `Create label`. The labels page then showed 14 active labels, including the newly visible `[in Human Review]` entry.

The user switched to an open backend pull request tab for `Novari-Education/novari-education-backend` PR #219, refreshed it, then switched to the portal PR tab for `Novari-Education/novari-education-portal` PR #185 and refreshed that too. Back on backend PR #219, the user opened the GitHub label picker and selected review-state labels including `[in Agentic Review]` and `[in Human Review]`. They then returned to portal PR #185, opened its label picker, and selected `[not Ready to Merge]`.

### ChatGPT/Codex handoff

After labeling the PRs, the user switched into the Codex desktop app, interacted with an attached image named `89351.png`, and started dictation. Several minutes later they used `Transcribe and send`, then copied a message from Codex.

The user then switched to Chrome, in a ChatGPT project conversation titled `Novari Education - Testfläche neu verdrahten`. They started a German message saying they had sent something to Lio, created a code block, pasted the copied context, and submitted it. The pasted context described that the new labels had been added across the Novari organization and major repositories, that current PRs had been labeled according to the user’s intended workflow, and that the next desired work was adding corresponding AGENTS.md guidance in the Website, LMS, Portal, and Backend repositories.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T17-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T17-40-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T17-30-00-nyyc-10min-memory-summary.md