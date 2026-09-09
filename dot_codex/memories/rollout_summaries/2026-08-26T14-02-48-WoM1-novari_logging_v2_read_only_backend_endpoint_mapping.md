thread_id: 01a03e61-6fab-7050-adca-75daabb15c51
updated_at: 2026-08-26T14:14:18+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T16-02-48-01a03e61-6fab-7050-adca-75daabb15c51.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/6e27/novari-education-backend

# Read-only Logging-V2 endpoint mapping completed

Rollout context: Fresh investigation in JavaScript repository `/Users/mrbubbles/.codex/worktrees/6e27/novari-education-backend`, requested baseline `5b95632051b649a742ad3309ff9b01a080bc90e5` on `chore/logging-improvements`. No edits, tests, formatters, processes, commits, pushes, delegation, or Git mutations were performed. The checkout was detached but exactly matched the local and remote branch tip; the working tree was clean.

## Task 1: Map Logging-V2 producers to real Portal/LMS endpoints

Outcome: success

Preference signals:

- The user required a “READ-ONLY” mapping, “keine Edits, Tests, Formatter, Prozesse, Commits, Pushes oder Git-Mutationen” and a fresh independent context -> future reviews should verify baseline and stop gates before investigation, avoid implementation, and report unperformed validation honestly.
- The user required an exact producer/contract matrix, explicit persistence yes/no, natural error prerequisites, security-event discoverability, and only concrete non-deterministic cases -> future analyses should distinguish HTTP response logging from persisted audit/security events and avoid treating every 5xx as a persisted event.
- The user required a minimal Production-Allowlist and hard stop-gates for any later temporary injection -> future implementation plans should keep the default allowlist empty and use narrowly gated, removable Dev-only mechanisms.

Key steps:

- Verified `HEAD`, branch reference, baseline cleanliness, and `origin/dev` comparison; confirmed the branch contains the Logging-V2/error-boundary changes and relevant tests/docs.
- Read `AGENTS.md`, `docs/project-docs/security/logging-policy.md`, and `docs/project-docs/platform/error-responses-and-debugging.md` as the current contract sources.
- Mapped real routes, role gates, controller behavior, global error ownership, audit middleware, Security Event list/export routes, GitHub inventory/scan flows, WorkRevision routes, document/PDF paths, calendar wrappers, Socket.IO acknowledgements, and certificate flows.

Important matrix conclusions:

- Shared HTTP envelope is `{error:{code,message,requestId}}`; `X-Request-Id` and `Date` are browser-readable. Invalid public codes fall back to `REQUEST_FAILED` for 4xx and `INTERNAL_ERROR` for 5xx.
- Exactly one schema-V2 support event is persisted: `GET /auth/lms/github-curriculum/program-types/:programTypeId/repository/inventory`, role `pdl`/`lmsSupport`, exact `503 GITHUB_SYNC_CONNECTION_FAILED`. It is a bounded `request.error` event with fixed category/severity/application/action, UUID/eventId, validated requestId, optional HMAC actor hash, safe environment/release/fingerprint, and best-effort single-attempt persistence. Persistence failure does not alter or delay the original response.
- `/auth/security-events` is role-gated to `lmsSupport`, `LmsSupport`, or `admin`. List/refresh/filter operations do not create success audit rows. Exact `requestId` searches remain ungrouped; grouping requires `view=groups`, repeated V2 events, and a valid inclusive maximum 30-day UTC window. List-only filters are `category=error`, `severity=error`, `application=Backend`, and `code=GITHUB_SYNC_CONNECTION_FAILED`; these do not carry over to exports.
- WorkRevision Patch target-not-found, Patch conflict, and Review-readiness errors expose only their documented bounded details; they are not persisted as Security Events. Relevant routes are under `/auth/lms/curriculum-versions/:versionId/work-revisions/...` and require `pdl`/`lmsSupport`, with PDL-only decision/publish actions.
- GitHub issue projection is reachable through scan/job routes and only exposes fixed `severity`, `title`, `description`, `nextStep`, `actions`, and `code`; source metadata and nested request IDs are removed.
- Document, module, profile, calendar, Socket.IO, Jobcoach/Freelancer timesheet, PDF, and generic controller failures are centrally logged/returned safely but are intentionally not persisted as V2 Security Events. Successful sensitive reads/downloads/writes retain their existing audit behavior.
- The Gateway itself has `/health`, `/calendars`, `/events/list`, and `/events/insert`; unexpected failures use a static `500 INTERNAL_ERROR` envelope without requestId. Portal/LMS only see the backend wrapper’s safe `UPSTREAM_FAILURE` contract.
- Self-Absence retains direct legacy 400 responses for Multer/file-type validation only; other router errors go to the global owner.
- Generated PDF streams (`GET /auth/hardware/student/:studentId/pdf`, `GET /auth/risks/overview/pdf`) use the shared stream lifecycle: pre-byte failure can become safe JSON, post-byte failure aborts the connection, and early client close only destroys the source. Freelancer and Jobcoach PDFs are HiDrive reads via `streamPdfFromHiDrive`, not generated streams.
- Certificate completion keeps HTTP 200 and reports per-participant `CERTIFICATE_GENERATION_FAILED`; that contained failure writes a Legacy `event=certificate`, `action=issued`, `outcome=failure` event. Certificate correction writes a Legacy success audit event.

Failures and how to do differently:

- P2 documentation mismatch: `logging-policy.md` and `error-responses-and-debugging.md` describe Freelancer PDF as part of the shared directly generated PDF stream, but `controller/freelancerTimesheets/pdf.controller.js` still reads the approved PDF exclusively from HiDrive. Future test plans must model Freelancer PDF as a storage-read failure, not a PDF-generation/stream-render failure; the documentation should be corrected in a separately authorized task.
- Do not infer that a stdout `request.error` implies MongoDB Security Event persistence. Persistence is restricted to the exact GitHub inventory connection-failure allowlist.
- Do not use invalid branch selection to test the V2 support event: it produces `GITHUB_CURRICULUM_BRANCH_NOT_FOUND`, not `GITHUB_SYNC_CONNECTION_FAILED`.
- The Gateway’s inner error contract cannot be meaningfully surfaced unchanged through Portal/LMS because the backend wrapper intentionally translates it.

Reusable knowledge:

- For future read-only Novari Logging-V2 reviews: verify exact checkout baseline/branch tip and clean status; read current `AGENTS.md` plus current logging/error docs; enumerate real routers/controllers; map each producer to roles, prerequisites, response, persistence, and search path; then identify only genuinely non-deterministic cases.
- Default temporary test surface requires no backend production change: existing Portal/LMS endpoints are sufficient for normal deterministic coverage.
- If full failure injection is later approved, the maximum identified production allowlist is `_lms/controller/githubCurriculumRepositoryInventoryController.js`, `controller/hardwareController.js`, `sockets/socketServer.js`, and `_classManager/controller/certificateCompletionController.js`; the Gateway file is only relevant to a direct Gateway test. Every injection must require both `NODE_ENV=development` and an explicit fixed scenario flag/value, preserve auth/CSRF/roles, perform no mutation or external call before failure, and be removed or provably unreachable in production.
- Hard stop conditions include any scope expansion, new endpoint/BFF/event store/parallel server, changed success contract, retry, new persistence category, client-selectable error payload, or altered response ownership.

References:

- Baseline: `5b95632051b649a742ad3309ff9b01a080bc90e5`; `origin/dev`: `004b629950599df0a324088ac64403732d1db432`.
- Contract docs: `docs/project-docs/security/logging-policy.md`; `docs/project-docs/platform/error-responses-and-debugging.md`.
- Global boundary: `error/globalErrorHandler.js`; shared sender: `error/httpError.js`; audit store: `libs/observability/auditStore.js`; logger/support persistence: `libs/observability/logger.js`.
- Security Event routes/controller: `router/securityAuditRouter.js`; `controller/securityAuditController.js`.
- Exact V2 producer: `_lms/controller/githubCurriculumRepositoryInventoryController.js`; route `/auth/lms/github-curriculum/program-types/:programTypeId/repository/inventory`.
- PDF distinction: `controller/freelancerTimesheets/pdf.controller.js` uses `streamPdfFromHiDrive`; generated stream helper is `controller/pdfController/pdfGeneratorCore.js`.
- Verification evidence: detached HEAD exactly matched `refs/heads/chore/logging-improvements` and `remotes/origin/chore/logging-improvements`; no tests were run because the user explicitly prohibited them.
