---
title: Novari migration database probing
description: You inspected Novari production MongoDB state for the broken GitHub curriculum setup after the portal still showed the GitHub connection as connected. The work focused on legacy migration records, branch promotion fields, topic bindings, image assets, and inline HTML content in migrated topics.
applications: [com.mongodb.compass, com.openai.codex, com.logi.cp-dev-mgr]
---

## Memory summary

The user continued debugging the Novari Education production GitHub curriculum migration failure in MongoDB Compass while a Codex chat for `novari-education-backend` was also active. The visible work centered on the `novariEducationProdHorst/Shell` connection and `novari_nexus` database, probing collections related to GitHub curriculum legacy migrations, branch promotions, topic bindings/import claims, and migrated topic content. The user was investigating why the setup remained broken despite the Portal showing the GitHub app connection as connected.

The Mongo shell history showed an earlier repair/checkpoint update had been applied to a curriculum work revision: the after-check reported `seq:384`, `cursor:2`, topic order arrays `[[1,2,3,5,4],[2,3,4,5,1]]`, and `checkpoint:1`, with follow-up checks indicating `contentUnchanged:true` and `overviewUnchanged:true`. The user then inspected a later revision `_id:ObjectId("6a736c5263f0d9aa00ecf5c2")`, which had `seq:385` and `topicCount:225`, and probed the migrated Editor.js-style `content.blocks` for inline HTML patterns, links, image blocks, and problematic alert messages.

### Relevant prior context

The immediately preceding Skysight summary established that this was a continuation of the Novari production GitHub curriculum setup incident. Portal PR #200 and backend PR #240 had been merged and deployed, but retrying the setup completion produced `GITHUB_SYNC_CONNECTION_FAILED` at `2026-09-07T20:55:43.000Z` with reference ID `88cf1ff3-b0d6-4b90-b90b-0b5328fe604f`; the Portal later still showed the GitHub app connection as `Verbunden`.

### Important non-obvious context about the user

- `MongoDB Compass`: used directly for production-state inspection in this window.
- `novariEducationProdHorst/Shell`: MongoDB Compass shell context used for the investigation.
- `novari_nexus`: database visible in Compass during the probes.
- `atlas-ldye11-shard-0 [primary]`: Atlas primary shown in the Mongo shell status.
- `novari-education-backend`: active Codex project connected to the same investigation.
- `GitHub-Setup trotz Abweichungen`: active Codex chat about the failing setup.
- `githubCurriculumLegacyMigrations`: collection queried for migration status, phase, error code, timestamps, and repository integration.
- `githubCurriculumVersionBranches`: collection queried for branch phase, last error, and promotion/materialization fields.
- `githubCurriculumImportClaims`, `githubCurriculumTopicBindings`, `githubCurriculumBindingWriterHeartbeats`: GitHub curriculum collections visible from the user’s collection-name probes.
- `curriculumVersionId:ObjectId('6a736c4c63f0d9aa00ecf578')`: curriculum version ID used in the legacy migration query.
- `repositoryIntegrationId:ObjectId('6a736c4d63f0d9aa00ecf5aa')`: repository integration ID used in branch/promotion queries.
- `ObjectId("6a736c5263f0d9aa00ecf5c2")`: work revision ID used for inline content probing.
- `codex/github-migration-inline-fix`: local branch visible in the Codex environment panel.
- `fix: preserve alert lines and validate GitHub migration exports`: visible commit/push entry tied to the active fix thread.

## Recording summary

### MongoDB Compass migration-state probes

- At the start of the window, MongoDB Compass showed the `novariEducationProdHorst/Shell` shell with `novari_nexus` expanded in the sidebar.
- The shell history already showed a repair/checkpoint sequence:
  - `overviewCheckpoint` was prepared with `operationKind:"checkpoint_resync_required"` and `resultWorkRevisionSequence:384`.
  - `repairSession.withTransaction(applyOverviewRepair)` was run.
  - The post-repair check returned `{"seq":384,"cursor":2,"orders":[[1,2,3,5,4],[2,3,4,5,1]],"checkpoint":1}`.
  - A structural comparison later returned `{"contentUnchanged":true,"overviewUnchanged":true}`.
- The user queried collection names matching GitHub migration/projection terms:
  - `db.getCollectionNames().filter(n=>/github.*migration|github.*projection/i.test(n));`
- The user queried recent `githubCurriculumLegacyMigrations` records for `curriculumVersionId:ObjectId('6a736c4c63f0d9aa00ecf578')`, projecting `status`, `phase`, `lastErrorCode`, `updatedAt`, `confirmedAt`, `completedAt`, and `repositoryIntegrationId`.
- The user queried `githubCurriculumVersionBranches` for `repositoryIntegrationId:ObjectId('6a736c4d63f0d9aa00ecf5aa')`, first checking `curriculumVersionId`, `branch`, `phase`, `lastError`, and `updatedAt`.
- The user then inspected branch promotion fields including `promotions.phase`, `promotions.lastError`, `promotions.promotesMain`, `promotions.createdAt`, `promotions.snapshotSha256`, `promotions.preMaterializationBranchHeadSha`, `promotions.materializationCommitSha`, and `promotions.materializedAt`.

### Topic binding and content probes

- Shell history showed collection-name probes for GitHub binding/claim collections returned `githubCurriculumImportClaims`, `githubCurriculumTopicBindings`, and `githubCurriculumBindingWriterHeartbeats`.
- A visible missing-path check showed these five curriculum README paths had `bindings:0` and `claims:0`:
  - `02-UIB/Tag35-Wiederholung/README.md`
  - `03-PB/Tag26-Wiederholung/README.md`
  - `04-SPA/Tag47-Wiederholung/README.md`
  - `04-SPA/Tag49-Praxisprüfung/README.md`
  - `05-BE/Tag21-Wiederholung-&-Deployment/README.md`
- The user inspected revision `_id:ObjectId("6a736c5263f0d9aa00ecf5c2")`; the shell output showed `seq:385`, `topicCount:225`, and topic documents containing fields such as `content`, `description`, `ownerCurriculumVersionId`, `topicRevision`, and version/supersession metadata.
- An initial inline-content scanning command hit `SyntaxError: Unexpected token (1:265)` because the regex was not escaped correctly.
- A corrected scan over 225 topic contents found `contentShape:"object"` with `contentKeys:["time","version","blocks"]`, `emptyCode:0`, many `code`, `b`, `a`, `div`, and other tag occurrences, and link categories including `https`, `other`, `anchor`, and `slash`.
- A follow-up scan identified non-code blocks containing disallowed-looking HTML tags in alert `data.message` fields, particularly `div` tags. The visible first results were alert blocks at positions 20, 34, 15, 28, and 21 across several topics.
- The user probed topic image blocks with aggregations over `content.blocks.type:"image"` and projected `content.blocks.data.file` / `content.blocks.data.file.url`.
- The user then queried topics containing image public ID `novari-lms-uploads/github-curriculum-86a52ef69ac094e0f77a0f25dcc9cb2f807a344e344e311eaacdefc47074ef6c`, projecting topic titles.

### Codex and peripheral app activity

- The user briefly switched to the Codex desktop app. The active project was `novari-education-backend`, and the chat title was `GitHub-Setup trotz Abweichungen`.
- The Codex chat showed the prior `GITHUB_SYNC_CONNECTION_FAILED` investigation still active, with Render and MongoDB Atlas sources visible. Codex was reading `githubCurriculumLegacyMigrationSchema.js`.
- The Codex environment panel showed scheduled task `GitHub-Fix: Main-PRs beobachten`, local branch `codex/github-migration-inline-fix`, and commit/push entry `fix: preserve alert lines and validate GitHub migration exports`.
- The user clicked a Logi Options+ radial menu item labeled for setting audio devices; this appeared incidental to the Novari debugging flow.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-00-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-00-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T20-50-00-ZzjH-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T20-40-00-mFOH-10min-memory-summary.md