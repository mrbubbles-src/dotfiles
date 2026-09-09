---
title: Novari MongoDB Sync Inspection
description: You moved from a brief Codex prompt into MongoDB Compass to inspect Novari production curriculum GitHub sync data. You connected to the production Compass profile, opened mongosh on `novari_nexus`, and queried binding/sync-state collections for the active curriculum version.
applications: [com.google.Chrome, com.openai.codex, com.mongodb.compass]
---

## Memory summary

The user investigated the Novari Education GitHub curriculum sync state directly in MongoDB Compass. After briefly prompting Codex with "okay go", the user opened the saved `novariEducationProdHorst` Compass connection, connected to `novari_nexus`, opened a mongosh tab, and typed focused queries against GitHub curriculum binding/sync-state collections for `curriculumVersionId` `6a736c4c63f0d9aa00ecf578`. The observed window captured the diagnostic queries being submitted, but not their returned result sets.

### Relevant prior context

The nearest earlier relevant Skysight summary records that the user had been acceptance-testing Novari Portal GitHub curriculum sync. Topic linking and release had worked, but `Topic anzeigen` failed with `Submodul konnte nicht gefunden werden`, server refresh surfaced `Lokale Sicherung erforderlich`, and GitHub verification showed many problems across `225` linked topics. That prior summary also identified `curriculumVersionId=6a736c4c63f0d9aa00ecf578` as the relevant version.

### Important non-obvious context about the user

- `MongoDB Compass`: used here for production data inspection rather than repository editing.
- `novariEducationProdHorst`: saved Compass connection selected for the live Novari production check.
- `novari_nexus`: database selected in mongosh for the GitHub curriculum sync inspection.
- `curriculumVersionId` `6a736c4c63f0d9aa00ecf578`: active curriculum version ID used in every diagnostic query.
- `githubCurriculumTopicBindings` and `githubCurriculumTopicSyncStates`: collections queried to compare binding metadata, sync lifecycle, writer generation, readiness, and legacy-version fields.
- `__v`, `writerGeneration`, `status`, `bindingLifecycle`, `operationalReadiness`: fields the user inspected to understand binding/sync-state shape and readiness.

## Recording summary

### Codex And Browser Context

- The window began with Chrome active on social-media tabs; those pages appear incidental to the main task and no safe task-continuity content was captured from them.
- The user switched to the Codex desktop app and typed `okay go`, then submitted it.
- The Codex sidebar showed several Novari-related pinned chats/projects, including Novari Education project entries, but no new code work or repository inspection was observed in this window.

### MongoDB Compass Inspection

- The user opened MongoDB Compass, selected the saved connection `novariEducationProdHorst`, and clicked `CONNECT`.
- Compass connected successfully and showed databases including `admin`, `config`, `local`, and `novari_nexus`.
- The user opened the MongoDB shell for `novariEducationProdHorst`; the shell status indicated Atlas primary context for `novari_nexus`.
- The user submitted a collection-name discovery query:
  `db.getCollectionNames().filter(n => /github.*(binding|syncstate)/i.test(n))`
- The user submitted an aggregation on `githubCurriculumTopicBindings` for `curriculumVersionId:ObjectId('6a736c4c63f0d9aa00ecf578')`, grouping by the type of `__v`, `writerGeneration`, `status`, and `operationalReadiness`, with counts.
- The user submitted a parallel aggregation on `githubCurriculumTopicSyncStates` for the same curriculum version, grouping by the type of `__v`, `writerGeneration`, `bindingLifecycle`, and `operationalReadiness`, with counts.
- After a brief switch back to Chrome, the user returned to Compass and submitted a sample lookup for binding documents missing `__v`:
  `db.githubCurriculumTopicBindings.find({curriculumVersionId:ObjectId('6a736c4c63f0d9aa00ecf578'),__v:{$exists:false}},{_id:1,repositoryIntegrationId:1,path:1,createdAt:1,updatedAt:1}).sort({path:1}).limit(2).toArray()`
- The recording did not capture the query result output after these submissions, so the diagnostic conclusion remains unresolved from this segment alone.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T10-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T10-40-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T01-50-00-pABH-10min-memory-summary.md