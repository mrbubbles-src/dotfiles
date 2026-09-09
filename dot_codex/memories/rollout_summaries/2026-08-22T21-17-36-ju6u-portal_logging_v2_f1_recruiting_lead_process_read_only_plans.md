thread_id: 01a02b56-1440-7db1-aa80-6e3b667143b2
updated_at: 2026-08-22T21:54:44+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T23-17-36-01a02b56-1440-7db1-aa80-6e3b667143b2.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Portal Logging V2 F1 review produced separate Recruiting and Lead Process plans

Rollout context: Fresh repository-bound review of `/Users/mrbubbles/dev/novari/novari-education-portal` on `chore/logging-improvements` at `bf78c29e9854d9f7b29dc734d66a9bfe90ed2a71`; local origin matched, upstream was `0/0`, and worktree/index were clean. No edits, tests, formatting, fetch, commit, push, browser, or security scan were performed.

## Task 1: Inventory and slice decision

Outcome: success

Preference signals:
- The user required a “vollständig frischer repositorygebundener READ-ONLY-Plan-Reviewer”, no delegation, no repository actions, current evidence only, and findings-first output -> future reviews should fail closed on drift and clearly distinguish verified facts from historical memory.
- The user required the “kleinsten kohärenten” slice, exact production allowlists, explicit exclusions, and separate Go before implementation -> do not infer authorization from an aligned plan.
- The user clarified that production-code scope/size is the meaningful gate; mechanically necessary test-file size should not trigger a stop -> assess production scope separately from test-file size.

Key steps:
- Read AGENTS.md, applicable review/slicing/gate skills, current Logging V2 Spec and Visualization, relevant source, callers, services, hooks, query client, API client, tests, and documentation.
- Verified the current central error ownership: Axios interceptor plus Production `MutationCache` can both toast failed TanStack mutations; request-local `skipGlobalErrorToast: true` is the existing intended deduplication mechanism.
- Inventoried active Recruiting and Lead Process write producers end-to-end, distinguishing JSON, FormData, Blob/download, local validation, and direct local error ownership.
- Determined that Recruiting and Lead Process share the broad F1 objective but not a coherent technical slice: separate services, hooks, query keys, components, payload contracts, cache invalidations, and owner boundaries. Recruiting also has a direct local employee-conversion owner, while Lead Process has ten MutationCache-owned mutations.

Findings and decision:
- [P1] Recruiting and Lead Process must be two plans/slices, not one combined slice, because their producer and error-owner boundaries are not tightly coupled.
- [P2] Active TanStack writes can produce duplicate 500/502/503 toasts unless each request opts out of the Axios global toast and leaves Production `MutationCache` as sole owner.
- [P2] Applicant conversion is a distinct direct `try/catch` contract and must not be migrated to MutationCache; only its local error helper should be upgraded while preserving pending reset, invalidation, success toast, and dialog close order.

## Task 2: Recruiting Plan 1

Outcome: success

Key steps:
- Defined eight active writes: applicant create/update; technical-interview assignment; sample-lesson assignment; assessment cancellation; final decision; teacher evaluation; employee conversion.
- Planned a typed request-local `{ skipGlobalErrorToast: true }` config on all eight service writes.
- Planned conversion-specific use of the existing handled API error helper with static area `Bewerberübernahme` while retaining its local owner.
- Defined a two-production-file implementation allowlist plus focused ownership tests and documentation/changelog updates.
- Defined real Production `queryClient` tests covering exact request shape, one toast, strict/malformed/missing/non-Axios fallback arity, no raw data, error identity, retry, success, invalidation, and conversion behavior.

## Task 3: Lead Process Plan 2

Outcome: success

Key steps:
- Defined ten active writes: course-start create; lead create; lead assignment; inquiry create; lead update; inquiry update; assessment-appointment assignment; assessment-appointment create; voucher upload; contract upload.
- Preserved JSON filtering, FormData contracts (`file + validTo` and `file`), response handling, auth replay, retry `0`, MutationCache metadata, success behavior, and invalidation of both `course-starts` and `inquiries`.
- Limited runtime change to `src/libs/leadProcessService.ts` with a typed request-local opt-out on exactly the ten writes.
- Excluded GETs, Blob download, curriculum-course-type query, local validation, student import, UI/role/table/dialog/admission contracts, and Recruiting.
- Defined the same focused Production-queryClient matrix and freeze/review gates.

Failures and how to do differently:
- A broad combined Recruiting+Lead Process slice would violate the coherent-slice boundary despite the shared product goal; keep them separate.
- Do not change `apiClient.ts`, `queryClient.ts`, central support projection, hooks, components, payloads, responses, retry, cache keys, invalidation, or success paths for these plans.
- Do not treat the old baseline as current implementation authority; before any future implementation, re-gate branch, HEAD, origin, upstream, worktree, and allowlists.
- No security-scan evidence was produced; a later scan is a separate explicitly authorized gate.

Reusable knowledge:
- Current Portal Logging V2 F1 producer fixes use request-local Axios opt-out plus the existing Production `MutationCache` or existing local owner; do not introduce new abstractions or migrate ownership unnecessarily.
- Strict support projection must preserve fixed safe fields; malformed/missing envelopes retain the exact legacy fallback and must never pass an undefined fourth toast argument.
- Canonical freeze hashing is `git diff --binary --full-index <baseline> | shasum -a 256`; freeze review must inspect the complete tracked and untracked candidate, and no edits/tests/formatting occur after freeze until review finishes.

References:
- Portal baseline: `chore/logging-improvements` @ `bf78c29e9854d9f7b29dc734d66a9bfe90ed2a71`; local origin identical; upstream `0/0`.
- Recruiting runtime: `src/libs/applicantService.ts`, `src/hooks/useApplicants.ts`, `src/components/dashboard/hr/applicants/ApplicantConversionDialog.tsx`.
- Lead Process runtime: `src/libs/leadProcessService.ts`, `src/hooks/useLeadProcess.ts`, `src/components/lead-process/LeadProcessPage.tsx`, `LeadVoucherDocumentDialog.tsx`, `LeadContractDocumentDialog.tsx`.
- Shared ownership: `src/libs/apiClient.ts`, `src/libs/queryClient.ts`, `src/libs/utils/backendError.ts`.
- Current docs: `docs/development/error-handling.md`, `docs/people/applicant-management.md`, `README.md`, `CHANGELOG.md`.
- Recruiting production sizes observed: `applicantService.ts` 320 LOC; `ApplicantConversionDialog.tsx` 124 LOC; expected runtime delta about `+30` total.
- Lead Process production size observed: `leadProcessService.ts` 231 LOC; expected runtime delta about `+32`.
