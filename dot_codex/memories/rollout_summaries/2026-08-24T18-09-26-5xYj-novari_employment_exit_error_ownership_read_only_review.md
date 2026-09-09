thread_id: 01a034f6-8587-7893-a0ac-3b55cfeedbb7
updated_at: 2026-08-24T18:15:05+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T20-09-26-01a034f6-8587-7893-a0ac-3b55cfeedbb7.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only final review of EmploymentExit error ownership

Rollout context: Fresh, repository-bound, strictly read-only review in `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`. Exact five-file allowlist, baseline/HEAD `a18eeec388811fc36377e65527ac4940fffaa8af`, and canonical NOVARI-FREEZE-V1 hash were supplied.

## Task 1: Review EmploymentExit JSON preview/write error ownership

Outcome: success

Preference signals:
- The user required “KEINE Delegation/Subagents”, read-only operation, an exact allowlist, double freeze verification, and “Stop bei Abweichung” -> future reviews should remain inline/read-only and stop before hunks on any gate mismatch.
- The user required findings-first P0–P3 reporting and explicit preservation of unchanged behavior -> report concrete contract evidence, not generic praise or speculative risks.

Key steps:
- Read applicable `AGENTS.md`, reviewer references, current error-handling documentation, and normative Logging V2 spec/visualization.
- Verified branch, HEAD, upstream `0/0`, status, exact five-file scope, and canonical freeze twice.
- Reviewed full tracked diff plus the untracked `EmploymentExitDialog.errorOwnership.test.tsx`.
- Traced the real path: `EmploymentExitDialog` → `certificateApi` → Axios interceptor → `handleError` → fail-closed support projection → toast/clipboard sink.
- Confirmed the runtime change is limited to request-local `skipGlobalErrorToast: true` on the JSON preview GET and completion POST.

Failures and how to do differently:
- No review findings. Previously supplied test/build evidence was not rerun because the task explicitly prohibited re-execution; future reports must distinguish inherited evidence from checks actually run.

Reusable knowledge:
- EmploymentExit is a JSON preview/write flow, not a Blob/PDF client flow. Preserve URLs, methods, payload/response identity, one 401 replay with flag preservation, dialog/unmount behavior, success ordering, archive behavior, and certificate number handling.
- A valid local owner requires the real Axios interceptor and existing support projection/toast path; fully mocking `apiClient` would not prove global 5xx suppression.
- Safe support projection requires a genuine Axios response with a complete nested `data.error` envelope, validated code/message/request ID, matching request-ID sources, optional strict HTTP Date, and excludes `actionHint`, raw/details, PII, URLs, and other sensitive data. Malformed envelopes must fail closed to the reference-only fallback.
- Final review reported no P0–P3 findings and continuity `aligned`. Supplied evidence was 11/11 focused tests, 121/121 focus checks, typecheck, ESLint, 5812/5812 serial suite, build, and diff-check; full lint retained known unrelated 4 errors/6 warnings.

References:
- Freeze: `a6941fd33054e49b16b48e7884a834466a7adfedf088bca6b9242d993aa76579`, tracked `4612` bytes, stream `18211` bytes.
- Untracked test: `src/components/dashboard/student/__tests__/EmploymentExitDialog.errorOwnership.test.tsx`, `13429` bytes, SHA `c5ed7a6ff9daa0e0e1e5aecab68ee6cf815c7483396af76b750b4b31ba60a773`.
- Runtime file: `src/libs/api/certificateApi.ts`; docs: `docs/development/error-handling.md`, `CHANGELOG.md`.
