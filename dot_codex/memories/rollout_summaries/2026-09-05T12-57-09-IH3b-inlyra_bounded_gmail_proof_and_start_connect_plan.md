thread_id: 01a071a4-ecb6-7c70-ab68-8e80400c4d91
updated_at: 2026-09-05T17:52:22+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T14-57-09-01a071a4-ecb6-7c70-ab68-8e80400c4d91.jsonl
cwd: /Users/mrbubbles/dev/private/projects/inlyra
git_branch: codex/inlyra-durable-card-decisions

# Inlyra live-source hardening, one-message proof, and connection-flow preparation

Rollout context: Work in `/Users/mrbubbles/dev/private/projects/inlyra`. The user resumed work from the canonical handoff, completed a bounded Gmail-session proof, then asked to prepare the normal startup and connection experience. No provider actions were executed.

## Task 1: Resume and harden the browser-boundary slice

Outcome: success

Preference signals:
- The handoff requires German UI text, umlauts, provider-neutral terminology, in-app Browser validation, and stopping after push/verification without provider actions -> preserve these defaults for future Inlyra work.
- The product goal remains “one card, explanation, proposed action, Composer, saved decision, next card” rather than an email client or admin dashboard.

Key steps:
- Verified branch `codex/inlyra-durable-card-decisions`, base/upstream `90209b4`, dirty worktree of 56 tracked plus 3 untracked files, nothing staged.
- Independent review found and fixed browser-boundary leakage of provider message/thread IDs and detailed State Doctor issues from digest/read responses.
- Approval plans now expose opaque server-keyed HMAC `approvalRef` values bound to exact card/action/kind/timestamp/provider target; provider targets stay in Node.
- Fixed Gmail-session login detection so it no longer scans `document.body.innerText`; it uses structural login signals and URL/origin checks.

Validation:
- Final local suite: 761 root tests passed, 39 UI tests passed.
- `npm run check`, `npm run format:check`, `npm run ui:lint`, and `git diff --check` passed.
- Independent reviews reported HIGH-REVIEW PASS and continuity aligned.

## Task 2: Execute the bounded Gmail-session proof

Outcome: success

Preference signals:
- The user explicitly accepted a one-message test and wanted the test task clearly treated as technical-only, not as an assessment of the email’s content -> future tests should use explicit bounded approval and distinguish technical completion from email/business completion.
- The user’s flow must remain local-only unless explicitly approved: no sending, archiving, deleting, marking read, or other provider actions.

Key steps:
- Used the paired Review UI and `/v1/review-read` with a maximum of one message.
- Final product run produced exactly 1 message, 1 saved card, and 1 newly visible card.
- A locally labeled Composer task persisted through Queue -> Working -> Done and survived reloads.
- The Gmail sweep was disabled again afterward.
- The task was deliberately described as a technical function test; the underlying security-warning email was not evaluated.

Reusable knowledge:
- State evidence showed one stable work-item identity with status history `queued`, `working`, `done`; final successful sweep metadata had `limit: 1`, `messagesSeen: 1`, `cardsCreated: 1`.
- No provider action occurred. Full-message analysis and automatic execution remain unproven/unimplemented.

## Task 3: Prepare the normal startup and connection flow

Outcome: partial

Preference signals:
- The user said “Ja, dann macht das nun” after being told the next step was a normal start/connection flow -> proceed toward implementation rather than repeating the live-mail test.
- The user selected the future deployed origin `https://inlyra.mrbubbles-src.dev`, but it is not deployed yet.
- The rollout explicitly avoids further mail reads while preparing startup/connection behavior.

Key steps:
- Read-only inventory found existing primitives for local UI, local-agent serving, pairing, same-tab `sessionStorage` restoration, Gmail readiness probes, and LaunchAgent planning.
- Added `docs/start-and-connect-plan.md` and linked it from README/Changelog.
- Plan scope: local starter first, reconnect an already configured Gmail-session account, then deployed-origin pairing after deployment and synthetic browser validation.
- Documented that existing LaunchAgent modules schedule sweeps and must not be reused unchanged as a normal agent server starter.

Failures and how to do differently:
- No implementation of the starter or connection dialog was completed; the task ended at a reviewed plan. Future continuation should begin with the local starter implementation, not another exploratory inventory.
- Deployed direct pairing is currently blocked by loopback-only CORS and the absence of a deployed HTTPS site. Do not add wildcard CORS or bypass browser security.

References:
- Canonical handoff: `docs/codex-handoffs/2026-06-22-inlyra-card-first-continuation.md`
- New plan: `docs/start-and-connect-plan.md`
- Live-test evidence: `docs/gmail-test-preparation.md`
- Local agent architecture: `docs/local-agent-session-architecture.md`
- Current local agent server entry: `apps/local-agent/src/cli/run-local-agent-serve.ts`
- Loopback-only origin check: `packages/local-agent-runtime/src/local-agent/server/http.ts:isAllowedCorsOrigin`
- Product contract: `docs/product.md`, `docs/contract.md`, `docs/local-review-ui.md`
