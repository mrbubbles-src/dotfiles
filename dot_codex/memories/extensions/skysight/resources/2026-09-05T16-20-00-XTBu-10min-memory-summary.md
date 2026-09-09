---
title: Faverelay Safari Slice 21 Started
description: You were in Codex on the Faverelay Multiway-Sync continuation. Slice 20 was visible as completed, and Slice 21 for Safari multiway sync had begun with an unresolved Safari profile-mapping/access issue.
applications: [com.openai.codex]
---

## Memory summary

The user was in the ChatGPT/Codex desktop app on the `Faverelay Multiway-Sync fortsetzung` thread, with the local branch shown as `codex/multiway-sync-profiles`. The visible Faverelay work had just moved from completed Slice 20, covering Firefox multiway sync for Places schema 86 and existing folders, into Slice 21 for Safari. Slice 21 was not yet complete: the visible Codex status said Safari profile assignment was not sufficiently proven because the implementation falls back from UUID matching to profile-name lookup, which was considered inadequate for write access, and the first access test of the installed app had failed while the assistant investigated the cause.

### Relevant prior context

Earlier same-day summaries show that the user had been coordinating Faverelay multiway sync work across browser-profile slices. A prior Faverelay continuation had involved preparing a `Faverelay Live Matrix` test setup, and the user had also worked heavily in Codex continuation threads for Inlyra, Bubblophy, and Logging V2. The immediately preceding 16:10 summary had almost no activity and did not add Faverelay state.

### Important non-obvious context about the user

- `Faverelay Multiway-Sync fortsetzung`: active Codex thread in this window.
- `codex/multiway-sync-profiles`: active branch visible in the Codex environment panel.
- `/Applications/Faverelay.app`: installed app path referenced in the visible QA plan.
- `Faverelay Live Matrix`: test-profile/bookmark-folder name visible in the Faverelay live QA context.
- `Sources/FaverelayParserTests/main.swift`: one of the changed files visible for Slice 20.
- `documentation/browser-adapters.md`: visible changed documentation file for Slice 20.
- `documentation/manual-qa.md`: visible changed manual-QA documentation file for Slice 20.
- `documentation/qa/2026-09-05-edge-brave-live-matrix.md`: visible QA report path from Slice 19.
- `efd23ad`: visible Slice 20 commit hash; the worktree was reported clean and not pushed.
- `62e69de`: visible Slice 19 commit hash; the worktree was reported clean and not pushed.
- `Safari contract scout` and `Safari mutator`: visible subagent/work items started for Slice 21.

## Recording summary

The segment contained three Codex desktop app events at 16:22Z: one `window.changed` event and two mouse clicks inside the ChatGPT/Codex window. The active application bundle identifier was `com.openai.codex`, and the window title was `ChatGPT`.

The Codex sidebar showed many continuation threads, including Faverelay, Inlyra, Bubblophy, and several Logging V2 threads. The active content was the Faverelay continuation. Older visible Faverelay context showed Slice 19 as completed after Edge/Brave live QA with separate test profiles, a QA report at `documentation/qa/2026-09-05-edge-brave-live-matrix.md`, commit `62e69de`, a clean worktree, no push, and two empty test profiles left behind.

The visible thread then showed Slice 20 as completed: Firefox multiway sync was enabled for Places schema 86 and existing folders. The result message reported 513 tests, parser checks, release verification, and independent review as passing; native database-copy behavior was checked, including exact restoration of WAL/SHM data; the release was installed; no personal Firefox profiles were changed; commit `efd23ad` existed; the worktree was clean; the commit was not pushed; and Slice 21 had not yet been started at that point. The changed-file list included `Sources/FaverelayParserTests/main.swift`, `documentation/browser-adapters.md`, and `documentation/manual-qa.md`.

The user had then sent `go slice 21`. The visible assistant response said Slice 21 was being started for Safari with exact profile assignment, write and restore checks, and an installed-app test. A later visible state showed a model-capacity message, automatic context compaction, and a `Safari contract scout` subtask running. The latest visible status said Safari profile assignment was still not sufficiently established because the current behavior falls back to profile-name lookup when UUID matching is missing, and that this was not enough for write access. It also said the first access test of the installed app had failed and the concrete cause was being investigated before Safari multiway support would be enabled. `Safari contract scout` and `Safari mutator` were both visible as started.

The Codex environment panel showed a very large visible change count, `Changes +53,401 -1,537`, and the active local branch `codex/multiway-sync-profiles`. The window also showed `Context usage: 80%`, a `Stop` button, and no new user message typed during the captured events.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-05T16-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-05T16-20-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-05T16-10-00-HWRk-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-05T13-40-00-BiXz-10min-memory-summary.md