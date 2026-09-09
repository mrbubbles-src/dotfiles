thread_id: 01a02190-5d32-7c03-8574-82f2e7a144c9
updated_at: 2026-08-20T23:52:41+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T01-45-04-01a02190-5d32-7c03-8574-82f2e7a144c9.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only F1a plan for central portal support information

Rollout context: The agent was instructed to inspect only the Novari education portal’s central error boundary for F1a, without edits, tests, fetches, delegation, or historical evidence. The portal worktree and Backend F0 prerequisite were verified.

## Task 1: Inventory and §14 F1a plan

Outcome: success

Preference signals:
- The user required a “kleinsten zentralen Portal-Teilslice,” an exact file allowlist, no caller mass migration, no implementation, and explicit stop gates -> future agents should stay narrowly slice-scoped and ask for explicit Go before edits.
- The user required findings-first reporting, exact deterministic copy text, per-runtime-hunk §2.2 Fall-6 mapping, unchanged callers, and understandable German approval wording -> future plans should include these explicitly rather than generic implementation steps.
- The user explicitly required fail-closed behavior for missing/invalid envelopes and forbade raw JSON, URLs, query values, IDs, headers, user input, and browser-time substitution -> future error-handling work must reject unsafe inputs rather than “best effort” project them.

Key steps:
- Verified portal start gate read-only: branch `chore/logging-improvements`, HEAD `ed327fed999ffffcdd941f8bcb752ef74ed5a989`, clean worktree, upstream `origin/chore/logging-improvements`, ahead/behind `0/0`; no fetch.
- Read repository rules and both normative logging specifications.
- Verified Backend F0 independently: backend branch `chore/logging-improvements`, HEAD exactly `f195f6e811dfea5b06d37e3614f6efd1bddd30a6`; CORS exposes `Date`; backend public error codes are normalized to `^[A-Z][A-Z0-9_]{0,127}$` with `REQUEST_FAILED`/`INTERNAL_ERROR` fallbacks.
- Inspected central files, tests, docs, Sonner setup, clipboard fallback, and all direct `showBackendErrorToast` callers.
- Identified that `backendError.ts` currently loses `Date`, does not require a validated nested envelope, and treats any request ID or 5xx as sufficient for sticky backend toast behavior.
- Identified three central F1a producers that can be extended without caller migration: `apiClient.ts`, `showHandledApiErrorToast`/`handleApiCall`, and non-warning `handleError`.

Reusable knowledge:
- Current central toast behavior already has `duration: Infinity`; global `Toaster` uses `closeButton`; `copyPlainText` uses Clipboard API then a DOM textarea fallback.
- Current persistent toast copies only the request ID. F1a’s proposed observable target is a deterministic full support-information block, only for a validated nested `data.error` envelope.
- Proposed copy contract is ordered lines with no trailing newline: `Support-Information`, `Meldung`, `Fehlercode`, `Referenz-ID`, `Anwendung: Portal`, static `Bereich`, optional validated `Zeitpunkt` from HTTP `Date`, and optional server-approved `Handlungsempfehlung`.
- Missing/invalid `Date` must omit the complete time line; browser time is never a fallback. Conflicting body/header request IDs, legacy/top-level payloads, network errors, plain errors, invalid codes, and invalid request IDs must not produce the new support-information block.
- Runtime allowlist: `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`, `src/libs/apiClient.ts`, `src/libs/utils/errorHandling.ts`, `src/libs/utils/error-handler.ts`. Tests: corresponding backendError/toast/errorHandling/error-handler tests plus `src/libs/__tests__/apiClient.authRetry.test.ts`. Docs: `docs/development/error-handling.md`, `README.md`, `CHANGELOG.md`.
- Explicitly excluded: `clipboard.ts`, `clipboard.test.ts`, `main.tsx`, `apiClient.test.ts`, all direct caller files, post-commit/cleanup warnings, Backend/LMS/API/role/product-flow changes, and F2.
- Direct callers were classified into central coverage, later F1 slices, or unchanged post-commit/follow-up warnings. In particular, `useLmsCurriculum.ts:617`, `:657`, `:663`, lease cleanup handlers, and post-publication certification warnings remain unchanged.

Failures and how to do differently:
- An initial broad `rg` command over the backend returned exit 2 because nonexistent paths were included; narrow searches to known directories and treat such output as incomplete rather than evidence.
- The rollout did not execute tests, formatting, linting, typecheck, build, or browser checks by design. Any implementation task must perform them only after explicit Go and within the allowlist.
- Do not infer that every existing `showBackendErrorToast` call is an F1a target: many are direct product or post-commit flows and require later producer-specific slices or must remain unchanged.

References:
- Portal baseline: `ed327fed999ffffcdd941f8bcb752ef74ed5a989`
- Backend F0 commit: `f195f6e811dfea5b06d37e3614f6efd1bddd30a6` (`fix: enforce backend support metadata contract`)
- Backend CORS: `/Users/mrbubbles/dev/novari/novari-education-backend/libs/http/corsOptions.js`
- Backend code normalization: `/Users/mrbubbles/dev/novari/novari-education-backend/error/httpError.js`
- Central extraction: `src/libs/utils/backendError.ts:451`
- Central sticky toast: `src/libs/utils/toast.ts:70`
- Global producer: `src/libs/apiClient.ts:80-95`
- Generic handled producer: `src/libs/utils/errorHandling.ts:107-120`
- Generic non-warning handler: `src/libs/utils/error-handler.ts:109-120`
- Clipboard fallback: `src/libs/utils/clipboard.ts`
- Existing docs: `docs/development/error-handling.md`
- Required user Go wording: “Go F1a: Setze ausschließlich den beschriebenen zentralen Portal-Teilslice ab Baseline ... mit exakt dieser Datei-Allowlist um ... Keine direkten Produktcaller, Warnungen, Backend- oder LMS-Änderungen.”
