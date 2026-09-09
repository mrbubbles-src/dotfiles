thread_id: 01a026ba-7fc8-7c00-bc7d-58d13ed744fd
updated_at: 2026-08-21T23:55:19+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T01-49-11-01a026ba-7fc8-7c00-bc7d-58d13ed744fd.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only scout selected the next coherent Portal Logging V2 F1 slice

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`; strict read-only investigation, no edits/tests/formatters/network operations. Current branch `chore/logging-improvements`, clean, HEAD `3848d1b23c1a9cb5fb316a6acf6b97c64223e9ad`, upstream `0/0`.

## Task 1: Select and scope the next F1 producer slice

Outcome: success

Preference signals:
- The user required the “kleinsten” coherent reviewable slice, findings-first output, exact production/test/documentation allowlists, explicit unchanged flows, and fail-closed stopping on scope or authorization drift. Future Logging V2 planning should preserve these defaults.
- The user prohibited delegation, edits, tests, formatters, Fetch/Pull, Commit/Push, and required F1 security constraints including conditional fourth toast arity, static areas, no raw/actionHint/context/URL/query/user data, unchanged mutation/follow-up/lease behavior, and a later full security scan.

Key steps:
- Verified branch, baseline, cleanliness, and upstream state.
- Read current `AGENTS.md`, orchestration/reviewability guidance, V2 specification, visualization, error-handling documentation, changelog, and slice-plan artifacts.
- Re-verified current code rather than relying on historical notes.
- Compared candidate boundaries: Review-Desk migration reads, Topic GET/claim, GitHub image upload, Review-Desk mutations, structure-reorder preview, Topic editor ownership, and normal Topic status 5xx.
- Selected **F1r – Review-Desk path-migration reads**, combining eligibility GET and exact migration-status GET because both share the same Review-Desk owner and quiet/fail-closed read contract; splitting them would be unnecessarily microscopic.

Reusable knowledge:
- `src/libs/githubCurriculumService.ts` makes both migration GETs quiet via `skipGlobalErrorToast: true`.
- `src/hooks/lms/useGithubCurriculumTopicPathMigrations.ts` uses `retry: false`; eligibility is loaded only for the exact approved review, and status polling is bounded and keyed by exact migration identity.
- `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx` owns both errors locally with separate deduplication refs (`shownMigrationQueryErrorRef` and `shownMigrationStatusErrorRef`), preserving distinct toasts even for identical errors.
- The proposed runtime change is limited to conditional support-information extraction for genuine backend GET failures. Invalid/incomplete envelopes retain exactly the legacy three-argument toast call; never pass `undefined` as argument four.
- Candidate production allowlist: only `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx`. Proposed focused test: `src/components/lms/teaching-plan/__tests__/CurriculumWorkRevisionReviewActions.previewSupportInformation.test.tsx`. Proposed docs: `docs/development/error-handling.md` and `CHANGELOG.md`.
- Explicitly unchanged: service endpoints/parameters, query keys, enabled/retry/polling budgets, fail-closed action gating, skeletons, Preview/Action/Continuation/Refetch, roles, CAS/idempotency/invalidation, post-commit/certification/lease warnings, and all F2/LMS behavior.

Failures and how to do differently:
- Repository search did not reveal a project file literally named Logging-Slice-Gate; the investigation correctly used the embedded user rules, V2 spec §§14–16, and current repository/project artifacts instead of inventing a missing artifact.
- Do not combine Topic GET, adoption claim, image conversion, local draft persistence, and navigation: they have mixed owners and materially higher duplicate-toast risk.
- Do not combine GitHub image upload with dialog/catch ownership; it has interceptor, hook, and dialog error paths.
- Do not include normal Topic-status 5xx or F2/LMS in this slice; they are separate explicitly authorized work.

References:
- Baseline: `chore/logging-improvements`, `3848d1b23c1a9cb5fb316a6acf6b97c64223e9ad`, clean, upstream `0/0`.
- `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx:215-239` — separate eligibility/status error owners and refs.
- `src/hooks/lms/useGithubCurriculumTopicPathMigrations.ts:96-155` — exact query/status contracts, `retry: false`, bounded polling.
- `src/libs/githubCurriculumService.ts:107-154` — quiet eligibility/status GET services.
- Proposed commit message: `feat: add path migration read support information`.
- Required post-Go checks listed by the scout: focused tests, typecheck, lint, full test, build, Prettier check, diff check, independent actual-diff review, Security Diff Scan with scan ID/coverage, then full Security Scan before PR.
