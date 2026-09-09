thread_id: 01a071a6-0620-7d91-9cea-b9113cc549b0
updated_at: 2026-09-05T16:56:00+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T14-58-21-01a071a6-0620-7d91-9cea-b9113cc549b0.jsonl
cwd: /Users/mrbubbles/dev/private/projects/faverelay
git_branch: codex/multiway-sync-profiles

# Continued Faverelay multiway sync through Slice 21 and stopped at the requested boundary

Rollout context: `/Users/mrbubbles/dev/private/projects/faverelay`, branch `codex/multiway-sync-profiles`. The handoff required continuing from completed Slices 1–18, then the rollout progressed through live-matrix hardening, Firefox Slice 20, and Safari Slice 21. The user’s standing stop rule was honored: do not start Slice 22.

## Task 1: Slice 19 live-matrix hardening

Outcome: success

Preference signals:
- The handoff explicitly required: “Never mutate Chrome, never close Edge,” explicit synthetic profile allowlists, independent review before live execution, and truthful skipped-live reporting. Future QA should preserve these constraints by default.
- The user/workflow requires copy-based verification before real-browser QA and installed-app testing via `/Applications/Faverelay.app`, not only SwiftPM artifacts.

Key steps:
- Replaced broad profile discovery with explicit `--allow-profile browser=/absolute/profile/Bookmarks` entries.
- Added hard Chrome exclusion, browser-root/path validation, symlink/hard-link rejection, marker-only scope (`Faverelay Live Matrix`), synthetic URL prefix checks, runtime fail-closed behavior, one backup per store, exact restoration, redacted reports, and planner-driven forward/reverse sync checks.
- Added copied-store safety, runner, command, and planner tests; fixed a report-path traversal/case-bypass finding during review.
- Installed Edge/Brave QA passed typed mutations, planner forward/reverse sync, open-Edge blocking, independent continuation, exact restoration, and empty-marker UI read-back. Chrome was not accessed and Edge was not closed.

Reusable knowledge:
- Live-matrix evidence is intentionally narrower than general product verification: it proves the typed mutator/planner path and restoration, not all UI, scheduler, or Ledger flows.
- Reports must contain opaque store IDs/outcomes only and must never overwrite existing files or write inside browser storage.

References:
- `Sources/Faverelay/Services/LiveMatrixCommand.swift`
- `Sources/FaverelayCore/LiveMatrixSafety.swift`
- `Sources/FaverelayCore/LiveMatrixSession.swift`
- `Sources/FaverelayCore/LiveMatrixSyncScenario.swift`
- Commit `22f80ad test: harden live multiway matrix`; installed QA closeout `62e69de`.

## Task 2: Slice 20 Firefox multiway

Outcome: success

Key steps:
- Implemented independent Firefox Places schema-86 mutation with GUID identity, transactional typed edits, WAL/SHM handling, integrity/foreign-key checks, replay/idempotence, mixed Chromium/Firefox recovery, and exact copied-database restoration.
- Verified copied database behavior, Firefox reopen, preservation of history/separators/unmanaged data, and planner/apply/Ledger integration.

Reusable knowledge:
- Firefox support remains restricted to verified existing Places schema 86 databases; unsupported schemas and missing-folder creation stay blocked.
- No installed Faverelay UI against a personal Firefox profile was used.

References:
- `Sources/FaverelayCore/FirefoxBookmarkMutator.swift`
- Firefox evidence: `documentation/qa/2026-09-05-firefox-copied-database.md`
- Commit `efd23ad feat: sync Firefox bookmark changes`.

## Task 3: Slice 21 Safari gated validation

Outcome: success

Preference signals:
- The user/workflow favors capability gates over optimistic enablement: Safari must remain read/source-only until native mapping, format preservation, installed-app write, reopen, and restore are all proven.
- The rollout stopped after the completed slice; Slice 22 was not started.

Key steps:
- Added UUID-scoped Safari plist mutation for create/update/move/reorder/delete, shared-store batching, atomic replacement, unknown-field/opaque-node preservation, deterministic pinned requests, and mixed-store recovery integration.
- Added `SafariFavoritesMapping`, validating custom `CustomFavoritesFolderServerID` ↔ plist `Sync.ServerID` associations and the native default `BookmarksBar`; profile names or UUIDs alone do not prove mapping. Invalid, duplicate, or case-colliding UUIDs fail closed.
- Added a lossless serialization guard: sparse native lists and XML-lossy values such as fractional dates are rejected before writes rather than silently altered.
- Native copied Safari data was inspected read-only. The native plist was safely rejected because some folders omit `Children`; its SHA-256 and bytes remained unchanged. Native mapping validation resolved 2/2 profiles, but native write/reopen/restore was not performed.
- Rebuilt and installed `/Applications/Faverelay.app` with stable local signing. Installed bundle baseline and Safari access audit passed; this proves access, not productive Safari mutation.
- Full verification passed: `swift build -j 1`, `swift test -j 1` (537 tests / 56 suites), `swift run -j 1 FaverelayParserTests`, App Store source baseline, `git diff --check`, cross-process pinned replay, and independent HIGH-REVIEW PASS with no open P0–P3 findings.
- Committed as `b097d6a feat: add gated Safari multiway mutation support`; working tree was clean and nothing was pushed.

Failures and how to do differently:
- Initial Safari XML serialization silently lost fractional date precision; the fix was a recursive typed plist round-trip check that throws `unsupportedLossySerialization` before preparation/write.
- Initial mapping accepted noncanonical/invalid UUID forms and did not handle sparse native folders; mapping now canonicalizes UUID identity and the mutator deliberately rejects sparse native structures.
- Do not infer productive Safari support from access-audit success, fixtures, or copied-store mutation alone.

Reusable knowledge:
- Safari profiles share `~/Library/Safari/Bookmarks.plist`; profile metadata comes from `SafariTabs.db`, opened through the app’s immutable SQLite path.
- Safari remains read/source-only after Slice 21. Follow-up work must first resolve sparse-list/native format contracts, connect proven mapping to production discovery/snapshots, then separately prove installed-app write/reopen/restore.
- Slice 22 (Arc) and Slice 23 were intentionally not started.

References:
- `Sources/FaverelayCore/SafariBookmarkMutator.swift`
- `Sources/FaverelayCore/SafariFavoritesMapping.swift`
- `Sources/Faverelay/Services/MultiwayBookmarkMutation.swift`
- `documentation/qa/2026-09-05-safari-gated-validation.md`
- Handoff: `documentation/codex-handoffs/2026-07-19-multiway-sync-profiles.md`
- Final commit: `b097d6a`.

