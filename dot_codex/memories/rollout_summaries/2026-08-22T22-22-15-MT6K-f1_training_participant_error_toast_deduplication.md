thread_id: 01a02b91-4357-7e33-a491-bece0c24e2ce
updated_at: 2026-08-22T22:36:43+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T00-22-15-01a02b91-4357-7e33-a491-bece0c24e2ce.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Implemented and shipped F1 participant error-toast deduplication

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements` at baseline `c22da204620bbb5e7294f05005ef7e9336af462d`, the user authorized exactly five files and required no unrelated behavior changes.

## Task 1: Training participant mutation error ownership

Outcome: success

Preference signals:
- The user required the “kleinsten coherent reviewable slice,” exact allowlist, fail-closed gates, explicit unchanged flows, independent review, freeze, and no commit/push before review.
- The user explicitly required malformed/missing support envelopes to preserve the legacy three-argument toast shape without `undefined`, and to avoid exposing raw payloads, URLs, IDs, or other internal fields.

Key steps:
- Verified clean branch/worktree, matching HEAD/origin, upstream `0/0`, and the exact five-file allowlist.
- Baseline focused tests passed: 40/40.
- Added a file-local typed Axios config with `skipGlobalErrorToast: true` to exactly three participant writes: add POST, update PATCH, remove DELETE.
- Added `meta.errorAction: 'Aktualisieren des Teilnehmers'` to `useUpdateParticipant`; existing add/remove metadata and success/invalidation behavior remained unchanged.
- Added `useTrainings.errorOwnership.test.tsx` covering request signatures, 4xx/5xx ownership, malformed/missing/mismatched IDs, non-Axios errors, retry `0`, success toasts, and invalidations.
- Updated `docs/development/error-handling.md` and `CHANGELOG.md`.
- Initial formatting introduced unrelated baseline churn in two runtime files; the local review caught this P2 scope drift, and only the formatter churn was reverted.
- Final validation: focused 52/52, full suite 4341/4341, typecheck green, focused ESLint green, build green, `git diff --check` green. Full lint retained the known unrelated baseline of 4 errors and 6 warnings outside the allowlist.
- Freeze hash: `21dd198e8d95c7a4a9a6ec1d40f975eb012b8d7208c4dc0144b8289c3f3512ce`; final review had no P0–P3 findings.
- Committed and pushed as `aceeaa7547685a05c4b994e020af57ac8ae8108f` with `fix: deduplicate training participant error toasts`; final HEAD equals origin, upstream `0/0`, clean worktree, exact five commit files.

Reusable knowledge:
- In this portal, duplicate 500/502/503 mutation toasts are prevented by request-local `skipGlobalErrorToast: true` while retaining the Production `MutationCache` as the single owner via mutation metadata.
- The participant slice’s exact runtime scope is `src/libs/trainingService.ts` and `src/hooks/useTrainings.ts`; tests belong in `src/hooks/__tests__/useTrainings.errorOwnership.test.tsx`, with docs in `docs/development/error-handling.md` and `CHANGELOG.md`.
- Freeze hashing must include tracked diff plus untracked files and use `git diff --binary --full-index`; after freeze, no edits, formatting, or tests should occur until independent review is complete.

Failures and how to do differently:
- Prettier rewrote unrelated existing formatting in runtime files. Always inspect the actual diff after formatting and revert formatter-only churn outside the authorized hunks.
- Full lint failures were pre-existing and outside scope; report them separately rather than fixing unrelated files.

References:
- Baseline: `c22da204620bbb5e7294f05005ef7e9336af462d`
- Freeze: `21dd198e8d95c7a4a9a6ec1d40f975eb012b8d7208c4dc0144b8289c3f3512ce`
- Commit: `aceeaa7547685a05c4b994e020af57ac8ae8108f`
- Commit message: `fix: deduplicate training participant error toasts`
- Final files: `CHANGELOG.md`, `docs/development/error-handling.md`, `src/hooks/__tests__/useTrainings.errorOwnership.test.tsx`, `src/hooks/useTrainings.ts`, `src/libs/trainingService.ts`
