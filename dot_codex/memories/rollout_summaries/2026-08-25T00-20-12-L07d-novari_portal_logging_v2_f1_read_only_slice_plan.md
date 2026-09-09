thread_id: 01a03649-f899-7643-bffb-c69470857d37
updated_at: 2026-08-25T00:33:05+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T02-20-12-01a03649-f899-7643-bffb-c69470857d37.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only plan for six confirmed Novari Portal Logging V2 F1 blocker groups

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, baseline `84facf6400a1d34e685070739aec6df995a0e349`, clean and upstream 0/0. The user explicitly prohibited edits, tests, formatting, Git mutations, delegation, new scans, and new findings. The current Logging V2 spec and visualization were fully read and hashes verified.

## Task 1: Plan coherent implementation slices for confirmed F1 blockers

Outcome: success

Preference signals:
- The user required a “frischer repositorygebundener read-only Planungs-Task” with “kein neuer Repositoryscan und keine neuen Findings” -> future agents should stay strictly within already-confirmed findings and avoid scope expansion.
- The user required exact production/test/docs allowlists, callchains, baseline, checks, stop-gates, and unchanged behavior per slice -> future plans should be concrete and file-specific rather than conceptual.
- The user emphasized additive Logging V2 and “keine Produktlogik, Transaktionen, Persistenz, Berechtigungen, Retry/Redirect oder Erfolgskriterien umbauen” -> preserve all product contracts and treat any required behavioral reordering as a hard stop.
- The user requested few coherent reviewable slices, bundling related contracts while separating independent product areas and Blob boundaries -> group by observable error-owner/projection contract, not by arbitrary individual hunks.

Key steps:
- Read `AGENTS.md`, orchestration/scoped-fix/slicing/reviewer/domain references, the full external V2 spec and visualization.
- Verified spec SHA `02f636cd9f17f1a96ca8e43c1d197281e97be7d81bcab0bd3355b748317d7fc6` and visualization SHA `d49a99afdd876db8fa8c1b1eaf965183ed8857f810fe03376dfb93945a7891d8`.
- Confirmed the active code paths for the six pre-confirmed blocker groups and mapped them into seven coherent slices:
  1. Fail-closed Incident/local error projection.
  2. Browser-console privacy for logout, `FeatureErrorBoundary`, and sockets.
  3. Student course/feedback/attendance false-empty handling.
  4. DropCases false-empty handling.
  5. Non-Blob duplicate owners for CM documents and HR employee data.
  6. Opaque Blob/PDF/download owner handling for Security Events, Freelancer, Student Documents, and Lead Documents.
  7. QM create/PDF-export ownership and silent-catch handling.
- Preserved HR 409 Blob decoding as explicitly out of scope.

Failures and how to do differently:
- No implementation or tests were performed by design; do not describe this rollout as code-verified or test-passing.
- Search output was sometimes truncated during exploration, but the final plan was based on the already-confirmed blocker groups and targeted runtime/test evidence, not new findings.
- Future implementation must stop if a slice needs a file outside its allowlist, more than ten production files, product-flow changes, Blob decoding, a second toast owner, or a new blocker.

Reusable knowledge:
- The central Portal error path is `backendError.ts` → `errorHandling.ts`/`error-handler.ts` → toast; valid support projection requires a genuine Axios 400–599 response with a complete nested `data.error` envelope. Root `data.message`, legacy strings, raw Axios messages, and Blob bodies must not become support data.
- `apiClient` emits global 500/502/503 toasts unless `skipGlobalErrorToast` is set. Local handlers, `MutationCache`, and `showPromiseToast` must have exactly one visible owner.
- `MutationCache` is the owner when mutation metadata has `errorAction`; adding local toasts without suppressing the interceptor causes duplicates.
- Blob/PDF responses must remain opaque. Only a validated request ID from safe headers may be used; never decode `.text()`, `.arrayBuffer()`, JSON, or Blob error bodies.
- Student and DropCases errors must remain rejected errors so the UI can distinguish failed reads from legitimate `null`/`[]` success.
- QM PDF flows preserve the existing Draft-save → export ordering and must add ownership without changing status transitions, payloads, refreshes, or download behavior.

References:
- [1] Baseline verification: branch `chore/logging-improvements`; HEAD `84facf6400a1d34e685070739aec6df995a0e349`; clean status; upstream `0/0`.
- [2] Central error code: `src/libs/utils/backendError.ts`, `src/libs/utils/errorHandling.ts`, `src/libs/utils/error-handler.ts`, `src/libs/apiClient.ts`.
- [3] Console sinks: `src/global/navigation/app-sidebar.tsx:100-112`, `src/components/ui/FeatureErrorBoundary.tsx:49`, `src/global/socketContext.tsx:72-74`.
- [4] Student false-empty paths: `src/libs/studentServices.ts:49-62,94-103`, `src/libs/feedbackService.ts:153-170`, `src/components/dashboard/student/StudentFeedbackPanel.tsx:66-78,217-223`, `src/hooks/useStudentAttendance.ts:34-44`.
- [5] DropCases path: `src/libs/utils/dropCasesHelpers.ts:90-103`, `src/libs/courseServices.ts:220-225`, `src/components/dashboard/flexpanels/dropCases.tsx`.
- [6] Blob paths: `src/libs/securityEventsService.ts:147-182`, `src/libs/freelancerTimesheetService.ts:139-145`, `src/libs/studentDocumentService.ts:24-37`, `src/libs/leadProcessService.ts:256-262`.
- [7] QM PDF paths: `src/libs/qmQuarterlyReviewService.ts:200-208`, `src/libs/qmReviewService.ts:100-109`, `src/libs/qmAuditService.ts:391-398`; callers in the corresponding QM detail views.
- [8] Planned docs allowlist: `docs/development/error-handling.md` and `CHANGELOG.md`; README, routes, and architecture docs remain unchanged.
- [9] Validation plan: focused tests, formatting/lint/typecheck per slice; after the final slice run full tests, lint, typecheck, build, and review the complete baseline-to-candidate diff findings-first.
