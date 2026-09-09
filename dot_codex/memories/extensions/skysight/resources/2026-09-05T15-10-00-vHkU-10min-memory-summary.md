---
title: Inlyra one-email test passed
description: You returned to the Inlyra Codex thread after the bounded Gmail-session test. The local review UI showed a real message saved as a Done card, with the queue workflow and reload persistence reported as passing.
applications: [com.openai.codex]
---

## Memory summary

The user was in ChatGPT/Codex on the `Inlyra fortsetzung` thread for project `inlyra`, reviewing the result of the authorized Inlyra Gmail-session live test. The Codex thread reported that the one-email test passed: a real message was saved as a local card, the Composer to Queue to Working to Done flow worked through reload, and 761 tests plus 39 UI tests and code review passed. The visible local Inlyra Review UI at `127.0.0.1:5173` showed `Done 4` and a local Done card with retained decision history; additional mail runs were paused, and the next stated work was preparing the normal startup and connection flow without the manual test steps.

### Relevant prior context

The earlier Inlyra summary from 2026-09-05T14:50 established that the separate-browser Gmail login recognition had been repaired, and that the user had authorized a bounded read-only live test involving at most one unread Gmail message with no sending, archiving, deleting, or marking as read. It also showed the Inlyra Review UI at `127.0.0.1:5173` and the active branch `codex/inlyra-durable-card-decisions`.

### Important non-obvious context about the user

- `com.openai.codex`: the only observed application in this window; the user was working in a Codex project thread with an embedded web preview.
- `Project: inlyra`: active Codex project visible during the test-result review.
- `Inlyra fortsetzung`: active thread where the Gmail-session test result and next work were discussed.
- `codex/inlyra-durable-card-decisions`: active local branch shown in the Codex environment panel.
- `127.0.0.1:5173`: local Inlyra Review preview open inside Codex.
- `Inlyra Review`: embedded preview tab displaying the local Inbox/Done workflow state.
- `personal-gmail-session` and `acct_personal_gmail_session`: source/account identifiers visible on the local Done card; they matter for continuing the Gmail-session integration context.
- `decision_55d121c570f7ffadca21368f`: visible local decision id for the Done card in the review UI.

## Recording summary

At 15:18Z, the only captured event was a ChatGPT/Codex window snapshot. The Codex sidebar showed several project threads, with `Inlyra fortsetzung` selected under project `inlyra`. The visible conversation showed the prior login setup and repair sequence, then the user’s authorization for the one-email test. The latest visible result said the one-email test had passed: one real message was saved as a card, the Composer to Queue to Working to Done state sequence worked including reload, and 761 tests plus 39 UI tests and code review passed.

The same result message stated that the local preview remained open, further mail runs were paused, and `Done` referred only to the function test rather than any substantive evaluation of the message content. The next work identified in the thread was preparing the normal Inlyra startup and connection flow: opening Inlyra, connecting the local agent, and using Gmail login only when needed, without the manual test steps used during this session.

The Codex environment panel showed a large uncommitted diff count, the local branch `codex/inlyra-durable-card-decisions`, and three background terminals. In the embedded browser preview, the Inlyra Review app was open at `127.0.0.1:5173`. The UI showed `Inbox`, `To review 0`, `Queued for Codex 0`, `Working 0`, and `Done 4`. A Done card displayed local decision history, “no provider action” status, source metadata for the Gmail session, and the decision id `decision_55d121c570f7ffadca21368f`.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-05T15-10-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-05T15-10-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-05T14-50-00-DRIj-10min-memory-summary.md