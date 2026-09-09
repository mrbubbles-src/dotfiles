thread_id: 01a0357d-f45a-77d0-9fc7-34cee0e1f901
updated_at: 2026-08-24T20:45:46+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T22-37-22-01a0357d-f45a-77d0-9fc7-34cee0e1f901.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/be29/novari-education-portal

# Read-only Portal-F1-Abschlussscan fand fünf echte Finding-Gruppen

Rollout context: Repository `/Users/mrbubbles/.codex/worktrees/be29/novari-education-portal`, detached HEAD allowed. Read-only, no edits/tests/delegation. Start gates passed: HEAD, local branch ref and remote ref all `d2b4cd12cdbb2a31e8f5306026895b699dd90d19`; worktree/index/untracked clean; both normative spec hashes matched. `docs/portal-data-loading-audit.md` was excluded as instructed.

## Task 1: Final active-production Portal F1 scan

Outcome: success (scan completed; result is not scan-clean)

Preference signals:

- The user required a “frische repositorygebundene read-only Scout-/Abschlussscan-Task”, “Gate fail-closed”, “Keine spekulativen Restpunkte”, “keine Tests” and exact allowlists/stop gates -> future reviews should independently verify the frozen repository state, inspect only active production consumers, avoid edits/tests, and report concrete evidence first.
- The user explicitly required Blob/PDF opacity and safe support data only from validated `AxiosError.response.data.error` -> never decode Blob/PDF error bodies or expose raw messages, paths, URLs, details, or PII.
- The user required one visible error owner and preservation of success/auth/retry/cache/navigation/role behavior -> trace the entire Axios → interceptor → Query/Mutation → hook/component chain before proposing a fix; do not revisit already hardened paths.

Key steps:

- Read `AGENTS.md`, the full normative Logging/Error/Audit V2 spec, and visualization; confirmed logging must observe product logic without changing transactions, ordering, retries, permissions, or product behavior.
- Inventoried global Axios handling, MutationCache, QueryClient retry behavior, local toast owners, active routes/consumers, Blob/PDF producers, and existing tests/docs.
- Cross-checked prior hardened paths and excluded them from new findings.

Failures and how to do differently:

- The scan is not “Portal-F1 scan-clean” and not PR-ready: five concrete finding groups remain.
- Do not treat a clean sub-slice or prior hardening as completion of the full F1 program; continue scanning authorized special cases until the final gate.

Reusable knowledge:

- P1 HR employee-file PDF: active `/employee` chain `Management.handleGeneratePdf` → `generateEmployeeHrPdf` → `POST /hr/pdf/generate/:id` requests `responseType: 'blob'`, but the 409 catch parses `raw.text()`/`JSON.parse` and renders unvalidated fields. The same 500/502/503 request can produce both the Axios global toast and local generic toast. Required review slice: `src/libs/api/employeeApi.ts`, `src/components/dashboard/hr/management.tsx`; likely tests under corresponding API/management test paths. Stop before changing the endpoint contract: successful PDF blobs, force behavior, roles, success, and preview must remain unchanged; either a backend contract precursor or explicit approval for a static 409 message is needed.
- P1 shared `DocumentPreviewModal`: 16 active consumers use Blob GETs. The modal’s local catch renders raw `err.message`, while 500/502/503 can also trigger the global interceptor toast. Required slice is only `src/components/dashboard/hr/documentPreviewModal.tsx` plus focused tests; do not alter consumers, Blob content, MIME/URL cleanup, abort, retry, new-tab behavior, or contracts.
- P2 Help Portal image upload: `PortalEntryEditor.ImageField` → `useUploadPortalImage` → `POST /help/config/portal-topics/upload-image` has no request-local opt-out and its catch adds a second local toast. Required slice is `src/hooks/useHelpPortal.ts` and `src/components/help/config/portal/PortalEntryEditor.tsx`; preserve FormData, create/update/delete, success order, preview, and HiDrive path behavior.
- P2 active Query read families: default QueryClient retries transient failures once, while the Axios interceptor can toast each 500/502/503 attempt, producing duplicate toasts. Risks, Incidents, and Hardware then render misleading empty/not-found states; Onboarding can disappear after a final read error. Keep family slices separate and preserve query keys, cache, retry/auth replay, mount/reconnect, request count, roles, and navigation. Use real production QueryClient/interceptor plus final-error identity claims, not fully mocked tests.
- P2 QM/GF Audit reads: rejected `getAudits` results become “Keine Audits gefunden”; QM detail can become “Audit nicht gefunden” after an effect promise rejection; GF detail has analogous unhandled/faulty read-state behavior. Keep audit mutations, Promise-toast slices, PDF/Blob, drafts, roles, and refresh ordering unchanged.

References:

- [1] Gate evidence: `git status --short --branch`; `git rev-parse HEAD refs/heads/chore/logging-improvements refs/remotes/origin/chore/logging-improvements` all resolved to `d2b4cd12cdbb2a31e8f5306026895b699dd90d19`.
- [2] Normative files and hashes: `Novari_Logging_Error_Handling_und_Audit_Spec_V2.md` → `02f636cd9f17f1a96ca8e43c1d197281e97be7d81bcab0bd3355b748317d7fc6`; visualization → `d49a99afdd876db8fa8c1b1eaf965183ed8857f810fe03376dfb93945a7891d8`.
- [3] Global ownership evidence: `src/libs/apiClient.ts`, `src/libs/queryClient.ts`, `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`.
- [4] Final user-facing conclusion: “Nicht Portal-F1-scan-clean und nicht PR-reif. Fünf belegte Finding-Gruppen bleiben.” No tests or mutations were performed.
