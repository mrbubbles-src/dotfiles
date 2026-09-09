thread_id: 019fd413-15b3-7b03-aa77-44774e53ffae
updated_at: 2026-08-12T22:20:52+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/06/rollout-2026-08-06T00-37-28-019fd413-15b3-7b03-aa77-44774e53ffae.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: curriculum-workrevision-continuity-phase-3

# Novari Curriculum WorkRevision collaboration rollout

Rollout context: Work was performed against the JavaScript backend only, primarily `/Users/mrbubbles/dev/novari/novari-education-backend`, with coordinated Portal work. The user required minimal, contract-first, fail-closed implementation, preserving Phase-1 provenance and avoiding Production writes.

## Task 1: Phase-2 shared WorkRevision contract

Outcome: partial

Preference signals:
- The user explicitly required: “ausschließlich dieses JavaScript-Backend”, no TypeScript backend, minimal invasive changes, no Production data/migrations/deployments, no PR/merge without later approval, and regular spec/review checkpoints. Future agents should preserve these boundaries by default.
- The user required Orchestrate, RED→GREEN contract tests, focused review before persistence/authorization changes, and commit-writer usage with verified incremental commits.
- The user emphasized no automatic merge magic: stale writes must never silently overwrite data; existing Sequence/CAS/Fence/EditSession/Recovery/Audit contracts should be reused.

Key steps:
- Verified branch `refactor/curriculum-workrevision-continuity-phase-2`, clean worktree, JavaScript backend, and read the Phase-1 Portal specification plus current backend contract.
- Read-only scouts concluded that `createdBy` currently drives authorization across the lifecycle, while Phase 2 would require shared version-scoped access across open/autosave/session/Recovery/merge/review/export/Topic paths.
- Added an additive Phase-2 specification and linked it from README/project docs, explicitly keeping Phase-1 behavior as the current runtime contract until implementation and rollout.
- The spec proposed one shared open Primary per Curriculum-Version, immutable `createdBy` provenance, role-based access for `pdl`/`lmsSupport`, sequence-CAS plus durable Recovery for races, no automatic merge/presence/WebSocket system, and duplicate preflight before any shared unique index.

Failures and how to do differently:
- No Phase-2 implementation was completed in this rollout; only analysis/specification work was evidenced. Do not treat the proposed shared-primary contract as implemented.
- A major risk identified by scouts: changing only the unique index is insufficient because owner-bound authorization is spread across many services. Future work must inventory and update every access boundary, not just Open.

Reusable knowledge:
- Current canonical model: `CurriculumVersion` is the structural/lifecycle aggregate, `CurriculumOverview` is planning state, and `CurriculumWorkRevision` is editable/reviewed/published state; legacy takeover provenance must remain readable.
- Existing Phase-1 routes/contracts include continuity context and takeover; normal Phase-2 collaboration should not use takeover.
- Existing WorkRevision schema contains `createdBy`, `editSessionFence`, sequence fields, lifecycle/review states, Recovery metadata, takeover provenance, and indexes including `curriculum_work_revision_continuity_candidate_lookup`.

References:
- Branch: `refactor/curriculum-workrevision-continuity-phase-2`
- Spec added: `docs/project-docs/curriculum/curriculum-work-revision-continuity-phase-2.md`
- Current contract: `docs/project-docs/curriculum/curriculum-work-revisions.md`
- Relevant code: `libs/lms/curriculumWorkRevisionRepository.js`, `curriculumWorkRevisionSessionOperations.js`, `curriculumWorkRevisionService.js`, `curriculumWorkRevisionTakeoverService.js`
- Existing route file: `_lms/router/lmsRouter.js`

## Task 2: Phase-3 Instructions collaboration slice

Outcome: success for implementation/review; browser proof initially failed closed, then the failure was reclassified as a test observability issue

Preference signals:
- The user constrained the slice to Instructions block `title`, `content`, and ordered `recommendations`, reusing proven Icebreaker primitives; no migration, new platform, adapter rewrite, ID generation, Automerge/LWW, or structural Block Add/Delete/Reorder changes.
- The user repeatedly required exact page-specific discriminated IDs, fail-closed malformed/duplicate handling, value-free errors/socket hints, Full-only behavior, no Browser/commit before shared review, and no further mutation after the first real browser finding.
- The user explicitly corrected the browser policy: existing authenticated Chrome profiles were allowed and should be used via the Chrome plugin, not the in-app browser, standalone Playwright CLI, or raw DevTools.

Key steps:
- Backend RED had 14 expected failures, then reached focused `174/174` green; full suite reported `6346 total / 6295 pass / 51 skip / 0 fail`.
- Backend final review: GO, no P0–P3 findings; 19 scoped files, no migration.
- Portal reached `605/605` focused and `3566/3566` full tests, build/lint/Prettier/diff checks green; known clean-HEAD fixture/typecheck baseline issues were separated.
- Cross-repo review passed; commits were pushed: backend `dc4d13f5`, Portal `bd0b9b67`; both were clean/upstream.
- Browser test first stopped fail-closed after an apparent stale Content result. Independent diagnosis established that the controlled `<textarea>` had been checked using `getAttribute('value')`, not the live `.value`/`inputValue`; no independent evidence proved a product defect. A later read-only gate confirmed equal nonempty live textarea values in both profiles, equal Recommendations structure/order, saved status, and no warnings.
- The final user-requested next step was a brand-new diagnosis thread, not the old Phase-3 thread, because manual two-profile testing exposed missing Presence, delayed/unclear Changes visibility, repeated server-version conflicts, broken comparison/restore behavior, and unexpectedly broad diffs. The new thread was created with ID `019ff80f-ee0e-71a3-aa37-b3e47f1d5306`; it started a fresh read-only checkpoint.

Failures and how to do differently:
- The browser stale finding was caused by invalid observability: never use `getAttribute('value')` for controlled textareas; use live DOM `.value`/`inputValue` and, where needed, authoritative Open/Changes evidence.
- The final browser gate did not prove exact per-request HTTP Changes counts because value-free backend logs did not distinguish those reads. Report this as observability-open, not as a product failure.
- The user’s later manual report remains important and unresolved: no Presence UI, delayed foreign-change visibility, repeated server-version conflicts, restore/compare failure, and broad unexpected differences. The fresh diagnosis thread was only started; no fix was implemented in this rollout.

Reusable knowledge:
- Instructions targets are page-specific and must never be routed through the generic legacy Instructions adapter. Canonical snapshot cloning must mutate only the exact addressed block field while preserving IDs/order/other fields.
- Recommendations use ordered whole-list CAS; title/content use the existing scalar contract. Malformed or duplicate IDs must produce zero Receipt/Change/Write; a valid missing target produces idempotent `TARGET_NOT_FOUND`.
- Browser acceptance should use two authenticated Chrome profiles, exact live-property checks, and fail closed on the first genuine product discrepancy.

References:
- Backend commit: `dc4d13f5`
- Portal commit: `bd0b9b67`
- Fresh diagnosis thread: `019ff80f-ee0e-71a3-aa37-b3e47f1d5306`
- Backend readiness used Port `5517` with controlled agent-owned sessions; processes were stopped and the port confirmed free after each gate.

