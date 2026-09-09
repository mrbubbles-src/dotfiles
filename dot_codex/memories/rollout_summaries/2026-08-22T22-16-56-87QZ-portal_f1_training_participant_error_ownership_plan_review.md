thread_id: 01a02b8c-64c3-7470-bac1-ff97dd2e4561
updated_at: 2026-08-22T22:21:51+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T00-16-56-01a02b8c-64c3-7470-bac1-ff97dd2e4561.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only normative review of Portal Logging V2 F1 Fortbildungs-Teilnehmer

Rollout context: Fresh repository-bound review in `/Users/mrbubbles/dev/novari/novari-education-portal`; no edits, tests, formatting, fetch, commit, push, browser, or security scan. Start gate passed on `chore/logging-improvements` at `c22da204620bbb5e7294f05005ef7e9336af462d`, clean, upstream 0/0.

## Task 1: Review and plan participant mutation error ownership

Outcome: success

Preference signals:
- The user required a “frischen, strikt read-only Plan-Review”, findings-first, exact allowlist, no delegation, and no implementation/testing actions -> future reviews should fail closed on scope or authorization drift.
- The requested target was the “kleinste kohärente” slice with explicit preservation of request, retry, auth, success, cache, and UI behavior -> future plans should enumerate unchanged flows and avoid adjacent training/HR surfaces.

Key steps:
- Read repository rules, Logging V2 specification/visualization, relevant review skills, and memory guidance.
- Traced all three participant writes through `trainingService.ts`, `useTrainings.ts`, Axios interceptor, Production `MutationCache`, auth replay, retry, success, and invalidation paths.
- Confirmed add/remove already have static `MutationCache` owners; update lacks one. All mutations are retry-free.
- Confirmed the coherent plan: add request-local `skipGlobalErrorToast: true` to exactly POST/PATCH/DELETE participant requests and add only `meta: { errorAction: 'Aktualisieren des Teilnehmers' }` to update.

Failures and how to do differently:
- A broad `rg` command included a nonexistent glob and produced incomplete evidence; subsequent searches used known paths. Future repo searches should avoid nonexistent directories/globs.
- The update owner is a real behavior addition for 4xx failures, not merely deduplication. It was classified as permitted additive F1 behavior, not a separate product decision, but requires explicit F1 sub-slice Go.

Reusable knowledge:
- Production `MutationCache` in `src/libs/queryClient.ts` owns global mutation toasts; `src/main.tsx` mounts the exported production `queryClient`.
- Axios request-local `skipGlobalErrorToast` suppresses the interceptor’s 500/502/503 toast while preserving auth replay; existing `apiClient.authRetry.test.ts` proves the flag survives replay.
- Exact five-file implementation allowlist: `src/libs/trainingService.ts`, `src/hooks/useTrainings.ts`, new `src/hooks/__tests__/useTrainings.errorOwnership.test.tsx`, `docs/development/error-handling.md`, and `CHANGELOG.md`. Existing `useTrainings.test.ts` remains unchanged because it is 734 lines and uses a non-production QueryClient.
- Required focused tests should use the real exported Production QueryClient and verify exact request arity/payloads, one toast owner, strict support-envelope fallback (3 args, never explicit `undefined`), non-Axios identity, retry 0, no error-path invalidation/success toast, and unchanged success invalidations.

References:
- `src/libs/trainingService.ts:212-243`: participant POST, PATCH, DELETE contracts.
- `src/hooks/useTrainings.ts:163-227`: three mutation hooks and current metadata/invalidation behavior.
- `src/libs/queryClient.ts:50-63,106-118`: Production MutationCache ownership and retry 0.
- `src/libs/apiClient.ts:64-103`: auth replay and request-local global-toast suppression.
- `src/libs/__tests__/apiClient.authRetry.test.ts:82-102,156-188`: replay preservation and interceptor opt-out evidence.
- Normative basis: Logging V2 Spec §2.2 Fall 6, §13 F1, §14; F1 remains separately gated and not implemented.
