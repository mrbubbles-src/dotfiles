thread_id: 01a034b8-4bf3-7202-9e43-9ec85261a391
updated_at: 2026-08-24T17:20:22+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-01-28-01a034b8-4bf3-7202-9e43-9ec85261a391.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Exam actions now have one visible error-toast owner

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, on `chore/logging-improvements` at baseline `5d4fcf0e003c73ee6db113150bcb731770e93a29`, the user authorized only assignment deletion and result release. Scope was restricted to `src/libs/examService.ts`, focused tests, `docs/development/error-handling.md`, and `CHANGELOG.md`; no unrelated production changes, commit/push only after freeze.

## Task 1: Fix duplicate toasts for exam assignment deletion and result release

Outcome: success

Preference signals:
- The user required a fail-closed workflow: read all governing instructions, verify exact branch/HEAD/upstream/clean state and active callchains before editing -> future agents should stop before changes on any gate mismatch.
- The user required “genau ein sichtbarer Owner,” exact request arity, unchanged payloads/results/invalidations, and real interceptor-to-hook tests -> preserve transport and ownership contracts rather than refactoring hooks.
- The user explicitly excluded `useDeleteExamTest`, other exam paths, unrelated refactors, and extra production files -> keep similar slices narrowly allowlisted.
- The user required findings-first review, canonical freeze twice, then no further edits/tests, and no commit/push until separately authorized -> follow this sequencing.

Key steps:
- Verified `AGENTS.md`, orchestrate/scoped-fix skills, branch, baseline HEAD, clean worktree, upstream `0/0`, current docs, and active consumers.
- Confirmed `/exams/assignments` uses `useDeleteExamAssignmentAny` and `/exams/results` uses `useReleaseExamAssignmentResults`; both hooks already own local errors and have MutationCache suppression metadata.
- Added `skipGlobalErrorToast` only to `examService.deleteAssignment` and `examService.releaseAssignmentResults`; preserved DELETE two-argument shape and bodyless PATCH `undefined` body plus third config argument.
- Added a real Axios adapter/interceptor → service → hook → production QueryClient/MutationCache integration test covering 500/502/503 for both actions, safe support projection, no sensitive leakage, success, and invalidations.
- Updated error-handling documentation and changelog.
- Focused test passed 8/8; relevant Exams suites passed 59/59; full Vitest passed 485 files/5789 tests; typecheck and focused lint passed; build passed with existing chunk-size warnings. Full lint had 4 pre-existing errors and 6 warnings outside the allowlist.
- Findings-first review found no P0–P3 issues.
- Freeze was computed twice identically: `29f917eebda2afba300311d1f35d0352c5fd0b9df1a7f8dd41243d87fbe58498`.
- Committed and pushed as `f4026c9af1a23a9be83ac82530e2ba6acf10c69b`, message `fix: prevent duplicate exam action error toasts`; final upstream `0/0`, worktree clean.

Failures and how to do differently:
- An initial `bun test` incorrectly invoked Bun’s runner and collected Playwright files, producing unrelated Playwright/Vitest errors; it was stopped and replaced with the repository script `bun run test` (`vitest run`).
- Initial staging without escalation failed with `.git/index.lock: Operation not permitted`; retrying `git add` with authorized escalation succeeded.
- Full lint remains nonzero only because of unrelated pre-existing findings outside the allowlist; do not “fix” those in a scoped exam slice.

Reusable knowledge:
- The central Axios interceptor emits global 5xx toasts unless request config has `skipGlobalErrorToast`; the Production MutationCache emits global mutation toasts unless mutation meta opts out.
- Existing local hook handlers use the validated backend support projection: safe message/code/request ID/Portal area/timestamp only; raw `message` alternatives, details, action hints, URLs, paths, PII, and payloads are excluded.
- `deleteAssignment` must remain `apiClient.delete(url, { skipGlobalErrorToast: true })`; result release must remain `apiClient.patch(url, undefined, { skipGlobalErrorToast: true })`.

References:
- Changed files: `src/libs/examService.ts`, `src/hooks/__tests__/useExams.assignmentErrorOwnership.test.tsx`, `docs/development/error-handling.md`, `CHANGELOG.md`.
- Commit: `f4026c9af1a23a9be83ac82530e2ba6acf10c69b`.
- Freeze: `NOVARI-FREEZE-V1` hash `29f917eebda2afba300311d1f35d0352c5fd0b9df1a7f8dd41243d87fbe58498`.
