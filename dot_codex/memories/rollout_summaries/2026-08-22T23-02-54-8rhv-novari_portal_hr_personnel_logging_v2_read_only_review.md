thread_id: 01a02bb6-7cd5-7461-94f3-aa35b125f5f9
updated_at: 2026-08-22T23:48:02+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T01-02-54-01a02bb6-7cd5-7461-94f3-aa35b125f5f9.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only HR personnel Logging V2 review produced three bounded implementation plans

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, the repository was verified clean at `3756df80b0a772d22970425c6ecb391ace563d4f`, synchronized with origin (`0/0`). The user required a fresh, repository-bound, findings-first, strictly read-only normative review: no edits, tests, formatting, fetches, Git mutations, browser/security actions, or delegation.

## Task 1: HR personnel write inventory and slice review

Outcome: success

Preference signals:
- The user required the “kleinsten kohärenten” reviewable scope, exact production/test allowlists, explicit exclusions, findings-first reporting, and fail-closed behavior on scope or authorization drift. Future Logging V2 work should preserve these defaults.
- The user explicitly prohibited implementation and validation actions for this review. Similar plan reviews must inspect current evidence without editing or running tests.

Key steps:
- Read AGENTS.md, Novari review references, Logging V2 normative Spec and explanatory visualization. The Spec is authoritative; visualization is explanatory only.
- Confirmed F1 is authorized only as individually approved Portal sub-slices under Spec §2.2 case 6: safe support information for genuine backend errors, without changing product flow.
- Inventoried active HR/personnel writes and traced endpoint, method/body, caller, Axios client, owner, retry, cache invalidation, success behavior, and UI error handling.
- Identified 7 active endpoints / 8 UI actions, split into three coherent slices rather than one broad HR change.
- Final findings: no P0/P1 findings; three P2 findings and one scope classification were reported.

Findings and plans:
- Plan 1: four Pending Changes PATCH operations currently have MutationCache ownership but also global 5xx Axios ownership. Add request-local `skipGlobalErrorToast` only to those four PATCHes; keep existing MutationCache metadata and behavior.
- Plan 2: employee update and archive have overlapping hook/component/global owners. Move active PUT/PATCH paths to sole MutationCache ownership; retain catches only as control boundaries, remove duplicate component error toasts, preserve success and dialog behavior.
- Plan 3: active employee creation uses `loginClient.post('/signup')` from `AddEmployeeDialog`, not the unused `/employees` hook. Convert only the dialog submit path to a local TanStack mutation with MutationCache ownership; preserve `loginClient`, `/signup`, payload, response, and success order.
- Separate active but unrelated surfaces—Security PIN unlock, absence decisions, archive deadline deletion, opaque Blob PDF generation, downloads/previews—from these slices. Inactive `useCreateEmployee`, `useDeleteEmployee`, and `useCancelAbsenceRequest` remain untouched.

Reusable knowledge:
- Global ownership is implemented by `src/libs/queryClient.ts` MutationCache; `meta.errorAction` triggers `handleError`, while `skipGlobalErrorToast` suppresses only the Axios interceptor’s 500/502/503 toast.
- Safe support projection must use the existing strict `extractBackendSupportInformation` path and must never expose raw error data, personal data, URLs, queries, payloads, or dynamic area names.
- A no-body Axios request must pass `undefined` as its body before the config argument; do not invent a request body.
- Every runtime diff must map to Spec §2.2, stay within the exact allowlist, preserve product logic, and remain under the §14.1 ten-production-file escalation threshold.

References:
- Normative Spec: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md`
- Gate skill: `/Users/mrbubbles/.codex/memories/skills/novari-logging-slice-gates/SKILL.md`
- Central ownership: `src/libs/apiClient.ts`, `src/libs/queryClient.ts`, `src/libs/utils/error-handler.ts`, `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`
- HR inventory: `src/hooks/useEmployeeMutations.ts`, `src/hooks/useEmployeeQueries.ts`, `src/hooks/usePendingChanges.ts`, `src/libs/api/pendingChangeApi.ts`, `src/hooks/useAbsences.ts`

## Task 2: Condense Plan 1 — Pending Changes

Outcome: success

Key steps:
- Exact operations: `PATCH /hr/pending-changes/:id/process` with `{ decisions }`; `PATCH /hr/pending-changes/:id/acknowledge` with no body; `PATCH /hr/pending-changes/:id/remove-profile-image` with `{ reason }`; `PATCH /hr/pending-changes/profile-image/:employeeId/remove` with `{ reason }`.
- Runtime allowlist: `src/libs/api/pendingChangeApi.ts` and `src/hooks/usePendingChanges.ts` (285 production lines total); tests include existing API tests plus a new ownership test.
- Preserve URLs, methods, bodies, responses, retry 0, success toasts, invalidation, sockets, queues, history, and moderation logic.

## Task 3: Condense Plan 2 — Employee update and archive

Outcome: success

Key steps:
- Exact UI callers: `EditEmployeeDialog` PUT `/hr/employees/:id`; `OnboardingAssignmentDialog` uses the same PUT with `{ onboarding }`; `Management`/`ArchiveEmployeeDialog` uses PATCH `/hr/employees/:employeeId/archive` with `{ reason }`.
- Runtime allowlist: `src/hooks/useEmployeeMutations.ts`, `src/components/dashboard/employee/editEmployeeDialog.tsx`, `src/components/dashboard/hr/OnboardingAssignmentDialog.tsx` (771 production lines total); `management.tsx` remains byte-identical.
- Preserve form data, onboarding logic, archive reason, responses, mutation keys, retries, invalidations, success callbacks, and dialog behavior. Remove only duplicate error owners.

## Task 4: Condense Plan 3 — Employee creation via loginClient

Outcome: success

Key steps:
- Active caller is `AddEmployeeDialog`; transport is `loginClient.post('/signup', employeeFormData)`. The unused `/employees` hook is not the active path.
- Runtime allowlist is only `src/components/dashboard/employee/addEmployeeDialog.tsx` (107 lines); `src/libs/login.ts` remains unchanged.
- Use a local TanStack mutation with `meta.errorAction: 'Anlegen des Mitarbeiters'`; keep `loginClient`, `/signup`, JSON payload, response, retry 0, success toast, validation, form state, and dialog-close order unchanged. No `skipGlobalErrorToast` is needed because `loginClient` has no global error-toast interceptor.
