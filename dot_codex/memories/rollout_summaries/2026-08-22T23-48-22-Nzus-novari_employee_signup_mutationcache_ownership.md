thread_id: 01a02be0-1c05-77d2-81ab-2c244aafaba4
updated_at: 2026-08-23T00:05:03+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T01-48-22-01a02be0-1c05-77d2-81ab-2c244aafaba4.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Employee signup error-ownership slice implemented and shipped

Rollout context: Novari education portal, `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`. The user authorized a tightly scoped four-file F1 slice, initially without commit/push, then separately authorized exact freeze verification and normal commit/push.

## Task 1: Implement and verify employee signup ownership

Outcome: success

Preference signals:

- The user required the “kleinsten coherent reviewable slice,” exact four-file allowlist, no unrelated edits, and preservation of endpoint, client, payload, retry, success, and other HR behavior -> future work should fail closed on scope drift.
- The user explicitly required one Production `MutationCache` owner, no component error toast, and preserved dialog values/open state after failure -> similar mutations should use existing global ownership rather than adding local duplicate handling.
- The user required strict error-output tests covering malformed envelopes, non-Axios errors, error identity, exact toast arity, and exclusion of sensitive/raw fields -> test error contracts and privacy boundaries explicitly.

Key steps:

- Verified branch/HEAD/origin `7bc5161a60a920dc67a277576e6c24e28223cb30`, upstream `0/0`, and clean baseline.
- Changed `AddEmployeeDialog` to use local `useMutation` with `loginClient.post('/signup', data)` and metadata `errorAction: 'Anlegen des Mitarbeiters'`.
- Removed direct `signup`, `extractErrorMessage`, and component `showErrorToast` usage. Catch now preserves the dialog and lets Production `MutationCache` own failure feedback.
- Added `addEmployeeDialog.errorOwnership.test.tsx` with 10 tests covering statuses 400/409/422/500/502/503, strict support projection, malformed/missing envelopes, non-Axios fallback, request/body exactness, mutation retry/error identity, success toast/close ordering, and no invalidation.
- Updated `docs/development/error-handling.md` and `CHANGELOG.md`.

Failures and how to do differently:

- Full lint had a pre-existing baseline of 4 errors and 6 warnings in unchanged files; targeted lint for the two code files passed. Do not “fix” unrelated baseline findings in a scoped slice.
- The first reported freeze hash `cb0652c1...` was noncanonical because it serialized the untracked test as a `--no-index` patch. Recomputed using the canonical NUL-framed raw-byte formula; authoritative hash was `0bc45277c2735a04421bb79a1247cbd0225d1fadac9ad2513c911191628734d3`.

Reusable knowledge:

- Production `queryClient` is defined in `src/libs/queryClient.ts` and is mounted at the application root in `src/main.tsx`.
- `loginClient` remains in `src/libs/login.ts`; the legacy `signup` helper was intentionally left unchanged and is no longer used by the dialog.
- Validation and success behavior remain in the existing form flow; no cache invalidation was introduced.

References:

- `src/components/dashboard/employee/addEmployeeDialog.tsx`
- `src/components/dashboard/employee/__tests__/addEmployeeDialog.errorOwnership.test.tsx`
- `docs/development/error-handling.md`
- `CHANGELOG.md`
- Focused test: `1 passed`, `10 passed`
- Full suite: `385/385` files, `4413/4413` tests
- Typecheck, build, formatting, and targeted lint passed.

## Task 2: Freeze verification and commit/push closeout

Outcome: success

Key steps:

- Confirmed exact four paths, empty staging before commit, branch/HEAD/origin alignment, and canonical freeze hash.
- Staged only the four allowlisted files.
- Created commit `a4ed55661e5100e159b38a9d8319dbb452efa2ad` with message `fix: route employee signup errors through mutation owner`.
- Normal push succeeded; final HEAD and origin matched, upstream `0/0`, and worktree/staging were clean.

Reusable knowledge:

- Canonical freeze stream: `NOVARI-FREEZE-V1\0TRACKED-DIFF\0`, raw `git diff --binary --full-index --no-ext-diff <baseline> --`, then `\0UNTRACKED-FILES\0`; sorted untracked files use `FILE\0<path>\0BYTES\0<size>\0CONTENT\0<raw bytes>\0END-FILE\0`.

References:

- Canonical pre-commit freeze SHA-256: `0bc45277c2735a04421bb79a1247cbd0225d1fadac9ad2513c911191628734d3`
- Final commit/HEAD/origin: `a4ed55661e5100e159b38a9d8319dbb452efa2ad`
- Final status: clean, upstream `0/0`, no amend or force push.
