thread_id: 01a05014-3e29-78e1-9873-cbd54047f945
updated_at: 2026-08-30T01:15:08+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T02-31-39-01a05014-3e29-78e1-9873-cbd54047f945.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/9d29/novari-education-backend

# Backend Logging V2 document-download slice implemented, privacy-corrected, reviewed, committed, and pushed

Rollout context: In `/Users/mrbubbles/.codex/worktrees/9d29/novari-education-backend`, the user required a tightly scoped Task C slice for six final document-download/preview `500 INTERNAL_ERROR` producers, with exact allowlist boundaries, unchanged product/response/streaming/success-audit behavior, no commit until separate review approval, and normal push only after freeze verification.

## Task 1: Implement six document-read Logging V2 producers

Outcome: success

Preference signals:
- The user required the “kleinsten” coherent slice, exact production/test/doc allowlists, no subagents, no commit/push in the first turn, and stopping on scope drift -> future implementation should establish baseline, branch, allowlist, and stop gates before edits.
- The user explicitly required request-local at-most-one persistence, not request-ID-global deduplication, and unchanged success/permission/audit ownership -> preserve this distinction in future Logging V2 work.
- The user required real Express route semantics and exact owner markers rather than mock-only route inference -> validate mounted router identity, owner marker, method, and `req.route.path` together.

Key steps:
- Verified baseline `242a5a80b3f663ff1f50ae943248d24e671e4c78`, main checkout branch `chore/logging-improvements`, upstream/direct remote identity, clean state, and `0/0` divergence.
- Reconstructed six route contracts and existing marker conventions. New Symbol.for owners used exactly: `novari.observability.router-owner.hr-pending-documents`, `novari.observability.router-owner.student-documents`, and `novari.observability.router-owner.class-manager-students`.
- Implemented all six producers only in `libs/observability/logger.js` and `models/audit/securityAuditEventSchema.js`; added focused contract/regression tests and documentation.
- Added a fail-closed `HIDRIVE_FILE_NOT_FOUND` own-data-property check after review found that this sentinel can lack an HTTP status and otherwise normalize as a false-positive 500.
- Verified eight focused test files: `190/190` passed; full `npm run lint`, five `node --check` checks, and `git diff --check` passed.

Reusable knowledge:
- The six exact mappings are:
  - `/auth/self-absence/download/:id` → `self_absence_attachment_download`, `controller.self_absence.attachment_download`, `self_absence`, relative `/download/:id`, existing self-absence marker.
  - `/auth/employees/my-documents/:documentId/download` → `employee_self_document_download`, `controller.employee.my_documents_download`, `employees`, relative `/my-documents/:documentId/download`, existing employee marker.
  - `/auth/hr/employees/:id/documents/:documentId/download` → `hr_employee_document_download`, `controller.hr_employee.document_download`, `hr`, relative `/:id/documents/:documentId/download`, existing HR-employee marker.
  - `/auth/hr/pending-documents/:id/preview` → `hr_pending_document_preview`, `controller.hr_pending_documents.preview`, `hr`, relative `/:id/preview`, Symbol.for pending-documents marker.
  - `/auth/student/documents/:documentId/download` → `student_document_download`, `controller.student.document_download`, `student`, relative `/:documentId/download`, Symbol.for student-documents marker.
  - `/auth/classmanager/students/:id/documents/:documentId/download` → `classmanager_student_document_download`, `controller.classmanager.student_document_download`, `class_manager`, relative `/:id/documents/:documentId/download`, Symbol.for class-manager marker.
- Every event uses the fixed tuple: `INTERNAL_ERROR`, `reasonCode=INTERNAL_ERROR`, HTTP 500, `failedStage=unexpected`, `causeClass=unknown`, `failureMode=unexpected_error`, `retryability=unknown`, `supportDisposition=engineering_investigation`, `impact=unknown`, with optional existing HMAC `actorHash`; no target fields, raw IDs, URLs, paths, provider text, or raw errors.
- Same request object is guarded by `SUPPORT_ERROR_ATTEMPTED`; distinct request objects sharing a request ID remain independent.
- `HIDRIVE_FILE_NOT_FOUND` must be rejected before document-read matching using a safe own data-property descriptor check, avoiding accessors and preserving the no-event boundary.

References:
- Initial freeze: baseline/direct remote `242a5a80…`, clean main checkout, task worktree detached at baseline.
- Initial candidate diff SHA-256 `8d87312402d46ef8d29e8803b805373b630681b73c5e62b4d7984bb1eb70419f`; corrective freeze diff SHA-256 `80dc02adfcba0ffeda178bf5098f18b68727b390f8415dee37a28c01c0a41067`.
- Corrective stable Patch-ID: `8c3e34e9c37dc5e9f1f39ebf7e62297a9eb6285e`.
- Corrective schema validator: `hasValidSchemaV2TargetHash` allows a target hash only for `COURSE_ARCHIVE_CERTIFICATE_GENERATION_FAILED`; all other V2 contracts require `targetHash === undefined`.

## Task 2: Close accepted targetHash privacy finding

Outcome: success

Key steps:
- Fixed the schema boundary so valid 64-hex `targetHash` is accepted only by the existing Course Archive contract, where it is required; all other V2 contracts reject it. `targetType` remained contract-bound.
- Added tabular negative tests proving all six document-read contracts reject both `targetType` and a valid 64-hex `targetHash`, while the Course Archive positive remained green.
- Re-ran the complete agreed matrix: `190/190` passed; Audit Store test alone passed `35/35`; full lint, syntax, and diff checks passed.

References:
- Final candidate had exactly seven modified allowlist files and no untracked files.
- Final blobs included `securityAuditEventSchema.js` `6278fbff7be0ddb9f77cca778203db925d153ac8` and `auditStore.test.js` `e35016ffb358b937b9c753248664c7e3d6e9becc`.
- Focused re-review reported no remaining P0–P3 findings.

## Task 3: Commit and normal push

Outcome: success

Preference signals:
- The user authorized only the exact frozen candidate and explicitly prohibited amend, force push, rebase, squash, matrix/spec changes, and test reruns at identical freeze -> future release steps should perform identity-only verification, then one normal commit/push.

Key steps:
- Revalidated freeze hashes, seven staged files, clean main checkout, upstream/direct remote at baseline, and `git diff --check` before commit.
- Created commit `65dbc607f98b20ea0ecc8ff5e121a79344fa1fdd` with parent `242a5a80b3f663ff1f50ae943248d24e671e4c78`.
- Commit message: `feat: add document download support event producers`; body documents fixed six-route outcomes and target-identifier rejection.
- Pushed normally with `git push origin HEAD:chore/logging-improvements`.
- Post-push verified task HEAD, tracking ref, and direct remote all equal `65dbc607f98b20ea0ecc8ff5e121a79344fa1fdd`, divergence `0/0`, task worktree clean, and commit diff clean.

Failures and how to do differently:
- Initial implementation allowed `targetHash` for any schema-v2 contract if it matched 64-hex format. The independent review caught this privacy-contract gap; future schema validators must enforce both shape and selected-contract ownership.
- Initial review also exposed the status-less `HIDRIVE_FILE_NOT_FOUND` false-positive path; expected storage sentinels must be excluded even when normalization would otherwise produce 500.
- Full suite was intentionally not run because the repository has a known hanging full suite and the user explicitly requested focused verification.

Unruns/rest uncertainties: no browser, real data, or full repository suite; separate high-review was completed before commit and push.
