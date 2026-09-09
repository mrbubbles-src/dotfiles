thread_id: 01a02cf7-c0b4-7203-9237-aa599702bc9a
updated_at: 2026-08-23T04:56:32+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-53-49-01a02cf7-c0b4-7203-9237-aa599702bc9a.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only final review of GitHub Classroom Assignments mutation error ownership

Rollout context: Novari Portal repo `/Users/mrbubbles/dev/novari/novari-education-portal`, branch `chore/logging-improvements`, HEAD `18e22bfdf1e24d40316d0b89d396dbe8da97f523`. Review was strictly read-only and limited to `src/libs/githubClassroomAssignmentService.ts` plus one untracked test file.

## Task 1: GitHub-Classroom-Assignments final normative review

Outcome: success

Preference signals:

- The user required an exact audited Ruby raw-byte freeze script, exact baseline/hash, exact allowlist, and no own serialization -> future reviews must reproduce the specified snapshot method and stop before substantive review on mismatch.
- The user explicitly required strict read-only behavior and no tests/edits/commit/push -> comparable independent reviews should inspect and report only.
- The requested review emphasized continuity with Spec §2.2 Fall 6, header-only request IDs, real MutationCache behavior, both Axios third arguments, and no special paths -> future reviews should verify these concrete contracts rather than only inspect the local diff.

Key steps:

- Read repo `AGENTS.md`, code-reviewer references, Novari logging slice-gates skill, Logging V2 Spec, and Visualization.
- Verified branch, HEAD, upstream `0/0`, exact two-file scope, and the expected freeze hash using the audited Ruby framing.
- Inspected the full production diff and test file, then traced `apiClient`, `MutationCache`, `handleError`, safe backend-error projection, hooks, query keys, retry defaults, and invalidation behavior.
- Review result: no P0–P3 findings; continuity was `aligned`.

Reusable knowledge:

- Canonical mixed tracked/untracked freeze result: hash `52fad65cd70783d87f62b1574756cb2efe439cd6f167354089b49ba419f668c7`, tracked diff size `1695` bytes, exactly one sorted untracked file: `src/libs/__tests__/githubClassroomAssignmentService.test.ts`.
- The production change only adds `{ skipGlobalErrorToast: true }` as Axios argument 3 to bulk create and update requests in `src/libs/githubClassroomAssignmentService.ts`.
- The local Axios opt-out prevents duplicate global 5xx toasts, while the existing real TanStack `MutationCache` remains the single mutation error owner. Mutation retry remains `0`; success messages, query invalidation, response values, status handling, and original error identity remain unchanged.
- Existing safe support projection correctly handles a header-only `x-request-id` and rejects malformed envelopes/accessors or unsafe raw fields.
- The review did not execute tests because the request was strictly read-only; test claims were inspected from the actual test file, not treated as execution evidence.

Failures and how to do differently:

- An initial direct `git diff <expected-hash>` failed because the supplied freeze value was a snapshot hash, not a Git revision. The correct approach was to use the audited Ruby raw-byte framing against the actual HEAD and allowlisted paths.
- Do not substitute `git diff --binary --full-index | shasum` alone when untracked files are part of the frozen candidate; use the project-defined framing including sorted untracked-file bytes.

References:

- Freeze command used: `ruby -rdigest -e 'def gb(*a);IO.popen(["git",*a],"rb",&:read);end;def f;t=gb("diff","--binary","--full-index","--no-ext-diff","HEAD","--");es=gb("ls-files","--others","--exclude-standard","-z").split("\0",-1).reject{|e|e.empty?}.sort;s=+"NOVARI-FREEZE-V1\0TRACKED-DIFF\0";s<<t;s<<"\0UNTRACKED-FILES\0";es.each{|e|c=File.binread(e);s<<"FILE\0"<<e.b<<"\0BYTES\0"<<c.bytesize.to_s.b<<"\0CONTENT\0"<<c<<"\0END-FILE\0"};[Digest::SHA256.hexdigest(s),t.bytesize,es];end;2.times{p f}'`
- Production file: `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/githubClassroomAssignmentService.ts`
- Test file: `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/__tests__/githubClassroomAssignmentService.test.ts`
- Final verdict: `Keine Findings (P0–P3)`; `git diff --check` passed; freeze remained unchanged.
