---
name: weekly-codex-maintenance-report
description: Run the local Codex maintenance workflow in strict report-only mode, check thread-tool availability first, and triage handoff candidates from bounded evidence instead of broad scans.
argument-hint: "[optional note]"
disable-model-invocation: true
user-invocable: false
allowed-tools:
  - Read
  - Grep
  - Bash
---

# When to use

Use for the recurring weekly Codex maintenance report or similar "check local Codex state and tell me what needs handoff attention" tasks on this machine.

Do not use for cleanup/apply runs unless the user explicitly overrides the report-only rule.

# Inputs / context to gather

1. Read the latest automation memory if present:
   `/Users/mrbubbles/.codex/automations/weekly-codex-maintenance-report/memory.md`
2. Remember the hard constraints:
   - Never pass `--apply`.
   - Never archive, move, prune, rotate, normalize, delete, or otherwise mutate local Codex state by default.
3. Check whether thread tools are available:
   - `read_thread`
   - `list_threads`
   - `send_message_to_thread`

# Procedure

1. Start in report-only mode.
2. If `python` is unavailable, use `/opt/homebrew/bin/python3`.
3. Run the maintenance script read-only.
4. Probe thread-tool availability before choosing the triage path.
5. If thread tools are available:
   - Use them only for idle, high-confidence candidates.
   - Skip active/running threads.
   - Skip low-value threads.
   - Skip threads that already had a recent handoff for the same work.
6. If thread tools are unavailable:
   - Use bounded script output rather than broad rollout or handoff-directory scans.
   - Triage the concrete emitted evidence conservatively.
7. Treat `handoff_review_candidates` as a prefilter, not the final decision.
8. Final output should contain only:
   - `Handoff machen`
   - `Unsicher prüfen`
   - skipped-bucket counts
   - exact `handoff_action_prompt` text for actionable items

# Efficiency plan

1. Prefer bounded script output over manual deep scans.
2. Preserve emitted prompts verbatim instead of rewriting them.
3. If a candidate thread is invisible to thread tools, stop escalating the lookup and use the script-emitted evidence conservatively.

# Pitfalls and fixes

- Symptom: `python` not found.
  Likely cause: PATH mismatch on this machine.
  Fix: use `/opt/homebrew/bin/python3`.

- Symptom: writes fail under `/automations`.
  Likely cause: `$CODEX_HOME` is unset.
  Fix: write under `/Users/mrbubbles/.codex/...` explicitly.

- Symptom: a candidate thread cannot be opened via `read_thread`.
  Likely cause: thread is no longer directly visible to tools.
  Fix: preserve the emitted `handoff_action_prompt` and classify conservatively; do not claim success.

- Symptom: temptation to mark every candidate `needs-user-review`.
  Likely cause: thread tools are missing or evidence is noisy.
  Fix: stay bounded, use concrete `handoff_*` evidence, and only escalate ambiguous leftovers.

# Verification checklist

- Confirm no mutating flags/actions were used.
- Confirm tool-availability detection happened before fallback selection.
- Confirm `handoff_review_candidates` was not treated as the decision.
- Confirm the final report is compact and contains exact prompts for action items.
- Confirm heavy processes were reported only, not killed.
