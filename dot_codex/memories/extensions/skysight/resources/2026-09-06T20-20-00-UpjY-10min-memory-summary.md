---
title: Novari PR Review Coordination
description: You checked Novari backend and portal PR review status, then asked Codex/ChatGPT whether the remaining findings were serious and whether fixes were already underway. You also reacted to usage consumption after a reset and pushed back on redundant review loops while PR review was already active.
applications: [com.google.Chrome, com.openai.codex, com.logi.cp-dev-mgr]
---

## Memory summary

The user continued coordinating Novari Education backend and portal PR review work. They inspected GitHub PRs for `novari-education-portal` PR #185 and `novari-education-backend` PR #219, then switched into Codex and a ChatGPT project conversation titled `Novari Education - Testfläche neu verdrahten` to ask about the remaining review findings. The active state was that backend and portal review findings were still being worked through; several packages were reportedly already fixed, independently checked, and pushed, while at least one management-review/KPI-related issue remained more serious and a separate invoice accept/reject extension was waiting on explicit approval. The user was concerned that repeated review cycles and long-running PR work were consuming usage quickly after a reset.

### Relevant prior context

The preceding Skysight summary shows the user had just been coordinating Novari PR-state label and AGENTS.md guidance. `Ready to Merge` had been clarified as a readiness status rather than merge authorization, with main-branch merges remaining manual through the shared Novari account. Prior context also showed Novari work split across `novari-education-backend`, `novari-education-portal`, `novari-education-lms`, and `novari-education-website`, with backend and portal PRs as the active review focus.

### Important non-obvious context about the user

`Novari-Education/novari-education-portal` PR #185: active portal PR under review; visible P2 findings included a KPI period/date boundary issue in `src/components/dashboard/qualityManager/QmKennzahlenPanel.tsx` and an expired setup-token recovery issue in `src/components/auth/LoginPage.tsx`.

`Novari-Education/novari-education-backend` PR #219: active backend PR under review; visible status showed external automated review trouble due to the PR size, while the ChatGPT/Codex workflow still tracked backend findings and tests.

`Novari Education - Testfläche neu verdrahten`: Chrome ChatGPT project conversation used for coordination/status questions about the backend and portal PR review work.

`com.openai.codex`: the user also used the Codex desktop app to ask whether remaining findings were severe and whether they were already being fixed.

`Martin`: current and prior context indicate some account/email/password/onboarding findings were being gathered as a Martin handoff rather than handled in the active implementation block.

## Recording summary

### GitHub PR Inspection

At the start of the captured activity, Chrome showed `novari-education-portal` PR #185. The visible review area included two P2 portal findings from `chatgpt-codex-connector`: one around preserving KPI period UTC calendar boundaries in `src/components/dashboard/qualityManager/QmKennzahlenPanel.tsx`, and one around password-setup recovery when first-login/setup tokens are expired, invalid, or already consumed in `src/components/auth/LoginPage.tsx`.

The user then switched to `novari-education-backend` PR #219 and refreshed. The backend PR page showed commit and merge history, an automated review status indicating review was skipped because the PR exceeded the file-count limit, and an active reviewer area showing the `chatgpt-codex-connector` review as still in progress or recently active.

### Codex And ChatGPT Coordination

The user moved to the Codex desktop app and typed a German question asking why findings were still being found, whether the remaining issues were serious, and whether the work should not already be finished. The visible response in the ChatGPT/Codex conversation characterized several remaining items as small but noted one more serious open issue involving management evaluations remaining confirmed after underlying KPI values change. It also stated that recently investigated findings mostly existed already rather than being newly introduced by the current changes.

The user then asked whether those issues were already being fixed. The visible response said fixes were already underway, with several packages finished, independently reviewed, and pushed. It described backend invoice corrections as largely implemented with targeted tests passing and awaiting broader final testing/review; portal corrections for missing KPI values and incorrect date displays as currently being implemented; and an invoice accept/reject extension as still waiting on the user's approval.

### Resource And Review-Loop Friction

After switching to the Chrome ChatGPT project conversation, the user typed that they had already needed another reset, that the process was still on the PRs, and that 19% usage had already been consumed after the reset. They also sent a message objecting to an additional review when the PR reviewer was already checking the work. This was part of active coordination/friction around the ongoing Novari PR review workflow, not a completed implementation step.

At the end of the window, the user clicked a Logi Options+ radial menu mute toggle.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T20-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T20-20-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T18-30-00-FtTH-10min-memory-summary.md