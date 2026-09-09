---
title: Novari curriculum work revision inspection
description: You continued the Novari production curriculum setup investigation in MongoDB Compass. You focused on `curriculumWorkRevisions` and topic structure fields after the draft `curriculumVersion` itself showed no modules.
applications: [com.mongodb.compass, com.openai.codex]
---

## Memory summary

The user continued investigating the Novari Portal production GitHub curriculum setup failure from the MongoDB Compass shell. The key finding in this window was that the previously identified draft `curriculumVersions` document for `_id:ObjectId("6a736c4c63f0d9aa00ecf578")` returned `moduleCount: 0`, so the user pivoted to `curriculumWorkRevisions` for the same curriculum version. They inspected an open work revision `_id:ObjectId("6a736c5263f0d9aa00ecf5c2")`, checking its nested module/submodule/topic structure, validating `githubPathPosition` values, counting missing/null positions, and cross-checking referenced topic documents for missing slugs, superseded status, and duplicate topic IDs.

### Relevant prior context

The immediately preceding summary shows this was part of a production Novari Portal issue where GitHub setup for “Fullstack Web Developer mit KI-Kompetenz” failed with `GITHUB_TOPIC_STRUCTURE_INVALID`. Earlier in the sequence, the user had created `Novari-Education/fullstack-web-ki_curriculum_backup_prod` from the `fullstack-web-ki_curriculum` template, confirmed the portal still showed `fullstack-web-ki_curriculum` as the connected repository, and then moved into MongoDB production data inspection because Codex did not have working MongoDB Atlas MCP access.

### Important non-obvious context about the user

- `com.mongodb.compass`: primary app used in this window for direct production data inspection.
- `novariEducationProdHorst`: MongoDB Compass production connection used for the investigation.
- `novari_nexus`: MongoDB database selected in Compass.
- `curriculumVersionId:ObjectId("6a736c4c63f0d9aa00ecf578")`: draft curriculum version under inspection; its direct `modules` projection returned `moduleCount: 0`.
- `curriculumWorkRevisions`: collection the user pivoted to after the draft curriculum version had no modules.
- `curriculumWorkRevision _id:ObjectId("6a736c5263f0d9aa00ecf5c2")`: open work revision inspected for the working structural snapshot.
- `workingStructuralSnapshot.modules`: nested data path queried for module/submodule/topic structure.
- `githubPathPosition`: topic structure field being validated for safe integer range `1..999`, missing values, and nulls.
- `topics`: collection cross-checked against topic IDs from the work revision to inspect referenced topic documents, slugs, status, and duplicate references.

## Recording summary

### MongoDB Compass shell investigation

- The window opened in MongoDB Compass on `novariEducationProdHorst/Shell`, connected to the `novari_nexus` database.
- The previous structural projection against `curriculumVersions.findOne({_id:ObjectId("6a736c4c63f0d9aa00ecf578")},{modules:1})` had produced `{ moduleCount: 0, firstModuleKeys: [], structure: [] }`. This showed that the draft curriculum version document itself did not contain the module structure needed for the failing GitHub topic setup diagnosis.
- The user submitted a query against `db.curriculumWorkRevisions.find(...)` filtering by `curriculumVersionId:ObjectId("6a736c4c63f0d9aa00ecf578")`, `lifecycleStatus:"open"`, and `recoveryKey:null`. The projection included `_id`, `reviewStatus`, `mergeStatus`, `workRevisionSequence`, and `workingStructuralSnapshot.modules`.
- The query mapped returned work revisions into module order/slug, submodule order/slug, topic counts, invalid `githubPathPosition` entries, and first topic samples. This indicates the user was trying to locate structural validation failures inside open work revisions rather than the base curriculum version.
- The user then focused on a specific work revision, `_id:ObjectId("6a736c5263f0d9aa00ecf5c2")`, and ran a `JSON.stringify(...)` projection of its `workingStructuralSnapshot.modules`, mapping module and submodule order/slug plus topic counts and invalid position counts.
- Next, the user ran an IIFE that flattened all topics from that same work revision and returned totals for all topics, missing `githubPathPosition`, null `githubPathPosition`, and the first topic object. This narrowed the check from per-submodule summaries to topic-level field presence.
- The user then ran another IIFE that loaded the same flattened topic references, fetched corresponding documents from `db.topics` by `_id`, and returned counts for referenced topics, found topic docs, missing slugs, superseded topics, and duplicate topic IDs. The final typed query corrected the duplicate count to use `new Set(ts.map(t=>String(t.topicId))).size`.
- Near the end of the window, focus briefly moved to a ChatGPT/Codex “Computer Use Controls” dialog, with no additional task content captured.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T14-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T14-30-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T14-20-00-ZnxS-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T14-10-00-ASWq-10min-memory-summary.md