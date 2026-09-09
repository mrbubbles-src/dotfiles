thread_id: 01a02ddc-b69f-7e41-ba08-3461f8d1c8dd
updated_at: 2026-08-23T09:06:28+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T11-03-54-01a02ddc-b69f-7e41-ba08-3461f8d1c8dd.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Fresh read-only Portal Logging V2 F1 producer audit completed

Rollout context: Audited `/Users/mrbubbles/dev/novari/novari-education-portal` on branch `chore/logging-improvements`, exact HEAD/baseline `82e3d58241f7301b5b862bcc701143992b7c710d`, clean worktree, upstream `0/0`. No edits, tests, formatting, fetches, delegation, or Git mutations.

## Task 1: Current active F1 producer delta audit

Outcome: success

Preference signals:
- The user required a “Fresh empty-context repository-bound READ-ONLY … audit”, “findings-first”, and explicitly prohibited edits, tests, formatter, fetch, Git mutation, and delegation -> future audits should fail closed on these constraints and report exact baseline/status before source findings.
- The user required current reachability rather than trusting historical inventory counts, with classification A–E and exact endpoints/files/owners -> future audits should trace active callers and owner behavior, not merely grep request sites.
- The user asked for the “smallest coherent reviewable slice” and separate treatment of FormData, Blob/PDF, socket, `showPromiseToast`, auth, quiet/preview/CAS/Claim boundaries -> preserve transport and product-boundary separation rather than mechanically migrating every producer.

Key steps:
- Read AGENTS.md, orchestration/scoped-fix guidance, current Logging V2 normative spec/visualization, and the Novari logging slice-gate memory.
- Verified start gate: repository/branch/HEAD, clean status, and upstream counts matched exactly.
- Searched active `apiClient` mutation producers, transport types, owner markers, MutationCache, toast helpers, and registered callers; then inspected candidate files and reachability.
- Confirmed central ownership contract: global Axios interceptor handles 500/502/503 unless request config has `skipGlobalErrorToast`; TanStack `MutationCache` handles mutation errors when metadata has `errorAction` and no skip flag.

Failures and how to do differently:
- Broad search output was truncated and initial inventory was too large to use directly; narrow subsequent searches by owner markers, transport, and named candidate files. Do not treat raw grep counts as final evidence.
- Static overlap can misidentify duplicate ownership. Trace request config, local handlers, MutationCache metadata, interceptor early returns, and actual caller reachability before classifying a finding.

Reusable knowledge:
- The next coherent ordinary B slice is the active ticket-status group in `src/hooks/useTickets.ts:472`: `PATCH /tickets/:id/assign`, `/close`, `/transfer`, `/escalate`, and `/topic`. It has a clear hook/UI boundary through `useTicketActions.ts`, standard JSON transport, and currently relies on MutationCache/global ownership; visible behavior can be preserved with request-local ownership changes.
- Other ordinary B candidates were identified: LMS module CRUD (`src/hooks/lms/useLmsModules.ts:150`, POST/PUT/DELETE `/modules`), student CRUD (`src/hooks/useStudents.ts:91`), absence mutations, Help Topic delete, and student-entry creation. Student/absence paths need more owner tracing because local error handling already exists.
- C boundaries must remain separate: Help Topic image upload; self-absence upload; hardware JSON/multipart/PDF; closing-report update coupled to PDF generation; training/course deletes and Risk mutations using `showPromiseToast`; incident JSON plus multipart attachments and socket pushes; onboarding PDF/multi-step approval; QM/GF/AZAV/certificate/archive/PIN/evaluation flows; auth/logout/loginClient; CAS/Claim/preview/quiet/recovery paths.
- `useCreateEmployee` in `src/hooks/useEmployeeMutations.ts:20` is a dead/unused export (D). The active employee creation flow is `loginClient.post('/signup')` in `src/components/dashboard/employee/addEmployeeDialog.tsx:32`, whose MutationCache is the relevant owner; do not alter the dead export.
- Existing completed F1 producer families were treated as conforming, including HR Documents, Recruiting, Lead Process, Training Participant, Profile/Account, Pending Changes, Self-Learning, Exams, Curriculum structure, GitHub Topic flows, Feedback, and employee update/archive.

References:
- Start gate: `git status --short --branch`; HEAD `82e3d58241f7301b5b862bcc701143992b7c710d`; branch `chore/logging-improvements`; upstream `0/0`.
- Central owner code: `src/libs/apiClient.ts:83-103`; `src/libs/queryClient.ts:50-63`.
- Ticket group: `src/hooks/useTickets.ts:472-588`; UI action boundary `src/hooks/useTicketActions.ts:58-138`.
- LMS modules: `src/hooks/lms/useLmsModules.ts:150-215`.
- Help topic delete/upload: `src/hooks/useHelpPortal.ts:163-198`.
- Closing report: `src/libs/api/closingReportApi.ts:180-210`; `src/hooks/useClosingReport.ts:59-78`.
- Training Promise Toasts: `src/hooks/useTrainings.ts:87-159`; service delete `/teamleader/trainings/:id`.
- Hardware transports: `src/libs/hardwareService.ts:179-253`.
- Incident JSON/multipart boundary: `src/libs/api/incidentApi.ts:177-287`.
- Active employee creation vs dead export: `src/components/dashboard/employee/addEmployeeDialog.tsx:32-69`; `src/hooks/useEmployeeMutations.ts:20-59`.
- Final audit conclusion: no P0–P3 security/data-integrity findings; ordinary F1 family not yet complete; ticket-status group is the next B slice, while C decisions remain before full pre-PR scan.
