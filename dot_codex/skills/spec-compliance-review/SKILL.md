---
name: spec-compliance-review
description: Use when an existing implementation must be audited end-to-end against an authoritative spec, ADR, or requirements package for completeness or PR readiness. Do not use for ordinary implementation, planning, or task-, slice-, PR-, or code-level review.
---

# Spec Compliance Review

Perform an independent, read-only conformance audit. The question is not merely whether the implemented slices are correct; it is whether every normative obligation in the original specification is satisfied by the exact candidate under review.

Do not edit code, tests, documentation, branches, or repository state unless the user separately authorizes implementation. Record findings and corrective slices instead of repairing them during the audit.

## When to Use

Use this heavyweight audit only when at least one of these conditions holds:

- An existing implementation must be checked completely against a concrete authoritative feature or project spec, ADR and acceptance package, requirements set, or comparable normative contract.
- The user explicitly requests a full spec-compliance, conformance, completeness, traceability, or PR-readiness audit.
- A larger spec-based feature is approaching a checkpoint, completion, or PR and the question is whether every original obligation—not merely the implemented slices—has been satisfied.
- There is concrete reason to suspect requirement omission, requirement reinterpretation, or drift between an original normative contract and the current implementation.

An ordinary user prompt or task description is not automatically a specification. Do not promote “build feature X with Y and Z,” task-level acceptance criteria, an implementation plan, or the size of the work into a formal compliance contract.

If no authoritative original spec or comparable normative contract exists, do not claim full spec compliance. Use this workflow only when the user explicitly requests a gap analysis; label it as such, identify the limited input contract, and do not issue `READY`.

## When NOT to Use

Do not use this skill merely because work is large, spans many files or repositories, or has ordinary acceptance criteria. It is not a replacement for:

- normal code or PR review;
- slice review;
- feature planning or implementation;
- bug-fix verification;
- test-driven development;
- ordinary task-level acceptance checking;
- architecture or design review without a normative original spec.

This workflow is intentionally thorough and comparatively expensive. Use it only when complete traceability against an actual authoritative contract justifies that cost.

## Choose the audit point

- **Checkpoint audit:** Run during a larger spec-based project to expose omissions, reinterpretations, drift, and missing evidence early. `partial` and `missing` are expected results. Report current coverage and blockers, but do not treat the checkpoint as the final readiness gate or issue `READY`.
- **Final compliance review:** Run before completion or PR as the full readiness gate. Apply all candidate-freeze, evidence, cleanup, full-diff, and verdict rules below.

Both modes use the same matrix method. Do not split matrix construction into a separate skill.

## Establish the review contract

1. Locate the original specification or comparable normative contract and treat it as the source of truth. Prefer the approved artifact over plans, issue summaries, PR descriptions, prior agent reports, or remembered intent.
2. Record the spec identity: path or URL, version or commit, and hash when practical. If product intent has clarified an ambiguous contract, require that clarification to be present in an authoritative artifact or list it as an unresolved contract blocker.
3. Freeze the candidate for every affected repository or component: repository, branch, HEAD, upstream, working-tree state, and the exact diff or allowlist in scope. Recheck this identity before the final verdict. A changed candidate invalidates earlier evidence until the affected checks are rerun.
4. Identify affected user roles, producers, consumers, APIs, schemas, persistence boundaries, permissions, environment behavior, UI states, external systems, and removal prerequisites. This is domain discovery, not permission to broaden implementation scope.

If the original spec cannot be identified, follow the explicit gap-analysis fallback above. If the exact candidate cannot be identified, the result is `INDETERMINATE`; do not declare the feature PR-ready.

## Build the contract matrix before judging the code

Read [references/contract-matrix.md](references/contract-matrix.md) for the required matrix fields, status rules, evidence rules, and report shape.

Create the matrix within this skill. Extract every normative requirement, acceptance condition, and authoritative non-goal into atomic rows. Split combined clauses when they can fail independently. Include positive behavior, negative behavior, failure and empty states, authorization, persistence and non-persistence, environment isolation, observability or support behavior, compatibility, migration or cleanup, and required verification.

If a matrix already exists, reuse it only after checking it row by row against the current authoritative source for completeness, correct atomization, applicability, and source identity. The existing matrix is an aid, not the contract.

For each row, identify the concrete producer, consumer, or owner that must satisfy it. Do not mark a row fulfilled because related infrastructure, a schema field, a helper, or a test harness exists. Fulfilled means the required behavior is present on the real path and has the required proof.

Do not silently reinterpret ambiguous, contradictory, or outdated language. Record the conflict, its practical consequence, and the decision needed. An unresolved contract contradiction blocks readiness.

## Trace implementation and verification

Audit from the matrix into the current candidate, not from the changed files outward.

For each requirement:

- Cite concrete implementation evidence using repository, file, symbol or route, and relevant lines or commit identity.
- Follow the end-to-end ownership chain across repositories and layers. Confirm the actual producer, transport, consumer, visible owner, persistence owner, and error owner where relevant.
- Cite concrete automated-test evidence: test file and case, what behavior it proves, and the result on the exact candidate. Test presence without execution evidence is weaker evidence and must be labeled as such.
- Require browser or manual evidence when the spec demands it or the behavior is inherently visual, interactive, browser-specific, or integration-dependent. Record the scenario, real route and data or fixture, expected observation, actual result, and candidate identity.
- Distinguish a real product-path test from a special test-only path. A button, sentinel, synthetic toast, mock page, or helper proves only itself unless it drives the production request, handler, interceptor or BFF, owner, and final sink required by the contract.
- Mock only boundaries when the contract requires proof of the real internal owner path. Do not accept a mocked-away implementation layer as proof of that layer.
- Treat prior summaries, plans, agent claims, green slice reviews, and related infrastructure as leads, never as fulfillment evidence.

Classify each row as `fulfilled`, `partial`, `missing`, or `intentionally-not-applicable`. `intentionally-not-applicable` requires an explicit authoritative basis; reviewer inference is insufficient.

## Preserve independent review

For a large cross-repository feature, separate evidence gathering into non-overlapping read-only tracks when orchestration is available, such as specification extraction, backend or persistence behavior, and user-facing Portal/LMS or integration behavior. Keep one integrator responsible for rereading the original spec, reconciling every row, checking cross-track contracts, and issuing the verdict.

Do not let implementation plans or earlier agent conclusions become inherited facts. The final conformance pass starts from the original spec and current candidate again.

## Report findings and readiness

Report actionable findings first, ordered P0 through P3. Each finding must state:

- affected requirement IDs;
- what the spec requires;
- what the candidate actually does;
- impact and severity;
- the drift or finding type when it materially clarifies the cause;
- concrete evidence;
- any relevant prior completion claim as provenance, never as evidence;
- the smallest coherent corrective slice and closure owner when reasonably identifiable, without implementing it.

Then provide the complete matrix or a linked artifact, coverage totals by status, unresolved contract questions, verification gaps, and candidate identity.

Use only these readiness verdicts:

- `READY`: every mandatory row is `fulfilled` or authoritatively `intentionally-not-applicable`; no P0/P1 issue or unresolved contract contradiction remains; required automated and browser/manual checks passed on the exact final candidates; the full affected diff was reviewed; and temporary test triggers, pages, fixtures, bypasses, or debug helpers are absent from the PR candidates.
- `NOT READY`: at least one mandatory row is partial or missing, a readiness blocker remains, required evidence is absent or stale, or candidate identity is not frozen.
- `INDETERMINATE`: the authoritative spec, candidate, repository, dependency, or verification environment is unavailable, preventing a defensible decision.

State PR readiness separately for each repository and for the integrated feature. State deployment readiness separately when deployment, migration, environment, rollback, operational, or external-system evidence exceeds the PR contract. Do not call production fixed or deployment-ready based only on local or PR evidence.

P2/P3 findings do not automatically block readiness unless the spec, repository policy, or their cumulative effect makes them release-blocking; state that decision explicitly.
