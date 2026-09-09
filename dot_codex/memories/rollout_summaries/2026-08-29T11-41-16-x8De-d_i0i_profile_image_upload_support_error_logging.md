thread_id: 01a04d52-f0bb-7ab3-a3b0-2ba88f267db8
updated_at: 2026-08-29T12:05:46+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T13-41-16-01a04d52-f0bb-7ab3-a3b0-2ba88f267db8.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# D-I0i profile-image upload support-error logging was implemented, verified, committed, and pushed

Rollout context: Backend repository `/Users/mrbubbles/dev/novari/novari-education-backend`, branch `chore/logging-improvements`, strict eight-file allowlist, no controller/router/global-handler/store/Cloudinary changes.

## Task 1: Implement D-I0i profile-image upload 500 logging

Outcome: success

Preference signals:
- The user required the “kleinsten” coherent slice, exact allowlist, explicit unchanged product behavior, and stop-on-drift gates -> future Logging V2 work should establish these gates before edits.
- The user required real Express/error-handler evidence rather than mock-only tests, strict privacy boundaries, request-local at-most-one behavior, and no broad matcher -> preserve this validation style.

Key steps:
- Verified branch, HEAD/upstream/direct remote, clean baseline, and authoritative spec hash `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`.
- Added a narrow matcher in `libs/observability/logger.js` for only marked `POST /upload-image`, final `500`, `INTERNAL_ERROR`, `Error` instances, `/upload-image` route metadata, and valid request IDs.
- Added the fixed schema-v2 tuple: `request.error`, `profile_image_upload`, `controller.profile.image_upload`, `/auth/profile/upload-image`, and fixed safe classification/fingerprint.
- Added schema acceptance for the exact contract and route template.
- Added matcher, schema/store, global-handler, and real controller-path regression coverage.
- Corrected incidental broad Prettier changes and retained only semantic slice changes.

Validation:
- Focused tests: `112/112` passed.
- `npm run lint`: passed.
- `node --check` for changed JavaScript: passed.
- `git diff --check`: passed.
- Full suite: `7411` tests, `7358` passed, `51` skipped, exactly `2` known unrelated baseline failures at `tests/hr/modelLookupMultiPersona.test.js:62` and `:77`.

Reusable knowledge:
- Express router unwinding can leave only relative `req.route.path`; the existing private `PROFILE_ROUTER_REQUEST` marker safely disambiguates ownership without persisting raw URLs or IDs.
- Deduplication is request-object-local: repeated handling of one request persists once; distinct requests sharing a request ID may each persist.
- Persistence failures are best-effort, non-retrying, non-recursive, and must not alter the original response.

## Task 2: Commit and push D-I0i

Outcome: success

Key steps:
- Revalidated exact eight-file allowlist, candidate diff SHA `f6a6b0a0069410e7a1c714694891bf38d25e8be9056161e3634fbe5d2d4445b9`, stable patch-ID `af3e8e221b33f2bc20fd8ee7cfaeaf0d952d9f07`, all target blobs, and direct remote baseline.
- Staged exactly the eight approved files and inspected staged name/status, diff, and `diff --check`.
- Created exactly one commit, no amend: `8fcf3d5f859bf1b1cb5636988020e09be2023d10`.
- Pushed normally with `git push origin HEAD:chore/logging-improvements`.
- Post-push verification: `HEAD = upstream = direct remote`, ahead/behind `0/0`, clean worktree/index.

References:
- Commit: `8fcf3d5f859bf1b1cb5636988020e09be2023d10`
- Parent: `c9f8f847520da32db856ff6dfacadbf28a931685`
- Message: `feat: persist profile image upload support errors`
- Commit stat: `8 files changed, 778 insertions(+), 10 deletions(-)`
- Files: `CHANGELOG.md`, `docs/project-docs/security/logging-policy.md`, `libs/observability/logger.js`, `models/audit/securityAuditEventSchema.js`, `tests/error/globalErrorHandlerPersistence.test.js`, `tests/observability/auditStore.test.js`, `tests/observability/logger.test.js`, `tests/profile/profileImageErrorProjection.test.js`
