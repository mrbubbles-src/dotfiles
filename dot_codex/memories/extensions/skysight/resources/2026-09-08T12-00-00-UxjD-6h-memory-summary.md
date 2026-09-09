---
title: Novari repair, PR, and lead-process coordination
description: You worked across Novari production data checks, Codex review/fix coordination, portal lead-process checks, and website PR promotion. The main arc was moving curriculum and website fixes through review/merge workflows while checking production portal/database state.
applications: [com.mongodb.compass, com.openai.codex, com.google.Chrome, com.apple.mail, com.apple.Safari]
suggestion:
  type: skill
  name: Novari PR release coordination
  description: Turn my Novari PR review, merge, preview-check, and main-promotion flow into a reusable release coordination skill.
---

## Memory summary

The user spent the window coordinating several Novari Education workstreams. The largest thread was curriculum post-setup repair work across backend, portal, LMS, and MongoDB production data: they ran or prepared projection-counter repair dry runs in MongoDB Compass, followed Codex review findings on backend PR #247 and portal PR #204, and checked whether related fixes had landed on `dev` or the LMS feature branch. A second major thread was the Novari website mobile homepage/course-start fix: Codex prepared PR #64 to `dev`, PR #65 promoted the changes from `dev` to `main`, and the user clicked through GitHub’s merge flow for PR #65; the recording ended while GitHub still showed `Merging...`, so completion was not independently captured.

The user also inspected the production Novari portal’s `Lead-Prozess` and personnel navigation under different role contexts, comparing a website-origin lead record with a newly received direct inquiry email in Mail. No saved portal lead edit, email reply, issue update, or final database repair result was captured.

### Relevant prior context

Earlier same-day summaries indicate the Novari curriculum repair was already in progress before this 6-hour window. Prior work had identified 44 GitHub scan conflicts among 225 linked topics for curriculum version `6a736c4c63f0d9aa00ecf578`, attributed them to missing internal Mongoose version counters, and left production data unchanged after an earlier Compass module-loading attempt was blocked.

The broader curriculum-fix effort before this window involved restoring employee access to explicitly selected draft curriculum versions, fixing portal-to-LMS `Topic anzeigen` navigation after snapshot changes, and handling projection-counter repair for GitHub source operations.

### Important non-obvious context about the user

- `MongoDB Compass`: used for direct production inspection and `mongosh` repair execution.
- `novariEducationProdHorst`: production MongoDB Compass connection used for the repair dry runs.
- `novari_nexus`: database targeted by the projection-counter repair work.
- `/tmp/novari-projection-counter-repair.cjs`: initial CommonJS repair helper loaded into `mongosh`.
- `/tmp/novari-projection-counter-repair-bson-20260908.cjs`: BSON-adjusted repair helper used after the first dry run hit `BSONVersionError: Unsupported BSON version, bson types must be from bson 7.x.x`.
- `/tmp/novari-projection-counter-preflight-20260908-1206.json` and `/tmp/novari-projection-counter-preflight-20260908-1305.json`: preflight manifest paths used for non-applying repair attempts.
- `runMongoshProjectionCounterRepair` and `createMongoshCounterRepairAdapter`: repair helper exports confirmed in Compass.
- `Novari-Education/novari-education-backend` PR #247: backend curriculum draft viewing/projection counter fix PR; visible P2 findings concerned failed migration blocking behavior and topic-version mismatch handling.
- `Novari-Education/novari-education-portal` PR #204: portal curriculum viewing/post-setup recovery PR; visible state included P1 review threads and not-ready labels.
- `Novari-Education/novari-education-lms`: related LMS branch/PR state was checked; one GitHub pull request list showed no open matching LMS PRs for the current filter.
- `Novari-Education/novari-education-website` PR #64 and PR #65: website fix flow from `dev` PR to `main` promotion PR.
- `src/components/layout/general/landingpage/hero-section.tsx` and `src/data/course-data.tsx`: website files changed for mobile hero containment and course-start display.
- `codex/fix-curriculum-post-setup` and `codex/fix-mobile-hero-course-start`: visible Codex branches for the curriculum and website fix work.
- `portal.novari.education/lead-process`: production portal area inspected for interested leads, planned course starts, suitability appointments, and editable lead data.
- `Personaler` and `Geschäftsführung`: portal role contexts the user switched between while checking HR/personnel navigation and lead tools.
- Martin: collaborator mentioned by the user as possibly making concurrent `main`/`dev` changes, relevant to merge/reconciliation risk.

## Recording summary

### Curriculum repair and review coordination

- In MongoDB Compass, the user loaded `/tmp/novari-projection-counter-repair.cjs` in a `mongosh` session connected to `novariEducationProdHorst` and active database context `novari_nexus`.
- The helper exported `createMongoshCounterRepairAdapter` and `runMongoshProjectionCounterRepair`.
- The user invoked `runMongoshProjectionCounterRepair` with `apply:false`, scoped to curriculum version `6a736c4c63f0d9aa00ecf578`, repository integration `6a736c4d63f0d9aa00ecf5aa`, environment `production`, and manifest `/tmp/novari-projection-counter-preflight-20260908-1206.json`.
- Later Compass history showed that earlier dry run failed with `BSONVersionError: Unsupported BSON version, bson types must be from bson 7.x.x`.
- The user then loaded `/tmp/novari-projection-counter-repair-bson-20260908.cjs`, confirmed the same exports, and submitted another `apply:false` dry run using `shellEJSON:EJSON` and manifest `/tmp/novari-projection-counter-preflight-20260908-1305.json`.
- The recording does not capture the completed output of either non-applying repair run.
- In Codex, the user returned to the Novari curriculum-fix thread on `codex/fix-curriculum-post-setup`. Visible review monitoring reported backend PR #247 had two confirmed P2 findings and a high-review failure.
- The user submitted a German request to fix the P2 findings. The segment did not capture the resulting implementation.
- In Chrome, the user inspected portal PR #204. It still showed active agentic review feedback, two visible P1 review threads, labels indicating it was in agentic review and not ready to merge, and related tabs for backend PR #247 and LMS PRs.
- Later, the user asked Codex to check whether curriculum-related changes had already been merged to `dev` or the LMS feature branch, and to reconcile missing portal/backend pieces with possible concurrent commits by Martin.
- Codex visibly reported partial progress: portal PR #204 was checked and conflict-free, backend work still needed attention around `currentTopicId` comparison, and LMS was being checked separately because new remote commits had arrived.
- A later Chrome check of `Novari-Education/novari-education-lms` pull requests showed no open matching PRs for the current open/sorted filter.

### Portal lead-process and operational checks

- The user inspected `portal.novari.education/topics` for the `Fullstack Web Developer mit KI-Kompetenz` curriculum context; the visible page included GitHub source-check problems for linked topics.
- They switched portal role context from `Geschäftsführung` to `Personaler` and navigated through employee/personnel areas such as `Mitarbeiter Dokumente`, `Mitarbeiterverwaltung`, `Freigaben`, `Historie`, `Übersicht`, `Bewerber`, `Fortbildungsverwaltung`, and `Abrechnungswesen`.
- The `Bewerber` page showed a load failure rather than a populated applicant list.
- In `Lead-Prozess`, the user inspected an `Interessenten` table entry from the website inquiry channel, opened edit mode twice, and canceled both times. No saved edit was captured.
- The user switched to Apple Mail and reviewed a new direct consulting inquiry email that matched the portal lead entry. The summary omits personal details.
- In Mail, the user selected the applicant name text and used a Google search action, which briefly opened Safari. No useful search result or follow-up action was captured.
- A later Mail-only window showed the unified `Alle` mailbox selected with no specific message handling.
- The user later refreshed the production `Lead-Prozess` page with `Command+Shift+R`; no resulting data change was captured.

### Website PR and merge flow

- In Codex, the user worked on `novari-education-website` after a request about mobile homepage header buttons overflowing horizontally and the current course start needing to show `laufend`.
- Codex’s visible result said the mobile header had been corrected so graphics and buttons fit within screen width, and the course start was set to `laufend`.
- Visible verification said build, type checking, linting, browser-width checks, and independent review had passed; 375–1440 px had no horizontal overflow, while a separate 320 px overflow remained outside the corrected hero.
- The changed website files were `src/components/layout/general/landingpage/hero-section.tsx` and `src/data/course-data.tsx`.
- The user asked Codex to create a PR to `dev`, monitor review results, open issues for non-critical findings instead of fixing them immediately, merge to `dev` when ready, and prepare a later PR to `main` while leaving the `main` merge to the user.
- Codex opened website PR #64 to `dev`. Visible state said CodeRabbit was reviewing and Netlify preview access required team-owner approval; the user later indicated CodeRabbit did not matter for this workflow.
- In Chrome, the user opened website PR #65, a `dev -> main` promotion PR titled around releasing the mobile hero layout and ongoing course start. It showed 6 commits, 3 changed files, 41 additions, 3 deletions, one passing check, and label `[in Human Review]`.
- The user briefly opened and dismissed the PR Labels control with no captured label change.
- Later, the user copied a Codex link for PR #65, opened it in Chrome, checked related Novari repository pages, copied the PR body, and opened GitHub’s merge status panel.
- GitHub showed all checks passed, one successful check, no base-branch conflicts, and automatic merge available.
- The user clicked `Ready to merge`, `Merge pull request`, and `Confirm merge`.
- The final captured GitHub state was `Merging...`; the recording does not confirm the post-merge success state.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-00-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-10-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T12-50-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T13-00-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T13-10-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T13-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T13-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T17-30-00Z/events.jsonl
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T11-00-00-HBEh-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T11-20-00-skrO-10min-memory-summary.md