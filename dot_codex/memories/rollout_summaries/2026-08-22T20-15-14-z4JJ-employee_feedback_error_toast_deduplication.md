thread_id: 01a02b1c-f97f-7ad3-bab2-3f713e26636b
updated_at: 2026-08-22T20:30:47+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T22-15-14-01a02b1c-f97f-7ad3-bab2-3f713e26636b.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Employee Feedback error-toast deduplication implemented, independently reviewed, committed, and pushed

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, the user authorized a narrowly bounded Portal Logging V2 F1 slice with an exact six-file allowlist, no unrelated behavior changes, independent review before commit, and normal push only after freeze verification.

## Task 1: Implement and verify Employee Feedback error ownership

Outcome: success

Preference signals:
- The user required “Allowlist exact 6”, strict runtime contracts, no caller changes, and “Stop” rules for payload, retry, success, service, component, cache, or seventh-file changes -> future work should remain fail-closed and narrowly scoped.
- The user required real Production `QueryClient`/`MutationCache` tests, serial cache cleanup, exact request assertions, original error identity, and strict/malformed/non-Axios coverage -> similar ownership changes should prove the full production chain rather than only mock local handlers.
- The user explicitly required Blob requests to remain byte-for-byte unchanged -> preserve opaque Blob request configurations when adding ownership controls elsewhere.

Key steps:
- Verified branch/HEAD/origin at `ace2c4ba93e8d1d170358e0d6b688301e3921a0c`, upstream `0/0`, and clean baseline.
- Added a typed shared `{ skipGlobalErrorToast: true }` Axios config to the eight JSON feedback mutations and DELETE only.
- Left all three PDF POSTs exactly `{ responseType: 'blob' }` with no opt-out.
- Added two ownership test files covering all eight hooks, DELETE, statuses 400/409/422/500/502/503, strict/malformed/missing/non-Axios errors, original identity, one MutationCache toast, success/invalidation behavior, and Blob negative assertions.
- Updated `docs/development/error-handling.md` and `CHANGELOG.md` within the allowlist.
- Focused tests passed `17/17`; auth-retry plus focused tests passed `26/26`; typecheck, focused lint, Prettier, and build passed.
- Full suite passed `4261/4262`; the sole failure was an unrelated Autosave timing test and passed isolated `1/1`. Full lint reproduced the known baseline of 4 errors/6 warnings in unchanged files. Local review found no issues.

Failures and how to do differently:
- Initial PDF test expectations incorrectly assumed no toast and used unnamed parameterized hooks; corrected tests to assert the existing three-argument fallback and add stable case labels.
- Initial mutation success-test typing mixed string and object mutation hooks; replaced it with explicitly typed per-hook cases. Re-run typecheck after test refactors.

Reusable knowledge:
- `src/libs/queryClient.ts` has the production `MutationCache`; `skipGlobalErrorToast` suppresses the Axios interceptor while leaving MutationCache metadata as the sole toast owner.
- The relevant production files remained `293` and `175` lines, under targets `<300/<180`.

References:
- Focused command: `npm test -- src/hooks/__tests__/useEmployeeFeedbackMutations.errorOwnership.test.tsx src/hooks/__tests__/useEmployeeFeedbackPdf.errorOwnership.test.tsx src/libs/__tests__/apiClient.authRetry.test.ts`
- Freeze SHA: `722e775f09666d006d9bdf09bd958fb0c0bdb9d253a8e16a72be92ad557a9bce`

## Task 2: Commit and push reviewed candidate

Outcome: success

Key steps:
- Reverified exact baseline, six-file allowlist, upstream `0/0`, and unchanged freeze before staging.
- Staged only the six authorized files and committed with `fix: deduplicate employee feedback error toasts`.
- Pushed normally to `origin/chore/logging-improvements`.
- Verified HEAD equals origin, upstream `0/0`, clean worktree, and exactly six commit paths.

References:
- Commit: `81745ea84e08de366058cadf949a53fbb914dbae`
- Parent: `ace2c4ba93e8d1d170358e0d6b688301e3921a0c`
- Commit paths: `CHANGELOG.md`, `docs/development/error-handling.md`, `src/hooks/useEmployeeFeedbackMutations.ts`, `src/hooks/useEmployeeFeedbackPdf.ts`, and the two new ownership test files.
