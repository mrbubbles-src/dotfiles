---
name: code-reviewer
description: Use when the user asks for a code review, PR review, branch review, diff review, module review, repo audit, regression review, security/performance review of code, or asks to find bugs, risks, missing tests, stale assumptions, or maintainability problems in a codebase.
---

# Code Reviewer

Use this skill to perform evidence-based code reviews across repositories. The goal is to find real risks with low noise.

## First Move

1. Read repo instructions first: `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `README`, or equivalent.
2. Inspect git state:
   - `git status --short`
   - current branch and commit
   - `git diff --name-only`, `git diff --stat`
3. Identify whether specialized review skills/plugins should assist this review.
4. Identify the review scope from the user request. If unclear, ask one concise question before reviewing.

## Skill Coordination

This skill is the review orchestrator, not a replacement for more specialized review skills.

Before reviewing, consider whether the current scope should also use bundled, plugin, or local skills such as:

- Security review skills for auth, dependency, injection, data exposure, or threat-model work.
- UI/UX/design-system review skills for frontend visual, accessibility, responsive, or animation changes.
- Framework-specific skills for Next.js, React, Vercel, Supabase, Cloudflare, iOS/macOS, Android, or other platform-specific code.
- Test/debugging skills when failures, flaky tests, or CI regressions are the core request.
- Project-specific skills when the repository has local domain rules.

Use the smallest useful set. Do not load every related skill. If a specialized skill has stricter guidance for its domain, follow it for that domain and keep this skill responsible for scope, evidence quality, severity, and final review structure.

If tool discovery is available and the request names or implies a specific plugin/framework, search for relevant tools/skills before falling back to this skill alone.

## Subagents And Research

For non-trivial reviews, prefer using subagents when available. Good splits:

- One implementation reviewer for correctness/regressions.
- One security reviewer for auth, trust boundaries, data exposure, and dependency risk.
- One performance reviewer for loading, caching, query behavior, and scalability.
- One UI/accessibility reviewer for frontend surfaces.
- One framework/domain specialist when the repo uses a specific platform such as Next.js, Vite, Supabase, Cloudflare, iOS/macOS, Android, or a project-specific stack.

Use subagents when they reduce blind spots. Do not spawn them for tiny diffs where coordination would add noise.

Treat research as part of review evidence:

- Do not assume framework, SDK, API, or platform behavior is current.
- Read local docs and repo instructions first.
- Use current official docs, Context7, bundled plugin docs, or web search when version-specific behavior, security posture, platform rules, browser behavior, package APIs, or deployment behavior matters.
- Prefer primary sources: official docs, specs, release notes, source repos, advisories, or vendor docs.
- Cite or summarize the external fact that supports a finding.
- If research cannot confirm a suspected issue, mark it `unclear` or omit it.

## Scope Clarification

Ask when the user says only "review this" or multiple scopes seem plausible:

```text
I am not sure which review scope you want. Should I review:
1. only the current diff
2. the whole branch as a PR review
3. the touched files fully
4. a specific module/directory
5. a broader repo audit for older issues
```

Do not ask when the request clearly maps to a mode below.

## Review Modes

- `diff-review`: Review only the current diff. Best for small changes.
- `branch-review`: Review the whole branch as a change package, usually `git diff <base>...HEAD` plus commits.
- `touched-surface-review`: Review changed files fully, not just changed lines.
- `module-review`: Review a named file, component, package, route, or directory.
- `repo-audit`: Broader search for existing risks, older bugs, architecture issues, and systemic gaps.

Default mapping:

- "review", "code review", "check my changes" -> current diff plus touched files.
- "PR review", "before merge", "branch review" -> branch review plus touched-surface review.
- "audit", "old problems", "find risks" -> repo audit.
- named file/directory/module -> module review.
- "security review" -> load `references/security.md`.
- "performance review" -> load `references/performance.md`.

For each finding, tag origin when possible:

- `introduced-by-branch`
- `pre-existing`
- `unclear`

## Reference Loading

Always read `references/general.md`.

Load additional references only when relevant:

- TypeScript/JavaScript: `references/typescript.md`
- React: `references/react.md`
- Next.js: `references/nextjs.md`
- Vite/SPAs: `references/vite.md`
- iOS/macOS/Android/mobile apps: `references/mobile.md`
- Security-sensitive changes: `references/security.md`
- Performance/lazy loading/data loading: `references/performance.md`
- Tests/fixtures/CI: `references/testing.md`
- Novari repos or Novari AGENTS/project docs: `references/novari.md`

Do not bulk-load every reference. Use the smallest set that matches the code under review.

## Review Workflow

1. Establish scope and base.
   - Prefer the repo's default base branch if obvious (`main`, `dev`, `develop`).
   - If not obvious, inspect remotes/branches or ask.
2. Build context.
   - Read changed files and nearby callers/callees.
   - Trace data flow, auth/permission boundaries, side effects, and tests.
   - For branch/module/repo reviews, search for repeated patterns with `rg`.
3. Look for high-signal issues first.
   - correctness bugs
   - regressions
   - missing authorization or validation
   - stale API contracts
   - missing/incorrect tests
   - production-only failures
   - performance cliffs
4. Verify before reporting.
   - A finding should be reproducible or strongly evidenced from code.
   - Avoid style nits unless they hide bugs, accessibility issues, or repo-rule violations.
5. Run appropriate checks when feasible and allowed.
   - Typecheck, lint, relevant tests, build, or targeted scripts.
   - Report exact failures.

## Output Rules

Follow a code-review stance:

- Findings first, ordered by severity.
- Use tight file/line references.
- Keep summaries short and secondary.
- If there are no findings, say so clearly and mention residual risk/test gaps.
- Do not include long praise, rewrite plans, or unrelated refactors.
- Do not invent evidence.

Finding shape:

```text
[P1] Title
file:line
Origin: introduced-by-branch | pre-existing | unclear
Why it matters and the smallest fix.
```

Severity:

- `P0`: immediate production/security/data-loss risk
- `P1`: likely bug, serious regression, exploitable risk, or failing core workflow
- `P2`: meaningful edge case, maintainability risk, missing important test
- `P3`: low-risk improvement; include sparingly

When the host supports inline review comments, emit inline findings for actionable code issues and keep line ranges tight.
