# Contract Matrix and Report Format

Use this reference when running a spec compliance review. Adapt labels to the project, but keep every evidence and verdict field represented.

## Matrix fields

| Field | Required content |
|---|---|
| Requirement ID | Stable spec section, acceptance-condition ID, or locally assigned ID tied back to the source. |
| Source | Exact spec location and version or hash. |
| Obligation | One atomic normative behavior, including important negative requirements. |
| Applicability | Mandatory, conditional with condition, or authoritatively not applicable. |
| Surface | Repository, service, client, role, environment, external system, or cross-repo contract. |
| Producer / consumer / owner | Concrete component that creates, transports, consumes, persists, displays, or owns the behavior. |
| Expected contract | Inputs, outputs, state transitions, permissions, failure semantics, persistence semantics, and prohibited behavior. |
| Implementation evidence | Current repository, file, symbol or route, lines or commit, plus what the evidence proves. |
| Automated-test evidence | Test file and case, level, exact command or CI run, result, and what the test proves. |
| Browser / manual evidence | Required scenario, route and data or fixture, candidate identity, observed result, and evidence location; otherwise `not required`. |
| Status | `fulfilled`, `partial`, `missing`, or `intentionally-not-applicable`. |
| Finding / blocker | Finding ID and severity, unresolved contract question, evidence gap, or `none`. |
| Drift / finding type (optional) | Use when helpful to distinguish omission, reinterpretation, drift, implementation failure, or an evidence problem. |
| Prior claim / provenance (optional) | Earlier agent, slice, plan, review, or report that claimed completion; never fulfillment evidence. |
| Closure owner / corrective slice (optional) | Coherent remaining slice, responsible repository or owner, or the product or contract decision required first. |

Add a row for a requirement even when no implementation or test exists. Empty evidence is itself a result; do not omit the row.

Use the optional traceability fields when they improve diagnosis or closure planning. Do not force values merely to populate a taxonomy.

### Drift and finding types

Choose the closest useful type when one applies:

- `requirement-omission`: a normative obligation was not carried into implementation.
- `requirement-reinterpretation`: implementation follows a materially different meaning than the authoritative requirement.
- `contract-drift`: code and the authoritative contract diverged over time without a valid contract update.
- `implementation-defect`: the intended requirement is represented but implemented incorrectly.
- `verification-gap`: required proof is absent or insufficient.
- `stale-evidence`: evidence refers to an earlier candidate and was not rerun after change.
- `unresolved-contract`: authoritative sources are ambiguous or contradictory.
- `unauthorized-scope-change`: implementation changes behavior outside the approved contract.

Severity describes impact; drift type describes the nature of the deviation. Keep them separate.

### Prior claims and closure provenance

Record a prior completion claim only when it is relevant to understanding audit drift, for example `Portal-Corr-4 review — claimed complete`. A prior claim can explain `previously claimed complete -> current status partial`, but it cannot raise evidence strength or satisfy any matrix row.

For each open mandatory row, record a closure owner or corrective slice when the evidence supports one. Use a repository, responsible system or team, or `product/contract decision required`. Do not invent ownership or turn the read-only audit into implementation.

## Status rules

### `fulfilled`

Use only when all applicable clauses are present and the required evidence proves the real behavior on the exact candidate. A fulfilled row needs:

- an identified producer, consumer, or owner;
- concrete implementation evidence;
- appropriate automated-test evidence;
- browser or manual evidence when required;
- no contradictory behavior on another affected surface.

### `partial`

Use when part of the obligation is implemented or proven but at least one independently meaningful clause, surface, state, or required verification is absent or contradicted.

### `missing`

Use when the required behavior is absent, only planned, represented solely by unused infrastructure, or has no credible evidence.

### `intentionally-not-applicable`

Use only when the authoritative spec, an approved decision record, or the requirement's explicit condition excludes the candidate. Cite that basis. Do not use this status to excuse an omission discovered during review.

If a contract is ambiguous, retain the evidence-based status the current implementation deserves and add an unresolved-contract blocker. Do not manufacture a compliant interpretation.

## Evidence strength

Prefer evidence in this order:

1. Exact current code plus a passing real-path automated test on the frozen candidate.
2. Exact current code plus required browser or integration evidence on that candidate.
3. Exact current code with an existing but not freshly executed relevant test, labeled stale or unverified.
4. Static code evidence without behavioral verification, labeled incomplete.

Plans, summaries, prior review conclusions, issue checkboxes, PR prose, generated interfaces without producers, and special test-only behavior are not fulfillment evidence.

When behavior spans layers, record the chain compactly, for example:

`real request -> backend failure -> safe error envelope -> client/BFF path -> one visible owner -> support information -> persisted event only if the persistence contract requires it`

Do not infer that every safely handled error must be persisted. Verify persistence and non-persistence against the contract row by row.

## Findings format

Use findings-first reporting:

```text
[P1] <short title> — <requirement IDs>
Spec: <required contract>
Actual: <observed candidate behavior>
Impact: <user, data, security, compatibility, or release impact>
Evidence: <specific code/test/browser references>
Corrective slice: <smallest coherent change boundary; no implementation during review>
Drift type: <optional classification>
Prior claim: <optional provenance; never evidence>
Closure owner: <repository, owner, or decision required>
```

Use the project's severity policy when one exists. Otherwise:

- P0: active or imminent catastrophic data loss, security compromise, or system-wide failure.
- P1: release-blocking correctness, security, data-integrity, or core-contract failure.
- P2: material defect or missing contract behavior that may be fixed independently.
- P3: limited-risk defect, evidence weakness, or maintainability concern relevant to compliance.

## Readiness report

Conclude with:

1. Findings, P0 to P3.
2. Matrix coverage: total mandatory rows and counts for each status.
3. Unresolved contract questions and unavailable evidence.
4. Open mandatory requirements grouped by closure owner or corrective slice when available.
5. Relevant prior completion claims that conflict with current evidence.
6. Candidate identity for each repository or component.
7. Checks actually run with exact results; distinguish local, build/CI, browser, PR, deployment, and live verification.
8. Temporary test or debug artifacts scan.
9. Repository-level PR verdicts.
10. Integrated-feature PR verdict.
11. Deployment-readiness verdict, if requested or materially distinct.

Never collapse `NOT READY` into a percentage-complete statement. Coverage percentages may summarize the matrix, but any mandatory partial or missing row remains visible and blocks a ready verdict.
