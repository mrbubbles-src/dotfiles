---
title: GitHub Legacy Setup Debugging
description: You hit a Novari Portal GitHub curriculum setup failure, handed the support details to Codex, and checked logging/database context while Codex investigated. You also continued a separate Classroom50 integration research thread and annotated architectural points about task/master mapping and LMS release behavior.
applications: [com.google.Chrome, com.openai.codex, com.mongodb.compass]
---

## Memory summary

The user was troubleshooting a failed Novari Portal GitHub legacy curriculum setup for `Fullstack Web Developer mit KI-Kompetenz` after the existing-repository setup flow rejected the confirmed curriculum state. The captured support details included `GITHUB_LEGACY_MIGRATION_CONTEXT_CHANGED`, reference ID `79695b24-6d8e-4fb7-828f-795a3542018b`, area `Bestätigen der GitHub-Legacy-Migration`, and timestamp `2026-09-08T01:09:59.000Z`. The user sent that failure context to Codex in the `GitHub-Setup trotz Abweichungen` chat, asked that local `dev` and `main` be updated after merges, switched the Portal role to LMS Support, opened Portal logging events, attached a screenshot of the event, and briefly used MongoDB Compass against a production-named connection.

In parallel, the user continued reviewing a separate Codex `Prüfe Classroom50-Recherche` response. They selected and added annotations around a proposed Classroom50 architecture: connecting an assignment master to course types/curriculum versions, giving each task an explicit teaching-day mapping, creating class-level Classroom50 setup state, extending existing task release behavior, and distinguishing LMS weekly content release from future per-task GitHub releases.

### Relevant prior context

The immediately preceding 10-minute summary records that the user had just finalized the `fullstack-web-ki_curriculum` existing-repository setup flow in Novari Portal. The prior window ended while `Einrichtung wird abgeschlossen` was visible, so this window captured the resulting failure and the start of a focused recovery/debugging thread.

The prior summary also records the broader context: recent backend and Portal release PR work had been merged or prepared, Portal PR #203 monitoring had been stopped for a manual merge, and the user had been working through GitHub curriculum repository setup for the Fullstack Web Developer course.

### Important non-obvious context about the user

- `GITHUB_LEGACY_MIGRATION_CONTEXT_CHANGED`: concrete Portal setup failure code being debugged.
- `79695b24-6d8e-4fb7-828f-795a3542018b`: reference ID copied from Portal support information and selected again in Codex.
- `fullstack-web-ki_curriculum`: repository involved in the failed curriculum GitHub setup.
- `novari-education-backend`: Codex project used for the setup-failure debugging chat.
- `codex/fix-legacy-session-retry`: branch visible in Codex during the fix thread, with a `Create pull request` action visible near the end of the recording.
- `novariEducationProdHorst/Shell`: MongoDB Compass connection/window used while investigating the failure.
- `curriculumTemplates`: visible Compass search value during the database-side investigation.
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/components/lms/github-classroom-assignments/TeacherGithubClassroomAssignmentsPage.tsx`: Codex inspected this file in the Classroom50 research thread.
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/components/dashboard/course/addCourseModal.tsx`: Codex inspected this file for class/course setup context.
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/types/teaching-plans.ts`: Codex inspected this file for teaching-plan/task mapping context.
- `docs/project-docs/curriculum/github-curriculum-topic-sources.md`: Codex inspected this documentation while reasoning about curriculum topic sources.

## Recording summary

### GitHub Curriculum Setup Failure

- At the start of the window, Chrome showed Novari Portal on `Kursarten` with `Fullstack Web Developer mit KI-Kompetenz`; the `fullstack-web-ki_curriculum` repository connection still displayed setup in progress.
- The user clicked `Support-Information kopieren`, then switched to the Codex desktop app and opened the `GitHub-Setup trotz Abweichungen` chat.
- The support information pasted into Codex described a rejected GitHub legacy migration confirmation, with error code `GITHUB_LEGACY_MIGRATION_CONTEXT_CHANGED`, reference ID `79695b24-6d8e-4fb7-828f-795a3542018b`, and timestamp `2026-09-08T01:09:59.000Z`.
- Codex reported it was investigating the reference ID and the current code to determine what changed the confirmed working state and whether the new failure related to the recent fixes.
- The user told Codex that `dev` and `main` should be pulled locally after merges; Codex then showed a command pulling `main` and switching back to `dev`.
- The user switched the Portal working role toward LMS Support, opened Portal logging events, and attached an event screenshot to the Codex thread.
- Codex’s visible task panel later showed sources including Codex App Tools, Render, and MongoDB Atlas, and a commit/push area referencing `fix: release legacy setup recovery and actionable backend errors`.
- Near the end, the same Codex thread showed branch `codex/fix-legacy-session-retry` and a visible `Create pull request` action, but no PR creation or merge outcome was captured in this window.

### Database And Logging Check

- The user opened MongoDB Compass in a window titled `MongoDB Compass - novariEducationProdHorst/Shell`.
- The Compass sidebar/search field showed `curriculumTemplates`, suggesting the user was looking at or searching curriculum template data while debugging the setup failure.
- Several keyboard inputs/shortcuts occurred in Compass, but the exact query text or database output was not visible in the captured accessibility data.

### Classroom50 Research Thread

- The user switched to the Codex `Prüfe Classroom50-Recherche` chat in the `novari-education-backend` project.
- Codex was visibly inspecting Portal files and docs, including the teacher GitHub Classroom assignments page, course creation modal, teaching plan types, and curriculum topic source documentation.
- The user selected and added response annotations around the proposed assignment-master architecture: tying an assignment source to course type/curriculum version, storing explicit task IDs and teaching-day mappings, using `overviewRowId`, `orderIndex`, and `exerciseLinks` as existing anchors, and freezing a task state for new classes so later master changes do not alter running classes unexpectedly.
- The user also selected and annotated a later section noting that existing LMS content is released weekly, while future task distribution should reuse calendar/holiday calculations but have separate per-task release timing.
- The visible response also emphasized that current task management stores links and does not unlock anything in GitHub, and that a verified participant-to-GitHub-account relationship would be needed for personal repository assignment.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T01-10-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T01-10-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T01-00-00-bfsW-10min-memory-summary.md