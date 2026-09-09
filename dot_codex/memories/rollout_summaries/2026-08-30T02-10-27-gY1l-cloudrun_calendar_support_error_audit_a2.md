thread_id: 01a0506e-b35a-7950-935e-00b718e6d683
updated_at: 2026-08-30T02:38:07+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-10-27-01a0506e-b35a-7950-935e-00b718e6d683.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/4fbb/novari-education-backend

# Implemented and shipped fail-closed CloudRun calendar support-error auditing

Rollout context: In `/Users/mrbubbles/.codex/worktrees/4fbb/novari-education-backend`, A2 added only the approved Logging-V2 support events for the three role-dependent CloudRun calendar reads. The baseline was `712cf7f0b67beab821fc3f0ccb21fe5f3cec62ce`; no subagents were used.

## Task 1: Implement CloudRun calendar support-event persistence

Outcome: success

Key steps:
- Added a private `Symbol.for('novari.observability.router-owner.cloudrun-calendar-reads')` marker in `router/cloudrun-health.js`, placed after successful role authorization and immediately before each controller.
- Added exactly three fixed producer contracts in `libs/observability/logger.js`:
  - `calendar_agenda_events_read` / `controller.calendar.agenda`
  - `calendar_absence_events_read` / `controller.calendar.absence`
  - `calendar_course_events_read` / `controller.calendar.course`
- Matching requires the server marker, `GET`, exact router-relative route template, final normalized `500 INTERNAL_ERROR`, and a valid request ID. Persistence remains request-local and best effort; store failures do not retry or alter responses.
- Added the three exact schema-V2 contracts and route enum values in `models/audit/securityAuditEventSchema.js`.
- Tests covered real router→controller→global-handler flows, one-event suppression, same-request-ID separation, privacy/size/HMAC constraints, store failures, headers-sent behavior, controlled 400/403/502 outcomes, health/list routes, wrong markers/methods/templates, lookalikes, and role-denial audit ownership.
- Initial sandboxed router tests failed only because binding to `127.0.0.1` returned `EPERM`; rerunning with authorized network access passed.
- A schema test initially exposed a missing route enum; adding the enum values fixed it. A review also identified that marking before role validation could contaminate rejected requests; moving the marker after `requireAnyRole` made the boundary structurally fail closed.

Validation:
- Focused suite: `167/167` passed.
- Relevant regression suite: `106/106` passed.
- Full repo ESLint and changed-file ESLint passed.
- `node --check` passed for all seven changed files.
- `git diff --check` passed.
- Local code review and separate high-review reported no P0–P3 findings.

Files changed: exactly seven allowlisted files: three production files and four test files. Controllers, `app.js`, global handler, audit store, auth/CSRF, responses, roles, gateway, cron, docs, and specs remained unchanged.

## Task 2: Commit and push the frozen candidate

Outcome: success

- Commit: `a19f3300c79793f076b9e105c6d2bae3d16e95ca`
- Parent: `712cf7f0b67beab821fc3f0ccb21fe5f3cec62ce`
- Message: `feat: persist CloudRun calendar support errors`
- Push: normal `git push origin HEAD:chore/logging-improvements`; no amend, force, rebase, or squash.
- Post-push HEAD, local tracking ref, and direct remote ref all matched `a19f3300c79793f076b9e105c6d2bae3d16e95ca`; divergence was `0/0` and the worktree was clean.
- Frozen diff SHA-256: `e7e4ab294f50a4fc5eada23494f85b28ebaccf6a272647c3b49bbfd96e97ebec`.
- Stable patch ID: `b151925855b122bdad54ef217e3357d695f17935`.
