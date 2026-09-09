---
title: Novari release smoke checks
description: You checked GitHub Education status, deployment dashboards, and Novari Portal/LMS behavior after the main PR merge work. You confirmed LMS login worked, noticed an unexpected LMS course dropdown fallback, and dictated follow-up observations into Codex.
applications: [com.google.Chrome, com.openai.codex, com.microsoft.VSCode]
suggestion:
  type: skill
  name: Novari release validation
  description: Turn my Novari post-release checks across deploy dashboards, Portal, LMS, and Codex notes into a reusable validation skill.
---

## Memory summary

The user spent this window validating Novari-related state after earlier main PR merge work. They first checked a GitHub Education benefits page where an application was still pending, then opened Render and Netlify project/deployment dashboards in the Novari Chrome profile, and moved through Novari Portal and LMS pages to smoke-check authentication, curriculum navigation, and exam/topic areas. The most important captured outcome was a dictated Codex note: LMS access and existing-login behavior appeared to work, but the LMS dropdown still showed a generic `Web Development` course despite the user not expecting a course with that name; the user suspected a fallback when no active curriculum is available and wanted draft-visible curriculum/sidebar behavior considered. The same note also said previously visible `44 Prüfprobleme` appeared to disappear after a manual recheck.

### Relevant prior context

Immediately before this window, the user had completed manual Chrome merges for Novari backend PR `#252` and LMS PR `#44` into `main` after Codex had earlier reported the LMS main merge as blocked by auto-review. The earlier Novari PR coordination thread was titled `GitHub-Setup trotz Abweichungen`, in the Codex project `novari-education-backend`.

### Important non-obvious context about the user

- `com.google.Chrome`: used for GitHub, Render, Netlify, Novari Portal, and Novari LMS validation.
- `com.openai.codex`: used to continue the Novari backend Codex thread and dictate follow-up validation notes.
- `com.microsoft.VSCode`: briefly foregrounded on workspace `novari-education-lms-nova-pr-label`.
- `github.com/settings/education/benefits`: visible GitHub Education benefits settings page; status was still `Pending`, submitted about 22 hours earlier, application type `Faculty`.
- `dashboard.render.com/project/prj-d52ju8vpm1nc73eptoh0`: Render project dashboard opened in the Novari Chrome profile.
- `novari-education-portal`: visible Netlify project overview tab title during deployment/dashboard checking.
- `portal.novari.education`: production Portal domain used for validation, including dashboard, topics, self-learning assets, curriculum program types, and exam tests.
- `lms.novari.education`: production LMS domain used for validation; LMS login/session behavior appeared normal in the user’s dictated observation.
- `curriculumVersionId=6a736c4c63f0d9aa00ecf578`, `curriculumTemplateId=6a736c4c63f0d9aa00ecf576`, `curriculumProgramType=fullstack-web-ki`: query parameters visible during Portal/LMS curriculum-topic validation.
- `Web Development`: unexpected LMS dropdown label the user noticed and suspected might be a fallback.
- `Fullstack Web Developer mit KI-Kompetenz`: expected/selected Portal program label visible while checking topics.
- `44 Prüfprobleme`: issue count the user said was still visible before a manual recheck; the dictated note says the issues then disappeared.
- `codex/fix-curriculum-post-setup`: visible local branch in the Codex environment panel.
- `fix: restore curriculum draft viewing and projection counters`: visible commit/push label in Codex.

## Recording summary

### GitHub and deployment dashboards

- The segment metadata recorded 108 events from `2026-09-08T22:40:00Z` to `2026-09-08T22:50:00Z`, with 13 suppressed events.
- At `22:42:25Z`, Chrome showed GitHub settings at the Education benefits page. The page displayed a pending application submitted about 22 hours earlier, with application type `Faculty`.
- The user switched to a Novari Chrome profile/new tab and opened Render. Chrome moved through the public Render page, Render login redirect, and then a Render project dashboard at `dashboard.render.com/project/prj-d52ju8vpm1nc73eptoh0`.
- A Netlify project overview tab for `novari-education-portal` was visible in the tab switcher shortly after the Render check.

### Novari Portal and LMS smoke checks

- The user returned to `portal.novari.education/dashboard`, opened the role/work context menu, and interacted with a confirmation dialog for continuing in the visible Portal role context.
- The user navigated to Portal `topics`, then switched to the LMS tab at a module URL for `onboarding-und-it-grundlagen` with `curriculumVersionId=6a736c4c63f0d9aa00ecf578`.
- In the LMS, the visible program dropdown showed `Web Development`, and the page showed no content available. The user opened the module overview and returned between LMS and Portal pages.
- The user switched through Portal topics with query parameters for `fullstack-web-ki`, `curriculumTemplateId=6a736c4c63f0d9aa00ecf576`, and `curriculumVersionId=6a736c4c63f0d9aa00ecf578`.
- In Portal, the selected program label `Fullstack Web Developer mit KI-Kompetenz` appeared while checking the topics area.
- The user opened the curriculum navigation and clicked through `Kursarten`, then returned to the dashboard and topics.
- Near the end, the user opened Portal `self-learning-assets` and `exams/tests`. The exam tests page showed an empty state with no tests found.

### Codex and VS Code context

- The user switched to Codex around `22:44:33Z`, with the active thread `GitHub-Setup trotz Abweichungen` and project `novari-education-backend`.
- Codex sources showed connected entries for Netlify, Render, and GitHub. Scheduled tasks shown in the Codex sidebar included `Curriculum-Fixes: PR-Reviews beobachten` and `GitHub-Fix: Main-PRs beobachten`, both every 10 minutes.
- Codex’s environment panel showed no file changes, local branch `codex/fix-curriculum-post-setup`, and commit/push label `fix: restore curriculum draft viewing and projection counters`.
- VS Code was briefly foregrounded at workspace/window `novari-education-lms-nova-pr-label`; no code edits were captured.
- At `22:49:32Z`, the user dictated a Codex message summarizing validation findings: LMS access worked and the user was normally logged in, but the LMS dropdown showed `Web Development`, which the user did not recognize as an existing course. The user suspected a fallback tied to no active curriculum and described a desire for draft curriculum content to be visible in the LMS sidebar for users with access. The same dictated note said `44 Prüfprobleme` were still visible, then after a manual recheck the user observed them disappear.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T22-40-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T22-40-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T22-10-00-Iwri-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T21-50-00-yiLy-10min-memory-summary.md