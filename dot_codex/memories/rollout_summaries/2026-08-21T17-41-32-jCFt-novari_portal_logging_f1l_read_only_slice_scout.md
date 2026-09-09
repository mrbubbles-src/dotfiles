thread_id: 01a02569-e5cb-7ee0-ab67-fb8d1d57d71b
updated_at: 2026-08-21T17:48:03+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T19-41-32-01a02569-e5cb-7ee0-ab67-fb8d1d57d71b.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only scout selected the next Portal Logging V2 producer slice

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, baseline/HEAD `a0916aa24373ccc51491e65f0aea97b1ec30ba69`, clean and synchronized with `origin/chore/logging-improvements` (0/0). No edits, tests, formatting, fetches, commits, or pushes were performed.

## Task 1: Select and scope the next F1 producer slice

Outcome: success

Preference signals:
- The user required a “frische, vollständig isolierte, read-only” findings-first scout and explicitly prohibited implementation authorization -> future agents should preserve strict read-only mode and distinguish planning from Go.
- The user required exact baselines, allowlists, stop-gates, real callpaths, preserved toast arity, and no Sammelmigration -> future slices should be producer-specific and evidence-backed.

Key steps:
- Verified repository, branch, exact HEAD, clean worktree, upstream, and 0/0 divergence.
- Read AGENTS.md, orchestration and logging-slice gates, normative Spec, visualization, current logging documentation, changelog, source, tests, and recent F1 history.
- Inventoried remaining direct `showBackendErrorToast` callers and classified GET/Preview, local, Cleanup/Lease, Postcommit/Partial-commit, and later mutation paths as out of scope.
- Selected exactly one real failure owner: `CurriculumWorkRevisionReviewActions.tsx` catch at approximately line 409, for the explicitly confirmed GitHub path-migration action.

Reusable knowledge:
- Proposed next slice: **F1l – GitHub path-migration action support information**, static area `GitHub-Pfadmigrationsaktion`.
- Callpath: `TeachingPlanReviewDeskPage` → `CurriculumWorkRevisionReviewActions` → confirmation dialog → `confirmMigrationAction()` → `useGithubCurriculumTopicPathMigrationAction` → `runGithubCurriculumTopicPathMigrationAction()` → locally handled Axios POST to `/lms/curriculum-versions/{versionId}/github-path-migrations/{migrationId}/{action}` with empty body and existing `Idempotency-Key`.
- Only a genuine Axios `400–599` response with a complete own-property `response.data.error` envelope may receive the fourth toast argument via `extractBackendSupportInformation`; `actionHint`, details, raw payloads, and raw Axios messages are ignored.
- Existing three-argument fallback must remain exactly three arguments for flat/legacy payloads, incomplete envelopes, conflicting body/header request IDs, local key failures, local invalidation failures, and other non-envelope errors.
- Optional `Date` is accepted only after strict validation and emitted as ISO UTC; missing/invalid Date omits the timestamp.
- Runtime allowlist: `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx`. New focused test: `src/components/lms/teaching-plan/__tests__/CurriculumWorkRevisionReviewActions.support-information.test.tsx`. Documentation allowlist: `docs/development/error-handling.md`, `CHANGELOG.md`.
- Runtime changes map only to Spec §2.2 Case 6: import the existing projection, derive the static support area after the existing status refetch, and conditionally append one fourth toast argument.

Failures and how to do differently:
- No execution or verification failures occurred because the task was explicitly read-only. The proposed test/typecheck/lint/build commands were not run and must not be reported as executed.
- Do not modify the hook, service, central projection, toast helper, unrelated callers, or the oversized existing review-actions test file.
- Do not migrate GET, status, preview, continuation, cleanup, lease-release, postcommit, partial-commit, or other review-action failures in this slice.
- Do not infer implementation authorization from the plan; F1l requires separate explicit Go. Full Security Scan belongs before PR, not in this scout.

References:
- Start gate: `git rev-parse HEAD` = `a0916aa24373ccc51491e65f0aea97b1ec30ba69`; upstream `origin/chore/logging-improvements`; divergence `0 0`.
- `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx:409-416` — existing catch, status refetch, and exact three-argument toast.
- `src/hooks/lms/useGithubCurriculumTopicPathMigrations.ts:249-292` — serialized action mutation and `skipGlobalErrorToast`.
- `src/libs/githubCurriculumService.ts:159-178` — POST path, empty body, Idempotency-Key.
- `src/libs/utils/backendError.ts:199-309` — fail-closed support projection.
- Suggested commit: `feat: add GitHub path migration action support information`
