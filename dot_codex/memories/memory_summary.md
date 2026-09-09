v1

## User Profile

The user coordinates evidence-led engineering, review, release, and cleanup across Novari Education (Backend, Portal, LMS, Website) and private products such as Inlyra, Faverelay, and Bubblophy. They work in German and use Codex for narrow implementations, independent review, handoffs, live-state investigation, and explicit stop/reactivation gates. They value exact scope, branch/baseline identity, ownership boundaries, and reports that separate local/slice evidence from PR, merge, deployment, and production reality. They prefer reusing existing components and keeping normal chat distinct from durable structured state. They call ChatGPT “Mika” and refer to Mika as female. [ad-hoc note]

## User preferences

- Lead reviews with P0–P3 findings and an explicit `HIGH-REVIEW PASS/FAIL`; reconstruct the actual candidate and remain read-only when requested.
- Treat an explicit stop as immediate; do not resume implementation, provider activity, commits, pushes, or extra tool calls until reactivated.
- Preserve exact allowlists, baseline/freeze/branch identity, ownership boundaries, and repo-local `AGENTS.md`; stop on mismatch rather than infer authorization.
- Keep runtime/slice PASS distinct from PR, merge, deployment, and overall readiness; focused green tests are not release evidence.
- Before changing configuration, “verify the exact configuration” and “show me a proposed diff before changing anything.”
- Start new Novari integrations by identifying components, services, and contracts to reuse or extend; “Wir müssen nicht alles von Grund auf neu aufbauen.”
- For a reproduced production access failure, prioritize it over lower-impact UI or maintenance work. [skysight memory]
- Preserve changed worktrees until backup/disposition is explicit. [skysight memory]

## General Tips

- Establish repo/branch/HEAD/upstream/clean tree, applicable `AGENTS.md`, contract, allowlist, and stop gate before edits in shared Novari worktrees.
- Report PR, branch divergence, CI, merge, deployment, and live smoke evidence separately.
- `apply:false`, an uncaptured `mongosh` result, or GitHub `Merging...` is not proof of a repair or merge; require terminal output/state.
- Use fresh independent evidence over historic handoffs. Archive before retention: archive state → complete verification → retention → final state.
- For resource pressure, use serial runs: `--maxWorkers=1 --no-file-parallelism`.
- Redact provider/environment/financial values and treat live state as time-sensitive.

## What's in Memory

### /Users/mrbubbles/dev/novari/novari-education-{backend,portal,lms,website}

#### 2026-09-09

- Release coordination and guarded cleanup: `GitHub-Setup trotz Abweichungen`, `AGENTS.md`, old worktrees, `Repository not found`, DATEV
  - desc: September 8–9 observed curriculum repair, Backend/LMS release, production smoke checks, local worktree safety, and local finance-file cleanup.
  - learnings: Capture terminal merge/preflight output; retain changed worktrees until backup is decided. [skysight memory]

#### 2026-09-08

- Classroom50 read-only integration spec: `Classroom50`, `libs/classroom50`, `locked`, `available-from`, `StudentReleasePicker`, `LmsContentGrant`
  - desc: Reuse-first Novari Backend architecture and provider-PoC boundary; no implementation or GitHub Education approval.
  - learnings: `locked` protects private templates; `available-from` only controls listing.

- Curriculum/LMS main release and smoke validation: `runMongoshProjectionCounterRepair`, `apply:false`, `BSONVersionError`, PR #247, PR #204, LMS PR #44, Backend PR #252
  - desc: Current repair/review/release snapshot and unresolved LMS dropdown/sidebar follow-up.
  - learnings: manual merge actions and an apparent improved login do not settle remaining live behavior. [skysight memory]

### /Users/mrbubbles/dev/private/projects/{bubbles-verse,inlyra,faverelay}

#### 2026-09-05

- Bubblophy, Inlyra, and Faverelay boundaries: `BUBBLOPHY_PHASE_3_FEATURE_EXTENSION_SPEC.md`, `approvalRef`, `SafariTabs.db`, `--allow-profile`
  - desc: Controlled MCP/state contracts, bounded Gmail proof, and browser-sync capability gates.
  - learnings: no provider action without approval; Safari stays source-only until native write/reopen/restore proof.

### Older Memory Topics

#### Novari Education — Logging V2 delivery and controls

- Route ownership and acceptance controls: `D-I0a–D-I0l`, `safeDomainDetails`, `sendProjectedErrorResponse`, `V-B`, `D-CA`, `C0`
  - desc: Backend/Portal/LMS safe error projection, real-path validation, traceability, retention, and release gates; cwd=/Users/mrbubbles/dev/novari/novari-education-{backend,portal,lms}.
- Portal error-ownership waves: `F1a–F1x`, `E1`, `E3`, `Request-ID`, `opaque document/PDF`, `Variante-A`
  - desc: Portal single-owner toasts, envelope privacy, auth refresh, and frozen-review boundaries; cwd=/Users/mrbubbles/dev/novari/novari-education-portal.

#### Codex and private workflows

- Codex configuration and monitoring: `context_management.experimental_mode`, `prevent_idle_sleep`, `watch-codex-threads`
  - desc: Exact config verification and fail-closed sleep/heartbeat workflows.
- Product/specification work: `Bubblophy`, `Phase 3`, `private recipe library`, `documentation taxonomy`
  - desc: Structured-state/product boundaries and documentation conventions; cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse.
- Local audio and workspace onboarding: `mlx-whisper`, `ffprobe`, `users.insert`, `Preview and Send`
  - desc: WhatsApp transcription and Google Workspace onboarding-email distinction; cwd=/Users/mrbubbles/dev/Codex/2026-09-03/new-chat.
