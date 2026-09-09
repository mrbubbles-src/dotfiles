thread_id: 01a02cf1-3a85-7073-8cf9-1c6b1470c23a
updated_at: 2026-08-23T04:48:50+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-46-41-01a02cf1-3a85-7073-8cf9-1c6b1470c23a.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only final review of GitHub Classroom assignment logging slice found one P2 test gap

Rollout context: In `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, the reviewer was asked to inspect a frozen candidate read-only, limited to the service and its new test, using the exact freeze serialization/hash gate.

## Task 1: Review frozen GitHub Classroom assignment logging changes

Outcome: partial

Preference signals:

- The user required a “fresh independent read-only final reviewer,” exact file allowlist, findings-first output, and no edits, tests, formatters, lint, typecheck, fetches, or Git mutations -> future reviews should preserve strict separation between implementation and independent review and stop on scope drift.
- The user explicitly required checking exact Axios argument count, URL/body/return identity, unchanged hook metadata, MutationCache/retry/cache/UI behavior, status coverage, request-ID handling, leak prevention, and exactly-once behavior -> similar reviews should proactively verify these contracts rather than only inspect the changed lines.

Key steps:

- Read repository `AGENTS.md`, code-reviewer guidance, Logging V2 Spec/Visualization, and relevant client/query/error-handling code.
- Verified the canonical freeze hash twice with the required Ruby serialization: `59c4003f5f9a1b66f78ce1c6a360cbb73a5d1e3579174913cb4a07be566dd426`, tracked diff size `1695`, and exactly one untracked test file.
- Inspected only the allowlisted service and test plus their hook/shared error-handling dependencies.
- Confirmed both writes add a third Axios config argument `{ skipGlobalErrorToast: true }` while preserving URLs, payloads, response return values, hook metadata, global MutationCache ownership, retry `0`, invalidation, success toasts, and safe payload filtering.

Failures and how to do differently:

- [P2] `src/libs/__tests__/githubClassroomAssignmentService.test.ts:226` covers request IDs only in the response body and does not assert the exact request ID passed to `showBackendErrorToast`. A header-only fallback or toast propagation regression could pass unnoticed. Add a header-only request-ID fixture and exact toast assertion.
- No dynamic validation was run because the review was explicitly read-only; do not describe tests, lint, formatter, or typecheck as passing.

Reusable knowledge:

- Freeze mismatch is a hard stop: do not inspect hunks, run tests, or issue findings until the project-defined tracked/untracked serialization exactly matches the expected hash.
- The Portal’s global Axios interceptor emits automatic toasts only for 500/502/503 unless `skipGlobalErrorToast` is set; TanStack MutationCache separately owns mutation error toasts and defaults mutation retry to `0`.
- Safe request-ID extraction supports body first and `x-request-id` header fallback; tests for local error ownership should include body/header conflict and header-only cases.

References:

- Freeze command: `ruby -rdigest -e 'def gb(*a);IO.popen(["git",*a],"rb",&:read);end;def f;t=gb("diff","--binary","--full-index","--no-ext-diff","HEAD","--");es=gb("ls-files","--others","--exclude-standard","-z").split("\0",-1).reject{|e|e.empty?}.sort;s=+"NOVARI-FREEZE-V1\0TRACKED-DIFF\0";s<<t;s<<"\0UNTRACKED-FILES\0";es.each{|e|c=File.binread(e);s<<"FILE\0"<<e.b<<"\0BYTES\0"<<c.bytesize.to_s.b<<"\0CONTENT\0"<<c<<"\0END-FILE\0"};[Digest::SHA256.hexdigest(s),t.bytesize,es];end;2.times{p f}'`
- Allowlist: `src/libs/githubClassroomAssignmentService.ts`; `src/libs/__tests__/githubClassroomAssignmentService.test.ts`.
- Final finding: add explicit header-only request-ID coverage and exact `showBackendErrorToast` assertion.
