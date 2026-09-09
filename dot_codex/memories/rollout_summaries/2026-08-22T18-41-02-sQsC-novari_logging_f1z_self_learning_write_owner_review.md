thread_id: 01a02ac6-bca9-7dc3-85e8-3859758c472e
updated_at: 2026-08-22T18:50:17+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T20-41-02-01a02ac6-bca9-7dc3-85e8-3859758c472e.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only review corrected the proposed Novari Logging V2 F1 self-learning slice

Rollout context: Fresh repository-bound review in `/Users/mrbubbles/dev/novari/novari-education-portal`, with no edits/tests/formatting/fetch/commit/push. Baseline and origin both matched `0555d5e6781cf1d2f0f8db03cd21b683174fafd0`; branch `chore/logging-improvements`, upstream divergence `0/0`, worktree clean.

## Task 1: F1z self-learning write-owner review

Outcome: success

Preference signals:

- The user explicitly required “vollständig frisch”, “READ-ONLY”, “findings-first”, exact allowlists, stop-gates, freeze/review/commit boundaries, and preservation of existing wording/arity and behavior. Future reviews should follow this strict evidence-first, scope-controlled format and avoid implementation until separately authorized.
- The user required that original error identity, Retry, CAS, Continuation, invalidations, Success, Draft/Storage, and Caller behavior remain unchanged. Similar slices should proactively include an unchanged-contract checklist.

Key steps:

- Read `AGENTS.md`, review/slicing references, Novari Logging V2 spec and visualization, and the project-specific logging slice gate.
- Verified eight self-learning mutation services and traced all runtime callers. No direct production service callers existed outside `useLmsSelfLearning.ts`, but the editor continuation invokes status/attach mutations and then catches errors again.
- Inspected the existing request interceptor, `showHandledApiErrorToast`, `handleError`, strict support projection, tests, docs, and changelog.
- Determined that `showHandledApiErrorToast` is the correct existing central path. A backward-compatible optional static `area` parameter is needed because Update/Delete/Review-Note currently preserve the title `Fehler`; otherwise the support area would incorrectly become `Fehler`.

Failures and how to do differently:

- The original “all eight writes with hooks as sole owners” hypothesis was rejected. `Update Status` and `Attach` are not solely hook-owned because the excluded 967-line editor continuation catches failures and calls `showHandledApiErrorToast` again. `skipGlobalErrorToast` only suppresses the interceptor toast, not this second local toast.
- Corrected slice: six writes only—Create, Update, Delete, Review-Note, Detach, Reorder. Status and Attach require a separate follow-up that addresses continuation ownership; the editor remains excluded now.
- Avoid `handleError` for this slice because it can change titles, fallback behavior, or console behavior. Avoid duplicating support projection logic in hooks.

Reusable knowledge:

- `src/libs/apiClient.ts` supports request-local `skipGlobalErrorToast`; it suppresses only automatic 500/502/503 interceptor toasts and does not affect GETs unless explicitly added.
- `src/libs/utils/errorHandling.ts` currently exposes `showHandledApiErrorToast(title, error)` and delegates strict support projection to `extractBackendSupportInformation`. Safe extension: `showHandledApiErrorToast(title, error, area = title)`; existing two-argument callers remain compatible.
- Strict support projection requires a genuine Axios error, status 400–599, complete nested `data.error` envelope, valid message/code/request ID, and safe headers. Invalid/incomplete envelopes retain the existing three-argument reference toast; missing ID or non-Axios errors retain the existing fallback.
- The six-write implementation should modify only the service request configs, hook-local error ownership, central helper arity, focused tests, docs, and changelog. Preserve request bodies, URLs, responses, CAS, continuation, retries, invalidations, success toasts, drafts/storage, and callers.
- Proposed focused test file: `src/hooks/lms/__tests__/useLmsSelfLearning.supportInformation.test.tsx`, rather than broadening the existing hook test file.

References:

- [1] Start gate: branch `chore/logging-improvements`; baseline/HEAD/origin `0555d5e6781cf1d2f0f8db03cd21b683174fafd0`; clean worktree; upstream `0/0`.
- [2] Relevant files: `src/libs/lmsSelfLearningService.ts` (307 lines), `src/hooks/lms/useLmsSelfLearning.ts` (528), `src/libs/utils/errorHandling.ts` (163), excluded editor `src/components/lms/self-learning-editor/self-learning-editor-form.tsx` (967).
- [3] Ownership defect: editor continuation around `self-learning-editor-form.tsx:442-509` invokes status/attach mutations and catches again; hook handlers already toast.
- [4] Existing interceptor: `src/libs/apiClient.ts:16-20,64-103`; `skipGlobalErrorToast` gates only the generic 500/502/503 toast.
- [5] Existing helper: `showHandledApiErrorToast` in `src/libs/utils/errorHandling.ts:108-127`; proposed compatible signature `showHandledApiErrorToast(title, error, area = title)`.
- [6] Final allowlist: `src/libs/lmsSelfLearningService.ts`, `src/hooks/lms/useLmsSelfLearning.ts`, `src/libs/utils/errorHandling.ts`, their existing tests, new focused support-information hook test, `docs/development/error-handling.md`, and `CHANGELOG.md`.
- [7] No tests or edits were run, as explicitly required by the read-only review.
