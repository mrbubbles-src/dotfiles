thread_id: 01a02abe-4d6c-7b93-af15-129f529f5724
updated_at: 2026-08-22T18:40:27+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T20-31-49-01a02abe-4d6c-7b93-af15-129f529f5724.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only audit of remaining Portal Logging-V2 F1 producer families

Rollout context: Fresh repository-bound audit in `/Users/mrbubbles/dev/novari/novari-education-portal`, strictly read-only: no edits, tests, formatting, fetch, scans, commits, pushes, browser access, or delegation. Start gate passed on `chore/logging-improvements`: `HEAD=origin=0555d5e6781cf1d2f0f8db03cd21b683174fafd0`, upstream `0/0`, clean worktree.

## Task 1: Classify the remaining 24 MutationCache producer families

Outcome: partial

Preference signals:

- The user required a “vollständig frischer repositorygebundener READ-ONLY-Auditor”, “keine Spekulation”, bounded searches, exact baselines/allowlists, unchanged flows, stop-gates, and no implementation -> future audits should remain findings-first, read-only, and explicitly distinguish verified evidence from uncertainty.
- The user explicitly prohibited broad inference from `meta.errorAction + Axios`; each mutation must be traced through service/HTTP/config, local handlers, Axios interceptor, status behavior, and toast ownership.
- The user requested smallest coherent reviewable slices rather than an automatically maximally fragmented plan -> group follow-up work by product area and shared test boundary.

Key steps:

- Verified the repository gate, `AGENTS.md`, existing error-handling contract, logging slice-gate skill, and relevant memory.
- Established 27 hook files with `meta.errorAction`; excluding Topics, Self-Learning, and Curriculum leaves exactly 24 families. Separate ClassManager/Classbook and Employee Feedback/Feedback PDF due to distinct request/test boundaries.
- Inspected the central `MutationCache` and Axios response interceptor. A normal `apiClient` mutation has one 4xx owner but typically two 500/502/503 owners unless request-local suppression is applied.
- Used bounded TypeScript AST extraction to inventory mutation names, HTTP methods, and handlers; separately inspected service implementations, local catches, Blob behavior, socket paths, and existing tests.
- Confirmed no implementation or verification commands beyond read-only inspection were performed.

Confirmed findings:

- P1 normative stop-gate: the current overarching Logging-V2 Spec/Visualization was not available in the checkout or discovered work files, so final §2.2/§14 authorization mapping cannot be claimed.
- P1 Employee Feedback PDF: three `responseType: 'blob'` POSTs cannot use the strict F1 projector’s object-shaped `data.error`; they remain reference-only unless Blob parsing receives an explicit security/contract decision. The DELETE is ordinary JSON and is covered.
- P1 current Teaching-Plan HiDrive export: its only production caller uses `handledLocally: true`, suppressing both global owners; it shows an inline reference-aware error but no F1 support projection and zero automatic toasts.
- P2 systemic duplicate ownership: ordinary `apiClient` 5xx mutations produce Axios-interceptor plus MutationCache/local-owner toasts. `meta.skipGlobalErrorToast` suppresses MutationCache only and does not suppress Axios.
- P2 existing tests mostly assert legacy two-argument Axios signatures and do not provide a family-wide proof of exactly-one-toast ownership plus conditional fourth support-information argument.

The 24-family inventory classified Absences, Applicants, AZAV, ClassManager Classbook, Classbook, Content Releases, Employee Documents, Employee Feedback, Employee Feedback PDF, Employee Queries, Exams, Feedback, GitHub Classroom, Grades, Lead Process, Pending Changes, Pending Documents, Profile, Security PIN, Student Documents, Students, Teaching Plans, Tickets, and Trainings. GETs, socket operations, local validation/preflight failures, and post-success follow-up failures were correctly excluded from F1 mutation coverage where applicable. Training contains additional `showPromiseToast` direct-owner writes outside the MutationCache inventory and requires a separate audit.

Failures and how to do differently:

- The missing normative Spec/Visualization prevented a complete authorization claim; future work must stop at that gate rather than treating historical plans or `error-handling.md` as implementation authority.
- Do not infer support projection from `meta.errorAction`; inspect actual response shape, request config, local ownership, and interceptor behavior.
- Do not parse Blob error bodies without an explicit contract/security decision; preserve opaque/reference-only behavior.
- Do not treat `skipGlobalErrorToast` as global deduplication; verify both Axios and MutationCache ownership.

Reusable knowledge:

- Central paths: `src/libs/queryClient.ts` MutationCache, `src/libs/apiClient.ts` Axios interceptor, `src/libs/utils/backendError.ts` strict projector, `src/libs/utils/error-handler.ts`, and `src/libs/utils/toast.ts`.
- Strict F1 support projection requires a genuine Axios error, own-data validated nested envelope, safe message/code/request ID, static area, and optional strict HTTP Date; invalid data fails closed.
- Existing contract uses `...(supportInformation ? [supportInformation] : [])`; legacy three-argument toast calls must remain unchanged when projection is absent.
- `src/docs/development/error-handling.md` records implemented F1 slices through F1y but explicitly leaves other direct product callers and LMS/F2 separate.

Proposed smallest coherent follow-up slices:

1. Employee Feedback JSON dedupe, then separate Blob-F1 decision.
2. Current Teaching-Plan HiDrive export local-owner support action.
3. Exams request-local dedupe preserving local delete/release handlers.
4. HR/student document service mutations.
5. Recruiting and Lead Process mutations.
6. Student/profile/HR pending-change workflows.
7. Classbook, grades, feedback, content release, and GitHub Classroom writes.
8. Absences, AZAV export, Ticket HTTP writes, and Training Add/Remove; audit remaining direct `showPromiseToast` Training writes separately.

References:

- [1] Gate evidence: `git status --short --branch`; `git rev-parse HEAD`; `git rev-parse origin/chore/logging-improvements`; `git rev-list --left-right --count origin/chore/logging-improvements...HEAD` -> clean branch, exact baseline, `0/0`.
- [2] `src/libs/queryClient.ts:50-63` -> MutationCache global success/error ownership.
- [3] `src/libs/apiClient.ts:58-103` -> auth replay and 500/502/503 Axios toast ownership with `skipGlobalErrorToast`.
- [4] `src/libs/utils/backendError.ts:199-309` -> fail-closed F1 projector and strict envelope/header validation.
- [5] `src/hooks/useEmployeeFeedbackPdf.ts:13-112` -> three Blob POSTs plus DELETE.
- [6] `src/hooks/useTeachingPlans.ts:348-395` and `src/components/lms/teaching-plan/export/CurriculumVersionExportAction.tsx:39-105` -> current export local ownership and inline error flow.
- [7] `src/docs/development/error-handling.md` -> current F1 slice boundaries and explicit exclusions.
