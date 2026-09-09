---
title: Novari migration fixes and GitHub Education setup
description: You spent most of this window driving a Novari GitHub curriculum setup incident through diagnosis, fixes, PRs, deploy checks, and repeated production retries. You later shifted into Classroom 50 / GitHub Education setup and prepared verification evidence for Novari Education.
applications: [com.google.Chrome, com.openai.codex, com.microsoft.VSCode, com.mongodb.compass, com.apple.mail, com.lowtechguys.Clop, cc.ffitch.shottr, com.logi.cp-dev-mgr, com.raycast.macos, com.apple.LocalAuthentication.UIAgent, com.apple.dock, com.apple.finder, com.apple.Preview, com.apple.appkit.xpc.openAndSavePanelService, com.pdfeditor.pdfeditormac]
suggestion:
  type: skill
  name: Novari incident triage
  description: Turn my request-ID lookup, deployment check, and PR readiness review for Novari production failures into a reusable incident triage skill.
---

## Memory summary

The user spent the first major arc of this 6-hour window resolving and rechecking a Novari Education production GitHub curriculum setup incident for `Fullstack Web Developer mit KI-Kompetenz`. They merged initial portal/backend release PRs, retried setup completion, hit new backend and portal failures, used Render logs and MongoDB Compass to trace request IDs and migration state, restored a missing `useReducer` image, and pushed the diagnosis toward code fixes for legacy setup recovery and clearer public error handling.

The Novari incident evolved through several specific failure states: `GITHUB_TOPIC_EXPORT_INLINE_UNSUPPORTED`, then `GITHUB_SYNC_CONNECTION_FAILED`, then `GITHUB_SYNC_GUARDRAIL_FAILED`, and finally a resume-flow/path-mismatch diagnosis around `useReducer`. The mismatch involved stored/generated GitHub paths diverging between `tag-110-spa-32-usereducer` and `tag-110-usereducer`, with the restored image no longer considered the blocker. Parallel PR work touched backend, Portal, and LMS repositories, including backend setup-recovery/error-details PR #242, Portal public error handling PR #201, and LMS PR #41 retargeting to the Nova integration feature branch.

The later arc shifted into Classroom 50 / CS50 research and GitHub Education setup for Novari Education. The user started ChatGPT Deep Research on Classroom 50 as a GitHub Classroom alternative and integration target for the Novari Portal/LMS, authorized a Classroom50/Foundation50 GitHub OAuth flow, began a GitHub Education Benefits application, then prepared employment/teaching verification evidence in Google Docs and exported PDFs after GitHub requested additional proof. The window ended with Classroom 50/GitHub Education still unresolved and Portal PR #201 apparently reviewed/checks passing but still waiting on an explicit final merge-readiness step.

### Relevant prior context

Earlier same-day context before this 6-hour window showed the Novari production repair began with `GITHUB_LEGACY_MIGRATION_CONTEXT_CHANGED` and duplicate topic order values in a production-like MongoDB shell. The first captured child summary in this window continued directly from that work by merging Novari portal PR #198 and backend PR #237 and attempting to complete the existing GitHub repository setup.

### Important non-obvious context about the user

- `Novari-Education/novari-education-portal`: Portal repository involved in setup UI, support errors, and PRs #198, #199, #200, and #201.
- `Novari-Education/novari-education-backend`: backend repository and Render service involved in migration confirmation, export, recovery, and PRs #237, #238, #240, and #242.
- `Novari-Education/novari-education-lms`: LMS repository involved in safe backend error display work, especially PR #41.
- `fullstack-web-ki_curriculum`: GitHub curriculum repository/setup target for the production migration.
- `legacy-source-912b71b03eef013497b09576e535b78fbb95ca1c`: archive branch shown by the setup preview before completion.
- `novariEducationProdHorst/Shell` and `novari_nexus`: MongoDB Compass context repeatedly used for production-like migration and topic-state inspection.
- `ObjectId('6a736c4c63f0d9aa00ecf578')`: curriculum version ID repeatedly used in migration and topic queries.
- `ObjectId('6a7cac431f76ecf92e057d47')`: `useReducer` topic ID central to the later mismatch diagnosis.
- `GITHUB_TOPIC_EXPORT_INLINE_UNSUPPORTED`: first post-release confirmation failure, tied to editor-generated line wrappers in alert/note blocks.
- `GITHUB_SYNC_CONNECTION_FAILED`: production retry failure after backend/portal main release was deployed.
- `GITHUB_SYNC_GUARDRAIL_FAILED`: Portal-visible failure after the missing `useReducer` image was restored.
- `GITHUB_LEGACY_MIGRATION_REQUIRED`: internal/setup reason visible in logging and MongoDB state after the restored-image retry.
- `feature/nova-integration-rework-of-landing-modules-page`: LMS feature branch selected as the correct target for PR #41 because it already included the sidebar split.
- `components/ui/shadcn/sidebar.tsx`: LMS sidebar file that should remain unchanged relative to the Nova feature branch during PR #41 correction.
- `ChatGPT - Novari Education - CS50 Recherche anfordern`: research thread used to evaluate Classroom 50 / CS50 Classroom and integration/automation options.
- `GitHub Education Benefits Application`: later operational workflow for Novari Education teacher/organization verification.
- `Employment and Teaching Verification...`: Google Docs/PDF proof artifacts prepared for GitHub Education verification; exact person-specific filenames are intentionally not retained.

## Recording summary

### Novari Release, Retry, And Inline Export Failure

The window opened with the user finishing a Novari setup repair release. They merged portal PR #198 and backend PR #237, checked the backend deploy in Render, returned to the Portal GitHub setup flow for `Fullstack Web Developer mit KI-Kompetenz`, saw a ready-to-complete preview with `181` assigned files, and clicked `Einrichtung abschließen`. The preview indicated legacy source preservation in `legacy-source-912b71b03eef013497b09576e535b78fbb95ca1c`.

The setup did not complete. The Portal still showed setup in progress, and the user found a backend failure in Render logs by request ID `97b4b1a0-7152-49de-be7a-033e104407a5`. The failure was `GITHUB_TOPIC_EXPORT_INLINE_UNSUPPORTED` on the migration confirm endpoint, returning HTTP 422 after a successful preview request.

The user synchronized local backend and portal repos in VS Code, then used MongoDB Compass against `novariEducationProdHorst/Shell` and `novari_nexus` to inspect curriculum work revision `ObjectId("6a736c5263f0d9aa00ecf5c2")`. They confirmed the current work revision had `225` topics and Editor.js-style `content.blocks`, then scanned for inline tags, links, and problematic non-code blocks. The problematic content was narrowed to alert/note message fields containing editor-generated line-break wrappers.

Codex work in `novari-education-backend` then produced fixes for preserving alert/note line breaks during GitHub curriculum export, improving safe support error output with request IDs, and validating exported versions before migration writes. Focused backend tests and Portal tests were visible as passing; the full backend suite had existing baseline failures reproduced on unchanged `dev`.

### Dev PRs, Main Release PRs, And Production Deploy

The user monitored companion PRs Backend #238 and Portal #199 for the inline export/error-message fix. Both were inspected in GitHub, appeared ready with checks passing, and contained notes that production confirmation remained pending after release. The user approved separating a pre-existing concurrency gap into a follow-up issue and performing final merge-readiness checks.

After the dev fixes, Codex indicated that production did not yet contain the new changes and prepared main-release PRs. The user opened backend PR #240 and portal PR #200, later merged both main-release PRs, and checked Render for `novari-education-backend`. Render first showed commit `709e0d7` live, then later `e9e35b7` as the latest successfully deployed backend commit corresponding to the merged backend release.

### New Production Failures And Migration State Diagnosis

After the main release deployed, the user retried the production setup completion. The Portal showed the GitHub app connection as connected, but completion failed during `Bestätigen der GitHub-Legacy-Migration` with `GITHUB_SYNC_CONNECTION_FAILED`, reference ID `88cf1ff3-b0d6-4b90-b90b-0b5328fe604f`, timestamp `2026-09-07T20:55:43.000Z`.

The user then used MongoDB Compass to inspect `githubCurriculumLegacyMigrations`, `githubCurriculumVersionBranches`, `githubCurriculumImportClaims`, `githubCurriculumTopicBindings`, and `githubCurriculumTopicSyncStates`. Earlier repair/checkpoint state showed work revision sequence `384`; the later topic revision under inspection showed sequence `385` and `225` topics. Branch `v1` had materialized, but legacy migration state still failed.

The user restored a missing `useReducer_infographic.png` by downloading it from the backup curriculum repository path `04-SPA/Tag32-State-Management/images/useReducer_infographic.png`, uploading it through the Portal topic editor for `useReducer`, renaming the image label, and saving the topic with a German change reason. A later retry still failed, now showing `GITHUB_SYNC_GUARDRAIL_FAILED` with reference ID `bdec4910-75df-4356-adbe-89694561a075` and timestamp `2026-09-07T21:16:16.000Z`.

Portal logging filtered by request ID `01dde845-00a8-4ff4-9996-70cd3b0e4d39` showed a failed legacy migration completion event with `GITHUB_LEGACY_MIGRATION_REQUIRED`. MongoDB and Codex diagnosis then shifted away from the image as the root cause. The key finding became a setup resume mismatch: the stored path for `useReducer` was `04-spa/13-state-management/tag-110-spa-32-usereducer/README.md`, while the current projected path was `04-spa/13-state-management/tag-110-usereducer/README.md`. The user authorized code work for both the concrete resume-flow repair and broader clearer setup-error handling, including Issue #241.

The user ran additional MongoDB probes to compare recovery sync states and import claims against binding/migration data. The event stream captured the commands being entered but not their outputs.

### Backend, Portal, And LMS PR Coordination

Later Novari work shifted into cross-repo PR follow-up. The user checked Render, GitHub, Codex, and VS Code while reviewing backend, Portal, and LMS fixes. Backend branch `codex/setup-recovery-error-details` was visible with changes around global/public error handling, GitHub curriculum Cloudinary image handling, and setup recovery. Codex reported backend PR #242 updates, including transaction/path-chain recovery logic, batched lookup behavior, many passing tests, one local MongoDB swap/rollback test, lint passing, and known baseline backend failures.

Portal PR #201 was updated with review-correction and verification status. Codex found a Portal Axios compatibility issue around real Axios error objects and added coverage for the still-allowed Axios 1.13.2 behavior, while pinned Axios 1.14.0 was already recognized correctly.

The LMS thread focused on PR #41, `fix: show safe actionable backend errors across LMS clients`. The user noticed it should target `feature/nova-integration-rework-of-landing-modules-page` rather than `dev`, because the feature branch already contained a later sidebar split. Codex adapted the PR to that feature branch, keeping `components/ui/shadcn/sidebar.tsx` unchanged relative to the branch and correcting `__tests__/unit/components/site-navigation-search.test.tsx`. The user inspected the LMS PR in GitHub, where review comments were still visible before later Codex status indicated final LMS recheck had passed and corrected state was being published.

Near the end of the PR arc, the user asked Codex to check review status across backend, LMS, and Portal. Codex reported backend and LMS as already merged into target branches, Portal PR #201 as reviewed with no open findings and checks passing, and the remaining Portal step blocked on an explicit final readiness/merge instruction.

### Classroom 50, GitHub Education, And Verification Evidence

The user started a separate ChatGPT Deep Research task inside the Novari Education project about CS50 Classroom / Classroom 50 as a possible GitHub Classroom replacement and integration target for the Novari Portal/LMS. The research plan was refined to cover integration and automation dimensions such as APIs, authentication, permissions, event flows, LTI, Git-related interfaces, pricing/limits, and whether a custom GitHub-based layer would be preferable.

The user opened Classroom50/Foundation50 from the research flow, authorized a GitHub OAuth application after a local authentication prompt, and started a GitHub Education Benefits application for Novari Education. They selected an organizational school email, filled school details, allowed location access, entered organization/course-provider details, and advanced the application. No final approval was observed.

GitHub Education later required additional proof. The user looked through local HiDrive/Finder company documentation, used Shottr while GitHub Education and ChatGPT were open, and asked ChatGPT for help with verification wording. They created a Google Docs proof document by copying an existing Novari document template, renamed it for employment/teaching verification, pasted and edited generated letter text, adjusted company-register wording, and prepared a second version. They exported PDFs, inspected one visually in Preview/PDFgear, added date/location text, and then tried to provide evidence to GitHub despite direct PDF upload apparently not working. No accepted upload or completed verification submission was captured.

The final segment returned to Classroom 50 research and Novari PR checks. The user asked ChatGPT for a shorter explanation of the long Classroom 50 research result, focusing on having created a Classroom 50 account, encountering an organization plan requirement, and trying to verify a GitHub account as a teacher to get appropriate access.

## Citations

- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T18-20-00-reWd-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T18-30-00-BgRA-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T18-40-00-qmIS-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T18-50-00-MrOC-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T19-20-00-qHeC-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T19-30-00-XOEs-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T19-40-00-npne-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T19-50-00-EDBw-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T20-30-00-alpY-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T20-40-00-mFOH-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T20-50-00-ZzjH-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-00-00-nGHU-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-10-00-RkXv-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-20-00-aRsz-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-30-00-xPCw-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T21-40-00-jJOJ-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-00-00-phyu-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-10-00-woUn-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-20-00-wcaQ-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-30-00-wOUa-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-40-00-QgQW-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T22-50-00-gIZj-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-00-00-Twuo-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-10-00-pdUi-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-20-00-nZKY-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-30-00-spkG-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-40-00-BqzH-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T23-50-00-bCte-10min-memory-summary.md