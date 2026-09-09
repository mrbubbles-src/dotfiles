thread_id: 01a02bef-924f-75d3-b28a-d515f272f0b5
updated_at: 2026-08-23T00:13:59+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T02-05-16-01a02bef-924f-75d3-b28a-d515f272f0b5.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only normative review of Portal Logging V2 F1 Teaching/QM

Rollout context: Repository-bound review in `/Users/mrbubbles/dev/novari/novari-education-portal`; no edits, tests, formatting, fetches, browser/security tools, or delegation. Start gate matched exactly: branch `chore/logging-improvements`, HEAD and origin at `a4ed55661e5100e159b38a9d8319dbb452efa2ad`, upstream `0/0`, clean worktree.

## Task 1: Teaching/QM producer inventory and slice planning

Outcome: success

Preference signals:

- The user required a “kleinsten coherent reviewable slice”, exact allowlists, findings-first reporting, explicit unchanged flows, and fail-closed stopping on scope or authorization drift. Future reviews should preserve this format and avoid broad domain sweeps.
- The user explicitly excluded the known Teaching Plan HiDrive/direct-inline export unless current evidence proved no product decision was needed. The review correctly kept the canonical current export out of the plan.
- The user required a fresh repository-bound read-only review with no edits/tests/delegation; the review stopped at planning and retained the clean candidate.

Key steps:

- Read current `AGENTS.md`, normative V2 spec, visualization, relevant Portal services/hooks/components/callers/tests/docs, and current Git state.
- Mapped active producers and owners across Teaching history export, canonical export, QM corrective measures, risks, audits, goals, management reviews, quarterly reviews, and inactive callers.
- Distinguished Production `MutationCache`, local `try/catch`, and `showPromiseToast` ownership instead of forcing unrelated domains into one slice.

Failures and how to do differently:

- A combined Teaching/QM slice is a P1 scope failure: services, owners, success paths, and cache boundaries differ. Split by coherent domain.
- `showPromiseToast` producers cannot be migrated casually: the promise toast owns loading/success/error behavior, so adding another backend toast duplicates UX or changing to MutationCache removes loading behavior.
- Blob/PDF exports cannot use the strict support projector because their responses are opaque blobs rather than object-shaped `data.error` envelopes. Keep them out until a separate product/contract decision.
- Existing 4xx gaps were found in `createAudit` and `createManagementReview`: `showPromiseToast(Promise.resolve(result))` is attached only after the API promise succeeds, so rejected 4xx calls have no local visible owner. This is a real finding but must be handled in a dedicated slice.

Reusable knowledge:

- Historical Teaching export is a coherent implementation candidate: one POST, existing Production `MutationCache`, request-local `skipGlobalErrorToast`, static area `Speichern des Exports in HiDrive`, and unchanged response/body/success behavior.
- QM corrective measures are a coherent nine-write domain: create, assignment, implementation, start, submit-for-review, effectiveness review, return-to-implementation, GF decision, and recurrence detection. Preserve the existing two-step implementation/start order.
- QM JSON metrics/goals form a separate candidate: audit baseline populate, audit sector populate, and goal patch. Keep `getOpenAudit` and PDF export outside the slice.
- The current Axios interceptor only globally toasts 500/502/503 and honors request-local `skipGlobalErrorToast`; Production `MutationCache` handles mutations with `errorAction` metadata and retry defaults are zero.

References:

- Gate command: `git branch --show-current && git rev-parse HEAD && git rev-parse origin/chore/logging-improvements && git rev-list --left-right --count HEAD...@{upstream} && git status --short`; verified exact HEAD/origin `a4ed556...`, `0/0`, clean.
- Normative sources: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md` and `Novari_Logging_System_V2_Visualisierung.md`.
- Current error-owner paths: `src/libs/apiClient.ts`, `src/libs/queryClient.ts`, `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`, `src/libs/utils/error-handler.ts`.
- Teaching history owner: `src/libs/teachingPlanService.ts`, `src/hooks/useTeachingPlans.ts`, `src/components/lms/teaching-plan/LegacyTeachingPlanHistorySheet.tsx`.
- Canonical export decision point: `src/components/lms/teaching-plan/export/CurriculumVersionExportAction.tsx`.
- QM paths: `src/libs/api/correctiveMeasureApi.ts`, `src/hooks/useCorrectiveMeasures.ts`, `src/libs/qmAuditService.ts`, `src/components/dashboard/qualityManager/QmKennzahlenPanel.tsx`, `src/components/dashboard/qualityManager/ziele/ZielePage.tsx`.
- Freeze verification command for any future candidate: `git diff --binary --full-index a4ed55661e5100e159b38a9d8319dbb452efa2ad | shasum -a 256`.

Final state: no files changed; no implementation or commit/push authorization inferred.
