---
title: Novari Curriculum Fix Steering
description: You continued investigating Novari curriculum revision and GitHub-check issues. You used MongoDB Compass for production read-only diagnostics, then answered an active Codex decision prompt about opening draft curriculum topics directly in the LMS.
applications: [com.mongodb.compass, com.google.Chrome, com.openai.codex]
---

## Memory summary

The user continued a Novari Education debugging thread around curriculum post-setup behavior. In MongoDB Compass, they queried production curriculum work revision documents and revision-change records for work revision `6a736c5263f0d9aa00ecf5c2`, then inspected the first module/submodule/topic structure in its working structural snapshot. Later, in the Codex desktop app, an active branch `codex/fix-curriculum-post-setup` showed ongoing code changes and a question about where `Topic anzeigen` should open for inactive curriculum versions; the user answered that it should open directly in the LMS because employee access had already worked before, and asked Codex to verify that.

### Relevant prior context

The immediately preceding summary records that the user had been investigating Novari Portal GitHub curriculum sync and acceptance-test failures. Earlier findings included `Topic anzeigen` failing with `Submodul konnte nicht gefunden werden`, server refresh surfacing `Lokale Sicherung erforderlich`, and GitHub verification reporting `44` problems among `225` linked topics for curriculum version `6a736c4c63f0d9aa00ecf578`. The prior window also recorded direct MongoDB inspection of GitHub binding and sync-state collections, especially around missing `__v` fields.

### Important non-obvious context about the user

- `MongoDB Compass`: used for production read-only diagnostics against the `novariEducationProdHorst` shell.
- `novariEducationProdHorst`: Compass connection visible during the production investigation.
- `curriculumWorkRevisions`: collection queried for revision metadata, collaboration cursor fields, and working structural snapshot shape.
- `curriculumWorkRevisionChanges`: collection queried for cursor-ordered revision changes from `cursor >= 3`.
- `workRevisionId` `6a736c5263f0d9aa00ecf5c2`: central revision ID inspected in this window.
- `codex/fix-curriculum-post-setup`: active Codex branch for the in-progress Novari portal fix.
- `/Users/mrbubbles/dev/novari/novari-education-portal`: repository path visible in the active Codex task.
- `Topic anzeigen`: behavior under decision; the user indicated inactive curriculum topics should open directly in the LMS because staff access had already supported it.

## Recording summary

### MongoDB Compass Diagnostics

- At `10:50`, the user submitted a `curriculumWorkRevisions.find` query for `_id:ObjectId('6a736c5263f0d9aa00ecf5c2')`, projecting `_id`, `sequence`, `workRevisionSequence`, `baseAggregateRevisionId`, `editSessionFence`, `status`, and `updatedAt`.
- The user then queried the same work revision for `workRevisionSequence`, `collaborationCursor`, and `collaborationCursorFloor`.
- At `10:51`, the user queried `curriculumWorkRevisionChanges` for `workRevisionId:ObjectId('6a736c5263f0d9aa00ecf5c2')` and `cursor:{$gte:3}`, projecting `cursor`, `operationKind`, `resultWorkRevisionSequence`, and `createdAt`, sorted by `cursor`.
- At `10:54`, the user ran an aggregation on `curriculumWorkRevisions` to extract the first module from `workingStructuralSnapshot.modules`, including `moduleId`, `moduleSnapshotId`, submodule IDs/snapshot IDs/titles, and a sliced sample of topic IDs.
- The recording captured the submitted MongoDB commands but not their returned result sets.

### Portal And Codex Context

- Chrome briefly showed the Novari Portal topics area for a draft Fullstack Web Developer curriculum context with GitHub verification problems, but the active work in this window was not direct browser interaction with that page.
- The Codex desktop app showed an active task on branch `codex/fix-curriculum-post-setup` with an in-progress change set that grew from roughly `+382 -4` to `+531 -4`.
- The active Codex thread showed prior diagnostic state: a Topic scout and Editor scout had been used, the GitHub problem count was tied to missing internal version counters on 44 of 225 linked topics, and production data had not been changed.
- Codex asked where `Topic anzeigen` should open for a not-yet-active curriculum version, offering a read-only portal preview or LMS draft preview direction.
- The user typed and submitted a response choosing direct LMS behavior, stating that it had previously been possible and that employees already had access, then asking Codex to verify because it was expected to work.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T10-50-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T10-50-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T10-40-00-BkGN-10min-memory-summary.md