thread_id: 01a02ddf-62e3-7ba2-8682-5d2b3d078f0d
updated_at: 2026-08-23T09:10:26+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T11-06-49-01a02ddf-62e3-7ba2-8682-5d2b3d078f0d.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only plan review for Portal Logging V2 F1 ticket-status mutations

Rollout context: Fresh repository-bound, strictly read-only review in `/Users/mrbubbles/dev/novari/novari-education-portal`. Start gate passed on branch `chore/logging-improvements`: clean worktree, HEAD `82e3d58241f7301b5b862bcc701143992b7c710d`, upstream `0/0`. No edits, tests, formatting, fetches, commits, pushes, or Git mutations.

## Task 1: Ticket status error-ownership plan

Outcome: success

Preference signals:

- The user required an exact, fresh READ-ONLY plan with “No implementation,” no delegation, and explicit stop gates -> similar reviews should inspect current code and return a concrete allowlist/plan without modifying or testing anything.
- The user required preserving titles, areas, wording, success behavior, payloads, invalidations, retry behavior, and excluded socket/FormData/message/attachment paths -> future slices should trace each contract explicitly instead of applying broad error-handling changes.
- The user asked for the “exact smallest prod/test allowlist” and a status matrix -> future plans should identify the minimum coherent file set and enumerate 2xx/4xx/5xx/transport/fail-closed behavior.

Key steps:

- Read `AGENTS.md`, orchestrate/scoped-fix guidance, Novari Logging V2 Spec/Visualisierung, and the Novari slice-gate memory.
- Inspected `useTickets`, `useTicketActions`, all relevant callers, `MutationCache`, Axios interceptor, strict backend-support projector, tests, and ticket socket/chat paths.
- Confirmed the five scoped HTTP mutations are PATCH `/tickets/:id/assign`, `/close`, `/transfer`, `/escalate`, and `/topic`.
- Confirmed `MutationCache` already owns normal mutation errors with existing `errorAction`, safe support projection, strict 4/3/2 toast arity, `actionHint` exclusion, and mutation retry `0`.
- Found Axios interceptor duplicate 5xx ownership; the minimal fix is request-local `skipGlobalErrorToast: true` on the five PATCH calls.
- Found an additional direct local toast in `LmsManagementDashboadRightSidebar.tsx` for topic-update failure; it must be removed/reduced to rejection handling so `MutationCache` remains the sole owner.
- Proved socket create/message/join/leave flows and `TicketChatInput` attachment UI are separate and can remain unchanged.

Planned production allowlist:

- `src/hooks/useTickets.ts`: only the five PATCH request configurations; preserve exact endpoints, payloads, response handling, `errorAction` strings, success messages, invalidations, auth replay, and no-body assign contract.
- `src/components/lms/dashboardpanels/LmsManagementDashboadRightSidebar.tsx`: stop the duplicate Topic toast while retaining `mutateAsync` rejection handling.

Planned test allowlist:

- `src/hooks/__tests__/useTickets.test.tsx`: assert exact request arity/payloads/config, metadata, invalidations, error identity, retry `0`, one-owner behavior, support-information projection, and fail-closed malformed cases.
- Extend an existing sidebar test only if the local Topic catch is currently covered; no new test file is needed.

Failures and how to do differently:

- No implementation or verification was performed, so the plan is not an implementation/test result. Future implementation must stop if it requires changing `MutationCache`, `apiClient`, `backendError`, socket/message/upload paths, success wording, invalidations, or files outside the allowlist.

Reusable knowledge:

- `src/libs/queryClient.ts` Production `MutationCache` is the intended sole owner for these five mutations; global mutation retry is `0`.
- `src/libs/apiClient.ts` independently shows 500/502/503 backend toasts unless request config opts out, so `meta.skipGlobalErrorToast` alone is insufficient for deduplication.
- Strict support projection is fail-closed: genuine Axios error, own-data envelope, safe message/code/request ID, static area, optional validated HTTP Date; arrays, malformed envelopes, contradictory IDs, and `actionHint` are excluded.
- `useTicketActions.ts` only manages dialogs/delegates mutations and is not an error owner.

References:

- [1] Gate: branch `chore/logging-improvements`; HEAD `82e3d58241f7301b5b862bcc701143992b7c710d`; upstream `0/0`; clean.
- [2] Runtime mutations: `src/hooks/useTickets.ts:472-597`.
- [3] Global owner/interceptor: `src/libs/queryClient.ts:50-63`; `src/libs/apiClient.ts:78-103`.
- [4] Duplicate local Topic toast: `src/components/lms/dashboardpanels/LmsManagementDashboadRightSidebar.tsx:130-140`.
- [5] Excluded socket paths: `src/hooks/useTickets.ts:354-470`; ticket UI `ticket:join`/`ticket:leave` and `TicketChatInput.tsx` remain unchanged.
