thread_id: 019fe3a2-4b08-7683-bde9-6faff2f16b66
updated_at: 2026-08-12T20:45:06+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/09/rollout-2026-08-09T01-08-11-019fe3a2-4b08-7683-bde9-6faff2f16b66.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: curriculum-workrevision-continuity-phase-3

# Phase-3 Instructions-Block collaboration completed and browser-validated

Rollout context: Backend-first work in `/Users/mrbubbles/dev/novari/novari-education-backend`, with coordinated Portal work on the same Phase-3 branch. Phase 2 compatibility and strict no-CRDT/Phase-4 scope were preserved.

## Task 1: Phase-3 backend semantic collaboration slice

Outcome: success

Key steps:
- Read and reconciled Phase-2/3/4 contracts, real schema-v1 validators, OverviewRow schema, autosave receipts, WorkRevision persistence, transaction/CAS helpers, and audit/event models.
- Preserved the required model: allowlisted semantic targets, target-hash CAS plus global sequence DB-CAS, immutable receipts, cursor/change resync, no last-write-wins or arbitrary JSON Patch.
- Backend implementation was committed as `dc4d13f5` (`feat: collaborate on Instructions block content`), pushed, and verified HEAD==upstream with a clean worktree.
- Backend tests and broader validation were reported green: focused backend suite 174/174; full suite 6,295 passed, 51 skipped, 0 failures.
- Independent backend review returned GO with no P0–P3 findings.

Reusable knowledge:
- Real OverviewRow Minor allowlist is `orderIndex`, `resources`, `exerciseLinks`, `exerciseNotes`, and `teacherInstructions`; identity, lifecycle, review, provenance, computed, and snapshot fields remain excluded.
- Instructions semantic targets use `overview_page_block_field` plus stable `instructionBlockId`; changes are materialized by exact stable ID and are value-free in hints/audit/logging.
- Existing transaction retries must reread the Primary and target after races; never reuse a pre-race snapshot.

## Task 2: Portal Instructions collaboration slice

Outcome: success

Key steps:
- Portal implementation was committed as `bd0b9b67` (`feat: collaborate on Instructions block content`), pushed, and verified HEAD==upstream with a clean worktree.
- Exactly 22 reviewed Portal files were staged; staged diff and `git diff --cached --check` were clean.
- Portal focused tests: 605/605; full suite: 3,566/3,566; build green.
- Cross-repo final review returned GO with no P0–P3 findings.
- Semantic Instructions title/content/recommendations controls route through the Phase-3 target-specific path; unrelated changes retain existing fallback behavior.

## Task 3: Two-profile browser acceptance and diagnosis

Outcome: success (with an initially invalid observation corrected)

Preference signals:
- The user explicitly required real two-profile browser validation, fail-closed behavior on the first genuine product/contract finding, no speculative repair, and exact cleanup of agent-owned processes.
- The user corrected the tooling constraint: use the authorized Chrome/browser-client flow, not In-App Browser, Playwright CLI, or raw DevTools; future browser work should follow the explicitly authorized tool.
- The user repeatedly required no IDs, values, hashes, secrets, or sensitive content in metadata checkpoints.

Key steps:
- Gate A passed with two authorized profiles on the same Development WorkRevision, both editor-ready and warning-free.
- Two semantic mutations succeeded; metadata showed two successful WorkRevision modifications and no 409, Recovery, or whole-snapshot write.
- The first apparent stale-content finding was correctly stopped fail-closed, but later disproven as a measurement error: the test read `getAttribute('value')` on a controlled `<textarea>`, not the live `.value` property.
- Final read-only gate used live DOM evidence: content controls were textareas with equal/nonempty `.value`; both profiles showed 7 sections; recommendations had 33 controls with matching order/structure and equal/nonempty live values; both showed saved status and no warnings.
- No content mutation, conflict resolution, Recovery, queue/IndexedDB cleanup, or code change occurred during the diagnosis/gates.
- Backend processes were stopped with SIGINT after each gate; Port 5517 was confirmed free. Backend `dc4d13f5` and Portal `bd0b9b67` were clean and equal to upstream.

Failures and how to do differently:
- Do not infer controlled-input state from the HTML `value` attribute. Use the live DOM property (`.value`/`inputValue`) or independent authoritative API evidence.
- The existing value-free backend logs cannot distinguish ordinary Changes reads, exact counts, resync status, or checkpoint coherence; treat that as observability-open rather than claiming verification.
- A static Legacy XLSX adapter grouping path exists, but it was not causal for this fixture: its grouping predicate requires nonempty block content and empty recommendations, unlike the observed fixture.

References:
- Backend commit: `dc4d13f5`
- Portal commit: `bd0b9b67`
- Backend cwd: `/Users/mrbubbles/dev/novari/novari-education-backend`
- Portal cwd: `/Users/mrbubbles/dev/novari/novari-education-portal`
- Browser acceptance conclusion: prior stale claim was a `getAttribute('value')` observability false negative; final live-DOM result GREEN.
