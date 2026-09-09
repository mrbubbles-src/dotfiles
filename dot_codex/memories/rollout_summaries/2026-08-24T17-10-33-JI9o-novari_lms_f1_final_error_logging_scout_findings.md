thread_id: 01a034c0-9c08-7eb3-81c8-c24233bb702e
updated_at: 2026-08-24T17:15:18+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-10-33-01a034c0-9c08-7eb3-81c8-c24233bb702e.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-lms
git_branch: chore/logging-improvements

# Read-only final F1 error/logging scout for Novari LMS found six active findings

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-lms`, branch `chore/logging-improvements`, baseline/HEAD `7bf7aa8bde6cd6d55a3c5922fd46dc7850a8eb30`, upstream `0/0`, initially and finally clean. The user required a fresh repository-bound, read-only, findings-first scan with no tests, edits, formatting, staging, commits, push, or delegation. AGENTS.md, orchestrate skill, current error-handling documentation/specs, active BFF/client/error paths, exams, sidebar, auth, and logging were inspected.

## Task 1: Final LMS F1 error/logging scout

Outcome: success

Preference signals:
- The user explicitly required “Keine Edits ... Keine Tests. Findings-first.” -> future scouts should preserve strict read-only scope, avoid validation commands unless authorized, and report concrete findings before recommendations.
- The user required active production callchains only, no speculative findings, exact allowlists, smallest coherent slices, mechanical tests/docs, and stop-gates -> future reviews should include those fields for every real finding and exclude legacy/inactive/test-only paths.
- The user required start/end branch, HEAD, upstream, and clean-status gates, stopping on drift -> always verify these gates before and after investigation.

Key steps:
- Verified start and end gates: branch `chore/logging-improvements`, HEAD `7bf7aa8...`, upstream `0/0`, clean status.
- Read existing contracts: server-side fail-closed safe projection, strict request-ID validation, persistent reference-aware toasts, expected quiet auth failures, and one visible toast owner.
- Scanned active routes/components and traced browser→BFF→backend paths for raw body/text/error fields, request IDs, toast ownership, auth refresh, retries, console logging, and upload/PDF/blob/download paths.

Failures and how to do differently:
- The LMS is not scan-clean and not PR-ready for final F1 completion. Do not report the already-hardened Sidebar, Exam BFF, or GitHub Classroom projector paths again as findings.
- No tests were run by design; no documented baseline test failures were found, but this remains unverified because testing was explicitly prohibited.

Reusable knowledge:
- Six active findings remain:
  1. **P1 Topic/SLP BFF raw error projection:** `app/api/modules/get-entry/route.ts` and `get-self-learning-entry/route.ts` use permissive `parseBackendErrorResponse`, exposing backend `message`, `code`, and `requestId`; `lib/data/db.ts` renders locked messages. Risks include raw technical text/URLs/PII, malformed or conflicting IDs, and unsafe browser-visible locked content. Reuse the existing server safe projector, but first confirm the real `LMS_CONTENT_LOCKED` contract and preserve only that narrow locked behavior.
  2. **P1 Auth reauth misclassification:** `lib/auth/reauth.ts` converts every non-2xx/network failure to `null` and logs the error; `app/api/auth/authenticate-user/route.ts` then refreshes and can return `401` for real 5xx/network failures, losing status/request ID and causing unnecessary token rotation. Correct behavior should distinguish 401 from backend/system failures, preserve refresh-cookie/order contracts, and avoid console output.
  3. **P1 Global exam banner false empty state:** `components/layout/exams/banner/student-global-exam-banner.tsx` maps all non-2xx/network errors to `[]`, then overwrites last successful assignments during polling. Active banners can disappear during transient outages; failures are silent. Preserve last-success data and define one deduplicated owner for final 5xx/network errors while keeping polling/socket/sorting/24-hour visibility unchanged.
  4. **P2 repeated persistent toasts:** Exam dashboard 30-second refresh and Sidebar focus refresh can call `showBackendErrorToast` repeatedly. `lib/errors/backend-error-toast.ts` has no stable Sonner ID, so identical failures stack. Deduplicate repeated errors, update the same owner for a new reference, and clear/update on success without changing refresh cadence or 401/403 silence.
  5. **P2 production console leakage:** `components/layout/modules/modules-components/custom-example-components/formbeispiel.tsx` logs full form data including user input; the shortcode is production-allowlisted. The topic error boundary `app/modules/[module]/[submodule]/[slug]/error.tsx` logs the full Error object, potentially including message/stack/paths. Remove raw logging while preserving form output and recovery UI.
  6. **P2 Logout fail-open request IDs:** `app/api/auth/logout-user/route.ts` uses permissive parsing and reflects selected IDs into body/header; `components/ui/user-logout.tsx` displays them persistently. Malformed/conflicting IDs may remain copyable. Apply the safe projector while preserving CSRF, Origin, backend Set-Cookie, status, and redirect timing.
- No active production upload/PDF/blob/download BFF paths were found; image transformation is unrelated to F1 backend error ownership.

References:
- [1] Gate command: `git branch --show-current && git rev-parse HEAD && git rev-list --left-right --count @{upstream}...HEAD && git status --porcelain=v1 --untracked-files=all` -> `chore/logging-improvements`, `7bf7aa8bde6cd6d55a3c5922fd46dc7850a8eb30`, `0 0`, empty status.
- [2] Existing safe projector: `lib/errors/server/backend-error-projection.ts`; strict envelope shape, technical-location rejection, request-ID validation/conflict suppression, status fallbacks.
- [3] Existing safe toast: `lib/errors/backend-error-toast.ts`; persistent Sonner toast with `Referenz kopieren`, currently lacking stable dedupe identity.
- [4] Final report explicitly classified the LMS as “nicht scan-clean und noch nicht PR-reif als finale F1-Vollendung.”
