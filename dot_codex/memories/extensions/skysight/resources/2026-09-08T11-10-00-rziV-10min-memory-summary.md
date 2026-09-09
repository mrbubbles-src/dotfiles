---
title: Novari CI And MDX Follow-Up
description: You checked Novari curriculum context, GitHub notifications, CI failures, and the LMS follow-up issue created from the prior repair thread. The window ended on PR #41 after inspecting issue #42 about MDX link conversion tests.
applications: [com.openai.codex, com.google.Chrome]
---

## Memory summary

The user continued the Novari Education curriculum repair and LMS test-follow-up thread. They first sent Codex a German clarification asking whether “aktive Versionen” meant active curricula, then switched to Chrome to inspect the Novari portal topics context for the Fullstack Web Developer mit KI-Kompetenz draft curriculum version. They then worked through GitHub notifications and opened failed Code Quality workflow notifications for the related portal, backend, and LMS branches before inspecting LMS issue #42 about MDX link conversion tests and returning to PR #41.

### Relevant prior context

The immediately preceding summary shows this was a continuation of the Novari curriculum post-setup repair. The earlier thread had identified `Topic anzeigen` failures, 44 GitHub conflicts tied to missing internal version counters for curriculum version `6a736c4c63f0d9aa00ecf578`, and an unapplied production repair helper because local module loading in Compass had been rejected. Codex had also been clarifying employee access semantics for explicitly selected inactive or draft curriculum versions.

### Important non-obvious context about the user

- `portal.novari.education`: the user inspected the Novari portal topics page for the active curriculum work context.
- `fullstack-web-ki`: visible curriculum program type in the Novari portal query state.
- `curriculumTemplateId` `6a736c4c63f0d9aa00ecf576`: visible template ID for the inspected curriculum context.
- `curriculumVersionId` `6a736c4c63f0d9aa00ecf578`: visible version ID for the inspected draft curriculum context.
- `Fullstack Web Developer mit KI-Kompetenz · v1.0 · Entwurf`: visible selected curriculum version in the portal topics page.
- `Novari-Education/novari-education-portal`: GitHub notifications showed a failed Code Quality workflow for `codex/fix-curriculum-post-setup`.
- `Novari-Education/novari-education-backend`: GitHub notifications showed a failed Code Quality workflow for `codex/fix-curriculum-post-setup`.
- `Novari-Education/novari-education-lms`: GitHub notifications and follow-up inspection centered on PR #41 and issue #42.
- `codex/setup-recovery-error-details`: visible LMS branch associated with a failed Code Quality workflow.
- `__tests__/unit/lib/utils.test.ts`: issue #42 identified this LMS test file as the failing test surface.
- `replaceLinksWithModulesLinks`: issue #42 identified this utility as producing MDX link output involved in the failing assertion.

## Recording summary

### Codex Clarification

- At the start of the window, the user finished typing and submitted: `meinst du mit aktive versionen, aktive curricula?`
- The message was sent in the ChatGPT/Codex desktop app, apparently steering an ongoing Codex repair thread about the meaning of “active versions” in the Novari curriculum context.

### Novari Portal Context

- After a brief incidental Chrome tab switch, the user opened the Novari Education portal topics page.
- The visible page state was the Topics screen with a curriculum work context marked `Entwurf`.
- The selected course type and curriculum were `Fullstack Web Developer mit KI-Kompetenz`.
- The selected version was `Fullstack Web Developer mit KI-Kompetenz · v1.0 · Entwurf`.
- The page showed the curriculum navigation with `Curricula`, `Versionen`, `Strukturansicht`, review-desk entries, and a topics list with 42 visible item slots.

### GitHub Notifications And CI

- The user opened GitHub notifications and interacted with notification filters including participating and mentioned states.
- They opened or targeted several failed workflow notifications:
  - `Novari-Education/novari-education-portal – Code Quality #122` for `codex/fix-curriculum-post-setup`.
  - `Novari-Education/novari-education-backend – Code Quality #71` for `codex/fix-curriculum-post-setup`.
  - `Novari-Education/novari-education-lms – Code Quality #3` for `codex/setup-recovery-error-details`.
- The user opened the portal action run for `fix: restore curriculum viewing and post-setup recovery` at commit `c65a608`, then clicked the related `#204` link.
- They opened the backend action run for `fix: restore curriculum draft viewing and projection counters` at commit `247779e`, then clicked the related `#247` link.
- They opened the LMS action run for `fix: show safe actionable backend errors across LMS clients` at commit `1450547`, then clicked the related `#41` link.

### LMS PR And Issue Follow-Up

- The user opened LMS PR #41, titled `fix: show safe actionable backend errors across LMS clients`.
- From the LMS repository navigation, they went to the bug issue list and opened issue #42, titled `Tests: MDX-Linkkonvertierung und bestehende Assertion abgleichen`.
- Issue #42 described a failing full test suite at `__tests__/unit/lib/utils.test.ts`, where the test expected an HTML attribute literal while `replaceLinksWithModulesLinks` emitted a JSON-quoted JSX expression for MDX.
- The issue text stated that implementation and test were unchanged against feature base `073f145c80ce7964137c925b222d09724b91890c`, and that the discrepancy became visible around PR #41 without proving a product bug.
- The issue had labels including `bug` and `Priorität: Normal`, and no assignee was visible.
- Near the end of the window, the user clicked from issue #42 back to the mentioned merged PR #41.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T11-10-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T11-10-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T11-00-00-HBEh-10min-memory-summary.md