thread_id: 01a02b07-bb91-7f92-b728-ca10219ffbea
updated_at: 2026-08-22T20:08:47+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T21-52-02-01a02b07-bb91-7f92-b728-ca10219ffbea.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Portal Logging-V2 F1 Curriculum-Struktur erfolgreich implementiert und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline/Origin `fcace9ee4beaa3399d631255be609872e001de5b`, initial worktree clean and upstream `0/0`. The user required a strict six-file allowlist, no delegation, no commit/push before independent review, and exact preservation of API, CAS, retry, success, invalidation, hook, and UI behavior.

## Task 1: F1 Curriculum structure toast ownership

Outcome: success

Preference signals:

- The user specified an exact allowlist and repeatedly required: “Stop if hooks/queryClient/apiClient/lmsModuleService/components/7th file/payload/CAS/retry/success changes needed.” This indicates future implementation should fail closed on production-scope drift and preserve unrelated contracts rather than opportunistically broadening the fix.
- The user explicitly clarified that mechanically necessary test-file changes do not require a new scope approval: “Testdateien sind ... ausgeschlossen ... mir geht es nur um Production Code.” Future slices should still constrain production code strictly while allowing directly necessary test updates.
- The user required independent review before commit/push and a canonical freeze artifact. Future repository tasks should freeze the exact tracked+untracked candidate, review the actual diff, and only then commit/push.

Key steps:

- Verified branch, HEAD, origin, upstream, and clean starting state.
- Read the normative Logging V2 specification and visualization, repository skills, and relevant memory.
- Traced the seven targeted versioned writes: module create/attach/remove, submodule create/attach/remove, and structure materialization.
- Added request-local `LOCALLY_HANDLED_REQUEST_CONFIG` to exactly those seven service requests. DELETE calls preserve the existing body under `config.data` while merging `skipGlobalErrorToast`.
- Added service transport assertions and two production-queryClient hook ownership suites covering 500/502/503, 409 refresh, malformed/missing envelopes, non-Axios fallback arity, retry `0`, original error identity, success and invalidation behavior.
- Updated only the narrow error-handling documentation and changelog entries.
- A regression stop gate initially identified nine stale expectations in an existing test file; the user authorized the mechanically necessary test-only extension, after which the full relevant suite passed.
- Independent final review reported no P0–P3 findings and Spec continuity `aligned`.
- Canonical pre-commit freeze: `NOVARI-FREEZE-V1 = 2773ac6e666e7a399f3bf76099bf7ceddc1b6595e982ebe2b1688f36f290a78a`.
- Committed and pushed normally as `ace2c4ba93e8d1d170358e0d6b688301e3921a0c` (`fix: deduplicate curriculum structure error toasts`).

Failures and how to do differently:

- Initial `git add` failed because `.git/index.lock` creation was not permitted; rerunning with the required elevated permission succeeded. This was an environment permission issue, not a code failure.
- An earlier broader slice hit stale existing test expectations outside the original allowlist. The correct response was to stop, explain the exact mechanical test-only mismatch, and obtain the user’s clarified rule before editing tests.
- Full lint remained at the known baseline: 4 errors and 6 warnings outside the diff. Focused lint on the changed files passed; do not “fix” unrelated baseline lint during similar slices.

Reusable knowledge:

- Production `queryClient` uses a global `MutationCache` as the mutation toast owner; mutation defaults have retry `0`.
- `apiClient` emits automatic 500/502/503 toasts unless request config contains `skipGlobalErrorToast`; request-local opt-out prevents duplicate transport and MutationCache ownership.
- Hook `onError` remains limited to one 409 detail refresh; no hook or query-client behavior changes were needed.
- DELETE request configuration must merge as `{ ...LOCALLY_HANDLED_REQUEST_CONFIG, data }` so `expectedAggregateRevision` remains the exact request body.
- The classic module service, adjacent template/catalog/version/certification writes, reads, payloads, responses, CAS semantics, invalidations, success feedback, and UI were intentionally unchanged.
- Canonical freeze hashing includes tracked binary full-index diff plus sorted untracked file contents; use full object indexes to avoid false hash drift.

References:

- `src/libs/lmsCurriculumService.ts`: seven request-local opt-outs; DELETE config/data merge.
- `src/libs/__tests__/lmsCurriculumService.test.ts`: exact request args, URLs, bodies, and adjacent unaffected calls.
- `src/hooks/lms/__tests__/useLmsModules.errorOwnership.test.tsx`
- `src/hooks/lms/__tests__/useLmsCurriculum.structureErrorOwnership.test.tsx`
- `docs/development/error-handling.md`, `CHANGELOG.md`
- Verification: focused 120/120; full suite 4245/4245 across 371 files; typecheck, Prettier, focused ESLint, diffcheck, and build green; full lint baseline only.
- Final commit: `ace2c4ba93e8d1d170358e0d6b688301e3921a0c`; branch clean and upstream `0/0`.
