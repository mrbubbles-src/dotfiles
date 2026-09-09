---
title: Novari migration mismatch probes
description: You continued diagnosing the Novari GitHub curriculum setup mismatch in MongoDB Compass, then briefly switched to a separate ChatGPT task about expanding an ÖPNV radius. The database work focused on `useReducer` binding/sync state and branch counts after the prior path-mismatch diagnosis.
applications: [com.mongodb.compass, com.google.Chrome]
---

## Memory summary

The user continued the Novari Education production setup investigation in MongoDB Compass. They probed the previously identified `useReducer` path mismatch by querying the current topic binding and related topic sync states, then aggregated active ready sync states by branch. The segment did not capture the output of those two new MongoDB commands, but it did preserve the earlier shell context showing the mismatch between the stored binding path and expected projected path.

The user then switched to Chrome and opened ChatGPT. In a separate `Fokus` project conversation titled `ÖPNV Umkreis visualisieren`, they sent a short German request asking to expand the radius to 54 km. They then switched to another Novari Education ChatGPT conversation titled `Haushaltsgemeinschaft erklärt`.

### Relevant prior context

The immediately preceding 21:20 summary established that the restored `useReducer_infographic` image was no longer the blocker for the Novari GitHub setup. The remaining production issue was a resume-flow inconsistency: the legacy migration had saved a setup path for `useReducer` as `04-spa/13-state-management/tag-110-spa-32-usereducer/README.md`, while the current projected topic path was `04-spa/13-state-management/tag-110-usereducer/README.md`. The failed migration was associated with `GITHUB_LEGACY_MIGRATION_REQUIRED`, and the user had authorized code work for both the concrete resume-flow repair and clearer setup error messaging.

### Important non-obvious context about the user

- `novariEducationProdHorst/Shell`: MongoDB Compass shell context used for production inspection.
- `novari_nexus`: MongoDB database inspected during the setup investigation.
- `githubCurriculumTopicBindings`: collection queried for the mismatching `useReducer` binding.
- `githubCurriculumTopicSyncStates`: collection queried to inspect sync state records linked to the mismatching source binding.
- `githubCurriculumVersionProjections`: collection used in the prior probe to compare projected topics against stored bindings.
- `githubCurriculumLegacyMigrations`: collection used in the prior probe to inspect the failed migration and planned moves.
- `ObjectId('6a7cac431f76ecf92e057d47')`: `useReducer` topic ID.
- `ObjectId('6a736c4c63f0d9aa00ecf578')`: curriculum version ID involved in the legacy migration.
- `ObjectId('6a9f02aa18a26ab6ac581c85')`: version branch state ID for branch `v1`.
- `ObjectId('6a9f028d18a26ab6ac581b63')`: failed legacy migration ID visible in the shell.
- `Fokus - ÖPNV Umkreis visualisieren`: separate ChatGPT task where the user asked to expand a transit radius to 54 km.

## Recording summary

### MongoDB Compass continuation

- The segment began in MongoDB Compass on `MongoDB Compass - novariEducationProdHorst/Shell`, connected to the `novari_nexus` database.
- The visible prior shell output showed `db.githubCurriculumLegacyMigrations.find(...)` returning a failed migration with:
  - `_id: ObjectId('6a9f028d18a26ab6ac581b63')`
  - `status: 'failed'`
  - `phase: 'versions_projecting'`
  - `lastErrorCode: 'GITHUB_LEGACY_MIGRATION_REQUIRED'`
  - `updatedAt: 2026-09-07T21:17:35.438Z`
- The visible prior branch query showed `db.githubCurriculumVersionBranches.find(...)` returning branch `v1` with `phase: 'ready'`, promotion phase `materialized`, `materializedAt: 2026-09-07T21:17:32.308Z`, `bindingsPreparedAt: 2026-09-07T21:17:32.735Z`, and `lastError.code: 'GITHUB_VERSION_PROJECTION_RETRY_REQUIRED'`.
- The visible projection/binding comparison showed `225` projected topics, `181` active ready bindings, and one mismatch for topic `6a7cac431f76ecf92e057d47`: stored path `04-spa/13-state-management/tag-110-spa-32-usereducer/README.md` versus expected path `04-spa/13-state-management/tag-110-usereducer/README.md`.
- The visible follow-up probe showed the migration’s planned move for `useReducer` targeting `04-spa/13-state-management/tag-110-spa-32-usereducer/README.md`, while the topic record had slug `usereducer`, updated at `2026-09-07T21:16:15.117Z`; the mismatching binding’s `updatedAt` was `2026-09-07T18:30:01.673Z`.
- At `21:31:46Z`, the user entered and ran a MongoDB shell query serializing:
  - the current `githubCurriculumTopicBindings.findOne({_id:mismatchBinding._id})` projection for `branch`, `path`, `status`, `operationalReadiness`, and `writerGeneration`
  - up to five `githubCurriculumTopicSyncStates` records with `sourceBindingId:mismatchBinding._id`, projecting `branch`, `path`, `bindingLifecycle`, `operationalReadiness`, and `writerGeneration`
- At `21:32:06Z`, the user entered and ran an aggregation over `githubCurriculumTopicSyncStates` for active ready sync states whose `sourceBindingId` was in `projectionProbeBindings`, grouping by `branch` and counting records.
- The event stream did not capture the result output for these two new queries.

### Chrome and ChatGPT switch

- At `21:36:13Z`, the active app changed to Google Chrome on the Novari Portal.
- The user opened ChatGPT and selected a `Fokus` project conversation titled `ÖPNV Umkreis visualisieren`.
- The user typed a short German request that, after correction, asked to expand the radius to `54 km`, then submitted it.
- At `21:37:27Z`, the active ChatGPT conversation changed to a Novari Education project chat titled `Haushaltsgemeinschaft erklärt`.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T21-30-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-20-00-aRsz-10min-memory-summary.md