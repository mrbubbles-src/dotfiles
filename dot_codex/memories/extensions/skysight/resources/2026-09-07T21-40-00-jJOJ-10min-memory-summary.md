---
title: Novari recovery state checks
description: You continued the Novari GitHub curriculum setup diagnosis in MongoDB Compass. You checked whether recovered binding, import claim, and sync-state records matched the expected `useReducer` migration/source-proof data.
applications: [com.mongodb.compass]
---

## Memory summary

The user stayed in MongoDB Compass on the `novariEducationProdHorst/Shell` window and continued probing the Novari Education production GitHub curriculum setup mismatch. The work focused on validating whether recovery-created `githubCurriculumTopicSyncStates` and `githubCurriculumImportClaims` records lined up with the mismatching `useReducer` binding and the planned legacy migration move. The event stream captured the MongoDB shell probes being entered and executed, but not the result output.

### Relevant prior context

The immediately preceding summaries establish that the user had traced the current Novari setup failure to a resume-flow mismatch for the `useReducer` topic. The restored image was no longer considered the blocker; the saved setup path was `04-spa/13-state-management/tag-110-spa-32-usereducer/README.md`, while the current projected topic path was `04-spa/13-state-management/tag-110-usereducer/README.md`. The failed legacy migration was associated with `GITHUB_LEGACY_MIGRATION_REQUIRED`, and the user had authorized code work for both the concrete resume-flow repair and clearer setup error messaging.

### Important non-obvious context about the user

- `novariEducationProdHorst/Shell`: MongoDB Compass shell context used for production inspection.
- `githubCurriculumTopicSyncStates`: collection queried to validate recovery sync state status, origin, source proof fields, and current topic linkage.
- `githubCurriculumImportClaims`: collection queried to validate import claim purpose, consumption state, path/branch/source proof fields, and migration metadata.
- `projectionProbeBindings`: shell variable used as the current set of projected bindings under inspection.
- `mismatchBinding`: shell variable used for the specific mismatching `useReducer` binding.
- `mismatchMigration`: shell variable used for the failed legacy migration and its planned move data.
- `useReducer`: topic still at the center of the mismatch/recovery investigation.

## Recording summary

### MongoDB Compass recovery probes

- The segment contained four captured events, all in MongoDB Compass on `MongoDB Compass - novariEducationProdHorst/Shell`.
- At `21:44:04Z`, the user entered and ran a shell probe that:
  - loaded `recoverySyncProbe` from `db.githubCurriculumTopicSyncStates.findOne({sourceBindingId:mismatchBinding._id})`
  - loaded `recoveryClaimProbe` from `db.githubCurriculumImportClaims.findOne({_id:mismatchBinding.importClaimId})`
  - serialized checks for sync status and origin, whether `lastHeadSha`, `lastCommitSha`, `lastBlobSha`, and `lastMarkdownSha256` matched the binding/migration data, whether the import claim had purpose `initial_import`, whether it was consumed, and whether the sync state’s `currentTopicId` matched the binding.
- At `21:48:25Z`, the user entered and ran a broader consistency probe that:
  - loaded all relevant recovery claims for `projectionProbeBindings.map(b=>b.importClaimId)`
  - loaded active recovery sync states for `projectionProbeBindings.map(b=>b._id)`
  - iterated through each binding, matching it to `mismatchMigration.moves`
  - counted mismatches in `recoveryMismatchCounts`
  - checked lifecycle expectations such as `writerGeneration === 2`, imported origin, consumed initial-import claim, ready operational state, synced status, and `syncOrigin === 'initial_import'`
  - checked source-proof expectations such as branch, path, directory, claim path, head SHA, commit SHA, blob SHA, and markdown hash alignment
  - compared migration/curriculum metadata fields including `curriculumVersionId`, `repositoryIntegrationId`, `environment`, `repositoryId`, `repositoryName`, and `repositoryUrl`
  - checked current topic linkage between the binding, sync state, and migration source topic
  - serialized counts for bindings, claims, sync states, and mismatch categories.
- The event stream did not capture the MongoDB shell output for either recovery probe.
- Segment metadata reported `eventCount: 4` and `suppressedEventCount: 2` for the `21:40:00Z` to `21:50:00Z` window.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-40-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-30-00-xPCw-10min-memory-summary.md