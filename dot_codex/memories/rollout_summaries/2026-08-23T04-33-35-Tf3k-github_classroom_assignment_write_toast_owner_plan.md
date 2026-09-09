thread_id: 01a02ce5-3c06-7393-b6d4-b8f505303da2
updated_at: 2026-08-23T04:36:25+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-33-35-01a02ce5-3c06-7393-b6d4-b8f505303da2.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only plan scout for GitHub Classroom assignment logging

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, clean at baseline/HEAD `18e22bfdf1e24d40316d0b89d396dbe8da97f523`. No edits, tests, formatting, scans, or Git mutations were performed.

## Task 1: Inventory the two active GitHub Classroom assignment writes

Outcome: partial

Key steps:
- Identified exactly two active writes in `src/libs/githubClassroomAssignmentService.ts`:
  - `POST /lms/github-classroom-assignments/bulk`, payload `courseId`, `publishAt`, `assignments[]`; response `assignments[]`, `message`.
  - `PATCH /lms/github-classroom-assignments/:assignmentId`, payload `title`, optional `description`, `links[]`, `publishAt`; response `assignment`, `message`.
- Confirmed direct UI mutation callers are limited to `TeacherGithubClassroomAssignmentsPage.tsx`; student and list paths are read-only.
- Existing mutation metadata in `useGithubClassroomAssignments.ts` provides success/error strings and cache invalidation. Global mutation retries are already `0`; Axios only performs one auth replay for `401`.
- Found a P2 duplicate-toast path for `500/502/503`: Axios response interceptor toasts, then `MutationCache.onError` toasts again from `errorAction`.
- The initial recommendation to place `skipGlobalErrorToast` in hook metadata was corrected in the follow-up: hook metadata does not reach Axios config.

Failures and how to do differently:
- Do not put `skipGlobalErrorToast` in TanStack Query `meta`; that only affects `MutationCache` and cannot suppress the Axios interceptor.

Reusable knowledge:
- Put `skipGlobalErrorToast: true` in the Axios request config at the service call site, while retaining hook `meta.errorAction` so `MutationCache` remains the sole failure owner.
- Status matrix should cover `400/403/409/422/429/500/502/503/599`; mutations retry `0`, request IDs are preserved, conflicting IDs fail closed, and support projections must exclude repository/branch/path/resource IDs, raw payloads, URLs, tokens, PII, and exception details.

References:
- `src/libs/githubClassroomAssignmentService.ts:89` and `:106`
- `src/hooks/useGithubClassroomAssignments.ts:84` and `:107`
- `src/libs/apiClient.ts:16-20, 85-99`
- `src/libs/queryClient.ts:50-63, 106-109`

## Task 2: Final exact implementation allowlist and Axios shape

Outcome: success

Preference signals:
- The user requested “final exakte Allowlist, Axiosargumentpositionen und bestehende exact successMessage/errorAction strings” without a new investigation -> future responses should distinguish confirmed implementation details from earlier scout hypotheses and give exact file paths/signatures.

Reusable knowledge:
- Exact production change: `apiClient.post(url, payload, { skipGlobalErrorToast: true })` and `apiClient.patch(url, payload, { skipGlobalErrorToast: true })` in `githubClassroomAssignmentService.ts`.
- Exact allowlist: `src/libs/githubClassroomAssignmentService.ts` and `src/libs/__tests__/githubClassroomAssignmentService.test.ts`; only add `src/libs/apiClient.ts` if the existing Axios config typing rejects the custom property.
- Preserve existing hook metadata: create success `'Aufgaben veröffentlicht'`, error `'Veröffentlichen der GitHub-Classroom-Aufgaben'`; update success `'Aufgabe aktualisiert'`, error `'Aktualisieren der GitHub-Classroom-Aufgabe'`.
- Do not add `skipGlobalErrorToast` to mutation metadata, or the remaining MutationCache toast would be suppressed.
