---
name: novari-logging-slice-gates
description: Prepare, implement, or independently review a narrow Novari Logging V2 slice when the request names an allowlist, baseline, stop gate, or separate Go.
argument-hint: "[slice and repository]"
disable-model-invocation: true
user-invocable: false
allowed-tools:
  - Read
  - Grep
  - Bash
---

# When to use

Use for Novari Logging V2 backend/Portal/LMS slice work, especially B1/C1a/W2/D1/E1/E2/E3/F1/F1a requests with a named baseline, allowlist, or read-only review.

Do not use to broaden a slice, repair adjacent work, or infer authorization from an aligned plan.

# Inputs / context to gather

1. Read the checkout `AGENTS.md`, current Logging V2 Spec/Visualization, and relevant `MEMORY.md` block.
2. Record repository, branch, exact baseline/HEAD, worktree status, upstream counts, requested mode, and changed-file allowlist.
3. Identify whether an explicit Go authorizes edits/commit/push; treat plan/review alignment as non-authorization.

# Procedure

1. Enforce the start gate. Stop on a branch, baseline, status, upstream, repository, allowlist, or specified freeze-hash mismatch. For a freeze-hash mismatch, do not read hunks, run tests, or issue findings; request recreation of the exact snapshot.
2. Inventory/reuse existing central route, projection, test, and UI surfaces before designing anything new.
3. Map each proposed runtime hunk to an authorized Spec case. If there is no authorization, produce findings/plan only.
4. For implementation, work only in the allowlist; preserve legacy, direct callers, warning paths, and other named exclusions.
5. Freeze the uncommitted candidate for an independent full-diff review when required. Do not commit/push before its acceptance and user Go.
6. Validate focused tests first, then only authorized broader checks. Report baseline failures/skips separately from regressions.
7. Before a normal push, recheck staged files, `git diff --check`, branch/upstream, exact commit message, and no amend/force constraint.

# Efficiency plan

1. Check start-gate facts in one bounded repository-status pass.
2. Search only known paths; a broad `rg` containing nonexistent directories is incomplete evidence.
3. Read plan/review summaries before reopening more source. Stop immediately at a normative or scope gate.

# Pitfalls and fixes

- Symptom: feature is named in the Spec but no §2.2 case permits its runtime change. Fix: stop for normative clarification; do not implement a precursor by assumption.
- Symptom: adjacent callers/tests are pulled into a central slice. Fix: classify them as central, later producer-specific, or unchanged before editing.
- Symptom: code relies on a removed injection or unsafe projection. Fix: test real imports and use fail-closed own-data allowlists; do not execute getters or project raw fields.
- Symptom: full lint/typecheck fails outside scope. Fix: retain focused evidence and report the known baseline failure without expanding scope.
- Symptom: a frozen candidate hash differs from the expected snapshot. Fix: stop before substantive review. Reproduce the project-defined tracked/untracked serialization; `git diff --binary --full-index <baseline> | shasum -a 256` is only the canonical tracked-diff form.

# Verification checklist

- Exact repo/branch/baseline/upstream/status and allowlist checked.
- Each runtime hunk mapped to the current contract.
- Independent review used the actual full diff where requested.
- Any specified freeze hash matched before hunk inspection; otherwise the task stopped without findings.
- Focused tests and permitted broader checks reported with skips/baseline failures separated.
- Commit/push happened only after explicit authorization and final changed-file/diff checks.
