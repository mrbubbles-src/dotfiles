---
name: orchestrate
description: Default coordination mode for every concrete task-oriented user request. Use from the beginning of investigation, diagnosis, research, analysis, planning, implementation, debugging, review, verification, or execution. Ordinary conversation without a concrete task outcome does not require this skill. Trivial and straightforward tasks may remain inline; delegate substantive work with clear ownership.
---

# Orchestrate

Use this skill from the beginning of every concrete task request. Activation does not require delegation for trivial or straightforward tasks; handle those inline.

For substantive work, remain available to the user while delegating substantive work. Run narrow, read-only scouts in parallel with `reasoning_effort: "low"` and `fork_turns: "none"`. Give each agent distinct ownership, prevent overlapping assignments, and instruct leaf workers not to delegate. Integrate the results and keep approvals with the user. For non-review work, default to the model selected for the current task, unless the user specifies otherwise or the Luna rule below applies.

Choose reasoning effort according to the model assigned to each agent:

- GPT-6 Astra: Use `reasoning_effort: "low"` by default for routine, well-defined work. Use `"medium"` when the assignment requires reasoning across interacting components or weighing non-obvious alternatives. Use `"high"` for difficult reasoning, such as subtle concurrency problems, complex migrations, or unresolved issues that require deeper analysis.
- GPT-5.6: Keep `reasoning_effort: "medium"` for routine implementation and `"high"` for difficult work. Narrow, read-only scouts remain at `"low"`. The specific Luna rule below takes precedence when Luna is selected.

For all reviews and re-reviews, use GPT-6 Astra regardless of the model used for implementation. Apply the same Astra effort levels above. Choose effort for the specific review assignment; being a reviewer,
performing a final review, or working within a large project does not by itself require a higher effort level. Keep the required review coverage and evidence standards at every level.

For very clear, bounded non-review tasks that can be completed and verified independently, consider delegating to `gpt-5.6-luna` with `reasoning_effort: "high"` and `fork_turns: "none"`. When using Luna this way, give it a self-contained assignment with all necessary context, constraints, paths, acceptance criteria, and expected output.

If completing the current task requires authorized work in another project or repository and the current agent cannot write there from its current project context, create a new Codex thread in the appropriate project and delegate that bounded work there. Give the thread enough task-specific context and instructions to complete its assigned part correctly, coordinate its progress, and integrate its handoff. Do not work around project boundaries.

If the cross-project work would materially expand the approved scope, obtain user approval before creating or dispatching the thread.

## Pull Request Review Reuse

When a pull request already has an active automatic independent reviewer, use that PR reviewer as the default independent review for coherent work pushed to that PR.

Do not automatically create an additional separate reviewer after every implementation block. For normal PR-based development:

1. implement one coherent work block;
2. run focused verification during implementation;
3. run the relevant local checks for the completed block;
4. push the completed block to the pull request branch;
5. let the automatic PR reviewer inspect the updated candidate;
6. address confirmed findings from that review.

A separate additional independent review is required only when at least one of the following applies:

- the automatic PR reviewer is unavailable, skipped, or clearly insufficient for the changed surface;
- its findings are materially ambiguous, conflicting, or require independent adjudication;
- the change is unusually security-critical, data-integrity-critical, migration-sensitive, concurrency-sensitive, or otherwise high-risk enough to justify extra coverage;
- the candidate cannot be pushed to an active reviewed PR before the next dependent work begins;
- the user explicitly requests another independent review.

Do not duplicate unchanged review coverage merely because another commit was pushed, a work block completed, or a PR is being prepared.

Use focused re-review for corrections to confirmed findings. Repeat a broader review only when the candidate materially changes or the findings reveal a wider risk.

This PR-review reuse rule changes the review cadence, not the required quality bar. Tests, verification, contract checks, and unresolved findings must still be completed before merge readiness.