---
title: Classroom50 Spec And Backend Release Checks
description: You continued the Classroom50 integration research/spec thread, added annotations about task release timing and GitHub account mapping, and asked Codex to keep the work read-only. You also briefly checked Novari Portal logging, Render, GitHub repositories, and backend PR state while the GitHub setup fix thread remained visible.
applications: [com.openai.codex, com.google.Chrome, com.apple.dock]
---

## Memory summary

The user spent this window primarily in Codex, continuing the `Prüfe Classroom50-Recherche` thread for the `novari-education-backend` project. They added and reused annotations about how Classroom50 assignments should be released by the currently active teaching day, how extra tasks could be released similarly to existing topic/material release controls, and how personal repository assignment needs a verified Novari participant to GitHub account link. The user then dictated a follow-up asking Codex to remain read-only, review the annotations, and turn the accumulated research and discussion into a spec that emphasizes reuse of the existing large Novari system instead of rebuilding from scratch.

The user also briefly checked Novari Portal logging/profile areas, a Render dashboard for `novari-education-backend`, the `Fullstack-webdev-v1` GitHub repository list, and backend pull requests before returning to Codex. A separate `GitHub-Setup trotz Abweichungen` Codex thread was visible with branch `codex/fix-legacy-session-retry`, changes `+158 -17`, commit text `fix: resume legacy setup after an unchanged editor session rollover`, and a scheduled task named `GitHub-Fix: Main-PRs beobachten`.

### Relevant prior context

The immediately preceding 10-minute summary records that the user had been troubleshooting a failed Novari Portal GitHub legacy curriculum setup. The failure involved `GITHUB_LEGACY_MIGRATION_CONTEXT_CHANGED`, reference ID `79695b24-6d8e-4fb7-828f-795a3542018b`, and repository `fullstack-web-ki_curriculum`; Codex had identified an unchanged editor session rollover as the apparent cause and the fix was not yet live.

The prior summary also records the parallel Classroom50 research review. Codex had inspected existing Portal files and docs, proposed a dedicated Classroom50 backend area such as `libs/classroom50/`, and identified a first implementation spike involving a prepared class organization, two assignments, one participant, and a real Portal-to-LMS repository release path.

### Important non-obvious context about the user

- `Prüfe Classroom50-Recherche`: active Codex thread where the user is shaping a Classroom50 integration spec.
- `novari-education-backend`: Codex project and Render service name visible during the work.
- `codex/fix-legacy-session-retry`: visible branch in the separate GitHub setup recovery/fix thread.
- `fix: resume legacy setup after an unchanged editor session rollover`: visible commit/PR text for the setup recovery work.
- `GitHub-Fix: Main-PRs beobachten`: scheduled Codex task visible as running every 10 minutes.
- `Fullstack-webdev-v1`: GitHub organization whose repositories page the user briefly checked.
- `libs/classroom50/`: proposed backend area visible in the Codex response for a dedicated Classroom50 integration.
- `Backend dev 64ca928`, `Portal codex/setup-recovery-error-details b8eaa15`, `LMS 3988d9f`: visible commit/branch context from the Classroom50 research answer.

## Recording summary

### Classroom50 Research And Spec Preparation

- The window opened in Codex with a response-annotation note being edited. The note said tasks should initially be released for the teaching day currently active, using the existing indication of the current topic day as the anchor.
- The same annotation described keeping task availability limited by default, while allowing teachers to release more tasks for faster students in the same spirit as existing extra topic/material release controls.
- The user added that annotation to the response.
- The user selected another response passage stating that personal assignment needs a verified link between Novari participant and GitHub account; a freely entered username is insufficient, and the backend needs a confirmed GitHub user identity to track invitation acceptance and repository assignment.
- The visible Codex response section proposed a dedicated Classroom50 backend integration area, separate organization and permission mapping, preservation of existing curriculum release/version rules, and continued support for existing manual assignment links.
- The response also marked two open technical prerequisites: whether full organization/team automation is available and which write operations can be performed by a GitHub App versus requiring another token type.
- The user dictated a follow-up into Codex and sent it. The dictated request asked Codex to keep working read-only, review the three annotations, and draft a spec from the gathered research and discussion, with special emphasis on reusing or extending existing Novari components/backend structures wherever possible.

### Brief Portal, Render, GitHub, And PR Checks

- Chrome showed `Portal | Novari Education` on the logging-events area. The user opened the profile menu and briefly viewed tabs including overview, private data, and history. Personal details visible there are omitted.
- The user switched back to Codex, then later briefly clicked the Dock item for PDFgear; no PDFgear window or document work was captured.
- Chrome briefly showed a Render dashboard page for `novari-education-backend`; the visible deployment entry related to merging backend development work to main. The recording only supports that the user checked the deployment/release context, not that they changed it.
- The user briefly checked the `Fullstack-webdev-v1` repositories page and then a `Novari-Education/novari-education-backend` pull requests page, refreshing it once.
- The user returned to Codex and sent the dictated Classroom50/spec request, then reopened the `Prüfe Classroom50-Recherche` thread.

### GitHub Setup Fix Thread State

- A separate Codex thread titled `GitHub-Setup trotz Abweichungen` remained visible during the window.
- Its panel showed project state for `novari-education-backend`, branch `codex/fix-legacy-session-retry`, changes `+158 -17`, and commit text `fix: resume legacy setup after an unchanged editor session rollover`.
- The visible conversation stated the cause had been confirmed as an unchanged work state where reopening the editor increased the session counter and prevented resume.
- The same visible state said the fix was in Backend PR #245, checks and an independent review had passed, the automatic PR review was still running, and the fix was not yet live.
- The visible scheduled task list included `GitHub-Fix: Main-PRs beobachten` with an every-10-minutes cadence.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T01-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T01-20-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T01-10-00-qwSN-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T01-00-00-bfsW-10min-memory-summary.md