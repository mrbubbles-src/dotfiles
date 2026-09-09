thread_id: 01a0332b-6862-7180-856f-86009a11811f
updated_at: 2026-08-24T09:54:45+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T11-47-58-01a0332b-6862-7180-856f-86009a11811f.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only analysis of active employee-feedback PDF producers

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, baseline `99a8b7b49871eedb6ec87de2d86abf2b869be0bf`; worktree clean and upstream `0/0`. No edits, tests, formatting, fetches, or Git mutations were performed.

## Task 1: Decide and scope the Employee Feedback PDF F1 slice

Outcome: success

Preference signals:
- The user required a “kleinsten coherent reviewable slice”, exact allowlist, explicit unchanged flows, and strict read-only gates -> future Logging V2 work should trace active reachability before widening scope.
- The user explicitly excluded Blob-PDF decoding and product/UI changes -> preserve opaque Blob handling and do not infer support metadata from PDF/Blob bodies.

Key steps:
- Verified the start gate exactly: cwd, branch, HEAD, clean status, and upstream.
- Traced both active flows from `/vacation-planning` TeamLeader route through `ScheduledFeedbacksList` and the two dialogs into `useEmployeeFeedbackPdf`.
- Inspected `apiClient`’s 401 replay/global 5xx interceptor, Production `MutationCache`, support projection, role gates, download lifecycle, cache invalidation, and existing tests.

Findings and how to do differently:
- Both active Blob POSTs currently produce two toasts for 500/502/503: the Axios interceptor and Production MutationCache. Add request-local `skipGlobalErrorToast: true` only to the two active producer POST configs; retain MutationCache as the sole owner.
- The existing PDF test fully mocks `apiClient`, so its one-toast assertion cannot prove real interceptor suppression. Use the real `apiClient` interceptor and Production `queryClient`/MutationCache, mocking only transport and the final toast sink.
- Do not include the observed success-ordering issue (success toast occurs before download/cleanup) or Part 1–4’s possible unhandled `mutateAsync` rejection in this slice; both require separate behavioral decisions and are protected by the V2 no-reordering boundary.

Reusable knowledge:
- Active producers are `/employeeFeedback/:id/pdf/part1to4` and `/employeeFeedback/:id/pdf/part1to5`, both POSTs with exactly `{ responseType: 'blob' }`.
- Both are reachable only through `teamLeader`/`teamleader` at `/vacation-planning`; the confidential dialog is not currently reachable for GF/HR despite its comment.
- Part 1–4 uses `await generatePdfPart1to4.mutateAsync(...)`; Part 1–5 uses `.mutate(...)`.
- Success behavior is otherwise unchanged: Blob URL creation, distinct filenames, link click/remove, URL revoke, detail/list invalidation, and MutationCache success toast.
- Blob bodies must remain opaque. A valid `X-Request-Id` header may support reference-only copying; body-only request IDs, Blob JSON, PDF contents, feedback data, PII, and URLs must not be decoded or displayed.
- Recommended bundle: one common producer-family slice because the defect, hook file, auth/retry contract, and active role gate are identical; keep the two endpoints, static areas, filenames, and tests explicitly separate rather than introducing a dynamic abstraction.

References:
- `src/hooks/useEmployeeFeedbackPdf.ts:19-95` — active PDF mutations and Blob/download behavior.
- `src/components/dashboard/employee/feedbackManagementDialog.tsx:104-107,557-596` — Part 1–4 caller and preview.
- `src/components/dashboard/employee/feedbackPart5Dialog.tsx:314-386` — confidential Part 1–5 caller and preview.
- `src/routes/__app/vacation-planning.lazy.tsx:17-62` — TeamLeader-only route.
- `src/libs/apiClient.ts:144-189` — auth replay and global 500/502/503 toast.
- `src/libs/queryClient.ts:50-63` — Production MutationCache owner and retry 0.
- `src/hooks/__tests__/useEmployeeFeedbackPdf.errorOwnership.test.tsx` — existing test mocks `apiClient` fully and therefore misses duplicate global toasts.
- Proposed production/test allowlist: `src/hooks/useEmployeeFeedbackPdf.ts`, `src/hooks/__tests__/useEmployeeFeedbackPdf.errorOwnership.test.tsx`, `src/libs/__tests__/apiClient.authRetry.test.ts`; documentation updates were identified in `docs/development/error-handling.md` and `CHANGELOG.md` if implementation is later authorized.
- Prioritized next F1 cases: GF labor-market approval Blob PATCH; HR employee-record PDF with 409 Blob JSON/product logic; QM PDF producers separately; Security Events export; then lower-priority Blob GET/download/preview paths; exclude the legacy Employee Feedback `/pdf` hook until an active caller exists.
