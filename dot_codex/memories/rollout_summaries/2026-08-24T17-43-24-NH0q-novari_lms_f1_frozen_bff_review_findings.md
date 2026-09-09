thread_id: 01a034de-ae8b-70c1-99fb-2a88a2c302be
updated_at: 2026-08-24T17:52:54+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-43-24-01a034de-ae8b-70c1-99fb-2a88a2c302be.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-lms
git_branch: chore/logging-improvements

# Read-only NOVARI Logging V2 F1 review found four actionable issues

Rollout context: Independent, findings-first, read-only review of the frozen 11-file LMS diff on `chore/logging-improvements`. No edits, tests, formatting, commits, or pushes were performed.

## Task 1: Frozen F1 Topic/self-learning BFF review

Outcome: success

Preference signals:
- The user required an isolated reviewer, exact allowlist, freeze verification, and “bei irgendeiner Abweichung sofort stoppen” -> future reviews must verify repository identity and the complete canonical freeze before inspecting hunks.
- The user explicitly required read-only behavior and findings-first P0–P3 reporting -> do not modify or test the candidate and lead with concrete findings.

Key steps:
- Read `AGENTS.md`, Logging V2 Spec/Visualization, reviewer references, and the Novari slice-gate skill.
- Verified repository `/Users/mrbubbles/dev/novari/novari-education-lms`, branch `chore/logging-improvements`, HEAD `7bf7aa8bde6cd6d55a3c5922fd46dc7850a8eb30`, upstream `0/0`, exactly 11 allowlisted modified files, and no untracked files.
- Recomputed the canonical `NOVARI-FREEZE-V1` twice: hash `06b3452137c917f04573a65e5954ec6d0853645481813ffa1323f0f917070990`, tracked diff `36586` bytes, serialized stream `36633` bytes.
- Reviewed the complete diff, shared projection, both route handlers, `lib/data/db.ts`, consumers, tests, and the real backend producer shape.

Findings:
- [P1] `lib/errors/server/backend-error-projection.ts:337` only accepts legacy locked bodies with `{code,message,requestId?}`. The real backend producer returns an additional own `status: "error"` field (`topicLookupController.js:447-452, 484-489`). Therefore real `LMS_CONTENT_LOCKED` responses fall back to `REQUEST_FAILED`; `lib/data/db.ts:36` returns `missing`, and both pages render `notFound()` instead of `LockedContentNotice`. Tests use an unrealistic fixture without `status`.
- [P2] `app/api/modules/get-entry/route.ts:60` and `get-self-learning-entry/route.ts:61` leave initial fetch, refresh, and replay fetch rejections uncaught. Network failures bypass the shared projector and do not return the required `503 BACKEND_UNAVAILABLE` projection. Tests cover resolved responses but not these rejection boundaries.
- [P2] `backend-error-projection.ts:356` passes through arbitrary legacy locked messages after narrow negative regex checks. Names, ObjectIds, free text, or framework details can still pass. The explicit legacy locked code should use only the static locked message.
- [P2] The projector suppresses a valid header-only `X-Request-Id` when the body is malformed/unreadable (`backend-error-projection.ts:402`); tests at `modules-get-entry.test.ts:91` and `modules-get-self-learning-entry.test.ts:194` encode this loss. Preserve independently valid header IDs; suppress only malformed or conflicting IDs.

Failures and how to do differently:
- Do not treat tests as proof when fixtures omit fields emitted by the real backend. Cross-check producer response shapes before accepting strict validators.
- F2 requires network-error handling as well as HTTP-error projection; add catches around initial fetch, refresh, and replay fetch, preserving cookies where applicable.
- Use positive allowlisting/static copy for special legacy codes rather than heuristic message filtering.
- Request-ID continuity should retain a valid header ID when no trustworthy body ID exists, while still rejecting malformed/conflicting combinations.

Reusable knowledge:
- The canonical mixed tracked/untracked freeze uses `git diff --binary --full-index --no-ext-diff HEAD --` plus sorted raw untracked serialization under `NOVARI-FREEZE-V1`; a mismatch is a hard stop.
- `lib/data/db.ts` now uses the real shared parser and rejects extra fields, inherited properties, accessors, and malformed request IDs fail-closed; those areas were otherwise clean.
- Successful responses, status semantics, auth replay, cookies, and product request paths were unchanged in the reviewed diff.

References:
- [1] Freeze result: `06b3452137c917f04573a65e5954ec6d0853645481813ffa1323f0f917070990`, `36586/36633`, no untracked files.
- [2] Real backend locked shape: `/Users/mrbubbles/dev/novari/novari-education-backend/_lms/controller/topic/topicLookupController.js:447-452,484-489` includes `status: "error"`.
- [3] Findings: `backend-error-projection.ts:337,356,402`; route fetches at `app/api/modules/get-entry/route.ts:60` and `get-self-learning-entry/route.ts:61`.
- [4] No tests or mutations were executed, as required by the review scope.
