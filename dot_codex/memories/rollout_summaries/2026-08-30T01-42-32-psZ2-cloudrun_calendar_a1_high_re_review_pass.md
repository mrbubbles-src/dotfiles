thread_id: 01a05055-245e-7f00-88aa-b3060bcfb640
updated_at: 2026-08-30T02:06:11+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T03-42-32-01a05055-245e-7f00-88aa-b3060bcfb640.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# CloudRun calendar proxy A1 review and corrective re-review

Rollout context: Strict read-only High Baseline→Candidate reviews in `/Users/mrbubbles/dev/novari/novari-education-backend`, with candidate worktree `/Users/mrbubbles/.codex/worktrees/766d/novari-education-backend`. Scope was exactly three calendar controllers plus `tests/calendar/cloudRunErrorProjection.test.js`; no subagents, edits, staging, commits, pushes, or write-effect tests.

## Task 1: Initial A1 High-Diff Review

Outcome: partial

Preference signals:
- The user explicitly required “Strikt read-only”, “Findings zuerst P0–P3”, “Keine Subagents”, and no reliance on earlier claims -> future reviews should independently verify scope/freeze and report findings before summary.
- The user required realistic controller→router→global-handler evidence and preservation of prior regression coverage -> tests should not replace real boundaries with internal mocks.

Key steps:
- Verified baseline `65dbc607f98b20ea0ecc8ff5e121a79344fa1fdd`, exact allowlist, detached candidate worktree, clean main checkout, and freeze hashes.
- Reviewed production changes: all three controllers now accept `next`; only known `FORBIDDEN_READ`/invalid-range messages remain local; unknown errors call `next(e)`.
- Found two P2 test-evidence defects: the test replaced real Mapping/Timing/CloudRun boundaries with `mock.module` mocks and removed existing real Router/Auth/Health regression cases; its `headersSent` test pre-set `headersSent` before controller entry rather than causing a failure during send.

Failures and how to do differently:
- Preserve existing real Express/Router/Auth/Health tests and mock only the external `fetch` boundary.
- Exercise `headersSent` by making `send()` mark headers sent and then throw; verify one controller delegation, one global delegation, and no second JSON response.

## Task 2: Corrected A1 High-Re-Review

Outcome: success

Key steps:
- Re-read the complete corrected diff and confirmed the production blobs were unchanged.
- Confirmed all baseline `/calendars`, Health, local 400/403, upstream-status, success, MIME, and byte-preservation cases were restored.
- Confirmed no `mock.module` remained; Mapping, Timing, CloudRun auth, Router, role middleware, and global handler run through real paths, with only external fetch replaced.
- Confirmed realistic send failure: `send()` marks `headersSent`, throws, controller forwards once, global handler delegates once, and no JSON response is emitted.
- Verified no calendar audit/D-producer/persistence changes; `persistSupportErrorEvent` has no calendar allowlist.
- Independent checks passed: focus `21/21`, Global/Envelope `70/70`, combined Persistence+Calendar `78/78`, syntax `4/4`, ESLint `4/4`, and `git diff --check`.
- Final post-freeze matched: diff SHA-256 `d819330b89dfba613b9a55ed1e5f739b47d3cbb0c1865130f9214cfa360cc5f6`, Patch-ID `5c91d34efad0d87a4489d4233abf5f634fa8941c`, exact four unstaged files, no staged/untracked files, and main/upstream/direct remote all `65dbc607…` at `0/0`.

Reusable knowledge:
- For this A1 contract, known 403/400 branches and returned `out.status >= 400` responses remain local; thrown structured 502 errors must reach the global handler unchanged as `UPSTREAM_FAILURE`; plain unexpected errors become generic 500 `INTERNAL_ERROR`.
- `globalErrorHandler` logs sanitized errors, preserves request IDs, and delegates unchanged when `res.headersSent` is true.
- The candidate worktree had no dependencies. A read-only test run required resolving packages from the clean main checkout via a temporary Node ESM resolver; sandboxed local HTTP servers failed with `listen EPERM`, while the same test run outside the sandbox passed.

References:
- Production files: `controller/calendarController/roleCalenderDates.js`, `controller/calendarController/absenceCalender.js`, `controller/calendarController/courseCalender.js`.
- Test file: `tests/calendar/cloudRunErrorProjection.test.js`.
- Route mount: `app.js:372`; global handler: `app.js:391`, `error/globalErrorHandler.js:614`.
- Final result: “HIGH-RE-REVIEW PASS”, with no P0–P3 findings and no repository mutation.
