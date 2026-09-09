thread_id: 01a0507c-91be-7fd2-9414-51eb82c7f70e
updated_at: 2026-08-30T02:35:01+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-25-36-01a0507c-91be-7fd2-9414-51eb82c7f70e.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# A2 CloudRun calendar Logging V2 review passed

Rollout context: Read-only independent high-review of the frozen uncommitted candidate in `/Users/mrbubbles/.codex/worktrees/4fbb/novari-education-backend`, compared with baseline `712cf7f0b67beab821fc3f0ccb21fe5f3cec62ce`.

## Task 1: Review A2 calendar-read support-event candidate

Outcome: success

Preference signals:
- The user required a “vollständigen findings-first Baseline→Kandidat-Diff-Review”, strict read-only behavior, no subagents, exact allowlists, and no commit/push -> future reviews should establish and preserve an immutable freeze before source analysis and report findings before summaries.
- The user repeatedly required the “kleinsten” coherent slice, explicit unchanged flows, and fail-closed stopping on scope drift -> do not broaden Logging V2 reviews into adjacent product, matrix, or infrastructure work.
- The user explicitly distinguished request-local “höchstens ein persistiertes Ergebnisereignis” from exactly-once guarantees -> preserve this wording and do not infer cross-request deduplication or exactly-once infrastructure.

Key steps:
- Verified main checkout branch/HEAD/upstream/direct remote and clean `0/0` state.
- Verified candidate detached at the same baseline with exactly seven unstaged allowlist files and no staged/untracked files.
- Recomputed canonical full-index diff hash and stable patch ID; both matched expected values.
- Reviewed production changes, unchanged global error/auth/CSRF/role/controller/store paths, and all four modified test files.
- Confirmed the private server-side marker is applied only after role authorization and immediately before the three controllers.
- Confirmed exact matching for GET, router-relative route template, normalized 500/`INTERNAL_ERROR`, valid request ID, and request-local at-most-one persistence.
- Ran the focused suite on an identical disposable copy with dependencies: `167/167` passed. Relevant regressions: `106/106` passed. Full repo ESLint, allowlist ESLint, syntax checks, and `git diff --check` passed.
- Removed the disposable copy and reverified candidate identity and cleanliness.

Failures and how to do differently:
- The isolated candidate initially lacked `node_modules`; direct tests failed with missing `express`, `mongoose`, and `webdav`. A disposable copy linked to the main checkout dependency tree enabled validation without mutating the candidate.
- Initial sandboxed router tests failed because local test servers could not bind (`listen EPERM`); rerunning the disposable tests with approved elevated execution produced `167/167` passes.
- The Codex Security Workbench diff scan did not start because it reported `Working-tree contents changed after they were selected`. No replacement scan was claimed; this remains an unrun external plugin pass.
- Canonical hashing requires `git diff --binary --full-index <baseline> | shasum -a 256`; omitting `--full-index` can change the digest.

Reusable knowledge:
- A2 adds three fixed contracts: `calendar_agenda_events_read` / `controller.calendar.agenda`, `calendar_absence_events_read` / `controller.calendar.absence`, and `calendar_course_events_read` / `controller.calendar.course`, all under `area=calendar`.
- The matcher excludes health, calendar-list, success, controlled 400/403, structured 502, role/auth/CSRF denials, headers-sent responses, wrong markers/templates/methods, gateway, cron, and lookalikes.
- Persisted V2 events contain only fixed safe fields plus valid request ID and optional existing actor HMAC; no target hashes, raw error text, query/calendar/provider/URL/ID data are persisted.
- Global error handling and audit-store ownership remain unchanged; store failures are best-effort with no retry or response mutation.

References:
- Baseline: `712cf7f0b67beab821fc3f0ccb21fe5f3cec62ce`
- Candidate diff SHA-256: `e7e4ab294f50a4fc5eada23494f85b28ebaccf6a272647c3b49bbfd96e97ebec`
- Stable patch ID: `b151925855b122bdad54ef217e3357d695f17935`
- Production files: `libs/observability/logger.js`, `models/audit/securityAuditEventSchema.js`, `router/cloudrun-health.js`
- Tests: `tests/error/globalErrorHandlerPersistence.test.js`, `tests/observability/logger.test.js`, `tests/observability/auditStore.test.js`, `tests/calendar/cloudRunErrorProjection.test.js`
- Final verdict: `HIGH-REVIEW PASS`, no P0–P3 findings; no edits, staging, commit, or push.
