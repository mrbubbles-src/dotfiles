# Task Group: Novari Classroom50 read-only integration specification
scope: Resume the reuse-first Classroom50 architecture/specification work; it does not establish GitHub Education approval, provider behavior, or implementation authority.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=verify Classroom50 and GitHub provider behavior in a current small PoC before implementation.

## Task 1: Produce a read-only, reuse-first Classroom50 integration spec v0.1

### rollout_summary_files

- rollout_summaries/2026-09-08T01-02-04-fffA-classroom50_novari_readonly_integration_spec.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/08/rollout-2026-09-08T03-02-05-01a07e89-56b1-73b1-b9a8-39032a7df48a.jsonl, updated_at=2026-09-08T01:32:03+00:00, thread_id=01a07e89-56b1-73b1-b9a8-39032a7df48a, read-only spec; no implementation or provider action)

### keywords

- Classroom50, libs/classroom50, private-template, locked, available-from, StudentReleasePicker, LmsContentGrant, overviewRowId, exerciseLinks, githubUsername, User-to-Server OAuth, courseDay, moduleSnapshotId, idempotency

## Reusable knowledge

- Classroom 50 has no Parent/Child-Classroom level; private assignment templates must live in the same organization as the Classroom. Keep the tightly guarded existing Curriculum GitHub App separate; a new `libs/classroom50/` domain and a small end-to-end provider PoC are the proposed boundary, not a validated implementation. [Task 1]
- `available-from` controls listing only. Protect templates by registering private assignments as `locked`, then explicitly unlock for the whole Classroom at the course-calendar time; current evidence does not establish individual early unlock. Bind durable assignments by repository ID, fixed assignment commit, and explicit `overviewRowId`/course-day reference, not a prefix such as `ITBT-`. [Task 1]
- Existing course `type`/`curriculumVersionId`, `exerciseLinks`, LMS course access, `LmsContentGrant`, `StudentReleasePicker`, and job lease/cursor/idempotency patterns are reuse candidates. Task release needs its own scope/reader so existing `all` content grants cannot unlock assignments; extending the three-field `exerciseLinks` contract also requires hash, validation, snapshot, merge, import/export, and recovery compatibility. [Task 1]

## Failures and how to do differently

- Symptom: a future `publishAt`, withheld Portal link, or public username profile is treated as access control/identity proof. Fix: use `locked` private in-org templates for provider protection, keep tests/solutions out of public GitHub Pages metadata, and require GitHub identity confirmation with an immutable user ID/User-to-Server OAuth before personal assignment. [Task 1]
- Symptom: `--unlock` is specified as per-student early release or master changes silently flow into existing classes. Fix: prove the provider behavior in a prepared-classroom PoC first; freeze each class assignment state and make correction/update flows explicit. [Task 1]

# Task Group: Novari September 8 release coordination, live smoke checks, and local cleanup
scope: Current observed Backend/Portal/LMS/Website release and post-release status, plus guarded cleanup; distinguish observed GitHub/production state from independently verified success.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-{backend,portal,lms,website}, GitHub, Render, and production Portal/LMS; reuse_rule=all PR, deployment, database, and worktree state is live—reopen it before action.

## Task 1: Curriculum projection-counter repair and Backend/Portal review state

### rollout_summary_files

- extensions/skysight/resources/2026-09-08T12-00-00-UxjD-6h-memory-summary.md (cwd=Novari Education GitHub/Chrome and production `novari_nexus`, rollout_path=/Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T12-00-00-UxjD-6h-memory-summary.md, updated_at=2026-09-08T12:00:00+00:00, thread_id=None, observed dry-run/review state) [skysight memory]

### keywords

- codex/fix-curriculum-post-setup, runMongoshProjectionCounterRepair, apply:false, BSONVersionError, PR #247, PR #204, githubCurriculumTopicBindings, `__v`, 44 Prüfprobleme

## Task 2: LMS and Backend main-release coordination with production smoke validation

### rollout_summary_files

- extensions/skysight/resources/2026-09-08T18-00-00-TJfk-6h-memory-summary.md (cwd=Novari Education GitHub/Chrome, Portal/LMS, Render, and production `novari_nexus`, rollout_path=/Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T18-00-00-TJfk-6h-memory-summary.md, updated_at=2026-09-08T18:00:00+00:00, thread_id=None, observed manual merge and smoke-check state) [skysight memory]

### keywords

- LMS PR #43, LMS PR #44, Backend PR #252, Issue #42, `Web Development`, login redirect loop, `NovariEducation`, 815/816, main merge

## Task 3: Guarded Novari worktree/branch cleanup and DATEV handoff follow-up

### rollout_summary_files

- extensions/skysight/resources/2026-09-09T00-30-00-iIfL-10min-memory-summary.md (cwd=Codex `GitHub-Setup trotz Abweichungen` / novari-education-backend, rollout_path=/Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-09T00-30-00-iIfL-10min-memory-summary.md, updated_at=2026-09-09T00:30:00+00:00, thread_id=None, observed cleanup status; no further mutation captured) [skysight memory]
- extensions/skysight/resources/2026-09-09T00-20-00-kMWN-10min-memory-summary.md (cwd=Finder/HiDrive/DATEV follow-up, rollout_path=/Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-09T00-20-00-kMWN-10min-memory-summary.md, updated_at=2026-09-09T00:20:00+00:00, thread_id=None, local finance-file cleanup observed) [skysight memory]

### keywords

- GitHub-Setup trotz Abweichungen, AGENTS.md, Issue #186, old worktrees, old branches, `Repository not found`, DATEV, HiDrive, DKB VISA Business Card

## User preferences

- when release validation exposed an LMS login loop, the user made it the top priority and left the oversized review list and missing employee-list roles for later -> prioritize a reproduced production access failure over lower-impact UI/maintenance work. [Task 2] [skysight memory]
- when cleaning local Novari worktrees/branches, the observed guard refused removal of changed worktrees without clarified backup -> inspect and preserve changed worktrees until their backup/disposition is explicit. [Task 3] [skysight memory]

## Reusable knowledge

- `apply:false` projection-counter repair plus an uncaptured output is not a completed preflight or data repair. The observed first helper hit `BSONVersionError: Unsupported BSON version, bson types must be from bson 7.x.x`; an adjusted helper was submitted, but its final result was not captured. [Task 1] [skysight memory]
- A manual GitHub merge click and a release smoke check are separate facts. LMS login appeared improved after the PR #44/#252 merge actions, while the unexpected `Web Development` dropdown label and draft/sidebar behavior remained follow-up concerns. [Task 2] [skysight memory]
- Keep the active GitHub CLI identity explicit: `NovariEducation` was authorized for Novari operations and the active CLI account was later switched back to `mrbubbles-src`. [Task 2] [skysight memory]

## Failures and how to do differently

- Symptom: an awaiting `Merging...` panel, a manual merge dialog, or a dry-run invocation is presented as completed release/repair. Fix: capture the terminal GitHub state or the repair/postflight output before making that claim. [Task 1] [Task 2] [skysight memory]
- Symptom: old branches/worktrees are cleaned because a status report says most cleanup is done. Fix: inventory retained items and stop on unresolved backup, an old temporary tool, or a changed worktree; `Repository not found` for an old Curriculum remote also needs separate diagnosis. [Task 3] [skysight memory]

# Task Group: Codex 0.153.4 Astra context-management configuration verification
scope: Inspect local Codex/Desktop versions, feature flags, experimental context management, and a proposed configuration diff without applying it.
applies_to: cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc; reuse_rule=machine-version and config facts are time-specific; verify the live config and installed binaries before reusing.

## Task 1: Verify versions, feature state, and an optional sleep-prevention proposal without changing configuration

### rollout_summary_files

- rollout_summaries/2026-09-05T23-48-39-H8Q1-codex_astra_context_management_verification.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/06/rollout-2026-09-06T01-48-39-01a073f9-6485-7970-98ec-ad574e1e29e1.jsonl, updated_at=2026-09-05T23:50:55+00:00, thread_id=01a073f9-6485-7970-98ec-ad574e1e29e1, exact state verified; no configuration change applied)

### keywords

- codex-cli 0.153.4, ChatGPT.app, gpt-6-astra, context_management.experimental_mode, config.toml, codex features list, prevent_idle_sleep, js_repl, multi_agent, memories, goals, hooks

## User preferences

- when requesting configuration work, the user said “verify the exact configuration” and “show me a proposed diff before changing anything” -> inspect live state, validate and show the exact proposed diff, and do not apply it without separate authorization. [Task 1]
- when asking which features help their workflow, the user wanted observed enabled features separated from documentation-based recommendations -> do not enable experimental or unfinished options speculatively. [Task 1]

## Reusable knowledge

- At inspection, Homebrew and the ChatGPT desktop bundled binary both reported `codex-cli 0.153.4`; the desktop binary is `/Applications/ChatGPT.app/Contents/Resources/codex`, not `/Applications/Codex.app`. `/Users/mrbubbles/.codex/config.toml` had `context_management.experimental_mode = true`, and runtime reported `context_management` enabled. [Task 1]
- Official documentation says experimental context management requires eligible ChatGPT sign-in and applies to new tasks; it uses notes/searchable history. Do not claim universal availability, retroactive activation, or that `remote_compaction_v2`, `multi_agent_v2`, or bare `context_management` is a prerequisite. [Task 1]
- The optional, TOML-validated proposal only was to replace `js_repl = false` with `prevent_idle_sleep = true` under `[features]`; it was not applied and is useful chiefly for long standalone CLI runs because desktop sleep prevention was already configured. [Task 1]

## Failures and how to do differently

- Symptom: `/Applications/Codex.app` or `ps` inspection fails. Fix: inspect ChatGPT app metadata and `/Applications/ChatGPT.app/Contents/Resources/codex`; do not block exact version verification on process access. [Task 1]
- Symptom: a validated proposed diff is treated as authorization. Fix: present it as optional and leave the live configuration unchanged until a separate explicit Go. [Task 1]

# Task Group: Bubblophy Phase-3 product specification and communication/MCP boundaries
scope: Phase-3 product design for Bubblophy as a structured state layer beside ordinary chat; use for specification, orchestration, MCP, stop-gate, or human-in-the-loop decisions.
applies_to: cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc; reuse_rule=the product boundaries are reusable for Bubblophy work, but the 2026-09-03 specification checksum and file location are checkout-specific.

## Task 1: Create and refine the Bubblophy Phase-3 feature-extension specification

### rollout_summary_files

- rollout_summaries/2026-09-03T22-24-34-iUbG-bubblophy_phase_3_specification_and_communication_boundaries.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/04/rollout-2026-09-04T00-24-34-01a0695f-b301-7452-80c7-3dd6b30ef5d4.jsonl, updated_at=2026-09-03T22:40:31+00:00, thread_id=01a0695f-b301-7452-80c7-3dd6b30ef5d4, specification completed and structurally checked)

### keywords

- Bubblophy, Phase 3, BUBBLOPHY_PHASE_3_FEATURE_EXTENSION_SPEC.md, Current Contract Summary, Work Blocks, Decision Requests, Evidence, Handoffs, Supersession, MCP, OAuth, passive inbox, stop-gates, human-in-the-loop

## User preferences

- when designing Bubblophy, the user said: “Bubblophy ersetzt nicht die normale Chat-Kommunikation” -> keep chats as the workspace for discussion, questions, planning, explanation, and review; record only relevant durable structured outcomes in Bubblophy. [Task 1]
- when there is a real blocker, the user requires an active chat explanation of what happened, why a decision is needed, options, recommendation, and what can continue -> a Decision Request or Evidence entry alone must not silently stop work. [Task 1]
- the user corrected a global read-only framing -> controlled, audited Phase-3 MCP writes are appropriate for Codex, Claude Code, and similar clients; read-only is only a possible early client-specific ChatGPT rollout. [Task 1]

## Reusable knowledge

- Bubblophy is a shared state layer beside normal agent chats, not a chat replacement or free agent-to-agent chatbus. Treat genuine stop gates doubly: a structured Decision Request plus active escalation in the current chat; normal status/finding/evidence updates do not require needless user Go. [Task 1]
- Require a distinct, semantically narrow MCP write contract with current membership/role checks, attribution, conflict protection, and audit. Exclude a generic `update_anything`; keep normative Decision activation, supersession, scope changes, run approval, deployment, and destructive external actions separate or Human-only until a specific contract exists. [Task 1]
- Keep Work Blocks distinct from technical Issues/Tasks and individual Runs. Findings inside an approved Work Block do not automatically create a feature or micro-slice; large matrices need human aggregation before being presented as product defects. [Task 1]
- The verified artifact was `BUBBLOPHY_PHASE_3_FEATURE_EXTENSION_SPEC.md` (790 lines/6,168 words, SHA-256 `b9b2075f8691671b5b0ea5900122b439d5f15ae0fe3b314aa259ab41b558563b`); reuse existing projects/membership, issues, versioned plans, runs, audit, roles, agent tokens, and Remote-MCP/OAuth foundations. [Task 1]

## Failures and how to do differently

- Symptom: “structured state” is written as though it replaces chat. Fix: explicitly separate the communication layer from the state layer and preserve active chat escalation for real stop gates. [Task 1]
- Symptom: requested export path fails with `mkdir: /mnt: Read-only file system`. Fix: verify the target before authoring or offer the persistent project workspace early; the completed artifact remained there. [Task 1]
- Symptom: a patch fails from stale context. Fix: locate the actual current lines before applying the corrective patch. [Task 1]

# Task Group: WhatsApp local-audio transcription and Google Workspace onboarding explanation
scope: Locate and transcribe recent WhatsApp Desktop voice messages, then explain Google Workspace/Admin SDK versus an application-owned onboarding-email flow without overstating unresolved security details.
applies_to: cwd=/Users/mrbubbles/dev/Codex/2026-09-03/new-chat; reuse_rule=the local WhatsApp paths and venv are machine/session-specific; reuse the workflow only after confirming current media and permission boundaries.

## Task 1: Transcribe and summarize Martin's two newest WhatsApp voice messages

### rollout_summary_files

- rollout_summaries/2026-09-03T13-21-03-oJGu-whatsapp_martin_audio_google_api_email_erklaerung.md (cwd=/Users/mrbubbles/dev/Codex/2026-09-03/new-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/03/rollout-2026-09-03T15-21-03-01a0676e-19f8-7ae2-85f1-0ff5cf532bee.jsonl, updated_at=2026-09-03T13:35:02+00:00, thread_id=01a0676e-19f8-7ae2-85f1-0ff5cf532bee, local transcription completed)

### keywords

- WhatsApp Desktop, Martin Krüss, .opus, group.net.whatsapp.WhatsApp.shared/Message/Media, ffprobe, mlx-whisper, mlx-community/whisper-small-mlx, Metal, No Metal device available

## Task 2: Separate Google-admin behavior from Novari's own onboarding emails

### rollout_summary_files

- rollout_summaries/2026-09-03T13-21-03-oJGu-whatsapp_martin_audio_google_api_email_erklaerung.md (cwd=/Users/mrbubbles/dev/Codex/2026-09-03/new-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/03/rollout-2026-09-03T15-21-03-01a0676e-19f8-7ae2-85f1-0ff5cf532bee.jsonl, updated_at=2026-09-03T13:35:02+00:00, thread_id=01a0676e-19f8-7ae2-85f1-0ff5cf532bee, transcript and official-doc cross-check)

### keywords

- Google Workspace Admin console, Preview and Send, Admin SDK, users.insert, onboarding email, private address, recovery email, initial password, password reset, email history

## User preferences

- when summarizing voice messages, the user asked for the “beiden” latest messages -> verify the exact newest messages by duration/time before summarizing. [Task 1]
- when an audio-derived technical workflow is unclear, the user asked to distinguish “was Google selbst macht, was seine eigene Software übernehmen soll und an wen welche E-Mail geht” -> separately state actor, trigger, recipient, and unresolved point, and re-check the original transcript passages. [Task 2]

## Reusable knowledge

- WhatsApp Desktop current voice media can be under `/Users/mrbubbles/Library/Group Containers/group.net.whatsapp.WhatsApp.shared/Message/Media` as `.opus`. If Accessibility exposes no transcript, join UI duration/time with `ffprobe` duration before selecting files. [Task 1]
- A dedicated `work/whisper-env` venv with `mlx-whisper` worked; invoke it reliably through `work/whisper-env/bin/python -m mlx_whisper` if a console script is absent. MLX needs Metal/GPU access. [Task 1]
- The documentation cross-check supports this boundary: Admin Console manual creation offers `Preview and Send` to a secondary/private address, while Admin SDK `users.insert` creates the account without that documented mail flow. Novari therefore needs its own onboarding mail to the private address for API-created accounts; later company/Novari mail can target the corporate Gmail address. [Task 2]
- Martin's broader system is an application-owned, role-based email service (common layout, variable contents, editing, history, aggregated delivery results), not a replacement for Gmail. Password-reset/emergency access and whether credentials are sent as cleartext, one-time link, or another mechanism remain separate security questions. [Task 2]

## Failures and how to do differently

- Symptom: WhatsApp's Accessibility UI has no voice-message text. Fix: inspect the local media cache before claiming the content is inaccessible. [Task 1]
- Symptom: standard Python lacks Whisper or MLX returns `ImportError: [metal::load_device] No Metal device available`. Fix: use an isolated install and arrange non-sandboxed Apple-Silicon GPU access when authorized. [Task 1]
- Symptom: a simplified account-email explanation implies a fully verified Google guarantee. Fix: distinguish the official Console/`users.insert` documentation from Martin's still-partly-unclear implementation and do not resolve the password-delivery question by assumption. [Task 2]

# Task Group: Novari Logging V2 final traceability refreeze, Block A support metadata, and filter-contract closeout
scope: September 2026 closeout coordination: reconcile current LMS acceptance, turn residual matrix rows into evidence/governance work blocks, and keep the bounded Backend Block A contract distinct from a full compliance claim.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-{backend,portal,lms} plus Novari Logging V2 Coordinator; reuse_rule=observed commits, counts, and task state are snapshots; re-establish the authoritative spec, exact checkout, and explicit Go before modifying code.

## Task 2: Convert remaining matrix rows into a read-only Gesamtabschlussplan and start only Block A

### rollout_summary_files

- rollout_summaries/2026-09-03T10-34-40-r5Dk-logging_v2_three_block_finalization_plan.md (cwd=/Users/mrbubbles/dev/Codex/2026-09-03/novari-logging-v2-traceability-final, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/03/rollout-2026-09-03T12-34-40-01a066d5-c4db-7b03-a391-c8b16af44452.jsonl, updated_at=2026-09-03T11:57:30+00:00, thread_id=01a066d5-c4db-7b03-a391-c8b16af44452, read-only three-block finalization plan)

### keywords

- 10 Abschlussblöcke, Gesamtabschlussplan, Block A, allowlist-based event context, category, severity, application, three diagnosis codes, release=development-local, github_sync_connection_failed, archive before retention, logging_system_alert

## Task 4: Correct the 30-day retention defect, separate HR-02 evidence, and retain the final readiness verdict

### rollout_summary_files

- rollout_summaries/2026-08-27T20-14-37-grC8-logging_v2_coordinator_d_producer_gate_and_final_readiness_r.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/verwende-den-angeh-ngten-logging-v2, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T22-14-37-01a044dc-379d-77f1-9b6d-9777d1d96d08.jsonl, updated_at=2026-09-05T16:51:11+00:00, thread_id=01a044dc-379d-77f1-9b6d-9777d1d96d08, final independent review failed readiness)

### keywords

- HIGH-REVIEW FAIL — NOT READY, S12-R1A, 30-day Mongo search, HR-01, HR-02, HR-03, 257 partial evidence obligations, f0809a8, 2db6ffd, 6b972bf, row-classification.tsv, Logging V2 Abschluss koordinieren

## Task 5: Coordinate the 30-day hot-search corrective, evidence blocks, and production archive diagnosis

### rollout_summary_files

- rollout_summaries/2026-09-05T19-07-15-5dGL-novari_logging_v2_abschluss_30_tage_archivierung_und_produkt.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T21-07-15-01a072f7-c65b-7be1-bdb4-a275fdba0e67.jsonl, updated_at=2026-09-07T12:55:09+00:00, thread_id=01a072f7-c65b-7be1-bdb4-a275fdba0e67, coordinated rollout; its candidate/review state predates later closure records)

### keywords

- LOGGING_V2_ABSCHLUSSPLAN_2026-09-05.md, 9524ce493066fc42aa10a240092d49966d3ad090c8c8beeca20267c7d25e8018, S12-R1A, 30×24 hours, auditStore.js, securityAuditArchiveCron.js, 374/374, Rückstand 0, AUDIT_MONTH_ARCHIVED, audit.retention_deleted, /logging-events, HiDrive HTTP 403

## User preferences

- when planning the finalization, the user said the “10 Restblöcke” were “nicht automatisch 10 separat freizugebende Slices” and requested “möglichst wenige fachliche Arbeitsblöcke” with “maximal sinnvoller Parallelisierung” -> distinguish fachliche blocks from internal repository tasks; parallelize only where ownership and data/state isolation are clear. [Task 2]
- when coordinating this finalization, the user said “Nicht selbst Runtime-Code implementieren”, “Keine Micro-Slice-Orgie”, “Fachliche Work Blocks bündeln”, and “Erst Plain-German-Status” -> coordinate/delegate coherent work blocks and communicate the status in plain German before implementation detail. [Task 5]
- “Kein neues Go zwischen normalen Teilaufgaben innerhalb des freigegebenen Abschlussblocks” -> after explicit Go, continue ordinary in-scope work autonomously; stop only for material product, security, or data-integrity findings. PR, merge, deployment, and production remain separate approvals. [Task 5]

## Reusable knowledge

- A01 is HIGH-EVIDENCE PASS for D0–D16 without P0–P3, not a Gesamt-Compliance-, PR-, or Deployment-Verdict. Existing candidate-valid Runtime-/Automated-/Slice-/Acceptance evidence must be adjudicated first: `partial` alone is not a trigger for new browser, real-path, or integration tests. The complete Spec→Matrix→Traceability→Runtime review occurs once at the final freeze; use focused checks only for material findings or contract changes. [Task 2]
- The overall verdict remains `HIGH-REVIEW FAIL — NOT READY`, distinct from a technically passing freeze. `S12-R1A` was corrected by the narrow backend 30-day Mongo-search fix (`f0809a8`); the later review still found HR-01 archive status, HR-02 evidence obligations, and HR-03 privacy-test scope. [Task 4]
- The 30-day gate applies to whole UTC-month batches: direct loader/archive and resume paths must share it, and deferred state keeps checkpoints, `activeAttempt`, and retry budget. The historical candidate reported `374/374`, full lint, and `git diff --check`, but its own rollout ended before final independent-review result; do not use it to overwrite later closure evidence. [Task 5]
- `Rückstand 0` means no due completed month, not an empty Mongo store. A whole August batch remains expected until `01.10.2026 00:00 UTC`; the normal event list has no automatic 30-day display filter. A HiDrive WebDAV HTTP 403 can be a path or permission problem even when Mongo and encryption work. [Task 5]

## Failures and how to do differently

- Symptom: Archive and retention are scheduled in parallel, or an unisolated real-data/notification path is introduced. Fix: execute archive state → complete verification → retention → final state sequentially; stop the affected block (or all work for identity/security/data-integrity faults) at the defined stop gates. [Task 2]
- Symptom: a local router test hits sandbox/loopback refusal and is recorded as a product regression. Fix: rerun with suitable isolated loopback access before diagnosing behavior. [Task 5]
- Symptom: a post-deploy portal error is interpreted as current without time comparison. Fix: refresh/reload, compare event timestamps to the deploy, and check actual HiDrive path, access, and directory structure read-only before claiming an absent directory. [Task 5]

# Task Group: Novari Logging V2 coordinator start-gates and cross-repository development controls
scope: Read-only coordination of D-Producer readiness and Portal/LMS development-control slices; use before starting runtime work or resolving a shared control API contract.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/verwende-den-angeh-ngten-logging-v2 plus Novari Backend/Portal/LMS; reuse_rule=freeze SHAs, branch state, and implementation status are snapshots; do not infer Runtime Go or rewrite a material API contract without explicit user direction.

## Task 1: Verify D-Producer start readiness and record the independent final review

### rollout_summary_files

- rollout_summaries/2026-08-27T20-14-37-grC8-logging_v2_coordinator_d_producer_gate_and_final_readiness_r.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/verwende-den-angeh-ngten-logging-v2, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T22-14-37-01a044dc-379d-77f1-9b6d-9777d1d96d08.jsonl, updated_at=2026-09-05T16:51:11+00:00, thread_id=01a044dc-379d-77f1-9b6d-9777d1d96d08, V-B still lacked final PASS; final review NOT READY)

### keywords

- D-Producer, V-F0, V-B, 85 IDs, chore/logging-improvements, af21c988c51b88fd47a4f2989614654c3b46a846, control-plane, D3, D5, D8, D9, event_store_unwritable, unexpected_5xx

## User preferences

- when coordinating Logging V2, the user required “noch keine Runtime-Implementation” and a separate explicit Go -> treat handoffs, plans, and a passing start check as read-only evidence, never as implementation authorization. [Task 1]
- use thinking levels proportionally: reviewers standardmäßig High; scouts Low/Medium/High according to the actual uncertainty. [Task 1]

## Reusable knowledge

- D-Producer is limited to `libs/observability/logger.js` and `models/audit/securityAuditEventSchema.js`, with `error/globalErrorHandler.js` retaining response/caller ownership and `libs/observability/auditStore.js` retaining persistence ownership. The recorded start state had 85 IDs (71 `partial`, 14 `missing`) and dependencies only `V-F0;V-B`; V-F0 was 11/11, but V-B was not fully evidenced. [Task 1]
- Validate scenarios through real callers before implementation: D3 is `useModules/useLmsModules -> lmsModuleService.getModules -> GET /auth/modules/ -> getAllModules` and expects one `INTERNAL_ERROR` support event; D5 is the LMS sidebar `GET /auth/lms/my-course` path and expects zero; D8/D9 belong to the GET-module owner, not PUT/updateModule/findById. [Task 1]

## Failures and how to do differently

- Symptom: V-F0 passes but a required V-B proof is absent. Fix: do not derive D-Go; keep D-Producer read-only until V-B is independently documented. [Task 1]

# Task Group: Novari website GTM tracking, lead-import configuration, and PR workflow
scope: 2026-09-01/02 Google Ads/consent audit, Website→Backend→LMS lead-import configuration, local Netlify development, and exact PR workflow rules; use before changing tags, lead forms, Functions, hosting variables, or repository readiness labels.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-website plus Google Ads/GTM; reuse_rule=Ads diagnostics and attribution are time-sensitive; re-check the live container and account before modifications.

## Task 2: Diagnose hosting variables and local Website→Backend→LMS lead-import flow

### rollout_summary_files

- rollout_summaries/2026-09-01T21-22-12-6FPq-novari_tracking_lead_import_and_pr_workflow.md (cwd=/Users/mrbubbles/dev/novari/novari-education-website, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/01/rollout-2026-09-01T23-22-12-01a05ed9-e2cb-7283-8699-3f22745a2e28.jsonl, updated_at=2026-09-06T18:45:43+00:00, thread_id=01a05ed9-e2cb-7283-8699-3f22745a2e28, exact variable placement and local-runtime boundary)

### keywords

- LEAD_IMPORT_TOKEN, LMS_LEAD_IMPORT_TOKEN, LMS_API_BASE_URL, /integrations/lead-process/inquiries, Render, Netlify Functions scope, netlify dev, npm run dev, externalSubmissionId, website-course-inquiry

## Task 3: Add the exact PR-label, review, readiness, and merge rules to Website AGENTS.md

### rollout_summary_files

- rollout_summaries/2026-09-01T21-22-12-6FPq-novari_tracking_lead_import_and_pr_workflow.md (cwd=/Users/mrbubbles/dev/novari/novari-education-website, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/01/rollout-2026-09-01T23-22-12-01a05ed9-e2cb-7283-8699-3f22745a2e28.jsonl, updated_at=2026-09-06T18:45:43+00:00, thread_id=01a05ed9-e2cb-7283-8699-3f22745a2e28, exact AGENTS policy committed but intentionally not pushed)

### keywords

- AGENTS.md, PR-LABEL-RULE.md, Ready to Merge, [WIP], [in Agentic Review], [in Human Review], [not Ready to Merge], 5e28e44, e073a66e, auto-merge, dev, main

## User preferences

- when validating a real lead conversion, the user chose “Wir warten einfach” rather than create someone “den es eigentlich nicht gibt” -> prefer a real successful request as the next verification event; do not manufacture customer/analytics data for a check. [Task 1]
- when historical leads contradicted an initial explanation, the user required exact variable placement and local-backend behavior -> check hosting configuration and lead metadata rather than dismissing the evidence as isolated tests. [Task 3]
- when refining the PR policy, the user required canonical wording across repositories and clarified that readiness is not permission -> preserve the supplied block verbatim, verify equality, and wait for separate explicit merge authorization. [Task 4]

## Reusable knowledge

- Production lead import: configure `LEAD_IMPORT_TOKEN` on Render, and matching `LMS_API_BASE_URL=https://<backend>.onrender.com` plus `LMS_LEAD_IMPORT_TOKEN` on the Netlify website project with Functions scope, then redeploy. The website appends `/integrations/lead-process/inquiries`; do not put `lms.novari.education`, `/auth`, or the full endpoint into `LMS_API_BASE_URL`. For local end-to-end tests, use a separate local token in website/backend `.env` and `netlify dev`; `npm run dev` starts only Vite. [Task 3]
- The updated rollout records that, after the required variables were added, lead import worked; treat this as a historical success signal and recheck the current deployment/configuration before relying on it. [Task 3]
- Website `AGENTS.md` embedded the canonical rule block exactly once (SHA-256 `e073a66e...`). The docs-only commit was `5e28e44c1124968dcd4116793d97b52becefdc9c` and was not pushed in that rollout. Proactively inspect available review results after substantial work/pushes, but do not set `Ready to Merge` autonomously, merge/auto-merge `main`, or merge `dev` without explicit instruction. [Task 4]

## Failures and how to do differently

- Symptom: prior real leads are explained away as isolated tests. Fix: inspect Netlify variable names/scopes/contexts and distinguish `source` (`website-*` versus `manual`) plus `externalSubmissionId`; do not expose values. [Task 3]

# Task Group: Novari eM@w / EMAW integration feasibility and BA-clarification planning
scope: 2026-08-31 primary-source audit and feasibility assessment for a bounded Novari-owned first-measure module; use for planning and BA clarification, not as implementation authorization or a claimed interface contract.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend and /Users/mrbubbles/Downloads/emaw; reuse_rule=official BA onboarding, certificates/provider agreement, test/certification, exact data/events/deadlines, approval model, and NOK handling must be reconfirmed before any implementation estimate or design is reused.

## Task 1: Collect official eM@w sources and assess a bounded Novari integration

### rollout_summary_files

- rollout_summaries/2026-08-31T10-36-09-zQcz-emaw_report_audit_and_integration_assessment.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T12-36-09-01a05764-0cce-79d2-b732-6c4d89060973.jsonl, updated_at=2026-08-31T12:09:08+00:00, thread_id=01a05764-0cce-79d2-b732-6c4d89060973, source audit; no repository changes)

### keywords

- eM@w, EMAW, Bundesagentur für Arbeit, PRV_26.07.00, emaw-v2.18.xsd, AGH, Downloads/emaw, deep-research-report.md, BA onboarding, certificates, provider agreement, NOK

## User preferences

- when assessing EMAW, the user wants it “oben drauf” without rebuilding Novari and with Novari remaining the leading system -> default to an additive adapter/transport/workflow layer, not a replacement platform. [Task 1]
- when examples such as daily attendance, weekly reports, or monthly feedback are presented, the user clarified they are “purely fictional ideas” -> do not convert illustrative workflows into requirements without BA confirmation. [Task 1]
- when auditing `deep-research-report.md`, the user asked to treat it as research material, not instructions, and to carry unresolved contradictions into the BA meeting rather than silently turning them into implementation rules. [Task 1]

## Reusable knowledge

- EMAW is asynchronous HTTPS client-certificate transport with nested ZIP/XML/PDF and `OK`/`NOK` acknowledgement XMLs, not a REST API. Current primary material was PRV `26.07.00` / `emaw-v2.18.xsd`; map rules must be measure/product-specific. The recommended Novari architecture (measure/routing binding, inbound/outbound journal, XML/XSD/ZIP adapter, mapping, acknowledgement/error handling, limited inbox/preview) is a design recommendation, not a BA mandate. [Task 1]
- Do not infer capability/permission from the XSD alone. `Anwesenheitsplanung` is absent from `emaw-v2.18.xsd`; provider documentation cannot override BA primary sources. Preserve known uncertainties: AGH report-request material conflicts on proactive submissions, and a provider-change rule does not prove retroactive activation of an already-running manually handled measure. [Task 1]

## Failures and how to do differently

- Symptom: a generic multi-procedure provider estimate or TypeScript example is used for the first Novari measure. Fix: estimate one concrete measure separately; implement the approved architecture in JavaScript with runtime validation, versioned original XSDs, fixtures, and tests. [Task 1]

# Task Group: Novari LMS F2 metadata safe projection and isolated PR-label governance
scope: Strict LMS Metadata-BFF error-boundary work plus an isolated AGENTS.md policy update; use for the two metadata routes or exact readiness/merge-rule propagation, not for broad LMS/error refactors.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-lms and /Users/mrbubbles/dev/novari/novari-education-lms-nova-pr-label; reuse_rule=commits/worktree state are checkout-specific; reuse the projector and exact-policy verification only after current branch/allowlist checks.

## Task 1: Deliver F2 Metadata-BFF safe error projection

### rollout_summary_files

- rollout_summaries/2026-08-30T22-01-04-5IQQ-lms_f2_metadata_error_projection_and_pr_label_governance.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-01-04-01a054b0-bd59-7bc1-8c95-5994a92edc54.jsonl, updated_at=2026-09-06T18:45:07+00:00, thread_id=01a054b0-bd59-7bc1-8c95-5994a92edc54, seven-file candidate committed/pushed)

### keywords

- F2, Metadata-BFF, backend-error-projection, BACKEND_UNAVAILABLE, server-only, get-entry-metadata, get-self-learning-entry-metadata, f43e33ac, 83/83

## Task 2: Apply the canonical PR-label rule in an isolated Nova worktree without pushing

### rollout_summary_files

- rollout_summaries/2026-08-30T22-01-04-5IQQ-lms_f2_metadata_error_projection_and_pr_label_governance.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-01-04-01a054b0-bd59-7bc1-8c95-5994a92edc54.jsonl, updated_at=2026-09-06T18:45:07+00:00, thread_id=01a054b0-bd59-7bc1-8c95-5994a92edc54, AGENTS.md-only update remained uncommitted/unpushed)

### keywords

- AGENTS.md, Ready to Merge, PR-LABEL-RULE.md, feature/nova-integration-rework-of-landing-modules-page, cmp, e073a66e, no commit, no push, auto-merge

## User preferences

- when the user required “Keine Subagents, kein Commit/Push” with exact allowlists -> verify branch, baseline, remote, and scope before editing; preserve all named status, success, auth, cookie, retry, cache, and client contracts. [Task 1]
- when the user required “nur AGENTS.md”, no product work, no commit/push, and byte-for-byte source comparison -> use an isolated worktree, preserve canonical wording exactly, and verify `cmp`, SHA-256, and `git diff --check`. [Task 2]
- `Ready to Merge` is readiness status, never authority: wait for a user-requested final readiness assessment; a `dev` merge separately requires explicit instruction, and `main` is never agent-merged or auto-merged. Proactive review-result checks are hygiene, not authorization. [Task 2]

## Reusable knowledge

- The existing server-only `lib/errors/server/backend-error-projection.ts` produces exact safe `{ error: { code, message, requestId? } }` envelopes and fail-closed fallbacks. Reuse it in the two metadata routes rather than route-local parsing/filtering; preserve Topic resolved status, SLP resolved-failure `404`, and rejected-fetch `503 BACKEND_UNAVAILABLE`. [Task 1]
- Route suites that import the intentional server-only projector need `vi.mock('next/dist/compiled/server-only', () => ({}))`. The strict candidate passed focused `83/83`, lint, Prettier, typecheck, and `git diff --check`; two full-suite failures stayed off-allowlist. [Task 1]
- F2 commit `f43e33ac6eb952d335223fb4ff06057089d6bc5f` was pushed to `origin/chore/logging-improvements`; the separate Nova AGENTS change was intentionally uncommitted/unpushed and exactly matched canonical `PR-LABEL-RULE.md`. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: a server-only route test fails with `This module cannot be imported from a Client Component module`. Fix: apply the existing allowed Vitest mock rather than weakening/removing the server-only boundary. [Task 1]
- Symptom: a strict slice exposes unrelated full-suite failures or a stale local tracking branch. Fix: leave off-allowlist failures untouched; fetch/re-establish direct remote ancestry before creating the isolated worktree, rather than treating a stale tracking ref as current. [Task 1][Task 2]

# Task Group: Novari Backend Logging V2 D-I0a–D-I0l route ownership, slice handoff, and independent review
scope: 2026-08-28 to 2026-08-29 narrow backend Logging V2 delivery; use for real Express route identity, at-most-one safe error persistence, strict frozen-candidate review, and resuming the current D-I0 sequence.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=commit hashes and suite counts are checkout-specific; reuse the mount-identity, allowlist, and review procedure only after re-establishing the current branch and exact candidate.

## Task 1: Deliver and re-review safe V2 persistence for LMS module failures

### rollout_summary_files

- rollout_summaries/2026-08-28T15-35-21-AhXV-d_i0a_lms_modules_high_review_rereview.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T17-35-21-01a04902-e371-77f0-8b30-04916cd8a857.jsonl, updated_at=2026-08-28T16:23:46+00:00, thread_id=01a04902-e371-77f0-8b30-04916cd8a857, corrective High-Review PASS)
- rollout_summaries/2026-08-28T15-12-10-ss9y-d_i0a_lms_module_support_error_persistence.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T17-12-10-01a048ed-abef-7922-8bb9-10547e598ad0.jsonl, updated_at=2026-08-28T16:26:06+00:00, thread_id=01a048ed-abef-7922-8bb9-10547e598ad0, implemented, committed, and pushed)

### keywords

- D-I0a, LMS_MODULE_ROUTER_REQUEST, markLmsModuleRouterRequest, /auth/modules, /auth/lms/course/:courseId, req.baseUrl, req.route.path, persistSupportErrorEvent, audit.data_write, a56e39689983a6b9b65f15d214a06a787fd54fe5

## Task 3: Implement profile-image 500 support-event logging (implementation evidence retained)

### rollout_summary_files

- rollout_summaries/2026-08-29T11-41-16-x8De-d_i0i_profile_image_upload_support_error_logging.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T13-41-16-01a04d52-f0bb-7ab3-a3b0-2ba88f267db8.jsonl, updated_at=2026-08-29T12:05:46+00:00, thread_id=01a04d52-f0bb-7ab3-a3b0-2ba88f267db8, implemented, committed, and pushed)

### keywords

- D-I0i, PROFILE_ROUTER_REQUEST, profile_image_upload, /auth/profile/upload-image, SUPPORT_ERROR_ATTEMPTED, B28, T22, 8fcf3d5f859bf1b1cb5636988020e09be2023d10

## Task 4: Review D-I0j Self-Absence attachment upload and record D-I0k/D-I0l coordination

### rollout_summary_files

- rollout_summaries/2026-08-29T14-19-12-KULY-d_i0j_high_review_actorhash_corrective_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T16-19-12-01a04de3-8ad4-7b92-93d5-23c484c6f66e.jsonl, updated_at=2026-08-29T14:24:50+00:00, thread_id=01a04de3-8ad4-7b92-93d5-23c484c6f66e, actorHash corrective HIGH-REVIEW PASS)
- rollout_summaries/2026-08-29T13-46-11-vlBh-d_i0j_self_absence_upload_high_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T15-46-11-01a04dc5-4d58-7c12-beed-c17ae1089853.jsonl, updated_at=2026-08-29T13:50:50+00:00, thread_id=01a04dc5-4d58-7c12-beed-c17ae1089853, frozen candidate HIGH-REVIEW PASS)

### keywords

- D-I0j, D-I0k, D-I0l-V, D-I0l, selfAbsenceRouter.js, /auth/self-absence/upload-file, /auth/self-absence/my-reports, supportDisposition=engineering_investigation, actorHash, 8f40d26c736b9feb8f421e1a24a260dea74ee716, 735029145ba2a9f4c8887a794408c81f9f07495c

## Task 5: Fail-close Self-Absence pagination and deliver D-I0l own-reports logging

### rollout_summary_files

- rollout_summaries/2026-08-29T19-23-59-VCNp-logging_v2_handoff_sync_after_d_i0l.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-17/novari-logging-v2-delegation, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T21-23-59-01a04efa-9183-74d1-81cd-a0c250f73d77.jsonl, updated_at=2026-08-29T19:30:14+00:00, thread_id=01a04efa-9183-74d1-81cd-a0c250f73d77, documentary handoff sync)
- rollout_summaries/2026-08-29T19-16-31-T3RD-logging_v2_d_i0l_checkpoint_and_p3_doc_closure.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-29/logging-v2-spec-checkpoint-after-d-i0l, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T21-16-31-01a04ef3-bdba-78a2-aa0a-960c52b0db21.jsonl, updated_at=2026-08-29T19:31:46+00:00, thread_id=01a04ef3-bdba-78a2-aa0a-960c52b0db21, D-I0l PASS; feature NOT READY)
- rollout_summaries/2026-08-29T19-02-36-8tig-d_i0l_traceability_abgleich.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-17/novari-logging-v2-delegation, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T21-02-36-01a04ee6-ffec-7100-a13b-c16ff79b9930.jsonl, updated_at=2026-08-29T19:15:52+00:00, thread_id=01a04ee6-ffec-7100-a13b-c16ff79b9930, traceability updated)
- rollout_summaries/2026-08-29T16-58-22-u4GR-novari_logging_v2_handoff_metadata_and_provenance_correction.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T18-58-22-01a04e75-424d-7421-9b5a-a17b5418ed71.jsonl, updated_at=2026-08-29T17:46:36+00:00, thread_id=01a04e75-424d-7421-9b5a-a17b5418ed71, C0 provenance correction)

### keywords

- D-I0l-V, D-I0l, /auth/self-absence/my-reports, zod, z.coerce.number, VALIDATION_FAILED, B31, T25, CP-DI0L-V-02, at-most-one, github-path-migration-2f

## Task 6: Implement, correct, and re-review D-I0m management-read support events

### rollout_summary_files

- rollout_summaries/2026-08-29T20-15-12-SLKW-d_i0m_self_absence_management_read_high_review_rereview.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T22-15-12-01a04f29-7597-7b71-b5c0-c6ee215d87ba.jsonl, updated_at=2026-08-29T20:26:52+00:00, thread_id=01a04f29-7597-7b71-b5c0-c6ee215d87ba, P2 closed; HIGH-REVIEW PASS)

### keywords

- D-I0m, managementReadErrorProjection.test.js, catchAsync, globalErrorHandler, CourseModel.find, SelfAbsenceModel.aggregate, 145/145, HIGH-REVIEW PASS, 5a5eda5749603393a176b40dbe7e807f06d8bce1

## Task 7: Coordinate D-I0n closeout and begin the D-Download response-owner / router-ownership sequence

### rollout_summary_files

- rollout_summaries/2026-08-29T22-11-38-psrf-self_absence_pagination_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T00-11-38-01a04f94-0e19-79c1-9dc2-2fe65f7b3c01.jsonl, updated_at=2026-08-29T22:16:03+00:00, thread_id=01a04f94-0e19-79c1-9dc2-2fe65f7b3c01, frozen pagination candidate HIGH-REVIEW PASS)
- rollout_summaries/2026-08-29T22-03-49-ldck-self_absence_management_pagination_commit_push.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T00-03-49-01a04f8c-e790-7b10-aff0-151b98ab4758.jsonl, updated_at=2026-08-29T22:18:16+00:00, thread_id=01a04f8c-e790-7b10-aff0-151b98ab4758, committed and pushed)

### keywords

- D-I0n, PATCH /auth/self-absence/process/:id, PATCH /auth/self-absence/process-vacation/:id, 70b6875b79e330771a0491bd896acd1d96ab0e9f, 156/156, selfAbsencePaginationQuerySchema, VALIDATION_FAILED, de8dbaad, calendar response-owner, 712cf7f0, D-I0o-V, D-Download, targetHash, course archive

## Task 8: Reconstruct the D-Producer checkpoint and identify the stale D-Download test finding

### rollout_summary_files

- rollout_summaries/2026-08-29T21-16-29-jCEY-novari_logging_v2_d_i0a_d_i0n_compliance_review.md (cwd=/Users/mrbubbles/.codex/worktrees/7d5b/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T23-16-29-01a04f61-9384-7820-a8be-4a08bbe0423c.jsonl, updated_at=2026-08-29T21:27:20+00:00, thread_id=01a04f61-9384-7820-a8be-4a08bbe0423c, D-I0a–D-I0n runtime review partial; formatter finding withdrawn)
- rollout_summaries/2026-08-30T03-02-55-oj5U-d_producer_checkpoint_p2_closed_p3_diffhash_mismatch.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/logging-v2-d-producer-final-compliance-2026-08-30, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T05-02-55-01a0509e-bd84-76c1-a6a9-08b21ba5efea.jsonl, updated_at=2026-08-30T11:54:29+00:00, thread_id=01a0509e-bd84-76c1-a6a9-08b21ba5efea, P2 closed; P3 hash mismatch then corrected)

### keywords

- D-Producer, 85 requirements, 66 mandatory, 19 conditional, 147/148, self_absence_attachment_download, managementReadErrorProjection.test.js:1252, D-Download, 145/145, V-F0, NOT READY

## Task 9: Deliver and independently review pending-read support events

### rollout_summary_files

- rollout_summaries/2026-08-29T22-30-44-b4XS-self_absence_management_read_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T00-30-44-01a04fa5-8ba2-7011-92f3-2a3a95e205d8.jsonl, updated_at=2026-08-29T22:36:09+00:00, thread_id=01a04fa5-8ba2-7011-92f3-2a3a95e205d8, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-29T22-19-19-DheQ-novari_self_absence_pending_logging_v2_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/edff/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T00-19-19-01a04f9b-17ea-7470-8aec-a0c9a7047a74.jsonl, updated_at=2026-08-29T22:38:53+00:00, thread_id=01a04f9b-17ea-7470-8aec-a0c9a7047a74, committed and pushed)

### keywords

- self_absence_pending_read, self_absence_hr_pending_employees_read, /auth/self-absence/pending, /hr/pending-employees, ccb7d2f8, 40/40, 129/129, routeTemplate enum, SUPPORT_ERROR_ATTEMPTED

## Task 10: Deliver D-Download response ownership, private router markers, and six document-read producers

### rollout_summary_files

- rollout_summaries/2026-08-30T00-49-11-rCYA-d_download_task_c_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T02-49-11-01a05024-4ee3-7d90-a30a-03e06146104c.jsonl, updated_at=2026-08-30T01:12:04+00:00, thread_id=01a05024-4ee3-7d90-a30a-03e06146104c, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T00-31-39-Z6n3-backend_logging_v2_document_download_producers.md (cwd=/Users/mrbubbles/.codex/worktrees/9d29/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T02-31-39-01a05014-3e29-78e1-9873-cbd54047f945.jsonl, updated_at=2026-08-30T01:15:08+00:00, thread_id=01a05014-3e29-78e1-9873-cbd54047f945, six producers committed and pushed)
- rollout_summaries/2026-08-30T00-12-55-KQyb-d_download_router_marker_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T02-12-55-01a05003-1934-7f83-83ac-0d1e7e9c6e97.jsonl, updated_at=2026-08-30T00:26:54+00:00, thread_id=01a05003-1934-7f83-83ac-0d1e7e9c6e97, marker re-review HIGH-REVIEW PASS)
- rollout_summaries/2026-08-29T23-57-02-S3Lh-task_b_download_router_owner_markers.md (cwd=/Users/mrbubbles/.codex/worktrees/1663/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T01-57-02-01a04ff4-901f-78d2-a545-40d6967e536f.jsonl, updated_at=2026-08-30T00:29:27+00:00, thread_id=01a04ff4-901f-78d2-a545-40d6967e536f, markers committed and pushed)
- rollout_summaries/2026-08-29T23-08-02-qzqR-d_download_high_re_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T01-08-02-01a04fc7-b0fa-7433-86b8-ea72e8e471bd.jsonl, updated_at=2026-08-29T23:53:26+00:00, thread_id=01a04fc7-b0fa-7433-86b8-ea72e8e471bd, response-owner re-review passed)
- rollout_summaries/2026-08-29T22-55-34-oG7I-d_download_task_a_document_error_ownership.md (cwd=/Users/mrbubbles/.codex/worktrees/bbdc/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T00-55-34-01a04fbc-4713-7723-97bc-8fe8b2427c66.jsonl, updated_at=2026-08-29T23:55:31+00:00, thread_id=01a04fbc-4713-7723-97bc-8fe8b2427c66, response ownership committed and pushed)

### keywords

- D-Download, Symbol.for, novari.observability.router-owner, HIDRIVE_FILE_NOT_FOUND, targetHash, self_absence_attachment_download, 65dbc607, 190/190, res.end, headersSent

## Task 11: Correct CloudRun calendar error ownership and add three safe support-event producers

### rollout_summary_files

- rollout_summaries/2026-08-30T02-25-36-uoP4-a2_cloudrun_calendar_logging_v2_high_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-25-36-01a0507c-91be-7fd2-9414-51eb82c7f70e.jsonl, updated_at=2026-08-30T02:35:01+00:00, thread_id=01a0507c-91be-7fd2-9414-51eb82c7f70e, A2 HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T02-10-27-gY1l-cloudrun_calendar_support_error_audit_a2.md (cwd=/Users/mrbubbles/.codex/worktrees/4fbb/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-10-27-01a0506e-b35a-7950-935e-00b718e6d683.jsonl, updated_at=2026-08-30T02:38:07+00:00, thread_id=01a0506e-b35a-7950-935e-00b718e6d683, A2 committed and pushed)
- rollout_summaries/2026-08-30T01-42-32-psZ2-cloudrun_calendar_a1_high_re_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T03-42-32-01a05055-245e-7f00-88aa-b3060bcfb640.jsonl, updated_at=2026-08-30T02:06:11+00:00, thread_id=01a05055-245e-7f00-88aa-b3060bcfb640, A1 corrected re-review passed)
- rollout_summaries/2026-08-30T01-32-19-7aGb-cloudrun_calendar_error_owner_a1_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/766d/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T03-32-19-01a0504b-c9b4-7622-9f3f-fdac9f83f877.jsonl, updated_at=2026-08-30T02:09:01+00:00, thread_id=01a0504b-c9b4-7622-9f3f-fdac9f83f877, A1 committed and pushed)

### keywords

- CloudRun, cloudrun-calendar-reads, calendar_agenda_events_read, calendar_absence_events_read, calendar_course_events_read, 712cf7f0, a19f3300, 167/167, 106/106, headersSent

## Task 12: Close the stale D-Producer test expectation without changing runtime ownership

### rollout_summary_files

- rollout_summaries/2026-08-30T11-28-17-fHU4-d_producer_download_test_corrective_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T13-28-17-01a0526d-69c3-7151-894d-37fa2b611ad8.jsonl, updated_at=2026-08-30T11:35:40+00:00, thread_id=01a0526d-69c3-7151-894d-37fa2b611ad8, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T11-24-13-vKNS-self_absence_test_expectation_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/1458/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T13-24-13-01a05269-b019-7a41-97f9-00e98c7d0cc4.jsonl, updated_at=2026-08-30T11:37:08+00:00, thread_id=01a05269-b019-7a41-97f9-00e98c7d0cc4, one-line test corrective committed and pushed)
- rollout_summaries/2026-08-30T02-40-33-z8LE-final_d_producer_traceability_abgleich.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/logging-v2-d-producer-final-traceability-2026-08-30, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-40-33-01a0508a-4407-7ac3-ac4d-d52379290c22.jsonl, updated_at=2026-08-30T03:02:04+00:00, thread_id=01a0508a-4407-7ac3-ac4d-d52379290c22, traceability synchronized before later test closure)

### keywords

- D-Producer, self_absence_attachment_download, managementReadErrorProjection.test.js:1255, 36efd59f, 159/159, MANAGEMENT_ACTIONS, 85 requirements, partial, HIGH-REVIEW PASS

## Task 13: Start D-Triage backend evidence after the D-Producer closeout

### rollout_summary_files

- rollout_summaries/2026-08-30T11-38-43-T1aQ-logging_v2_d_triage_startability_stop_gates.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T13-38-43-01a05276-f7c7-77d2-ae61-1b2749008a0c.jsonl, updated_at=2026-08-30T11:48:59+00:00, thread_id=01a05276-f7c7-77d2-ae61-1b2749008a0c, initial plan stopped on material owner mismatch)

### keywords

- D-Triage, 36efd59f, d-triage-backend-core.md, e2-backend.md, securityAuditController.test.js, securityAuditRouter.test.js, read-only owner/evidence rescope

## Task 14: Re-scope, deliver, and independently close D-Triage Backend evidence without a runtime claim

### rollout_summary_files

- rollout_summaries/2026-08-30T13-49-16-OiV3-d_triage_backend_evidence_high_spec_compliance_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/logging-v2-d-triage-backend-compliance-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T15-49-16-01a052ee-7c54-7241-a8d7-581061988769.jsonl, updated_at=2026-08-30T14:00:14+00:00, thread_id=01a052ee-7c54-7241-a8d7-581061988769, independent high compliance review)
- rollout_summaries/2026-08-30T13-29-15-6tpQ-finalize_d_triage_backend_traceability.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/logging-v2-d-triage-backend-traceability, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T15-29-15-01a052dc-288c-7db2-8627-331135d12756.jsonl, updated_at=2026-08-30T13:48:39+00:00, thread_id=01a052dc-288c-7db2-8627-331135d12756, traceability finalized)
- rollout_summaries/2026-08-30T13-06-55-PN3z-d_triage_backend_evidence_high_review_p3_corrective.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T15-06-55-01a052c7-b735-71d1-9971-66e3d965b769.jsonl, updated_at=2026-08-30T13:24:31+00:00, thread_id=01a052c7-b735-71d1-9971-66e3d965b769, P3 evidence corrective independently reviewed)
- rollout_summaries/2026-08-30T12-50-00-PkQA-d_triage_backend_evidence_test_freeze_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/aafd/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T14-50-00-01a052b8-3b4d-7992-9a50-d46df4b199c4.jsonl, updated_at=2026-08-30T13:28:32+00:00, thread_id=01a052b8-3b4d-7992-9a50-d46df4b199c4, evidence/tests committed and pushed)

### keywords

- D-Triage, evidence-only, 68 IDs, 36efd59f, 35e3c4dd, d-triage-backend-core.md, e2-backend.md, securityAuditGrouping, securityAuditController.test.js, securityAuditRouter.test.js, partial, NOT READY

## User preferences

- when implementing Logging V2, the user repeatedly required the “kleinsten” coherent slice, an exact file allowlist, explicitly unchanged product flows, and stopping on scope drift -> formalize these gates before edits. [Task 1]
- when reviewing, the user required “strikt read-only”, “Findings zuerst”, exact scope/identity gates, and real Express semantics/owner uniqueness rather than mock-only tests. [Task 1]
- when the frozen candidate was accepted, the user required no amend/force push and a byte-exact freeze before review, commit, and push. [Task 1]
- when the user asks for a release review, they require “Findings first”, independently reconstructed candidate identity (including untracked files), and a clear evidence-backed PASS when no reproducible P0–P3 defect remains; do not convert the review into speculative hardening. [Task 3][Task 4][Task 5]
- when closing traceability, the user distinguishes a product/response prerequisite from a Logging producer and requires “höchstens ein persistiertes Ergebnisereignis”, never “Exactly-once”. Keep slice-level closure, D-Producer status, and overall readiness separate. [Task 4]
- when handing off an accepted candidate, the user required rechecking the exact allowlist, diff SHA, patch ID, target blobs, branch/upstream/direct remote, then staging only named files with no amend/rebase/squash/force push; “Task B nicht starten” is a hard stop. [Task 9]
- when checkpointing D-Producer, the user required a complete atomized review of all 85 rows, independent owner/candidate reconstruction, findings first, and separate D-Producer, PR, integrated-feature, and deployment verdicts. [Task 10]
- when delivering an approved D-Download or calendar slice, the user required the smallest coherent allowlist, a frozen uncommitted candidate, real mount/owner-path evidence, and an explicit later Go for normal commit/push. [Task 11][Task 12][Task 13]
- when correcting the stale D-Producer assertion, the user required “ausschließlich” the allowlisted test file, baseline reproduction, targeted/full/combined evidence, and explicit unruns; no runtime cleanup or broader validation. [Task 14]
- when a planned slice conflicts with current owners, the user required findings-first re-scoping and a fresh exact baseline before Go; do not manufacture a production diff where runtime behavior is already implemented. [Task 15][Task 16]

## Reusable knowledge

- After Express unwinds nested routers, `req.baseUrl` may be empty while `req.route.path` remains only the relative template. If a controller/template is mounted under more than one router, this is insufficient route identity. Set a private symbol in fixed server middleware at the intended mount and require it in the logger matcher; do not persist raw URLs or IDs to compensate. [Task 1]
- The D-I0a matcher requires exact method/route/component/status/error/request-ID predicates plus `LMS_MODULE_ROUTER_REQUEST`. The real regression needs both `/auth/modules` positives and the active `/auth/lms/course/:courseId` negative. [Task 1]
- Preserve request-local, not request-ID-global, deduplication: repeated handling on the same request object yields one event; distinct request objects with the same valid request ID each yield an event. Successful DELETE remains the existing generic `audit.data_write`; failed DELETE yields only the safe V2 failure event. [Task 1]
- D-I0i logs only the final `POST /auth/profile/upload-image` `500 INTERNAL_ERROR` through the private `PROFILE_ROUTER_REQUEST` marker, fixed schema-v2 event tuple, valid request ID, and request-local `SUPPORT_ERROR_ATTEMPTED`. It excludes success, 4xx/provider-400, auth/role/not-found and preserves success `audit.data_write/create`; writes are best-effort, non-recursive, and do not change the response. Runtime commit `8fcf3d5f859bf1b1cb5636988020e09be2023d10` passed independent review. B28/T22 traceability initially over-assigned four rows; the targeted closure leaves exactly 67 matching IDs and D-Producer `partial`. [Task 4]
- For D-I0l-V pagination, strict decimal-string validation must happen before numeric coercion: reject malformed values with controlled `400 VALIDATION_FAILED` while preserving query passthrough. D-I0l then covers only `GET /auth/self-absence/my-reports` final unexpected 500; B31/T25 maps 68 partial requirements. The known full suite is still not a pass without an aggregate result because `github-path-migration-2f` leaves a fixture child server open. [Task 7]
- D-I0m covers exactly five management-read routes and retains the real Controller→`catchAsync`→Global-Handler chain. The released candidate was `5a5eda5749603393a176b40dbe7e807f06d8bce1`; `145/145` focused/dependent and `11/11` Grundschutz checks were reported green. [Task 8]
- D-I0n persists only final unexpected `500 INTERNAL_ERROR` on `PATCH /auth/self-absence/process/:id` and `/process-vacation/:id`, using the private marker, exact route/method/status/code/request-ID predicates, fixed safe tuple, actor-independent fingerprint, and request-local `SUPPORT_ERROR_ATTEMPTED`. Success remains `audit.data_write/modify`; role 403, controlled 400/404/409, and swallowed calendar failures remain negative. The reviewed candidate passed `156/156`, lint, six syntax checks, and `git diff --check`; full-suite status stays unclaimed because of the known `github-path-migration-2f` hang. [Task 9]
- For management pagination, reuse the existing decimal-string Zod contract only after `requireAnyRole`: `limit` is `1..100`, `offset` a nonnegative safe integer, unknown keys pass through, and `/pending` keeps `20/0` while `/hr/pending-employees` keeps `50/0`. Authorized invalid input is `400 VALIDATION_FAILED` before controller/DB/support/write audit; role denial remains `audit.permission_denied`. The four-file slice was independently reviewed and pushed as `de8dbaadd0421e4af7cf6fe6a40e5e8db0944d85`. [Task 9]
- Pending reads add fixed `GET /pending` and `/hr/pending-employees` tuples without router/controller/global-handler/store changes; require the private Self-Absence marker, final `500 INTERNAL_ERROR`, valid request ID, request-local guard, and schema route-template enum. The released candidate is `ccb7d2f8559d1016aaf32691120bee57f1b1f104`. [Task 11]
- D-Download response ownership belongs to the global handler before headers; after `headersSent`, delegate without a second response. Router owners that cross boundaries use stable `Symbol.for` keys, and the six document-read producer contracts persist only fixed safe fields plus optional HMAC actorHash. `HIDRIVE_FILE_NOT_FOUND` is an explicit no-event boundary; `targetHash` is valid only for the Course Archive contract. [Task 12]
- CloudRun A1 forwards only unknown calendar errors through `next(e)` while preserving controlled `400`/`403` and structured upstream `502`; A2 then marks only authorized calendar reads and persists exactly three final unexpected `500 INTERNAL_ERROR` tuples. Health, list, gateway, cron, role/auth/CSRF, controlled errors, and headers-sent paths remain negative. [Task 13]
- The 2026-08-30 checkpoint reconstructed 85 D-Producer rows (66 mandatory, 19 conditional), all honestly `partial`; it verified the 40 `INTERNAL_ERROR` owners plus existing GitHub-inventory 503 and course-archive certificate 409 paths. Its one stale real-router expectation was later corrected only by adding `self_absence_attachment_download` to the neighbor list: baseline `0/1`, candidate `1/1`, full file `14/14`, combined suite `159/159`, and independent HIGH-REVIEW PASS. D-Producer traceability is synchronized, but `partial` rows still do not establish Fullsuite/browser/realdata, PR, integrated-feature, or deployment readiness. [Task 10][Task 14]
- The initial 68-row D-Triage plan mixed already-implemented backend grouping with Portal and integrated obligations. Re-scope by repository/owner/test seam, require a reproducible missing behavior before runtime edits, and keep its evidence/test closure distinct from the 68 matrix rows: they remain `partial`, and the integrated feature remains `NOT READY`. [Task 15][Task 16]
- A formatter finding requires a repository formatter contract: dependency/lockfile package, configuration, or script. Transitive tool hits do not establish a standard; when absent, record Prettier as not applicable and retain the configured ESLint check. [Task 10]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1]

## Failures and how to do differently

- Symptom: a matcher based on method, relative template, component, status, and code passes unit tests but persists an unapproved sibling-router path -> trace the real mounted route; add a server-owned mount marker and a real positive/negative Express test. [Task 1]
- Symptom: read-only review conditions prohibit potentially writing checks -> do not claim fresh test/lint execution; report the implementer evidence as unverified and name the post-corrective suite as unrun. [Task 1]
- Symptom: a local Express test fails with `listen EPERM` -> sandbox socket restriction, not product failure; rerun only where authorized. For `/slug-options`, include the required `programType` query so the test reaches the intended 500 path rather than expected 400 validation. [Task 1]
- Symptom: an evidence generator assigns B/T IDs to every nearby D row -> traceability becomes mechanically synchronized but semantically wrong. Bind evidence requirement-by-requirement, compare exact ID sets across source/matrix/persistence artifacts, and validate before calling closure. [Task 4]
- Symptom: a local HTTP test fails with `listen EPERM` or Prettier is unavailable in a strict read-only review -> record sandbox/availability limits separately; rerun only where authorized and never report the unrun formatter as passed. [Task 5]
- Symptom: a positive D-I0m router test replaces real controller handlers with synthetic `next(error)` -> it cannot prove the actual controller/error-owner boundary. Keep the controller and `catchAsync` active; inject only model/decrypt/enrichment/aggregation dependencies and re-review the frozen candidate. [Task 8]
- Symptom: a local real-router suite reports `listen EPERM: operation not permitted 127.0.0.1` -> it is a sandbox loopback-binding limitation, not a product assertion failure. Rerun the identical suite only where authorized; separately name full-suite, DB/Auth/CSRF, or formatter checks that remain unrun. [Task 9]
- Symptom: a D-Producer checkpoint is reported green despite `147/148` real-router results -> the stale integration assertion at `tests/selfAbsence/managementReadErrorProjection.test.js:1252-1260` omits legitimate `self_absence_attachment_download` introduced by D-Download. Correct only that expected action list, then rerun the focused, combined D-Producer, and real-router suites; do not alter runtime ownership or broaden the slice. [Task 10]
- Symptom: document downloads hang or double-respond after headers -> `res.end` has synchronous/asynchronous callback, response/socket-error, premature-close, and listener-lifecycle semantics. Await a single-settlement completion path, clean listeners, and delegate post-header errors to the global handler without JSON. [Task 12]
- Symptom: a private router owner is unreadable across the producer boundary or an authorized rejection is marked -> use `Symbol.for('novari.observability.router-owner.<owner>')`, test `Symbol.keyFor`, and set the marker after role authorization immediately before the controller. [Task 12][Task 13]
- Symptom: a temporary resolver makes the top-level test work but a child test process still lacks dependencies -> propagate the same process-local resolver through `NODE_OPTIONS`; do not install, symlink, or mutate a strictly read-only candidate. [Task 14]
- Symptom: a D-Triage plan proposes production changes because 68 IDs remain partial -> it may conflate existing runtime, evidence, Portal, and integrated-owner obligations. Stop on plan/code disagreement, reconstruct the current baseline and exact owners, then use a bounded evidence/test slice only after explicit Go. [Task 15][Task 16]

# Task Group: Novari Logging V2 Portal E1/E3 evidence closure, Backend C-Projection, and G-Archive contract
scope: Late-stage Portal evidence, finalized Backend safe projection, completed G-Archive development proof, and the next bounded Eventbetrieb planning; use for status routing and bounded follow-up, not authority to continue work.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-{portal,backend}; reuse_rule=commits, counts, and active task state are snapshots; re-establish checkout and explicit authority before edits.

## Task 1: Sync Portal E1 and complete E3 automated evidence without broadening readiness

### rollout_summary_files

- rollout_summaries/2026-08-30T15-29-53-2WUt-portal_e1_high_spec_compliance_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/logging-v2-portal-e1-compliance-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T17-29-53-01a0534a-99c4-7c13-ad94-61d44d8c0005.jsonl, updated_at=2026-08-30T15:39:52+00:00, thread_id=01a0534a-99c4-7c13-ad94-61d44d8c0005, formal slice PASS; integrated feature NOT READY)
- rollout_summaries/2026-08-30T14-27-55-Jspt-portal_e1_logging_events_route_rename_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/6f75/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T16-27-55-01a05311-e088-79d2-9ab2-6a714c63a593.jsonl, updated_at=2026-08-30T15:10:41+00:00, thread_id=01a05311-e088-79d2-9ab2-6a714c63a593, reviewed candidate committed and pushed)
- rollout_summaries/2026-08-30T20-58-22-S9DR-e3_portal_formal_documentary_closure.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-e3-portal-formal-closure, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-58-22-01a05477-55b1-7442-84d7-c3cf4c83467b.jsonl, updated_at=2026-08-30T21:01:27+00:00, thread_id=01a05477-55b1-7442-84d7-c3cf4c83467b, documentary closure only)
- rollout_summaries/2026-08-30T20-49-51-VAga-novari_e3_portal_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-49-51-01a0546f-8d14-7f53-afcd-6d85c0d1a752.jsonl, updated_at=2026-08-30T20:57:58+00:00, thread_id=01a0546f-8d14-7f53-afcd-6d85c0d1a752, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T20-45-37-vtgj-logging_v2_next_slice_routing_e3_portal.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-next-slice-after-c-projection, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-45-37-01a0546b-ad17-7552-902b-a45e970da61f.jsonl, updated_at=2026-08-30T20:49:21+00:00, thread_id=01a0546b-ad17-7552-902b-a45e970da61f, routing only)

### keywords

- Portal-E1, E3-Portal Automated-Evidence, /logging-events, /security-events, e573ec03, 25/25, 6525/6526, CurriculumWorkRevisionEditor.test.tsx:946, NOT READY

## Task 3: Fail-close early C-Projection candidate reviews on disclosure, route-context, direct-envelope, and scope regressions

### rollout_summary_files

- rollout_summaries/2026-08-30T18-19-04-8HGl-backend_c_projection_high_review_fail_direct_envelope_scope.md (cwd=/Users/mrbubbles/.codex/worktrees/4d8c/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-19-04-01a053e5-8163-7870-9cae-553ed461aebd.jsonl, updated_at=2026-08-30T18:25:57+00:00, thread_id=01a053e5-8163-7870-9cae-553ed461aebd, HIGH REVIEW FAIL)
- rollout_summaries/2026-08-30T18-03-50-P0OW-novari_backend_c_projection_high_review_p1_audit_route_drift.md (cwd=/Users/mrbubbles/.codex/worktrees/d191/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-03-50-01a053d7-8d0d-7222-93d6-fcf9472f08be.jsonl, updated_at=2026-08-30T18:10:00+00:00, thread_id=01a053d7-8d0d-7222-93d6-fcf9472f08be, P1 audit-route drift)
- rollout_summaries/2026-08-30T17-28-39-abc0-c_projection_high_rereview_findings.md (cwd=/Users/mrbubbles/.codex/worktrees/8877/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T19-28-39-01a053b7-5667-76f3-951a-f8ae0d5b0eb4.jsonl, updated_at=2026-08-30T17:42:19+00:00, thread_id=01a053b7-5667-76f3-951a-f8ae0d5b0eb4, HIGH REVIEW FAIL)
- rollout_summaries/2026-08-30T16-55-38-MWHl-novari_c_projection_high_review_fail.md (cwd=/Users/mrbubbles/.codex/worktrees/b01f/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T18-55-38-01a05399-1b98-7e53-8ab4-88b686914967.jsonl, updated_at=2026-08-30T17:07:40+00:00, thread_id=01a05399-1b98-7e53-8ab4-88b686914967, initial HIGH REVIEW FAIL)

### keywords

- C-Projection, globalErrorHandler, httpError, httpLogger, sendErrorResponse, sendProjectedErrorResponse, err.expose, getSafeRequestPath, req.route.path, archive-course, direct envelope, route-template, query keys, HIGH REVIEW FAIL

## Task 4: Implement, independently pass, commit, and trace C-Projection

### rollout_summary_files

- rollout_summaries/2026-08-30T20-21-43-gFiV-novari_c_projection_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-21-43-01a05455-c898-7fd3-ac1f-295eaf80f029.jsonl, updated_at=2026-08-30T20:30:44+00:00, thread_id=01a05455-c898-7fd3-ac1f-295eaf80f029, main-checkout HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T20-11-45-1wUD-novari_c_projection_safe_direct_error_details_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/1e8b/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-11-45-01a0544c-a83e-7522-89ab-58bfdfbab10f.jsonl, updated_at=2026-08-30T20:28:56+00:00, thread_id=01a0544c-a83e-7522-89ab-58bfdfbab10f, direct-details corrective pushed `56ddb128`)
- rollout_summaries/2026-08-30T19-22-21-1zT6-logging_v2_c_projection_compliance_review_findings.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-c-projection-final-compliance, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-22-21-01a0541f-7089-71a3-998b-3b59f31b2f1c.jsonl, updated_at=2026-08-30T19:32:54+00:00, thread_id=01a0541f-7089-71a3-998b-3b59f31b2f1c, interim findings later corrected/superseded)
- rollout_summaries/2026-08-30T19-14-32-jcje-c_projection_request_failed_allowlist_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-14-32-01a05418-4905-7a90-8b5a-65d0a95fdd40.jsonl, updated_at=2026-08-30T19:19:37+00:00, thread_id=01a05418-4905-7a90-8b5a-65d0a95fdd40, REQUEST_FAILED corrective HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T19-08-18-H2Hl-novari_traceability_backend_freeze_advance.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-c-projection-generator-corrective, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-08-18-01a05412-917b-7613-8c24-94050b2e28ef.jsonl, updated_at=2026-08-30T19:21:59+00:00, thread_id=01a05412-917b-7613-8c24-94050b2e28ef, mechanical current-freeze advance)
- rollout_summaries/2026-08-30T19-07-58-Fg87-c_projection_remove_unapproved_request_failed_message.md (cwd=/Users/mrbubbles/.codex/worktrees/83be/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-07-58-01a05412-42dc-7cb2-a042-cfbba62a37af.jsonl, updated_at=2026-08-30T19:20:18+00:00, thread_id=01a05412-42dc-7cb2-a042-cfbba62a37af, minimal allowlist corrective pushed `aab92a`)
- rollout_summaries/2026-08-30T18-55-17-ZU7I-backend_c_projection_compliance_review_p2_p3.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-c-projection-compliance-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-55-17-01a05406-a813-7542-ba31-965652c9bda6.jsonl, updated_at=2026-08-30T19:07:17+00:00, thread_id=01a05406-a813-7542-ba31-965652c9bda6, compliance review still found P2/P3; no overall readiness)
- rollout_summaries/2026-08-30T18-43-37-qnaV-novari_c_projection_traceability_evidence_handoff.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-17/novari-logging-v2-delegation, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-43-37-01a053fb-fb4c-7d73-9115-ddacd1fd8811.jsonl, updated_at=2026-08-30T18:54:46+00:00, thread_id=01a053fb-fb4c-7d73-9115-ddacd1fd8811, traceability synchronized)
- rollout_summaries/2026-08-30T18-34-58-27IW-backend_c_projection_high_review_pass.md (cwd=/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-34-58-01a053f4-0ddb-7cc0-a048-4e874e6a777e.jsonl, updated_at=2026-08-30T18:39:21+00:00, thread_id=01a053f4-0ddb-7cc0-a048-4e874e6a777e, HIGH REVIEW PASS)
- rollout_summaries/2026-08-30T16-30-56-JnDD-c_projection_backend_error_projection_commit_push.md (cwd=/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T18-30-56-01a05382-80a2-70f3-8586-087ec0a5462d.jsonl, updated_at=2026-08-30T18:42:03+00:00, thread_id=01a05382-80a2-70f3-8586-087ec0a5462d, committed and pushed `33c6bdcd`)
- rollout_summaries/2026-08-30T20-34-36-SafS-logging_v2_c_projection_final_compliance_rereview.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-c-projection-final-compliance-rereview, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T22-34-36-01a05461-9414-7d40-9e6d-0591f841c3e0.jsonl, updated_at=2026-08-30T20:45:14+00:00, thread_id=01a05461-9414-7d40-9e6d-0591f841c3e0, final slice PASS; all rows remain partial)
- rollout_summaries/2026-08-30T19-34-03-emvx-c_projection_traceability_response_correctives.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-c-projection-traceability-corrective, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-34-03-01a0542a-24b1-7433-9eaf-69b693498dfb.jsonl, updated_at=2026-08-30T20:34:17+00:00, thread_id=01a0542a-24b1-7433-9eaf-69b693498dfb, narrow traceability/handoff corrective)

### keywords

- C-Projection, 33c6bdcd, aab92a, 56ddb128, sendProjectedErrorResponse, sendErrorResponse, B40, T35, build-matrix.mjs, 92/92, 231/232, listen EPERM, partial, HIGH REVIEW PASS

## Task 5: Design, repair, and close the monthly G-Archive retry and cleanup contract

### rollout_summary_files

- rollout_summaries/2026-08-30T23-21-10-amR9-g_archive_hidrive_verified_hot_deletion_candidate.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T01-21-10-01a054fa-15dc-7f83-b41f-243897a25fa7.jsonl, updated_at=2026-08-30T23:43:41+00:00, thread_id=01a054fa-15dc-7f83-b41f-243897a25fa7, uncommitted candidate; independent review pending)
- rollout_summaries/2026-08-30T23-09-40-yUsG-logging_v2_next_slice_g_archive_read_only_preparation.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/novari-education-next-logging-slice, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T01-09-40-01a054ef-8c0f-7131-8769-14497a09ad62.jsonl, updated_at=2026-08-30T23:15:31+00:00, thread_id=01a054ef-8c0f-7131-8769-14497a09ad62, formal start-gate conflict identified)

### keywords

- G-Archive, HiDrive, MongoDB, deleteMany(), eventId, occurredAt, ingestedAt, monthly JSON, manifest, archive_readback, mongo_cleanup, Logs Archivieren

## Task 6: Complete the authorized G-Archive development proof and explain encrypted HiDrive visibility

### rollout_summary_files

- rollout_summaries/2026-09-01T09-24-44-FBkU-g_archive_development_evidence_hidrive_visibility.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/01/rollout-2026-09-01T11-24-44-01a05c49-057c-7d33-853e-d0380178c26c.jsonl, updated_at=2026-09-01T10:57:57+00:00, thread_id=01a05c49-057c-7d33-853e-d0380178c26c, real Development proof completed; no product commit/push)

### keywords

- G-Archive Development-Echtnachweis, AUDIT_ARCHIVE_TRANSACTION_LIFETIME_LIMIT_SECONDS, AtlasError 8000, transactionLifetimeLimitSeconds, 9731, archiveMonth, /novari-dev/.encrypted, securityAuditArchiveStorage, AES-256-GCM

## User preferences

- when reviewing C-Projection, the user required German “Findings zuerst” with P0–P3, path/line/origin/smallest fix, independently reconstructed candidate identity and an explicit “HIGH REVIEW PASS/FAIL, commit-ready ja/nein”. [Task 3]
- when a bounded, explicitly authorized evidence run was ready, the user said “mach das jetzt bitte einfach. Teste.” and did not want to give “alle fünf Minuten ... ein Go” -> proceed autonomously within the confirmed collection/month/safety guards; do not widen the authorization. [Task 6]

## Reusable knowledge

- C-Projection started clean at Backend `35e3c4dd7d40e0888efe91d0328ec4af501382e5`; the accepted 10-file candidate was committed and normally pushed as `33c6bdcd6b5c433ba1c774f12e4db4ac382fca47`. Its strict boundaries remain: central `sendProjectedErrorResponse` fails closed while direct `sendErrorResponse` retains safe `issue` payloads; logs carry only server-owned route templates, `queryKeys`, a validated request ID, and optional `actorHash`. [Task 2][Task 3][Task 4]
- C-Projection has a runtime/high-review PASS (`92/92` focus tests, lint, syntax, diff check), but the later compliance review found an out-of-date normal generator freeze and a test-only production allowlist pair. All 92 C rows remain `partial`; do not claim C evidence as PR, integrated, deployment, or overall Logging V2 readiness. [Task 4]
- The formerly unapproved `REQUEST_FAILED / Sichere Meldung` allowlist pair was removed; only `REQUEST_FAILED / Modul konnte nicht aktualisiert werden.` is public for that module path. The final owner chain is `updateModule -> next(requestError) -> globalErrorHandler`, not `catchAsync`; an interim contrary traceability claim is superseded. [Task 4]
- For C-Projection traceability/handoff-only work, change the generator/source/evidence/handoff artifacts but not product runtime, tests, requirements, or status. Keep the evidence chain `33c6 -> aab92a -> 56ddb`; regenerate rather than hand-edit the 92 C rows, and verify source paths plus the SHA manifest after all manual edits. [Task 4]
- A later High Review found P1 archive-completeness verification and incorrect bypass of an older month awaiting retry. Preserve completeness/retry ordering in any corrective; current branch/review/push status must be re-established from present evidence. [Task 5]
- Completed Development evidence: with an exact four-month/count guard, the coordinator archived April–July oldest-first, verified encrypted HiDrive bytes/counts/manifest/SHA-256/membership, then removed exactly 9,731 approved audit documents; April–July reached 0, August stayed 15,415, two non-derivable documents stayed unchanged, and a synthetic old event was placed in open `archiveMonth=2026-09`. `25,148 - 9,731 + 1 = 15,418`. [Task 6]
- Logical archive files live through `securityAuditArchiveStorage`; with encryption enforced, their HiDrive physical representation is random `.bin` objects under `/novari-dev/.encrypted/`, not visible `events.json`/`manifest.json` paths. Verify through authenticated read-back and manifest metadata rather than expecting cleartext WebDAV files. [Task 6]

## Failures and how to do differently

- Symptom: an unmarked 4xx, accessor/Proxy route value, arbitrary query key, or dynamic domain detail reaches public projection/logging -> accept only explicit safe positive projection, own data-property reads, fixed route/query contracts, and hostile regressions. Preserve direct safe domain envelopes separately. [Task 3]
- Symptom: replacing `originalUrl` audit context with the route template makes archive certificate generation look like a normal completion -> keep the existing full archival route contract in its internal audit owner; do not rewrite the assertion to bless the wrong intermediate value. [Task 3]
- Symptom: an external evidence runner fails with `ERR_MODULE_NOT_FOUND` for `mongoose`, a JSON-string guard fails on key order, or the endcheck rejects the intentional Late-Arrival. Fix: run temporary scripts from the repository package context, compare guard fields structurally, model approved expected mutations separately, then remove temporary runners. [Task 6]
- Symptom: a destructive archive run is authorized generally rather than against exact data. Fix: run an executable month/count guard before the coordinator and preserve the closed-month/open-month boundary. [Task 6]

# Task Group: Novari security-maintenance merge candidates and release verification
scope: 2026-08-28 normal, frozen merges of approved Dev security-maintenance changes into Portal or Backend Logging baselines; use for narrow conflict resolution, no-rebase release handoffs, and post-push identity proof.
applies_to: cwd=/Users/mrbubbles/.codex/worktrees/{0247,7a42}/novari-education-{portal,backend}; reuse_rule=these worktrees, refs, merge parents, and baseline failures are snapshot-specific; reuse only the merge/verification method after identifying the active checkout and authorized scope.

## Task 1: Merge Portal security maintenance while preserving error ownership

### rollout_summary_files

- rollout_summaries/2026-08-28T12-30-51-TOKr-portal_security_maintenance_merge_and_push.md (cwd=/Users/mrbubbles/.codex/worktrees/0247/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T14-30-51-01a04859-f985-7212-8a27-de46db374ccf.jsonl, updated_at=2026-08-28T14:29:49+00:00, thread_id=01a04859-f985-7212-8a27-de46db374ccf, normal merge committed and pushed)

### keywords

- merge --no-commit --no-ff, IncidentManagement.tsx, SECURITY_MAINTENANCE_ACTIVE, skipGlobalErrorToast, V-B, 86a167746d8093b72924312d4bfd39bcae95880a, routeTree.gen.ts

## User preferences

- for these integrations, the user required “kein Rebase, kein Cherry-pick, kein Squash”, no delegation, and preservation of the approved Dev/product logic -> use only the authorized normal merge and narrowly resolve expected conflicts. [Task 1]
- until full verification, the user required “Noch kein Commit und kein Push”; after accepting review findings as out-of-scope, they required no further code/test/docs/plan changes -> freeze, then perform only identity checks, commit, push, and post-push verification. [Task 1]

## Reusable knowledge

- Before mutation, verify baseline, Dev ref, merge-base, divergence, clean status, direct remote refs, and the expected conflict set. Before release, verify `MERGE_HEAD`, candidate tree/patch identity, no unresolved conflicts, then after normal push prove HEAD = tracking ref = direct remote ref, ahead/behind `0/0`, and a clean tree. [Task 1]
- Portal: invalid or missing support message/request ID must not suppress a global 5xx toast; all six maintenance mutations use request-local `skipGlobalErrorToast`, and read/socket/archive error owners mount only in the active Incident tab. [Task 1]

## Failures and how to do differently

- Symptom: shared-worktree Git metadata cannot write `ORIG_HEAD.lock` or `index.lock` -> the common Git directory is permission-restricted; use authorized Git mutation access instead of changing project content. [Task 1]
- Symptom: typecheck or full suite is red outside the merge scope -> compare to the exact baseline and report known `routeTree.gen.ts`/Help-Portal failures separately; do not fold them into the merge or claim them as candidate regressions. [Task 1]
- Symptom: verification reports a noncanonical diff hash or `node --check` extension noise -> use the exact full-index hash command and restrict syntax checks to JavaScript files. [Task 1]

# Task Group: Novari Logging V2 acceptance-control matrix, real-path development validation, and remaining compliance gaps
scope: 2026-08-26 to 2026-08-28 cross-repository acceptance control and the first D-Producer slices for the current Backend, Portal, and LMS Logging V2 candidates; use for authoritative-spec traceability, post-C0 matrix/handoff corrections, real-path temporary validation, and readiness decisions rather than ordinary slice review.
applies_to: cwd=Novari Logging V2 Delegation plus /Users/mrbubbles/dev/novari/novari-education-{backend,portal,lms}; reuse_rule=matrix counts, commit heads, and observed gaps are snapshot-specific; reuse the evidence model and stop gates only after re-identifying the authoritative spec and exact candidates.

## Task 1: Build and review a full Logging V2 spec-compliance / requirement-traceability matrix

### rollout_summary_files

- rollout_summaries/2026-08-26T23-22-52-o2J8-spec_compliance_review_skill_creation_and_trigger_scope_revi.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/computer-history-plugin-computer-history-openai, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T01-22-52-01a04062-34a1-7f12-82cc-02981f2ada66.jsonl, updated_at=2026-08-27T00:03:48+00:00, thread_id=01a04062-34a1-7f12-82cc-02981f2ada66, created/refined the reusable audit method)

### keywords

- spec-compliance-review, Novari_Logging_Error_Handling_und_Audit_Spec_V2.md, 02f636cd9f17f1a96ca8e43c1d197281e97be7d81bcab0bd3355b748317d7fc6, 121 rows, raw-sink inventory, 420 candidates, hot-event deletion, HiDrive manifest, X-Audit-Export-Path, Logging Events, READY, NOT READY

## Task 2: Map real LMS Logging V2 producers and define the smallest permissible development test surface

### rollout_summary_files

- rollout_summaries/2026-08-26T18-40-13-WXDk-simplify_and_transfer_temporary_lms_test_page.md (cwd=/Users/mrbubbles/.codex/worktrees/0755/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T20-40-13-01a03f5f-6d5b-7360-9783-0092fbd91572.jsonl, updated_at=2026-08-26T19:04:46+00:00, thread_id=01a03f5f-6d5b-7360-9783-0092fbd91572, simplified and fast-forwarded the reviewed LMS page)
- rollout_summaries/2026-08-26T18-50-24-UXjp-novari_lms_logging_v2_read_only_review.md (cwd=/Users/mrbubbles/.codex/worktrees/2c5f/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T20-50-24-01a03f68-c0fe-7fc0-9312-302968bc783f.jsonl, updated_at=2026-08-26T18:53:14+00:00, thread_id=01a03f68-c0fe-7fc0-9312-302968bc783f, frozen static review found no P0–P3)

### keywords

- backend-error-projection.ts, LMS_CONTENT_LOCKED, BACKEND_UNAVAILABLE, refreshBackendSession, GET /auth/reauth, GET /api/exams, Topic, SLP, GHCR, app/development/logging-v2/page.tsx, catalog.ts, b0b1bbdf, fast-forward, detached-head

## Task 3: Correct and independently review the post-C0 matrix; preserve bounded Backend route persistence

### rollout_summary_files

- rollout_summaries/2026-08-27T16-26-19-xxOr-novari_logging_v2_post_c0_independent_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/novari-logging-v2-c0-final-independent-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T18-26-19-01a0440b-3103-7880-b5cb-0a184dfb4333.jsonl, updated_at=2026-08-27T16:32:05+00:00, thread_id=01a0440b-3103-7880-b5cb-0a184dfb4333, C0 accepted but matrix and runtime readiness rejected)
- rollout_summaries/2026-08-27T16-16-38-zoab-novari_logging_v2_atomic_matrix_generator_corrective.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/novari-logging-v2-matrix-corrective, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T18-16-38-01a04402-54f3-7071-86a3-82b09b833dbf.jsonl, updated_at=2026-08-27T16:25:46+00:00, thread_id=01a04402-54f3-7071-86a3-82b09b833dbf, successful six-artifact generator corrective)

### keywords

- C0 – normative Synchronisierung, S20-R1E, 6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6, atomic matrix, generator, Backend-F0, routeTemplate, D-Producer

## Task 4: Create, correct, and independently adjudicate the C0→Runtime handoff and Portal V-B continuity gate

### rollout_summary_files

- rollout_summaries/2026-08-28T01-34-11-PUhX-v_b_normative_adjudication_combined_evidence.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T03-34-12-01a04600-ca1c-71a2-bd36-fb2807c88521.jsonl, updated_at=2026-08-28T01:43:51+00:00, thread_id=01a04600-ca1c-71a2-bd36-fb2807c88521, final normative V-B acceptance from combined evidence)
- rollout_summaries/2026-08-27T19-48-57-bTki-novari_logging_v2_handoff_rules_corrective.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/novari-logging-v2-c0-handoff-rules-corrective, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T21-48-57-01a044c4-b4ee-77f1-b8f9-9cefa2398aee.jsonl, updated_at=2026-08-27T19:50:32+00:00, thread_id=01a044c4-b4ee-77f1-b8f9-9cefa2398aee, isolated eight-section handoff corrective)
- rollout_summaries/2026-08-27T19-37-51-fupt-novari_logging_v2_c0_runtime_handoff.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/novari-logging-v2-c0-runtime-handoff-writer, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T21-37-51-01a044ba-8d86-7cb2-b9f9-5b9df42f3e7b.jsonl, updated_at=2026-08-27T19:44:08+00:00, thread_id=01a044ba-8d86-7cb2-b9f9-5b9df42f3e7b, initial self-contained runtime handoff)

### keywords

- logging-v2-c0-runtime-handoff.md, §§14–16.1, 7f50b358, D-Producer, V-F0, V-B, V-B-RET-1, continuity-context, visibilitychange, AbortSignal, 8ab63d7e, 36/36, audit-work/slice-evidence/v-b.md

## Task 5: Implement, independently review, and deliver the D-CA course-archive failure-audit contract

### rollout_summary_files

- rollout_summaries/2026-08-28T11-08-46-hr3k-dca_startfreeze_branch_upstream_blocker.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T13-08-46-01a0480e-d250-7750-9a66-85579a607ba2.jsonl, updated_at=2026-08-28T11:10:21+00:00, thread_id=01a0480e-d250-7750-9a66-85579a607ba2, hard start freeze stopped the wrong active branch)
- rollout_summaries/2026-08-28T11-11-08-1Xma-dca_course_archive_v2_audit_commit_push.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T13-11-08-01a04810-fdd8-7830-a878-198fae69faa2.jsonl, updated_at=2026-08-28T11:54:56+00:00, thread_id=01a04810-fdd8-7830-a878-198fae69faa2, implemented, reviewed, committed, and pushed)
- rollout_summaries/2026-08-28T11-37-39-HwUI-read_only_dca_course_archive_audit_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T13-37-39-01a04829-444b-77c1-8a00-128beae50e84.jsonl, updated_at=2026-08-28T11:46:02+00:00, thread_id=01a04829-444b-77c1-8a00-128beae50e84, independent read-only HIGH-REVIEW PASS)

### keywords

- D-CA, COURSE_ARCHIVE_CERTIFICATE_GENERATION_FAILED, course_archive, closingReportArchiveController, logAuditEvent, securityAuditEventSchema, at most one persisted result event, e2b8cbdfe79b95b9fe6bcbdb1df7a900cecc2894

## Task 7: Complete V-F0, F1/F2 safe-projection evidence, and raw-source traceability correction

### rollout_summary_files

- rollout_summaries/2026-08-30T21-21-03-vAHB-logging_v2_v_f0_traceability_high_review_pass.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-v-f0-traceability-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T23-21-03-01a0548c-1cd4-7e01-bcec-a96cdadf32a7.jsonl, updated_at=2026-08-30T21:29:59+00:00, thread_id=01a0548c-1cd4-7e01-bcec-a96cdadf32a7, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T21-09-58-1KGL-close_v_f0_traceability_findings.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-v-f0-traceability-closure, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T23-09-58-01a05481-f521-7bb0-9e65-5d05c630e61b.jsonl, updated_at=2026-08-30T21:20:46+00:00, thread_id=01a05481-f521-7bb0-9e65-5d05c630e61b, documentary corrective)
- rollout_summaries/2026-08-30T21-01-54-PqDI-logging_v2_v_f0_backend_adjudication_pass.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-v-f0-final-adjudication, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T23-01-54-01a0547a-9478-7c51-a269-212cb9af848e.jsonl, updated_at=2026-08-30T21:09:17+00:00, thread_id=01a0547a-9478-7c51-a269-212cb9af848e, adjudication PASS)
- rollout_summaries/2026-08-30T22-07-58-wAM9-lms_f2_metadata_bff_high_review_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-07-58-01a054b7-0e93-7b43-8d15-31be4df7ccb9.jsonl, updated_at=2026-08-30T22:12:54+00:00, thread_id=01a054b7-0e93-7b43-8d15-31be4df7ccb9, HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T22-01-04-5IQQ-lms_f2_metadata_error_projection_and_pr_label_governance.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-01-04-01a054b0-bd59-7bc1-8c95-5994a92edc54.jsonl, updated_at=2026-09-06T18:45:07+00:00, thread_id=01a054b0-bd59-7bc1-8c95-5994a92edc54, committed/pushed F2 projection; separate uncommitted Nova AGENTS governance update)
- rollout_summaries/2026-08-30T22-00-06-UieR-f2_lms_metadata_bff_detached_head_stop_gate.md (cwd=/Users/mrbubbles/.codex/worktrees/c4a2/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-00-06-01a054af-dce7-7880-816e-834aa1f98b91.jsonl, updated_at=2026-08-30T22:00:41+00:00, thread_id=01a054af-dce7-7880-816e-834aa1f98b91, detached-HEAD stop gate)
- rollout_summaries/2026-08-30T22-15-50-4kBg-f1_portal_read_only_evidence_review_slice_pass.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-15-50-01a054be-428c-70a3-9897-ef510b82da06.jsonl, updated_at=2026-08-30T22:23:32+00:00, thread_id=01a054be-428c-70a3-9897-ef510b82da06, slice PASS)
- rollout_summaries/2026-08-30T23-04-32-qikG-f1_f2_traceability_p2_corrective_high_rereview.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/novari-education-f2-traceability-final-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T01-04-32-01a054ea-d968-70b3-933d-64d73537c43a.jsonl, updated_at=2026-08-30T23:09:18+00:00, thread_id=01a054ea-d968-70b3-933d-64d73537c43a, final HIGH-REVIEW PASS)
- rollout_summaries/2026-08-30T22-58-42-LpYL-f2_lms_traceability_raw_source_regression_gate.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/novari-education-f2-traceability-gate, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-58-42-01a054e5-80e5-7ff3-88cc-3ec2284e8c73.jsonl, updated_at=2026-08-30T23:04:14+00:00, thread_id=01a054e5-80e5-7ff3-88cc-3ec2284e8c73, raw-source gate repair)
- rollout_summaries/2026-08-30T22-52-04-oISP-logging_v2_f1_f2_high_review_regression_gate_fail.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/logging-v2-f1-f2-compliance-rereview, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-52-04-01a054df-710f-7732-b9db-ca1fc765e757.jsonl, updated_at=2026-08-30T22:58:21+00:00, thread_id=01a054df-710f-7732-b9db-ca1fc765e757, HIGH REVIEW FAIL exposed stale gate)
- rollout_summaries/2026-08-30T22-46-00-qASm-f1_traceability_s6_r2_section61_correction.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/logging-v2-f1-traceability-p2-corrective, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-46-00-01a054d9-e07a-7fb0-b078-122bdbae7e7a.jsonl, updated_at=2026-08-30T22:51:45+00:00, thread_id=01a054d9-e07a-7fb0-b078-122bdbae7e7a, correction)
- rollout_summaries/2026-08-30T22-37-28-Spbt-novari_f1_f2_traceability_p2_review_fail.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/logging-v2-f1-f2-compliance-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-37-28-01a054d2-13a2-7293-b87e-8debf3db4bbb.jsonl, updated_at=2026-08-30T22:45:35+00:00, thread_id=01a054d2-13a2-7293-b87e-8debf3db4bbb, P2 finding)
- rollout_summaries/2026-08-30T22-24-06-YqQ5-logging_v2_f1_f2_traceability_closeout.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-31/logging-v2-f1-f2-traceability-closeout, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-24-06-01a054c5-d6d0-7bb0-a97a-df212090a765.jsonl, updated_at=2026-08-30T22:37:09+00:00, thread_id=01a054c5-d6d0-7bb0-a97a-df212090a765, documentary closeout)
- rollout_summaries/2026-08-30T21-30-22-x07K-logging_v2_f1_f2_read_only_support_information_plan.md (cwd=/Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-f1-f2-support-information-plan, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T23-30-22-01a05494-a30e-7322-889f-bff097f4ae98.jsonl, updated_at=2026-08-30T21:37:36+00:00, thread_id=01a05494-a30e-7322-889f-bff097f4ae98, read-only plan)

### keywords

- V-F0, F1-Portal, F2-LMS, f43e33ac, backend-error-projection.ts, S6-R2B, S6-R2A, S6-R2E, S6-R3, validateRawF1PortalSection61Traceability, applyCurrentTraceability, 1288, 1050, 33, partial, NOT READY

## User preferences

- when the user added “step 0” before further Logging V2 implementation, they required a full spec-compliance/requirement-traceability matrix across Backend, Portal, and LMS -> atomize the authoritative contract before judging slices; do not call a collection of green slice reviews feature completion. [Task 1]
- when requesting the LMS mapping, the user required “READ-ONLY”, “keine Spekulation”, a complete matrix, exact allowlist, and no invented Blob/PDF case -> state unknown event/Portal contracts as blockers and map only real flows. [Task 2]
- when implementing the certificate test sentinel, the user required “minimal”, “exactly” bounded behavior, real auth/CSRF/role checks and real POST route, no new route/env/collection/test file, no push, and removal after browser testing. [Task 3]
- when revising the audit skill, the user said “Sonst nichts … ändern.” -> for a narrowly authorized metadata revision, preserve all non-requested bytes and verify the diff is exactly that change. [Task 1]
- when correcting C0 artifacts, the user required a “frischen eigenständigen Corrective-Task mit leerem Kontext”, full rereading of the spec, no delegation, and no Runtime-/Branch-/Commit-/Push-/Remote changes -> re-identify spec and candidate identity and keep documentary correction separate from runtime work. [Task 4]
- when requesting the final V-B review, the user required strictly read-only work, no delegation/new runs, and exact separation of original Spec wording from Handoff/Plan traceability -> adjudicate existing primary evidence against the authoritative contract; do not invent a manual/browser obligation from a chosen evidence method. [Task 5]
- when correcting the handoff, the user required additions “in den bestehenden acht Hauptabschnitten”, no ninth section, and no commit/push before independent review, accepted findings, and a separate Go -> preserve the document structure and treat review/findings closure/user approval as independent hard gates. [Task 5]
- when D-CA was authorized, the user required “höchstens ein persistiertes Ergebnisereignis”, not “Exactly-once”, unchanged controller/route/global-handler/audit-store flows, and safe server-side projection -> preserve the at-most-one-per-attempt distinction and do not add ownership or retry infrastructure. [Task 6]
- when evaluating formal C/V/F evidence, the user required no subagents, read-only findings-first review, independently verified candidate identity, and a separate slice/PR/integrated/deployment verdict. [Task 8]
- when correcting traceability, the user required raw-source validation and a negative probe before normalization -> do not let `applyCurrentTraceability` overwrite an invalid classification. [Task 8]

## Reusable knowledge

- A full compliance verdict follows the original authoritative spec into the exact frozen candidates, not the changed files outward. A `READY` verdict needs every mandatory row fulfilled or authoritatively non-applicable, no P0/P1 or unresolved contradiction, required automated/browser evidence on the final candidates, full-diff review, and no temporary test aids. Successful slice review, schemas, helpers, sentinels, and prior agent claims are leads, not fulfillment evidence. [Task 1]
- LMS local contract source is `docs/development/error-handling.md`, not a normative Logging V2/event/Portal contract. `backend-error-projection.ts` accepts only exact safe envelopes and coherent request IDs fail-closed; the visible `403 LMS_CONTENT_LOCKED` path is static copy plus validated request ID, while Topic/SLP `5xx` becomes `missing` then `notFound()`. Only Exam Start/Save/Submit/Results normalize rejected fetches to `503 BACKEND_UNAVAILABLE`; assignment lists intentionally do not. [Task 2]
- A temporary LMS catalog may only be `app/development/logging-v2/page.tsx`: production `notFound()`, no own fetch/BFF/toast/error renderer/product logic, only links to existing paths. A deterministic backend failure needs a separately approved `NODE_ENV=development` injection at a real endpoint; clean `[LOGGING-V2-TEST:<run-id>:...]` data, injections, page, and tests afterward and verify zero hits with `rg`. [Task 2]
- The certificate sentinel must execute before all course/student reads and writes, only at `NODE_ENV=development` with exact `__novariDevSentinel=certificate-generation-failed` and reserved dummy ID. Preserve route middleware/CSRF/class-manager checks; set `res.locals.skipWriteAudit` only inside this branch and use deterministic lowercase SHA-256 target hash. The final temporary candidate passed 13 focused tests, ESLint, and `git diff --check`; its target fast-forward allowed only the explicit `node_modules` symlink exception. [Task 3]
- C0 itself was accepted as a spec-only synchronization: exact 24-month allowlist / 12-month fallback using existing `event`, `action`, and `outcome`, server-only HiDrive export, `/logging-events`, three diagnosis codes, narrow `LOG_HASH_SALT`, and fixed `logging_system_alert`. It is not runtime, test, browser, PR, or deployment evidence. [Task 4]
- The successful corrective mechanically synchronized 150 source/matrix IDs and 128 persistence rows; the generator validates before writing and negative duplicate-ID/status probes must exit 1 without changing generated outputs. Treat that as structural integrity only: the later independent review found remaining bundled requirements and missing owner-correct Backend-F0 planning, so the matrix is NOT READY. [Task 4]
- Backend inventory route-unwind persistence was safely fixed by accepting exactly `/github-curriculum/program-types/:programTypeId/repository/inventory` in addition to canonical `/auth/lms/...`, while persisting only the canonical template and continuing to reject raw-ID paths. The target `af21c988...` was identity-verified and pushed after 12 focused tests and lint. [Task 4]
- Current post-corrective structural validation is 1,288 source rows, 1,050 persistence rows, and 33 canonical slices. V-F0 is adjudicated and traceability-reviewed PASS; F2 Metadata-BFF reuses `lib/errors/server/backend-error-projection.ts` only in its two metadata routes and was pushed as `f43e33ac6eb952d335223fb4ff06057089d6bc5f`. F1/F2 slice PASSes do not change overall `NOT READY`. [Task 8]
- The durable F1/F2 regression shield is to validate the 16 positive §6.1/F1 rows before `applyCurrentTraceability`; `S6-R2A/E` are V-F0-only and all `S6-R3*` remain §6.2/E2-only. [Task 8]
- The final C0→Runtime handoff is SHA-256 `7f50b358c74af9009e5735e82769fccc3ce6e722eedbadf02132625de209922f`, exactly eight main sections, and carries the universal §§14–16.1 slice/review/report contract. C0+Traceability remains documentation/traceability readiness only: it does not itself authorize runtime, PR, deployment, or production work. [Task 5]
- For the snapshot audited in the handoff, D-Producer is limited to exactly two production files (`libs/observability/logger.js`, `models/audit/securityAuditEventSchema.js`) and two tests; a third production file stops the slice. `error/globalErrorHandler.js` and `libs/observability/auditStore.js` remain unchanged owners outside its allowlist. Re-identify heads/counts before reuse. [Task 5]
- Final V-B adjudication accepted combined evidence: real `visible → hidden → visible` behavior (55.965 s hidden with no poll and exactly one return poll), native cancellation, focused Portal suite `36/36`, identity/late-result/claim tests, and prior 21-request no-write evidence. The `V-B-RET-1` change at Portal `8ab63d7e...` affected only Query/Focus options, so existing service/API/persistence/audit-owner evidence remained applicable. V-B can be closed by a short Coordinator decision; no further manual run or corrective is normatively required. [Task 5]
- D-CA changes exactly two production files and three tests. `closingReportArchiveController` remains the sole owner of `COURSE_ARCHIVE_CERTIFICATE_GENERATION_FAILED`; it writes once, then forwards to the global handler, whose GitHub-only support-event allowlist rejects this code. The V2 matcher must reject mixed contracts and persist only bounded safe fields; store failure is best effort with no retry or response change. The delivered commit is `e2b8cbdfe79b95b9fe6bcbdb1df7a900cecc2894`. [Task 6]

## Failures and how to do differently

- Symptom: Backendevent or Portal Security Event is inferred from LMS status, URL, or local UI. Cause: no normative cross-repository event contract. Fix: mark it unknown/blocked, then separately establish the contract and live-verify via the visible request ID and Portal event view. [Task 2]
- Symptom: a certificate sentinel uses the existing per-student failure path after reads and writes. Cause: trigger placement is too late. Fix: put the exact development guard at the earliest permitted controller boundary and test positive, negative, empty, malformed, production, closing-report, and real middleware/finish paths. [Task 3]
- Symptom: a narrow skill/artifact patch accidentally changes multiple sections or `git status` is unavailable. Fix: make one coherent patch per file; use direct artifact diffs and the relevant validator when the output directory is not a Git repository. [Task 1]
- Symptom: mechanically synchronized matrix counts are treated as acceptance-ready. Cause: rows still bundle independently failing obligations, status/evidence semantics are unchecked, or the slice plan lacks the owner-correct Backend-F0 work. Fix: findings-first review of atomicity, full source ranges, runtime evidence, and owner mapping; do not authorize D-Producer from C0 alone. [Task 4]
- Symptom: an early V-B review treats a missing manually manufactured late response or a canceled request without `X-Request-Id` as a product failure/unfinished normative condition. Cause: it imports stricter Handoff/Plan evidence mechanics or response-header expectations into Spec §10. Fix: distinguish protection behavior from evidence blockers; a pre-header native cancel can be identified by HAR transport/status and poll stop, and automated race/identity tests plus real lifecycle/no-write evidence can satisfy the actual contract. [Task 5]
- Symptom: a read-only report makes broad redaction claims such as “no server addresses.” Cause: it did not check the exact retained HAR fields. Fix: phrase claims field-by-field and account for retained local hosts such as `backend.local.test:5517`. [Task 5]
- Symptom: a Logging V2 slice starts on an auto-created branch with no upstream. Fix: stop before edits, re-establish the agreed branch/direct remote ref/clean baseline, then restart the gate. Symptom: Prettier broadens baseline test diffs. Fix: restore the project `--single-quote` style and leave baseline deviations untouched. [Task 6]
- Symptom: a current traceability artifact looks correct but a stale raw §6.2/LMS source survives the regression gate. Cause: validation runs after normalization. Fix: validate raw source first with an explicit negative probe, then regenerate and review deterministic hashes/manifest. [Task 8]

# Task Group: Novari Portal Logging V2 corrective wave, Corr-1–7 integration, and PR-readiness gates
scope: 2026-08-25 to 2026-08-26 Portal corrective delivery: request-start auth ownership, one local error/toast owner, frozen-candidate identity, additive integration, and deliberate deferral of product/error-propagation work.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal and its named frozen worktrees; reuse_rule=commit IDs, worktrees, branch state, and test counts are snapshot-specific; reuse the scope, ownership, freeze, integration, and verification gates only after re-establishing the active candidate.

## Task 1: Freeze, review, transfer, and audit Corr-5 and Corr-6

### rollout_summary_files

- rollout_summaries/2026-08-25T23-40-45-bqLE-portal_corr_6_git_transfer_verification.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T01-40-45-01a03b4c-35f2-7f71-b775-6b100d5f9b8a.jsonl, updated_at=2026-08-25T23:49:15+00:00, thread_id=01a03b4c-35f2-7f71-b775-6b100d5f9b8a, Corr-6 transferred with identity verification)

### keywords

- Corr-6, 648d448e, c92cd98b, ceefa399, patch-id, binary-diff, blob-identity, EvaluationFormPanel, NOVARI-FREEZE-V1

## Task 2: Coordinate final multi-repo browser validation, temporary dev surfaces, and AGENTS.md cleanup

### rollout_summary_files

- rollout_summaries/2026-08-26T13-12-27-zcxG-backend_dev_merge_logging_improvements_fast_forward.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T15-12-27-01a03e33-590a-7113-b90b-0a71e1169c30.jsonl, updated_at=2026-08-26T13:18:15+00:00, thread_id=01a03e33-590a-7113-b90b-0a71e1169c30, backend fast-forward integration)
- rollout_summaries/2026-08-26T13-06-45-PDf1-portal_dev_merge_ff_only_push_98ab51d6.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T15-06-45-01a03e2e-1eb2-78a3-ac56-7a9b9d813fc7.jsonl, updated_at=2026-08-26T13:11:45+00:00, thread_id=01a03e2e-1eb2-78a3-ac56-7a9b9d813fc7, Portal fast-forward integration)
- rollout_summaries/2026-08-26T12-52-31-gOwS-novari_backend_origin_dev_logging_v2_merge.md (cwd=/Users/mrbubbles/.codex/worktrees/88d0/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T14-52-31-01a03e21-1983-7731-ad08-6f3f951568ce.jsonl, updated_at=2026-08-26T13:07:16+00:00, thread_id=01a03e21-1983-7731-ad08-6f3f951568ce, reviewed `origin/dev` merge candidate)

### keywords

- Logging V2 Delegation, /logging-v2-dev, /dev/logging-v2, tests/browser-fixtures/logging-v2, AGENTS.md, SENSITIVE_CHANGE_FIELDS, browser validation, temporary test surface, encryption rollout

## Task 3: Build, correct, and independently review the temporary Portal/LMS development catalogs

### rollout_summary_files

- rollout_summaries/2026-08-26T18-40-13-WXDk-simplify_and_transfer_temporary_lms_test_page.md (cwd=/Users/mrbubbles/.codex/worktrees/0755/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T20-40-13-01a03f5f-6d5b-7360-9783-0092fbd91572.jsonl, updated_at=2026-08-26T19:04:46+00:00, thread_id=01a03f5f-6d5b-7360-9783-0092fbd91572, replaced LMS catalog with four direct links and identity-preserving transfer)
- rollout_summaries/2026-08-26T18-50-24-UXjp-novari_lms_logging_v2_read_only_review.md (cwd=/Users/mrbubbles/.codex/worktrees/2c5f/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T20-50-24-01a03f68-c0fe-7fc0-9312-302968bc783f.jsonl, updated_at=2026-08-26T18:53:14+00:00, thread_id=01a03f68-c0fe-7fc0-9312-302968bc783f, exact-parent static review found no P0–P3)

### keywords

- temporary development catalog, import.meta.env.DEV, NODE_ENV, notFound, native anchor, next/link, Button asChild, Metadata-BFF, GITHUB_SYNC_CONNECTION_FAILED, opaque Blob, request-free, removal-before-PR

## Task 4: Establish a read-only Logging V2 acceptance-control matrix before further implementation

### rollout_summary_files

- rollout_summaries/2026-08-27T16-26-19-xxOr-novari_logging_v2_post_c0_independent_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-27/novari-logging-v2-c0-final-independent-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/27/rollout-2026-08-27T18-26-19-01a0440b-3103-7880-b5cb-0a184dfb4333.jsonl, updated_at=2026-08-27T16:32:05+00:00, thread_id=01a0440b-3103-7880-b5cb-0a184dfb4333, independent matrix acceptance review)

### keywords

- compliance matrix, 103 atomic requirements, 117 rows, 25 §19 acceptance criteria, §20 open decisions, hot-event deletion, HiDrive proof, route template, audit-work

## User preferences

- when correcting Portal error ownership, the user required an “exakte Produktions-Allowlist”, “genau einen” visible error/toast owner, and no central `apiClient`/`queryClient` or product-flow changes -> treat any added producer, shared default, cache/redirect/payload change, or scope drift as a hard stop. [Task 1][Task 2]
- when a frozen/read-only reviewer is requested, the user required a “frischer repositorygebundener, vollständig read-only unabhängiger Reviewer”, “keine Edits, Formatierungen, Tests, Commits, Staging oder Git-Mutationen”, and findings-first P0–P3 -> establish candidate identity, parent, cleanliness, and allowlist before inspection and state unrun checks separately. [Task 2][Task 3]
- when reviewing a temporary test surface, the user asked for “ausschließlich echte Testblocker prüfen” and no design/performance/documentation/production-readiness detours -> report P0–P3 first, keep a request-free catalog narrowly technical, and disclose unrun checks. [Task 5]
- when the user called the prior pages an “unübersichtliche interne Vertragsdatenbank” / “große Owner-/Producer-Katalog”, they required “kleine echte Testoberfläche, keine Dokumentation”, “ohne Eingaben und ohne das Heraussuchen von IDs”, and only a short understandable expectation -> use fixed executable scenarios or direct real-page links; hide Owner/Producer/BFF/Persistenz metadata. [Task 5]

## Reusable knowledge

- Variante A: capture `authStateAtRequestStart` immediately before a direct request or in React Query `onMutate`, pass it to the local final owner, retain `skipGlobalErrorToast: true`, show safe local feedback only for authenticated-start requests, and keep expected signed-out-start 401s silent. Missing state must not be repaired by changing global defaults. [Task 1]
- The initial pattern count is not a scope: 58 files using `showHandledApiErrorToast` and 40 without same-file capture narrowed to 97 confirmed local-owner/helper callsites across 47 files only after tracing productive paths. Exclude central MutationCache owners, silent handlers, local/non-Axios errors, and ambiguous multi-phase flows until separately approved. [Task 1]
- Wave 1 was integrated as `b470f5ef → 55470b93 → 48cddbd4 → edbca5f2`; candidates require conflict-free cherry-pick plus patch-ID, binary-diff, tree, and blob identity, then tests on the combined target and a `0/0` remote confirmation before cleanup. A green focused matrix does not satisfy a hard full-suite gate. [Task 1][Task 2]
- Corr-5 preserves existing `showPromiseToast` as the sole owner for six active Training mutations; preserve Promise/return identity, ordering, lifecycle, payloads, invalidations, and `retry: 0`. Corr-6 local preconditions must run before auth capture and strict API error handling so established user copy is not collapsed to `UNKNOWN`. [Task 2]
- Temporary catalogs are only safe as fail-closed development surfaces: gate before render (`import.meta.env.DEV`/`NODE_ENV` plus existing access-cookie check), make the catalog static/request-free, use only real product links and fixed scenario data, retain opaque Blob handling, and remove the surface before PR. [Task 4][Task 5]
- For an expressly hydration-free LMS server catalog, use native `<a>` rather than `next/link` or `Button asChild`; `prefetch={false}` does not remove the client boundary. Validate declared Topic/SLP paths against `lib/data/db.ts`, which directly uses the Public backend. [Task 5]
- The simplified LMS page is a development-and-auth-cookie-gated four-link page (`/`, `/modules`, `/exams`, `/github-classroom`); delete its unused `catalog.ts`, retain `notFound()` outside the gate, and test that internal terms and text inputs are absent. The exact reviewed commit was fast-forwarded without amend/copy/push; destination checks must run in the destination worktree. [Task 2][Task 5]
- The Portal surface has four fixed scenarios (Inventory, Hardware-PDF, Socket, Zertifikat), automatic valid `browser-<12-digit timestamp>` Run-ID, request-local `skipGlobalErrorToast`, strict expected HTTP/code checks, and opaque Blob handling. A static review found no P0–P3, but browser/runtime checks were intentionally unrun. [Task 5]
- Certificate-sentinel review first found two P2 deviations: generic HTTP-200 `audit.data_write` success logging and an absent `targetHash` when `LOG_HASH_SALT` was missing. The corrected cumulative candidate sets `res.locals.skipWriteAudit` only in the exact early sentinel branch and uses a fixed lowercase SHA-256 dummy hash without changing normal `hashLogValue`; final static re-review was findings-free. [Task 3]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 2][Task 3]

## Failures and how to do differently

- Symptom: an authenticated request refreshes, signs out, then reaches a local catch with default `signed-out` state -> no local or global owner may remain. Capture request-start state before the operation and test the real refresh-signout side effect, not only `refreshAuthSession() === false`. [Task 1]
- Symptom: a local toast uses `extractErrorMessage`/raw `response.data.message` or omits `skipGlobalErrorToast` -> raw text and double toasts can appear. Use strictly validated safe-envelope projection and request-local opt-out. [Task 1]
- Symptom: target HEAD/remote looks synchronized but the named frozen candidate worktree is missing -> patch/tree/blob identity cannot be proven. Stop before hunk review, tests, build, cleanup, or integration; restore the exact worktree or name an equivalent frozen candidate. [Task 2]
- Symptom: an amend changes a candidate but green evidence belongs to its replaced sibling commit -> the candidate is not release-ready. Repeat relevant suites, full suite, targeted lint/Prettier, diff check, typecheck-baseline, and production build on the exact final commit. [Task 3]
- Symptom: a temporary catalog reads as static but imports `next/link` or Radix `Slot` through `Button asChild` -> it hydrates. Replace it with server-native anchors while retaining focus/responsive styles, then re-review the exact correction commit. [Task 5]
- Symptom: a sentinel catch treats any thrown error as expected or presents the same success copy for an unrelated failure -> validate the exact expected status/code (or Socket `join_failed`) and branch user copy on that outcome; add a negative test. [Task 5]
- Symptom: a controller-only test passes but the real response finish path emits an audit event, or no-salt development omits the target hash -> test the actual `auditWriteActions` finish path and actual `hashLogValue` no-salt behavior; scope suppression/hash correction to the exact sentinel only. [Task 3]
- Symptom: Next build/typecheck fails on existing `ModulePage`/`SubmodulePage` exports or a worktree has incomplete `node_modules` -> separate the known baseline/infrastructure condition from candidate evidence; do not expand the temporary allowlist or call it a product finding. [Task 5]

# Task Group: Novari Portal Variante-A auth-refresh local-owner scope gate
scope: 2026-08-25 Portal Auth-Refresh correction: preserve a request's local owner when refresh fails and logout follows, without changing global signed-out behavior or widening the approved producer allowlist.
applies_to: cwd=/Users/mrbubbles/.codex/worktrees/c693/novari-education-portal and /Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=the partial candidate and its baseline are snapshot-specific; reuse the request-start-state decision and hard scope stop only after checking the active allowlist.

## Task 1: Stop the partial Variante-A lifecycle fix at unapproved final-401 owners

### rollout_summary_files

- rollout_summaries/2026-08-25T16-19-13-lUsl-novari_logging_v2_variante_a_scope_stop.md (cwd=/Users/mrbubbles/.codex/worktrees/c693/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T18-19-13-01a039b7-f84f-7602-b46f-85775f6e54d5.jsonl, updated_at=2026-08-25T16:44:02+00:00, thread_id=01a039b7-f84f-7602-b46f-85775f6e54d5, partial; no commit/push)

### keywords

- Variante A, Auth-Refresh, authStateAtRequestStart, authSessionState, final-401, useEmployeeFeedbackPdf.ts, IncidentLegalHoldControl.tsx, ticketPopover.tsx, MutationCache, duplicate-toast, scope-gate

## User preferences

- for this Auth-Refresh slice, the user required an “exakte Produktions-Allowlist”, exactly one error/toast owner, unchanged logout/redirect/session-cleanup flows, and an immediate stop on scope drift -> check those gates before editing and ask for explicit authorization rather than making a global fallback. [Task 1]
- the user rejected global-plus-local double projection and a new auth architecture -> extend the central helper narrowly and request-start-locally. [Task 1]

## Reusable knowledge

- `authSessionState.ts` tracks local session state; `login.ts` marks a successful login active and cache cleanup signed-out. `errorHandling.ts` and `error-handler.ts` accept explicit `authStateAtRequestStart`, so a request that began authenticated keeps its local owner even after refresh failure causes logout. [Task 1]
- A global `authenticated` default is unsafe: un-migrated requests that began signed-out could unexpectedly display 401 toasts. Keep the state explicit at the migrated request boundary. [Task 1]

## Failures and how to do differently

- Symptom: final-401 owner tests expect one toast after failed `/refresh` but receive zero -> three owners did not pass request-start state, not a reason to alter global defaults. Ask to add exactly those production paths (or a named central lifecycle route); do not silently widen scope. [Task 1]
- Symptom: a test mock appears correct but focused tests fail -> mock the real direct import path, not a barrel path. [Task 1]
- Do not remove Blob-opacity/single-owner safeguards to make the slice pass; that workaround was correctly blocked. [Task 1]

# Task Group: Novari Portal F1 final ownership wave and fail-closed corrective delivery
scope: 2026-08-25 Portal F1 closure slices: preserve error-versus-empty semantics, keep exactly one local visible owner, and enforce opaque Blob/PDF boundaries.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=commits and inherited full-repo failures are checkout-specific; reuse the owner/allowlist/review gates only after validating the active candidate.

## Task 1: Preserve failed reads rather than rendering successful empty states

### rollout_summary_files

- rollout_summaries/2026-08-25T08-16-45-iSj2-novari_dropcases_error_ownership_fix.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T10-16-45-01a037fe-4305-7b53-a834-ea97c750a304.jsonl, updated_at=2026-08-25T08:27:07+00:00, thread_id=01a037fe-4305-7b53-a834-ea97c750a304, fix pushed)
- rollout_summaries/2026-08-25T08-03-50-lEf5-student_read_error_ownership_f1_slice_3.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T10-03-50-01a037f2-6f33-72a2-b34a-0912f6ea0c1f.jsonl, updated_at=2026-08-25T08:16:25+00:00, thread_id=01a037f2-6f33-72a2-b34a-0912f6ea0c1f, fix pushed)

### keywords

- DropCases, getUnconfirmedDropCases, studentServices, feedbackService, skipGlobalErrorToast, WeakSet, error-versus-empty, Retry, showHandledApiErrorToast, ed5c9b4a, c8ad6850

## Task 2: Eliminate duplicate owners and keep document/PDF bodies opaque

### rollout_summary_files

- rollout_summaries/2026-08-25T09-00-40-iJcm-qm_f1_slice_7_pdf_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-00-40-01a03826-78f9-7423-8cbb-f33d674ffb72.jsonl, updated_at=2026-08-25T09:15:43+00:00, thread_id=01a03826-78f9-7423-8cbb-f33d674ffb72, QM create/PDF fix pushed)
- rollout_summaries/2026-08-25T08-38-32-A2iU-portal_f1_slice_6_7_opaque_document_export_errors.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T10-38-32-01a03812-3568-74d0-86ce-929fe1fb1d7c.jsonl, updated_at=2026-08-25T08:57:34+00:00, thread_id=01a03812-3568-74d0-86ce-929fe1fb1d7c, opaque-download fix pushed)

### keywords

- Blob, responseType, X-Request-Id, skipGlobalErrorToast, MutationCache, studentDocumentApi, employeeApi, Security-Events-Export, Quarterly Create, PDF, opaque-body, 801c2f0e, 8df6f746

## Task 3: Correct strict local projection after final review found raw Error message disclosure

### rollout_summary_files

- rollout_summaries/2026-08-25T09-33-38-D5L5-novari_logging_corrective_diff_final_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-33-38-01a03844-a710-77a2-be72-c513d93789a3.jsonl, updated_at=2026-08-25T09:36:02+00:00, thread_id=01a03844-a710-77a2-be72-c513d93789a3, corrective review clean)
- rollout_summaries/2026-08-25T09-27-09-HQ4U-novari_portal_f1_strict_local_error_projection_fix.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-27-09-01a0383e-b93f-7b53-94a5-fefd3ac061c8.jsonl, updated_at=2026-08-25T09:33:18+00:00, thread_id=01a0383e-b93f-7b53-94a5-fefd3ac061c8, corrective fix pushed)
- rollout_summaries/2026-08-25T09-16-36-c89j-novari_logging_blocker_final_review_p2_raw_error_message.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-16-37-01a03835-10f7-7811-95c2-38a9299128f1.jsonl, updated_at=2026-08-25T09:26:19+00:00, thread_id=01a03835-10f7-7811-95c2-38a9299128f1, P2 finding)

### keywords

- requireValidatedAxiosMessage, extractErrorMessage, ERROR_MESSAGES.UNKNOWN, Error TypeError, strict local projection, fail closed, 3c9ef9af

## User preferences

- when defining F1 slices, the user required an "exakte Produktions-/Test-/Docs-Allowlist", "genau ein request-ID-fähiger lokaler Owner", unchanged success contracts, findings-first baseline→candidate review, and stop-on-drift -> make these hard gates, not report prose. [Task 1][Task 2][Task 3]
- for Blob/PDF routes, the user required "Body vollständig opak", a request-local interceptor opt-out, a static local owner, and at most validated `X-Request-Id` -> never decode a body to improve its error text. [Task 2]

## Reusable knowledge

- A read helper that catches rejection and returns `null`/`[]` collapses failed reads into successful empty UI. Preserve the original Error with request-local `skipGlobalErrorToast: true`, keep real successful absence mapped to `null`/empty, and claim it once at the active UI owner; Retry must trigger a real new request. [Task 1]
- Test the real Axios interceptor and production QueryClient/MutationCache rather than only helper mocks. Explicitly cover status/network failures, retry/invalidations, success toasts, and unchanged multipart/JSON payloads. [Task 1][Task 2]
- Strict `requireValidatedAxiosMessage` is fail-closed: dynamic text only from complete validated nested Axios envelopes; non-Axios `Error`/`TypeError` maps to `ERROR_MESSAGES.UNKNOWN`, while Axios transport failure uses static network copy. [Task 3]

## Failures and how to do differently

- Symptom: a proposed PDF scope requires production paths outside the approved allowlist or contradicts an existing audit test -> stop unchanged and ask for scope resolution; do not invent a broader "safe" interpretation. [Task 2]
- Symptom: full lint/typecheck is red or an effect test times out -> separate inherited out-of-allowlist failures; use effect- and retry-aware waits rather than changing production behavior. [Task 1][Task 3]

# Task Group: Novari Backend Logging V2 dev integration and Jobcoach central error ownership
scope: 2026-08-25 JavaScript backend integration: merge `origin/dev` into Logging V2 without changing product contracts, then remove only redundant Jobcoach local error sinks.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend and isolated backend worktrees; reuse_rule=SHA counts, dependencies, and baseline failures are checkout-specific; reuse the merge gates and real global-handler test path after re-establishing current remotes.

## Task 1: Perform and independently review the allowlist-based normal merge

### rollout_summary_files

- rollout_summaries/2026-08-25T11-41-49-pD8j-novari_merge_read_only_review_no_findings.md (cwd=/Users/mrbubbles/.codex/worktrees/cc6a/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T13-41-50-01a038ba-0425-7393-8c46-db78b5cbd2b7.jsonl, updated_at=2026-08-25T11:54:46+00:00, thread_id=01a038ba-0425-7393-8c46-db78b5cbd2b7, independent review clean)
- rollout_summaries/2026-08-25T11-27-20-4tRa-integrate_dev_into_logging_improvements.md (cwd=/Users/mrbubbles/.codex/worktrees/1958/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T13-27-20-01a038ac-be81-7dd1-b93a-e213234b0eb4.jsonl, updated_at=2026-08-25T11:41:19+00:00, thread_id=01a038ac-be81-7dd1-b93a-e213234b0eb4, merge pushed)
- rollout_summaries/2026-08-25T09-59-20-z6xv-readonly_dev_logging_v2_integration_plan.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-59-20-01a0385c-2eda-7c12-a6b4-abe4a28df59d.jsonl, updated_at=2026-08-25T10:09:09+00:00, thread_id=01a0385c-2eda-7c12-a6b4-abe4a28df59d, read-only plan)

### keywords

- origin/dev, chore/logging-improvements, git merge-tree, e101a7e, streamPdfFromHiDrive, decryptEmployeeFields, dev-exclusive byte-identical, modelLookupMultiPersona, HiDrive-only

## Task 2: Remove exactly 13 Jobcoach Timesheet local console.error calls and review the result

### rollout_summary_files

- rollout_summaries/2026-08-25T12-08-02-zI22-novari_backend_jobcoach_error_ownership_read_only_review.md (cwd=/Users/mrbubbles/.codex/worktrees/8b5c/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T14-08-02-01a038d2-0457-7bb3-b03d-ac6dfaa30ed6.jsonl, updated_at=2026-08-25T12:12:49+00:00, thread_id=01a038d2-0457-7bb3-b03d-ac6dfaa30ed6, review clean; local tests unavailable)
- rollout_summaries/2026-08-25T11-55-13-fXD9-jobcoach_timesheet_central_error_logging_slice.md (cwd=/Users/mrbubbles/.codex/worktrees/5655/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T13-55-13-01a038c6-4878-7063-976b-215e2b6206ff.jsonl, updated_at=2026-08-25T12:07:42+00:00, thread_id=01a038c6-4878-7063-976b-215e2b6206ff, fix pushed)

### keywords

- jobcoach-timesheets, console.error, next(error), globalErrorHandler, errorOwnership.test.js, a57bf8c8, ERR_MODULE_NOT_FOUND, mongoose

## User preferences

- for the merge, the user required "ausschließlich" the normal integration merge and preserved Martin's product logic: no change to PDF-HiDrive behavior, roles, document versioning, persistence, or side effects; mechanically necessary test mocks were permitted, additional production files were not. [Task 1]
- for the Jobcoach slice, the user required "ausschließlich die 13 redundanten lokalen console.error-Aufrufe", real global-owner coverage, baseline comparison, P0–P3 review, one narrow commit, and normal push. [Task 2]

## Reusable knowledge

- Before merge resolution, verify expected remote SHAs, merge-base, clean status, `git merge-tree` conflict set, and scope hashes. Preserve dev-exclusive paths byte-for-byte with `git diff --quiet <dev> HEAD -- <file>`; review the merge against both parents, not only its combined diff. [Task 1]
- Keep the freelancer PDF flow HiDrive-only through `streamPdfFromHiDrive`; resolve only allowed overlaps and update test mocks minimally when integrated interfaces change. Existing `origin/dev` baseline failures remain baseline, not merge findings. [Task 1]
- For redundant backend console sinks, leave every `next(error)` untouched and run the controller family through `error/globalErrorHandler.js`; remove raw local logs rather than replacing them with detailed logs. [Task 2]

## Failures and how to do differently

- Symptom: a zsh verification loop says commands disappeared or emits false mismatches -> do not use `path` as a variable; it is zsh-special. [Task 1]
- Symptom: a read-only review worktree lacks `node_modules` and reports `ERR_MODULE_NOT_FOUND: Cannot find package 'mongoose'` -> mark focused tests unavailable, not failed, and do not present inherited implementation evidence as a fresh run. [Task 2]

# Task Group: Novari LMS F1 rejected exam-fetch normalization
scope: 2026-08-25 narrow LMS browser-fetch failure normalization and final read-only review.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-lms; reuse_rule=commit and baseline test/formatting state are checkout-specific; reuse only the local rejected-fetch boundary and start/review gates.

## Task 1: Normalize rejected browser fetches without changing resolved HTTP behavior

### rollout_summary_files

- rollout_summaries/2026-08-25T09-16-35-INGy-lms_exam_fetch_rejections_read_only_final_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-16-35-01a03835-0a12-7722-b79b-98b6a1cfc022.jsonl, updated_at=2026-08-25T09:20:39+00:00, thread_id=01a03835-0a12-7722-b79b-98b6a1cfc022, review clean; tests not run)
- rollout_summaries/2026-08-25T07-45-32-4TAJ-lms_f1_exam_fetch_rejections.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T09-45-32-01a037e1-aee1-7832-86a6-d0db9e9a39e1.jsonl, updated_at=2026-08-25T07:52:25+00:00, thread_id=01a037e1-aee1-7832-86a6-d0db9e9a39e1, fix pushed)
- rollout_summaries/2026-08-25T07-42-55-z9Q8-lms_f1_exam_fetch_start_gate_detached_head.md (cwd=/Users/mrbubbles/.codex/worktrees/2584/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T09-42-55-01a037df-4909-7b13-8a33-4150dbcda33c.jsonl, updated_at=2026-08-25T07:44:52+00:00, thread_id=01a037df-4909-7b13-8a33-4150dbcda33c, detached-head stop gate)

### keywords

- fetchExamResponse, TypeError Failed to fetch, BACKEND_UNAVAILABLE, parseExamJsonResponse, fetchExamAssignments, cde3f352, no retry

## User preferences

- the user required a narrow allowlist, no unrelated product change, no retry, no invented request ID, and unchanged component catches. [Task 1]

## Reusable knowledge

- Catch only rejected browser `fetch` promises at `fetchExamResponse`, throw static `{status:503, code:'BACKEND_UNAVAILABLE', message:'Backend ist gerade nicht erreichbar'}`, and leave fulfilled response parsing through `parseExamJsonResponse` unchanged. Apply it only to start/save/submit/results; leave `fetchExamAssignments` unchanged. [Task 1]

## Failures and how to do differently

- Keep pre-existing full-suite and repository-wide Prettier failures outside the exact candidate allowlist; final read-only review without dependencies must say tests were not run. [Task 1]

# Task Group: Novari Logging V2 F1 closure, blocker packages, and bounded completion coordination
scope: Late 2026-08-24 to 2026-08-25 Portal/Backend/LMS closure work: verify single error owners, treat final-scan findings as bounded repository packages, and stop after the already-created threads rather than expanding indefinitely.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal, /Users/mrbubbles/dev/novari/novari-education-backend, /Users/mrbubbles/dev/novari/novari-education-lms, and Novari coordination workflow; reuse_rule=paths, commits, and F1 status are checkout-specific; reuse the scope/freeze/error-projection procedure only after re-establishing current branch, baseline, and task state.

## Task 1: Close confirmed Portal F1 owners and plan the remaining blocker groups

### rollout_summary_files

- rollout_summaries/2026-08-25T00-20-12-L07d-novari_portal_logging_v2_f1_read_only_slice_plan.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T02-20-12-01a03649-f899-7643-bffb-c69470857d37.jsonl, updated_at=2026-08-25T00:33:05+00:00, thread_id=01a03649-f899-7643-bffb-c69470857d37, six confirmed blocker groups planned)
- rollout_summaries/2026-08-24T18-09-26-5xYj-novari_employment_exit_error_ownership_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T20-09-26-01a034f6-8587-7893-a0ac-3b55cfeedbb7.jsonl, updated_at=2026-08-24T18:15:05+00:00, thread_id=01a034f6-8587-7893-a0ac-3b55cfeedbb7, final review clean)
- rollout_summaries/2026-08-24T17-01-28-xhiF-exam_assignment_error_toast_ownership_fix.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-01-28-01a034b8-4bf3-7202-9e43-9ec85261a391.jsonl, updated_at=2026-08-24T17:20:22+00:00, thread_id=01a034b8-4bf3-7202-9e43-9ec85261a391, duplicate-toast fix)

### keywords

- Portal F1 blockers, EmploymentExit, certificate, exam assignment, Training Mutation, QM Promise-Toast, direct toast projection, root toast, swallowed PDF error

## Task 2: Validate LMS BFF/error projection, identify real blockers, and preserve freeze gates

### rollout_summary_files

- rollout_summaries/2026-08-24T17-43-24-NH0q-novari_lms_f1_frozen_bff_review_findings.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-43-24-01a034de-ae8b-70c1-99fb-2a88a2c302be.jsonl, updated_at=2026-08-24T17:52:54+00:00, thread_id=01a034de-ae8b-70c1-99fb-2a88a2c302be, four actionable issues)
- rollout_summaries/2026-08-24T17-10-33-JI9o-novari_lms_f1_final_error_logging_scout_findings.md (cwd=/Users/mrbubbles/dev/novari/novari-education-lms, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T19-10-33-01a034c0-9c08-7eb3-81c8-c24233bb702e.jsonl, updated_at=2026-08-24T17:15:18+00:00, thread_id=01a034c0-9c08-7eb3-81c8-c24233bb702e, six active findings)

### keywords

- LMS BFF, Sidebar, Topic/self-learning, safe error projection, AxiosError, freeze gate, canonical hash, browser network errors, technical error messages

## Task 3: Record Corr-5 transfer state and keep Corr-7 product-propagation cases explicit

### rollout_summary_files

- rollout_summaries/2026-08-25T23-40-45-bqLE-portal_corr_6_git_transfer_verification.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T01-40-45-01a03b4c-35f2-7f71-b775-6b100d5f9b8a.jsonl, updated_at=2026-08-25T23:49:15+00:00, thread_id=01a03b4c-35f2-7f71-b775-6b100d5f9b8a, Corr-6 transfer evidence; Corr-5/Corr-7 remain historical coordination context)

### keywords

- Portal-Corr-5, Portal-Corr-6, Portal-Corr-7, c92cd98b, a462f6bc, 4779cc5b, Resubmit Absence, Employment Exit, error propagation, corrective-slice integration

## User preferences

- when planning or implementing a slice, the user required an “exakte Produktions-Allowlist”, “genau ein Logging-/Response-Owner”, no adjacent cleanup, and real integration coverage rather than mocked behavior under review. [Task 1][Task 2]
- when requesting frozen/read-only review, the user required “keine Edits, Formatierungen, Tests, Commits, Staging oder Git-Mutationen”, a fresh independent repository-bound reviewer, and findings-first P0–P3 output. [Task 1][Task 2]

## Reusable knowledge

- Preserve one visible error owner. In Portal, scope `skipGlobalErrorToast`/MutationCache opt-outs to the confirmed request; in LMS, accept support detail only from a real validated Axios error. [Task 1][Task 2]
- Freeze gates remain a hard stop: verify exact branch/HEAD/upstream and the tracked/untracked allowlist twice with canonical NUL-based `NOVARI-FREEZE-V1`; a mismatch means no hunk review, tests, or findings until the candidate is re-established. [Task 1][Task 2]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: a review test mocks `apiClient`, projector, QueryClient, or handler being validated -> it can become tautological. Use the productive interceptor / QueryClient / handler and mock only transport/auth boundaries and final toast sinks. [Task 1][Task 2]
- Symptom: a final scan detects actual disclosure or reproducibly wrong user-visible error behavior -> do not declare F1 complete because earlier slices were clean; write a bounded allowlist and test plan for the coherent owner package. [Task 1][Task 2]

# Task Group: Novari Portal F1 risk, hardware, Request-ID, and Incident ownership completion
scope: 2026-08-23 Portal F1 producer-family delivery after the early wave: risk writes, hardware/PDF Blob boundaries, fail-closed Request-ID, and Incident lifecycle/report/archive/message paths.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=use the ownership/test/freeze patterns after verifying the current branch, baseline, allowlist, and explicit Go; commits and test counts are snapshot-specific.

## Task 1: Complete Risk measure/delete and non-GF Risk-write ownership

### rollout_summary_files

- rollout_summaries/2026-08-23T13-36-31-unmJ-f1_risk_measure_delete_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T15-36-31-01a02ed6-4c7d-7172-8c96-80c2aed1544d.jsonl, updated_at=2026-08-23T13:52:08+00:00, thread_id=01a02ed6-4c7d-7172-8c96-80c2aed1544d, deleteMeasure corrected and pushed)
- rollout_summaries/2026-08-23T13-56-37-cmky-f1_risk_write_error_ownership_implementation_and_push.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T15-56-37-01a02ee8-b3db-79c0-8975-ff5ff09dfc02.jsonl, updated_at=2026-08-23T14:12:43+00:00, thread_id=01a02ee8-b3db-79c0-8975-ff5ff09dfc02, six writes pushed)

### keywords

- deleteMeasure, useDeleteMeasure, riskService, useRisks, bodyless DELETE, skipGlobalErrorToast, mutateAsync, return-value identity, reopenRisk, NOVARI-FREEZE-V1

## Task 2: Harden auth replay, Hardware writes/PDF handling, and fail-closed Request-ID resolution

### rollout_summary_files

- rollout_summaries/2026-08-23T16-32-56-90s3-hardware_pdf_error_ownership_f1_slice.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T18-32-56-01a02f77-cf09-7e20-8175-fde259151fd3.jsonl, updated_at=2026-08-23T17:23:00+00:00, thread_id=01a02f77-cf09-7e20-8175-fde259151fd3, Blob ownership pushed)

### keywords

- auth refresh exclusions, URL method base-path, Hardware PDF, responseType: blob, no decode, X-Request-Id, malformed ID, mismatched ID, apiClient.authRetry.test.ts

## User preferences

- when the user required exact body/transport arity, original result/error identity, success invalidation, and `retry: 0` -> preserve those contracts while replacing a duplicated toast owner. [Task 1][Task 2]
- when reviewing frozen work, the user required a fresh independent reviewer and “Stop mismatch” -> verify baseline/branch/upstream/allowlist/hash before hunks; separate inherited test evidence from checks prohibited in read-only mode. [Task 1][Task 2]

## Reusable knowledge

- A bodyless DELETE remains `apiClient.delete(url, { skipGlobalErrorToast: true })`; a bodyless POST needing config remains `post(url, undefined, config)`. Hooks must return the original service result from `mutateAsync`, dismiss loading in `finally`, rethrow the same error, and invalidate only on success. [Task 1]
- Request-local suppression preserves actual Axios 401 refresh/replay. Exact URL/method/base-path matching is required for auth-replay exclusions; substring exclusions are unsafe. [Task 2]
- Blob/PDF handling is an opacity boundary: do not decode Blob bodies, change cleanup/MIME/filename/abort behavior, or merge product/download contracts into a toast-owner fix. Invalid or conflicting request IDs fail closed and must not remain copyable. [Task 2]

## Failures and how to do differently

- Symptom: a replacement mutation returns `undefined` after a successful service call -> assert result identity and return the service result; removing `showPromiseToast` must not alter `mutateAsync` semantics. [Task 1]
- Symptom: the full suite turns red after a fail-closed Request-ID correction -> classify stale ID expectations/fixtures before widening production scope; update only authorized contract tests. [Task 2]
- Symptom: tests assert config but not the real visible error path -> use real hook/service/interceptor/QueryClient integration coverage and mock only transport/auth and final sinks. [Task 1][Task 2]

# Task Group: Novari Portal F1 late-wave error ownership, request-ID safety, and onboarding PDF retry
scope: Fresh 2026-08-23 Portal Logging V2 work after the initial producer wave: error-owner fixes, delete flows, risk/onboarding boundaries, and observed incident/request-ID coordination.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=verify the current Spec, branch, baseline, candidate, allowlist, and explicit Go; commit/hash/status claims are snapshot-specific.

## Task 1: Deliver Help Topic, Training, Course, and Quarterly Report DELETE single-owner paths

### rollout_summary_files

- rollout_summaries/2026-08-23T13-16-14-76iM-f1_quartalsbericht_delete_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T15-16-14-01a02ec3-bc2c-7fa0-a054-41644146880c.jsonl, updated_at=2026-08-23T13:31:05+00:00, thread_id=01a02ec3-bc2c-7fa0-a054-41644146880c, shipped)

### keywords

- Help Topics DELETE, Training DELETE, ClassManager course DELETE, Quartalsbericht DELETE, undefined body, skipGlobalErrorToast, formatting hunk, NOVARI-FREEZE-V1

## Task 2: Ship GF effectiveness and Risk snapshot/Dossier POST ownership; leave Blob preview unchanged

### rollout_summary_files

- rollout_summaries/2026-08-23T14-17-32-JOHR-gf_effectiveness_error_ownership_fix.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T16-17-32-01a02efb-da47-7cc2-8406-844174e8873f.jsonl, updated_at=2026-08-23T14:28:30+00:00, thread_id=01a02efb-da47-7cc2-8406-844174e8873f, shipped)
- rollout_summaries/2026-08-23T14-43-31-BTUh-risk_snapshot_post_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T16-43-31-01a02f13-a4f0-7ee1-b928-aa5fd851bca5.jsonl, updated_at=2026-08-23T14:50:57+00:00, thread_id=01a02f13-a4f0-7ee1-b928-aa5fd851bca5, review clean)
- rollout_summaries/2026-08-23T14-55-29-s4JM-risk_dossier_pdf_error_ownership_f1.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T16-55-29-01a02f1e-9732-7801-9890-10786f5f3226.jsonl, updated_at=2026-08-23T15:08:29+00:00, thread_id=01a02f1e-9732-7801-9890-10786f5f3226, shipped)
- rollout_summaries/2026-08-23T15-08-43-cets-risk_dossier_pdf_preview_blob_no_change_decision.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T17-08-43-01a02f2a-b5db-7d33-a030-a82efeb5070a.jsonl, updated_at=2026-08-23T15:15:13+00:00, thread_id=01a02f2a-b5db-7d33-a030-a82efeb5070a, documented no-change)

### keywords

- GF effectiveness, risk snapshot, generateRiskDossierPdf, responseType: blob, DocumentPreviewModal, runRiskMutationWithToast, AbortController

## Task 3: Fix the Onboarding-PDF retry storm and retain the prior review findings

### rollout_summary_files

- rollout_summaries/2026-08-23T23-14-01-DXKz-novari_f1_onboarding_pdf_freeze_review_findings.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T01-14-01-01a030e7-0302-7511-8d35-6137c960433b.jsonl, updated_at=2026-08-23T23:18:15+00:00, thread_id=01a030e7-0302-7511-8d35-6137c960433b, P1/P2 findings)
- rollout_summaries/2026-08-23T22-59-17-vE9I-onboarding_pdf_retry_storm_fix_and_safe_error_owner.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T00-59-17-01a030d9-88ad-7450-b248-a9c6a362da92.jsonl, updated_at=2026-08-23T23:32:05+00:00, thread_id=01a030d9-88ad-7450-b248-a9c6a362da92, corrected, reviewed, committed, and pushed)

### keywords

- OnboardingWidget, useMyOnboarding, QueryClient claim, StrictMode, retry: 0, extractBackendErrorDetails, Request-ID, 401 replay, 503, 99a8b7b4

## User preferences

- when approving these slices, the user repeatedly required an “exakte Allowlist”, fail-closed start/freeze gates, “keine breite Formatierung”, and no commit before review -> keep the requested product and file boundary intact; do not repair neighbouring problems opportunistically. [Task 1][Task 2][Task 4][Task 5]
- when requesting a read-only review, the user required a “frischen repositorygebundenen unabhängigen Reviewer”, “keine Spekulation”, findings-first P0-P3 output, and no tests or mutations -> do not substitute handoff claims for independent inspection. [Task 2][Task 5]
- when a slice is frozen, the user required “keine weiteren Edits oder Tests” -> finish validation before freezing and treat any mismatch as a new-candidate/re-review boundary. [Task 2][Task 3][Task 4]

## Reusable knowledge

- One visible owner remains the F1 contract: use request-local `skipGlobalErrorToast` only for the confirmed request, preserve `undefined` body/transport arity and success ordering, and retain the existing local hook or MutationCache owner. [Task 1][Task 2][Task 4]
- `handleApiCall` resolving `null` after a displayed error is unsafe for mutation callers that need rejection semantics: rethrow the original error so upload/submit/resubmit cannot clear state, refetch, or show success after a failed request. [Task 1]
- Do not infer DELETE scope by verb or service name. Inventory reachable promise-returning flows, then split Help Topic, Training, Course, Quarterly Report, no-body, blob/download, dead-code, and unrelated paths before implementation. [Task 2]
- For `ClosingReportStudentDialog` TS2352 test-only corrections, explicit `vi.hoisted` stubs are safer than unsafe `ReturnType` casts; a freeze mismatch still stops substantive review even on a one-file test diff. [Task 3]
- Risk Dossier generation is a bodyless POST and `runRiskMutationWithToast` is the established local-owner pattern. Keep the POST separate from preview GET: `responseType: 'blob'` makes JSON errors a Blob, and changing shared `DocumentPreviewModal` (16 consumers) needs a separate product/architecture decision. Abort remains silent. [Task 4]
- A QueryClient-bound synchronous claim keyed by `userID + role + contractStartDate` deduplicates StrictMode/remount/parallel widgets. Keep it after final failure; release it only on confirmed nonqualifying state. Test real QueryClient/interceptor behavior, reset tests after a real claim, and fix time-dependent fixtures with deterministic system time. [Task 5]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 5]

## Failures and how to do differently

- Symptom: a formatting-only hunk appears in a frozen functional slice -> record the P2 scope finding, remove it, then re-freeze and use a fresh reviewer; do not normalize it into the producer fix. [Task 2]
- Symptom: a fully mocked hook, helper, cache invalidation, or transport test seems green -> it may be tautological. Keep the real Axios response interceptor, support projector, hook/QueryClient, and local handler; mock only transport/auth boundary and final toast sink. [Task 4][Task 5]
- Symptom: a fail-closed projection suppresses an incomplete envelope and also loses an independently valid Request-ID -> preserve a safely validated reference with a persistent static `showBackendErrorToast`; otherwise use the normal generic error. Conflicting/malformed IDs must not remain copyable. [Task 5]
- Symptom: a retry is set to `0` but POSTs repeat after final failure -> guard the React effect with a synchronous cache-bound claim; auth 401 replay remains part of one logical attempt and must not unlock a new attempt. [Task 5]

# Task Group: Novari Portal F1 producer error-toast ownership completion wave
scope: Fresh 2026-08-22/23 Portal Logging V2 F1 HR, Teaching/QM, Classbook, Attendance, Content Releases, and GitHub Classroom slices; use to route a related producer to its exact ownership/review pattern.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=verify current Spec, baseline, candidate, allowlist, and explicit Go; progress and hashes are snapshot-specific.

## Task 1: Complete HR/personnel and employee-signup ownership slices

### rollout_summary_files

- rollout_summaries/2026-08-22T23-02-54-8rhv-novari_portal_hr_personnel_logging_v2_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T01-02-54-01a02bb6-7cd5-7461-94f3-aa35b125f5f9.jsonl, updated_at=2026-08-22T23:48:02+00:00, thread_id=01a02bb6-7cd5-7461-94f3-aa35b125f5f9, three bounded plans)
- rollout_summaries/2026-08-22T23-48-22-Nzus-novari_employee_signup_mutationcache_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T01-48-22-01a02be0-1c05-77d2-81ab-2c244aafaba4.jsonl, updated_at=2026-08-23T00:05:03+00:00, thread_id=01a02be0-1c05-77d2-81ab-2c244aafaba4, shipped)

### keywords

- HR Pending Changes, employee update/archive, /signup, loginClient, Production MutationCache, skipGlobalErrorToast, NOVARI-FREEZE-V1

## Task 2: Deliver Teaching-history and QM JSON-write ownership

### rollout_summary_files

- rollout_summaries/2026-08-23T00-14-17-AkEX-teaching_history_hidrive_export_toast_deduplication.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T02-14-17-01a02bf7-d527-7770-a097-758b7d94b9fb.jsonl, updated_at=2026-08-23T00:28:14+00:00, thread_id=01a02bf7-d527-7770-a097-758b7d94b9fb, shipped)
- rollout_summaries/2026-08-23T00-34-00-clNu-portal_f1_qm_corrective_measures_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T02-34-00-01a02c09-e156-7b31-b805-8ba3f09df400.jsonl, updated_at=2026-08-23T01:01:31+00:00, thread_id=01a02c09-e156-7b31-b805-8ba3f09df400, nine writes and P2 test correction)
- rollout_summaries/2026-08-23T01-09-39-uW15-qm_auditwerte_f1_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T03-09-39-01a02c2a-8576-7451-b2f3-2e17fc54a21b.jsonl, updated_at=2026-08-23T01:26:57+00:00, thread_id=01a02c2a-8576-7451-b2f3-2e17fc54a21b, shipped)

### keywords

- Teaching-History HiDrive Export, QM Corrective Measures, QM-Auditwerte, no-body, two-step ordering, request-local Axios opt-out, test matrix

## Task 3: Resolve Attendance POST ownership and validate the canonical freeze

### rollout_summary_files

- rollout_summaries/2026-08-23T02-59-21-x2yL-attendance_f1_read_only_allowlist_scout.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T04-59-21-01a02c8e-f4a8-7be2-9d5f-7654c94716ab.jsonl, updated_at=2026-08-23T03:01:27+00:00, thread_id=01a02c8e-f4a8-7be2-9d5f-7654c94716ab, plan only)
- rollout_summaries/2026-08-23T03-01-56-s3vH-novari_standard_attendance_post_error_ownership_f1.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T05-01-56-01a02c91-51f7-76f3-9054-079689cb3199.jsonl, updated_at=2026-08-23T04:29:00+00:00, thread_id=01a02c91-51f7-76f3-9054-079689cb3199, shipped)
- rollout_summaries/2026-08-23T03-30-29-3AD4-novari_freeze_v1_hash_audit.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T05-30-29-01a02cab-7674-7a51-afcf-b9f737899ade.jsonl, updated_at=2026-08-23T03:32:59+00:00, thread_id=01a02cab-7674-7a51-afcf-b9f737899ade, canonical audit passed)
- rollout_summaries/2026-08-23T03-35-47-WVgN-novari_logging_v2_f1_attendance_post_final_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T05-35-47-01a02cb0-50f0-7c30-b8fb-974699346af5.jsonl, updated_at=2026-08-23T03:38:04+00:00, thread_id=01a02cb0-50f0-7c30-b8fb-974699346af5, final review)

### keywords

- Standard-Anwesenheit POST, `git diff --binary --full-index`, NOVARI-FREEZE-V1, real central support projection, final toast sink, tautological mock

## Task 4: Ship Content Releases and retain GitHub Classroom review/test boundaries

### rollout_summary_files

- rollout_summaries/2026-08-23T04-33-35-Tf3k-github_classroom_assignment_write_toast_owner_plan.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-33-35-01a02ce5-3c06-7393-b6d4-b8f505303da2.jsonl, updated_at=2026-08-23T04:36:25+00:00, thread_id=01a02ce5-3c06-7393-b6d4-b8f505303da2, two-write plan)
- rollout_summaries/2026-08-23T04-51-12-h8fH-github_classroom_assignment_read_only_review_no_findings.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-51-12-01a02cf5-5c82-7c81-895f-006b2eec29b5.jsonl, updated_at=2026-08-23T04:53:35+00:00, thread_id=01a02cf5-5c82-7c81-895f-006b2eec29b5, re-review clean)

### keywords

- Content-Releases, GitHub Classroom assignment, freeze mismatch, P2 test gap, two active writes, Axios config shape

## Task 5: Complete GitHub Classroom, PDL feedback/tag, and labor-market ownership

### rollout_summary_files

- rollout_summaries/2026-08-23T04-53-49-stdM-github_classroom_assignments_read_only_final_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T06-53-49-01a02cf7-c0b4-7203-9237-aa599702bc9a.jsonl, updated_at=2026-08-23T04:56:32+00:00, thread_id=01a02cf7-c0b4-7203-9237-aa599702bc9a, aligned)
- rollout_summaries/2026-08-23T05-17-45-k98g-novari_f1_pdl_labor_market_analysis_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T07-17-45-01a02d0d-ac1f-7092-838f-1fa92ef71fd4.jsonl, updated_at=2026-08-23T05:31:52+00:00, thread_id=01a02d0d-ac1f-7092-838f-1fa92ef71fd4, shipped)

### keywords

- githubClassroomAssignmentService.ts, PDL content-feedback tags, Arbeitsmarktanalyse, Axios argument 3, header-only x-request-id, MutationCache

## Task 6: Finish student-entry and absence approve/reject single-owner handling

### rollout_summary_files

- rollout_summaries/2026-08-23T09-27-49-AlB3-portal_logging_v2_f1_student_entry_error_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T11-27-50-01a02df2-9deb-7f81-9e12-78966952fe9d.jsonl, updated_at=2026-08-23T09:38:30+00:00, thread_id=01a02df2-9deb-7f81-9e12-78966952fe9d, shipped)
- rollout_summaries/2026-08-23T09-56-40-Tdt5-portal_logging_v2_f1_absence_single_owner.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T11-56-40-01a02e0d-0412-77b1-8f15-f58e4ba5aad7.jsonl, updated_at=2026-08-23T10:07:11+00:00, thread_id=01a02e0d-0412-77b1-8f15-f58e4ba5aad7, shipped)

### keywords

- Class Manager student-entry, useStudents dead code, approve absence, reject vacation, mutation meta, createTestQueryClient, zod mock baseline

## User preferences

- when planning or reviewing a Logging V2 slice, the user repeatedly required the “smallest coherent reviewable slice”, an exact allowlist, explicit unchanged flows, and no implicit Go -> fail closed rather than widening a producer family. [Task 1][Task 3][Task 4]
- when a candidate is frozen, the user required “keine weiteren Edits, Formatierungen oder Tests” before independent full-diff review -> treat the canonical candidate hash as a hard start gate. [Task 2][Task 4][Task 5]
- when a review is explicitly read-only, the user repeatedly required “Findings first or none” and prohibited tests, edits, formatter, fetch, commit, and push -> separate inspected static evidence from unrun runtime checks. [Task 6][Task 7][Task 10]

## Reusable knowledge

- The recurring runtime contract is one visible error-toast owner: use request-local Axios suppression only for the confirmed request and retain existing local hook/MutationCache ownership, response bodies, success paths, invalidation, retries, and transport arity. `loginClient` is not a generic Axios-interceptor path. [Task 1][Task 2][Task 3]
- Keep producer boundaries real: Teacher-Classbook manual PUT, Auto-POST, and manual POST are separate decisions; the same applies to the narrower Standard-Anwesenheit POST and the two GitHub Classroom writes. [Task 3][Task 4][Task 5]
- Test the real central support projection/interceptor behavior and mock only the final toast sink. A fully mocked `apiClient` or helper makes duplicate-toast coverage tautological and cannot prove global 5xx suppression. [Task 2][Task 4][Task 5]
- Active-path inventory is a gate: exclude no-body, dead-code, blob/download, or unreachable writers rather than importing them solely by API-name similarity. Use production `queryClient`, not `createTestQueryClient()`, when proving MutationCache ownership. [Task 6][Task 8][Task 10]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 4]

## Failures and how to do differently

- Symptom: a frozen-candidate hash differs -> stop before hunks, tests, or findings. Recreate the project-defined tracked/untracked serialization; `git diff --binary --full-index` is necessary for the tracked form but may not cover untracked bytes. [Task 4][Task 5]
- Symptom: an apparent duplicate owner is inferred from call-site overlap -> trace early returns, request config, interceptor, local handler, and visible toast count before changing code. [Task 1][Task 3]
- Symptom: review finds a P2 test gap or a freeze mismatch -> correct the test/obtain the exact candidate, then perform a fresh independent re-review; do not call the original review runtime-verified when its no-test boundary held. [Task 6][Task 7][Task 9]

# Task Group: Novari Portal Logging V2 F1 delivery progress and security-scan gates
scope: Portal F1a–F1x and later producer-owner slice progression on `chore/logging-improvements`; use for continuity and gates, never as authority to edit a current candidate.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=verify current branch, baseline, candidate, allowlist, and separate Go; progress/status is time-specific.

## Task 1: Implement and independently re-review central F1a support information

### rollout_summary_files

- rollout_summaries/2026-08-21T10-03-26-0Dbr-novari_portal_f1a_support_information_commit_push.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T12-03-26-01a023c6-8073-78c1-a467-0706b1eb0901.jsonl, updated_at=2026-08-21T11:06:50+00:00, thread_id=01a023c6-8073-78c1-a467-0706b1eb0901, implemented/pushed)
- rollout_summaries/2026-08-21T10-19-41-6fvV-novari_portal_f1a_final_rereview.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T12-19-41-01a023d5-5edd-7b71-8efc-49f3995655a7.jsonl, updated_at=2026-08-21T11:05:19+00:00, thread_id=01a023d5-5edd-7b71-8efc-49f3995655a7, zero-findings final review)

### keywords

- F1a, extractBackendSupportInformation, AxiosError, data.error, actionHint, hostile arrays, Security Diff Scan

## Task 2: Deliver Attendance-interventions F1b and preserve its formal scan gate

### rollout_summary_files

- rollout_summaries/2026-08-21T11-23-47-VfLj-portal_f1b_attendance_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T13-23-47-01a02410-0e93-7ae0-87ac-eda76fc94dc9.jsonl, updated_at=2026-08-21T11:55:21+00:00, thread_id=01a02410-0e93-7ae0-87ac-eda76fc94dc9, implemented/pushed)
- rollout_summaries/2026-08-21T11-09-04-15P7-novari_f1b_attendance_support_information_scout.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T13-09-04-01a02402-975a-7a90-a2e2-6afbc70ff88d.jsonl, updated_at=2026-08-21T11:15:16+00:00, thread_id=01a02402-975a-7a90-a2e2-6afbc70ff88d, read-only scout)

### keywords

- F1b, useAttendanceInterventions, showAttendanceWriteError, 133/133, 3.871/3.871, exact three-argument call, Working-tree contents changed after they were selected.

## Task 3: Deliver F1c feedback-question support information

### rollout_summary_files

- rollout_summaries/2026-08-21T12-12-24-mRVR-portal_f1c_feedback_question_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T14-12-24-01a0243c-93ab-7223-912b-1135b31d5fd7.jsonl, updated_at=2026-08-21T12:39:06+00:00, thread_id=01a0243c-93ab-7223-912b-1135b31d5fd7, implemented/pushed)

### keywords

- F1c, useFeedbackQuestions, showQuestionMutationError, skipGlobalErrorToast, publish, §2.2 Fall 6

## Task 4: Deliver F1d curriculum-review submit support information

### rollout_summary_files

- rollout_summaries/2026-08-21T13-11-40-bo2R-portal_f1d_curriculum_pruefung_supportinformation.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T15-11-40-01a02472-d390-7213-9598-72f2f6c4bb39.jsonl, updated_at=2026-08-21T13:32:42+00:00, thread_id=01a02472-d390-7213-9598-72f2f6c4bb39, implemented/pushed)
- rollout_summaries/2026-08-21T13-03-13-yvYD-portal_f1d_curriculum_review_plan_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T15-03-13-01a0246b-18dd-7493-83d2-0111d21b23fb.jsonl, updated_at=2026-08-21T13:07:31+00:00, thread_id=01a0246b-18dd-7493-83d2-0111d21b23fb, read-only plan review)

### keywords

- F1d, Curriculum-Prüfung, useCurriculumWorkRevision, security scan retry, six-file allowlist

## Task 5: Deliver F1e labor-market review support information

### rollout_summary_files

- rollout_summaries/2026-08-21T14-08-44-l5th-novari_portal_f1e_gf_labor_market_review_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T16-08-44-01a024a7-1348-72e3-93f0-50fe3fb67503.jsonl, updated_at=2026-08-21T14:23:30+00:00, thread_id=01a024a7-1348-72e3-93f0-50fe3fb67503, implemented/pushed)
- rollout_summaries/2026-08-21T14-17-50-2W50-novari_portal_f1e_independent_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T16-17-50-01a024af-6967-7530-88ce-cdfc6f03c5ee.jsonl, updated_at=2026-08-21T14:21:55+00:00, thread_id=01a024af-6967-7530-88ce-cdfc6f03c5ee, independent review)

### keywords

- F1e, labor-market review, support information, independent read-only review

## Task 6: Deliver and review F1h stored Curriculum Draft export support information

### rollout_summary_files

- rollout_summaries/2026-08-21T16-02-10-y9Mu-novari_portal_f1h_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T18-02-10-01a0250e-ec39-78f0-95cb-afc6e81e9042.jsonl, updated_at=2026-08-21T16:05:41+00:00, thread_id=01a0250e-ec39-78f0-95cb-afc6e81e9042, zero-findings review)

### keywords

- F1h, CurriculumStoredDraftExportAction.tsx, Curriculum-Entwurfsexport, 4c794d3a9efd26814b91587213f700d518beb9d4, 16/16

## Task 7: Ship F1i–F1n producer-specific Portal support information

### rollout_summary_files

- rollout_summaries/2026-08-21T19-24-09-yoal-novari_f1n_path_migration_preview_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T21-24-09-01a025c7-daf6-7cb3-8cb4-21c0a0c86b31.jsonl, updated_at=2026-08-21T19:39:11+00:00, thread_id=01a025c7-daf6-7cb3-8cb4-21c0a0c86b31, implemented/pushed)
- rollout_summaries/2026-08-21T18-39-48-CGFu-novari_portal_f1m_github_topic_update_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T20-39-48-01a0259f-401d-7171-bf6d-6368e58aa1c4.jsonl, updated_at=2026-08-21T19:01:49+00:00, thread_id=01a0259f-401d-7171-bf6d-6368e58aa1c4, implemented/pushed)

### keywords

- F1i, F1j, F1k, F1l, F1m, F1n, extractBackendSupportInformation, conditional spread, skipGlobalErrorToast, Axios response.data.error, exact toast arity, chore/logging-improvements

## Task 8: Review the next coherent F1s GitHub-Topic draft-preparation slice

### rollout_summary_files

- rollout_summaries/2026-08-22T02-54-06-OGgd-portal_f1s_read_only_plan_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-54-06-01a02763-cb34-79c2-bf27-3426f6722875.jsonl, updated_at=2026-08-22T03:00:47+00:00, thread_id=01a02763-cb34-79c2-bf27-3426f6722875, corrected plan; repository unchanged)
- rollout_summaries/2026-08-22T02-44-30-fR1H-novari_portal_f1s_github_topic_draft_support_scout.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-44-30-01a0275b-0053-7973-88a7-8b5a44ec3da5.jsonl, updated_at=2026-08-22T02:51:36+00:00, thread_id=01a0275b-0053-7973-88a7-8b5a44ec3da5, read-only scout)

### keywords

- F1s, Als Entwurf übernehmen, getTopicById, createGithubCurriculumTopicChangeAdoptionClaim, locallyHandledErrorConfig, skipGlobalErrorToast, handler-local union variable, apiClient auth replay

## Task 9: Deliver F1o–F1r and preserve their distinct toast-ownership contracts

### rollout_summary_files

- rollout_summaries/2026-08-22T02-28-28-R3es-novari_portal_logging_v2_f1r_read_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-28-28-01a0274c-51eb-7a71-87c5-49af5efe1c94.jsonl, updated_at=2026-08-22T02:44:17+00:00, implemented/pushed)
- rollout_summaries/2026-08-22T02-38-05-QFB0-novari_f1r_read_only_full_diff_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-38-05-01a02755-1ede-7da0-b0d9-144e628299ea.jsonl, updated_at=2026-08-22T02:42:46+00:00, independent full-diff review)
- rollout_summaries/2026-08-21T23-34-11-vTFI-novari_portal_f1q_review_decision_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T01-34-11-01a026ac-c482-7470-88da-d6c4104e711e.jsonl, updated_at=2026-08-21T23:48:53+00:00, implemented/pushed)
- rollout_summaries/2026-08-21T23-03-28-ognT-portal_f1p_curriculum_target_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T01-03-28-01a02690-a510-77a3-adc5-3d0c7ba5e609.jsonl, updated_at=2026-08-21T23:19:51+00:00, implemented/pushed)
- rollout_summaries/2026-08-21T21-29-49-2Flq-f1o_topic_write_support_information.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T23-29-49-01a0263a-e789-7691-ad8a-6e34a59dde84.jsonl, updated_at=2026-08-21T22:16:25+00:00, implemented/pushed)

### keywords

- F1o, F1p, F1q, F1r, extractBackendSupportInformation, skipGlobalErrorToast, handledLocally, locallyHandledErrorConfig, GitHub-Topic-Entwurfsziel, GitHub-Topic-Reviewentscheidung, GitHub-Pfadmigrationsstatus, --full-index

## Task 10: Stop F1x on review findings, plan the minimal claim-module split, and enforce the freeze gate

### rollout_summary_files

- rollout_summaries/2026-08-22T17-02-36-5kcY-novari_f1x_final_review_freeze_mismatch.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T19-02-36-01a02a6c-9d89-7553-abb3-7308405e9adc.jsonl, updated_at=2026-08-22T17:05:24+00:00, thread_id=01a02a6c-9d89-7553-abb3-7308405e9adc, stopped: freeze hash mismatch)

### keywords

- F1x, freeze hash mismatch, useGithubCurriculumImportClaim.ts, inspectClaimError, header-only request ID, mutateAsync(), onSuccess, 1169 to 1309 lines, exact nine allowlisted paths

## Task 11: Deliver Curriculum lifecycle and structure mutation ownership

### rollout_summary_files

- rollout_summaries/2026-08-22T19-52-02-b2IO-portal_f1_curriculum_structure_toast_ownership.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T21-52-02-01a02b07-bb91-7f92-b728-ca10219ffbea.jsonl, updated_at=2026-08-22T20:08:47+00:00, thread_id=01a02b07-bb91-7f92-b728-ca10219ffbea, seven structure writes delivered)
- rollout_summaries/2026-08-22T20-02-09-DUZD-portal_f1_curriculum_structure_read_only_final_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T22-02-09-01a02b11-0025-7ee1-a3ad-58a50b22cc55.jsonl, updated_at=2026-08-22T20:07:39+00:00, thread_id=01a02b11-0025-7ee1-a3ad-58a50b22cc55, clean final review)

### keywords

- useLmsCurriculum, useLmsCurriculumCertification, useLmsModules, handledLocally, MutationCache, CAS, delete transport, seven writes, nine-file scope

## Task 12: Plan Recruiting and Lead Process as separate owner boundaries

### rollout_summary_files

- rollout_summaries/2026-08-22T21-17-36-ju6u-portal_logging_v2_f1_recruiting_lead_process_read_only_plans.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T23-17-36-01a02b56-1440-7db1-aa80-6e3b667143b2.jsonl, updated_at=2026-08-22T21:54:44+00:00, thread_id=01a02b56-1440-7db1-aa80-6e3b667143b2, separate plans)

### keywords

- Recruiting, Lead Process, direct try/catch, MutationCache, multipart, no-body contracts, eight writes, ten writes

## Task 13: Deliver Training Participant ownership and retain Profile/Account review evidence

### rollout_summary_files

- rollout_summaries/2026-08-22T22-22-15-MT6K-f1_training_participant_error_toast_deduplication.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T00-22-15-01a02b91-4357-7e33-a491-bece0c24e2ce.jsonl, updated_at=2026-08-22T22:36:43+00:00, thread_id=01a02b91-4357-7e33-a491-bece0c24e2ce, training-participant slice shipped)
- rollout_summaries/2026-08-22T22-56-25-7BbA-portal_f1_own_profile_account_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T00-56-25-01a02bb0-8a58-73c1-b678-aa5bfb1e4cfa.jsonl, updated_at=2026-08-22T23:01:21+00:00, thread_id=01a02bb0-8a58-73c1-b678-aa5bfb1e4cfa, canonical freeze review clean)

### keywords

- Fortbildungs-Teilnehmer, useProfile, profileApi, Security PIN, DELETE arity, loginClient, 3756df80, NOVARI-FREEZE-V1

## Task 14: Fail-close then re-review HR Pending Changes

### rollout_summary_files

- rollout_summaries/2026-08-22T23-23-52-CG6O-novari_f1_hr_pending_changes_read_only_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T01-23-52-01a02bc9-adcf-7cb1-8f30-81943f14f58e.jsonl, updated_at=2026-08-22T23:27:31+00:00, thread_id=01a02bc9-adcf-7cb1-8f30-81943f14f58e, freeze reproduced and no findings)

### keywords

- HR Pending Changes, pendingChangeApi, NOVARI-FREEZE-V1, zsh path variable, freeze_file, freeze_size, skipGlobalErrorToast

## User preferences

- when a Logging V2 slice is planned or reviewed, the user repeatedly required “kleinsten” coherent scope, an exact file allowlist, findings-first delivery, explicit unchanged flows, and no implicit Go -> fail closed on scope/authorization drift. [Task 1][Task 2][Task 3]
- when a candidate is frozen, the user required “keine weiteren Edits, Formatierungen oder Tests” and an independent actual-diff review before commit/push -> separate implementation, review/security, and closeout phases. [Task 1][Task 8]
- when the fallback has no valid support information, the user required “vierter Parameter nur bedingt, nie undefined” -> retain the exact legacy three-argument toast call. [Task 2][Task 8]
- when an F1 plan is explicitly read-only, the user required a “vollständig frischer repositorygebundener READ-ONLY-Plan-Reviewer”, findings-first, and no delegation -> do not edit, test, format, fetch, mutate Git, or spawn subagents unless separately allowed. [Task 11]
- when existing test files need mechanical updates within an approved slice, the user allowed it without a separate Go only when the production and test scope do not expand -> keep the allowlist and report the boundary explicitly. [Task 16]

## Reusable knowledge

- F1a’s central projector accepts only a genuine `AxiosError` with own-data `isAxiosError === true`, validates the nested envelope fail-closed, rejects array header containers before inspection, and never projects `actionHint`, raw/contextual data, URLs, queries, or full JSON. [Task 1]
- Producer slices reuse that projector only after the existing error-owner/early-return boundary. Runtime/API payloads, retry, invalidation, success behavior, roles, and unrelated direct callers remain unchanged; F2/LMS requires separate authorization. [Task 2][Task 3][Task 8]
- F1h was committed/pushed as `4c794d3a9efd26814b91587213f700d518beb9d4` after a four-file candidate and a zero-findings read-only review. The review did not rerun the full suite; two unrelated Autosave timing flakes stayed explicit implementer evidence. [Task 8]
- F1i–F1n kept the contract producer-specific: support information is projected only for the confirmed Axios request after the relevant operation marker/owner boundary, via `...(supportInformation ? [supportInformation] : [])`; local, malformed, GET, cleanup, and post-success failures retain their existing two- or three-argument call. [Task 10]
- F1s was delivered and independently reviewed cleanly: Topic GET plus adoption claim share a handler-local phase; set it immediately before each request and clear it only after a successful await. Preserve default `getTopicById` behavior and use `post(url, undefined, locallyHandledErrorConfig)` for the claim. [Task 11][Task 15]
- F1o, F1p, F1q, and F1r were delivered as distinct contracts: F1p makes the final Curriculum target GET locally owned through explicit `handledLocally`; F1q suppresses the global interceptor only for the review-decision PATCH; F1r keeps the two quiet/retry-free path-migration GETs locally owned with separate dedupe refs. Keep `skipGlobalErrorToast` request-local and preserve query/cache/polling/action behavior. [Task 13]
- Canonical frozen-diff hashing is `git diff --binary --full-index <baseline> | shasum -a 256`; omitting `--full-index` changes abbreviated `index` headers and yields a different hash without content drift. [Task 13]
- F1t was delivered only after the independent review’s P2 test-quality issue was corrected: exercise the real upload response/manifest validation rather than an impossible fixture. F1w avoids growing already oversized LMS hook/test/service files: general import calls the claim service directly, leaves Topic Editor default ownership unchanged, and keeps claim 409 with the existing inline alert. [Task 15][Task 16]
- F1x is not reviewable or commit-ready: successive reviews found callback exceptions can turn an already-successful service response into `mutateAsync` failure, unsafe/unbounded claim projection, loss of header-only request-ID fallback, and an unauthorized oversized `useGithubCurriculumRepositories.ts` growth. The focused ninth path is `src/hooks/lms/useGithubCurriculumImportClaim.ts` with aggregate-module re-export, but the latest final review stopped before hunk inspection because its freeze hash did not match. Recreate the exact frozen candidate before any verdict. [Task 17]
- Curriculum structure mutations remain a separate contract: preserve `handledLocally`, CAS/delete transport, existing MutationCache metadata and success behavior; the retained review covers exactly seven service writes. [Task 21]
- Training Participant and the retained Profile/Account review preserve transport-specific contracts: keep PATCH/POST three-argument and bodyless DELETE two-argument calls; `/logout-all` uses `loginClient` (no generic Axios interceptor) and is not a reason to apply a broad opt-out. [Task 24]
- Canonical freeze of tracked plus untracked candidates must serialize the tracked `git diff --binary --full-index --no-ext-diff`, then sorted untracked raw bytes with explicit path, decimal byte count, NUL delimiters. For zsh scripts never assign the reserved `path`; use `freeze_file` and `freeze_size`. [Task 24][Task 25]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 9]

## Failures and how to do differently

- Symptom: `Working-tree contents changed after they were selected.` before a scan ID -> on a one-attempt read-only task, do not rerun, use an alternate scanner, or claim findings/coverage; report the gate as unproven and preserve the snapshot. [Task 2][Task 4]
- Symptom: full suite/lint reports timing flakes or failures in unchanged files -> isolate the failure and compare the file/path with baseline; report it as unverified baseline/flake evidence, never repair unrelated code to make the slice green. [Task 1][Task 8]
- Symptom: a shared `useRef` phase looks convenient for serial requests -> it is race/stale-prone across overlapping actions; use a handler-local union variable and do not clear it in `finally`, so a rejected request retains its correct area. [Task 11]
- Symptom: a one-file local toast addition duplicates a global interceptor/retry owner -> trace the whole Axios/Query ownership chain first. F1p required an explicit request-local `skipGlobalErrorToast` opt-in; do not solve it by changing the shared key, retry policy, or unrelated consumers. [Task 13]
- Symptom: an F1x freeze hash differs from the specified snapshot -> stop before reading hunks, running tests, or giving findings. A handoff/test claim never substitutes for the exact frozen diff; recreate it with the project-defined tracked/untracked serialization first. [Task 17]
- Symptom: a frozen candidate hash differs -> do not inspect hunks, run tests, or issue a code verdict. Reconstruct the exact canonical serialization; never rely on a handoff/test claim instead of the expected raw-byte hash. [Task 24][Task 25]

# Task Group: Novari Portal F1a central error-support information plan and review
scope: Read-only planning/review for the smallest central Portal F1a slice: fail-closed, copyable support information from an authorized Axios error envelope. No implementation is authorized by these notes.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=read the current V2 Spec and verify branch/baseline/Backend F0 before use; edit only after an explicit F1a Go with the exact allowlist.

## Task 1: Inventory the central F1a support-information slice

### rollout_summary_files

- rollout_summaries/2026-08-20T23-45-04-ZHDP-novari_f1a_central_portal_error_support_plan.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T01-45-04-01a02190-5d32-7c03-8574-82f2e7a144c9.jsonl, updated_at=2026-08-20T23:52:41+00:00, thread_id=01a02190-5d32-7c03-8574-82f2e7a144c9, read-only plan)

### keywords

- F1a, data.error, showBackendErrorToast, Support-Information, HTTP Date, CORS_EXPOSED_HEADERS, backendError.ts, duration: Infinity

## Task 2: Independently review and correct the F1a plan

### rollout_summary_files

- rollout_summaries/2026-08-20T23-53-23-FHIx-portal_f1a_read_only_plan_review.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T01-53-23-01a02197-fbab-7f22-ba83-23888f45a44d.jsonl, updated_at=2026-08-21T00:01:15+00:00, thread_id=01a02197-fbab-7f22-ba83-23888f45a44d, aligned read-only review)

### keywords

- actionHint, backendError.supportInformation.test.ts, apiClient.authRetry.test.ts, IMF-fixdate, REQUEST_FAILED, Handlungsempfehlung, 13-Dateien-Allowlist

## User preferences

- when planning error support, the user required a “kleinsten zentralen Portal-Teilslice”, an exact file allowlist, no caller mass migration, and no implementation without explicit Go -> keep direct product callers, warning paths, Backend/LMS, and F2 outside the slice. [Task 1]
- when reviewing, the user required “findings-first”, deterministic copy text, per-runtime-hunk contract mapping, and understandable German Go wording -> report concrete file/contract evidence and the smallest repair, not generic recommendations. [Task 1][Task 2]
- when a handoff has hard limits such as “unter 6.000 Zeichen”, “maximal 2.500 Zeichen”, or “maximal 900 Zeichen” -> finish the complete check, then consolidate into the requested fixed sections and length. [Task 2]

## Reusable knowledge

- F1a support information is valid only for a real Axios error with an object-shaped nested `response.data.error`; validate one-line bounded message, `code` `^[A-Z][A-Z0-9_]{0,127}$`, request ID `^[A-Za-z0-9._-]{1,128}$`, and matching valid body/header IDs. Reject header arrays/multiple values. [Task 1][Task 2]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 2]
- Use a separate F1a extractor in `src/libs/utils/backendError.ts`; do not widen the legacy extractor. Put its matrix in `backendError.supportInformation.test.ts`, because `backendError.test.ts` was already 749 lines. `apiClient.authRetry.test.ts` is the relevant interceptor surface; `apiClient.test.ts` is Attendance-only. [Task 2]
- Copy text is fixed ordered lines, no trailing newline: Support-Information, Meldung, Fehlercode, Referenz-ID, Anwendung: Portal, static Bereich, optional Zeitpunkt from strictly valid IMF-fixdate rendered ISO-UTC. `actionHint` is not server-authorized in F1a and the Handlungsempfehlung line always stays absent. [Task 2]
- Existing central producers are `apiClient.ts`, `showHandledApiErrorToast`/`handleApiCall` in `errorHandling.ts`, and non-warning `handleError` in `error-handler.ts`; `toast.ts` already uses `duration: Infinity` and global Sonner `closeButton`. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: broad search exits 2 because it names nonexistent directories -> search known paths only; incomplete `rg` output is not proof. [Task 1]
- Symptom: a plan treats every `showBackendErrorToast` caller as F1a -> classify first; direct product callers and post-commit/follow-up warnings remain unchanged. [Task 1]
- Symptom: an implementation starts from the read-only plan -> stop. The corrected 13-file allowlist, focused tests, formatter/typecheck/lint/build, and explicit Go are prerequisites; browser time, raw JSON/URLs/query/header/user input and legacy/top-level payload fallbacks are forbidden. [Task 1][Task 2]

# Task Group: Novari Logging V2 E2/E3/F1 specification reviews and stop gates
scope: Read-only scout/review workflow for V2 contract authorization, E2/E3 implementation readiness, and the F1 staged predecessor decision.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-*-review; reuse_rule=these baselines/plans are historical; re-read current Spec, Visualization, AGENTS.md, and exact diff before reviewing or starting a slice.

## Task 1: Review E2 plan, implementation, and frozen final diff

### rollout_summary_files

- rollout_summaries/2026-08-17T22-07-23-9VkO-novari_logging_spec_fall_7_visualization_rereview.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-e2-spec-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T00-07-23-01a011c3-db23-7dd0-8e93-e255396393b6.jsonl, updated_at=2026-08-17T22:10:16+00:00, thread_id=01a011c3-db23-7dd0-8e93-e255396393b6, spec/visualization re-review aligned)

### keywords

- E2, §14, security-event filters, V2 grouping, runtime exports, frozen diff, separate Go

## Task 2: Review E3 authorization/plan/final Portal diff

### rollout_summary_files

- rollout_summaries/2026-08-18T09-06-45-t52V-novari_e3_final_review_aligned.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-e3-final-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T11-06-45-01a0141f-8800-7821-8c18-fe77630e48e1.jsonl, updated_at=2026-08-18T09:25:14+00:00, thread_id=01a0141f-8800-7821-8c18-fe77630e48e1, aligned final review)
- rollout_summaries/2026-08-18T08-27-14-Vlic-novari_logging_v2_fall6_fall7_re_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-e3-spec-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T10-27-14-01a013fb-5813-7351-88e8-a8fb9bd313f4.jsonl, updated_at=2026-08-18T08:32:09+00:00, thread_id=01a013fb-5813-7351-88e8-a8fb9bd313f4, spec re-review aligned)

### keywords

- E3, §2.2 Fall 6, 10-file allowlist, Security Diff Scan, one-sided from, Page-level interaction

## Task 3: Identify F1 as staged but normatively blocked, then review its gate

### rollout_summary_files

- rollout_summaries/2026-08-18T10-16-38-OYO0-novari_logging_v2_f1_gate_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-f1-gate-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T12-16-38-01a0145f-7fd6-7de0-afd6-6bf157095b9c.jsonl, updated_at=2026-08-18T10:24:11+00:00, thread_id=01a0145f-7fd6-7de0-afd6-6bf157095b9c, read-only gate review)
- rollout_summaries/2026-08-18T10-12-04-I0pv-novari_logging_v2_f1_stop_gate_scout.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-next-slice-scout, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T12-12-04-01a0145b-52b7-7603-aee4-810c731f00ed.jsonl, updated_at=2026-08-18T10:16:12+00:00, thread_id=01a0145b-52b7-7603-aee4-810c731f00ed, partial: normative stop gate)

### keywords

- F1, §13, §2.2, HTTP Date, CORS, showBackendErrorToast, 19 direct callers, F2

## User preferences

- for reviews, the user asked for a “vollständig frischen, isolierten unabhängigen read-only Reviewer”, “keine Spekulation”, findings-first P0–P3, and actual complete-diff evidence -> preserve read-only mode and label unperformed checks honestly. [Task 1][Task 2][Task 3]
- “Stop bei Abweichung”, exact allowlists, baseline/upstream/status gates, and a separate explicit Go are binding; an aligned plan/review never authorizes implementation. [Task 1][Task 2]

## Reusable knowledge

- V2 review sequence: check exact baseline/branch/upstream/file freeze, read Spec/Visualization/plan/AGENTS, map every runtime hunk to an authorized §2.2 case, then use a fresh Security Diff Scan if requested. [Task 1][Task 2]
- Related skill: skills/novari-logging-slice-gates/SKILL.md. [Task 1][Task 2][Task 3]
- E3 allows Portal rendering of authorized E2 responses, never local grouping/counting/sorting/impact/actor reach; final review should test one-sided and complete date ranges plus page-level filter serialization. [Task 2]
- F1 sequence was: Spec authorization -> narrow Backend precursor (`Date` CORS/code constraint) -> central Portal F1a -> later direct-caller slices -> F2. A broad F1 sweep of 19 callers violates the size gate. [Task 3]

## Failures and how to do differently

- An MCP Security Diff Scan draft failed with `-32602` after invalid coverage fields; send only schema-required labels and omit workbench-owned metadata. [Task 2]
- Do not treat a named §13 feature as implementation authority when §2.2 excludes its runtime hunk; stop for a normative clarification first. [Task 3]

# Task Group: Novari Logging V2 F1 read-only stop-gate review
scope: Findings-first review of the normative and technical prerequisites for Portal F1 error-support work; use to decide slice order before any runtime implementation.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-f1-gate-review; reuse_rule=checkout/time-specific baselines are historical; re-read the current V2 Spec, backend, Portal, and LMS before acting.

## Task 1: Review F1 Stop-Gates and slice sequence

### rollout_summary_files

- rollout_summaries/2026-08-18T10-16-38-OYO0-novari_logging_v2_f1_gate_review.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-f1-gate-review, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T12-16-38-01a0145f-7fd6-7de0-afd6-6bf157095b9c.jsonl, updated_at=2026-08-18T10:24:11+00:00, thread_id=01a0145f-7fd6-7de0-afd6-6bf157095b9c, success: read-only blocker review)

### keywords

- Logging V2, F1, Stop-Gate, error envelope, requestId, HTTP Date, CORS_EXPOSED_HEADERS, showBackendErrorToast, opaque error code, §2.2, §14, findings-first

## User preferences

- when the user required a “vollständig frischen, isolierten unabhängigen read-only Reviewer” with “keine Spekulation” -> use only current local evidence, make no implementation move, and mark uncertainty explicitly. [Task 1]
- when the user required “findings-first”, P0/P1/P2, and clear user decisions -> lead with prioritized findings, then the minimum sequence and decisions; do not turn the review into implementation. [Task 1]

## Reusable knowledge

- F1 is a P1 stop gate until the V2 Spec §2.2 authorizes both F1 and its small backend response-contract predecessor; update the reference to the seven cases consistently before runtime work. [Task 1]
- `sendErrorResponse` provides `code`, `message`, and `requestId`, but not browser-readable server time. The minimal contract is to expose the existing HTTP `Date` header through `CORS_EXPOSED_HEADERS` and parse it strictly in Portal; never present browser time as server time. [Task 1]
- `showBackendErrorToast` currently receives only title, description, and request ID, while 19 runtime files call it directly. First use a central F1a slice, then small feature slices with real error paths under the §14 ten-production-file gate; separate successful follow-up warnings and F2. `error.code` may be an opaque value if the backend binds it to a safe syntax and falls back to `REQUEST_FAILED`/`INTERNAL_ERROR`. [Task 1]

## Failures and how to do differently

- Do not claim F1 complete from a central utility change: direct callers discard code/time before the toast. Do not invent a full error-code allowlist or derive application/function area from URL, query, or raw backend data. [Task 1]

# Task Group: Novari backend certificate operation, preflight, finalization, and required-audit cutover
scope: B7a.1d1 certificate-generation slices on `refactor/logging-system`: recovery/owner gates, additive d1a/d1a2 primitives, and d1b finalization wiring. Use for the JavaScript backend only; distinguish intentionally unconnected foundations from the later active-producer cutover.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=read `AGENTS.md`, current logging Spec/Plan, and active certificate code before reuse; never treat skipped Replica-Set tests as executed proof or broaden a named d1 slice into an outbox/queue/legacy redesign.

## Task 1: Add unconnected certificate claim/resume and environment primitives (d1a)

### rollout_summary_files

- rollout_summaries/2026-08-15T20-24-17-s0l8-b7a1d1a_certificate_operation_primitives.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T22-24-17-01a00718-bdb6-75d3-843d-21a841928cde.jsonl, updated_at=2026-08-15T20:38:48+00:00, thread_id=01a00718-bdb6-75d3-843d-21a841928cde, success: additive primitive foundation pushed `06802e90`)

### keywords

- CertificateGenerationOperationModel, certificate_operation_key_unique, operationKey, allocateCertNumber, certificateOperationRecovery, SHA-256, Development Exporte, CURRICULUM_TEST_REPLICA_SET_URI

## User preferences

- when the user required “VOR ERSTEM PRODUKTEDIT READ-ONLY RECOVERY-GATE” and “STOP” at a missing primitive or unclear owner -> inspect the existing upload/download/hash/overwrite primitives and the finite Partial-Batch owner matrix before any edit; hand off rather than invent a safe contract. [Task 1]
- when the user required “ausschließlich additive, UNVERDRAHTETE Operation-/Resolver-/Repository-/Code-Primitiven” -> prove the active route/generator has no new imports; leave active producer, Student state, responses, audits, and d1b untouched until the named cutover. [Task 2][Task 3]
- when the user required exact server-side environment handling -> derive paths on the server and fail closed for `test`, `staging`, empty, and unknown environments; never silently fall back to production. [Task 2]
- when the user required a narrow JavaScript slice without TypeScript, legacy/dual-shape contracts, Outbox/Queue, or C4 reimplementation -> reuse existing primitives and keep the named cutover boundary. [Task 4]

## Reusable knowledge

- The recovery gate is technically supported by `db/hidrive.connect.js` `downloadFile(relativePath)` and overwrite-capable `uploadFile`; `allocateCertNumber(..., { session })` and the `{ year, courseCode }` counter index already exist. The original partial-batch contract was unsafe because free `eligibility.reason`/`err.message` flowed into states; use fixed producer-local codes/owners, no PII/paths/stacks. [Task 1]
- d1a uses `CertificateGenerationOperationModel`: transactionally claim Student/Course plus number through real unique `certificate_operation_key_unique`; derive server-side SHA-256 operation identity and deterministic paths. Exact `development` is `/students/Development Exporte/{studentId}/certificates`, exact `production` is `/students/{studentId}/certificates`; all other environments fail before HiDrive. Recovery verifies matching bytes or same-path overwrite; fencing rejects stale terminal writes. [Task 2]
- d1a2 separates `preflight` (no issuance values) from `pending` (number/issuedAt/path/canonical hash); exact index readiness must reject a `partialFilterExpression`, sparse/hidden/TTL or other descriptor drift. Reset transaction return state per attempt and validate full phase invariants on replay/winner/fresh-read paths. Bind `course.courseId` before counter allocation, in CAS, and after conflicts. [Task 3]
- d1b finalization is one MongoDB session: CAS `uploaded → finalized`, conditional Student certificate entry, `certificated=true`, `certificateStatus.status='generated'`, and required `certificate.issued` audit. After post-claim error, fresh-read durable winner state; only the finalizer can mark `uploaded + CERTIFICATE_OPERATION_RETRY_REQUIRED`. Public partial-batch output stays safe; internal `{studentId,status}` coverage is not serialized. [Task 4]

## Failures and how to do differently

- A safe recovery primitive alone is not authorization to proceed: if `notEligible`, `error`, `retry`, `conflict`, or `unknown` lack a sole owner/fixed code, stop before product edits and do not commit/push. [Task 1]
- Fixture SHA-256 must be calculated from exact bytes. Use a helper-approved Replica-Set database identifier; missing `CURRICULUM_TEST_REPLICA_SET_URI` means race/index/fencing tests are residual risk, not proof. [Task 2][Task 3][Task 4]
- P1 review found stale `assigned:true`, incomplete replay validation, and missing actual handler coverage for marker-store errors. Use shared fresh-read phase logic, actual controller integration tests, and phase-specific durable writers; accept a parallel `finalized` result as truth rather than overwriting it. [Task 3][Task 4]

# Task Group: Novari logging delegation coverage matrix and Development-harness stop gate
scope: Logging-system coordination, test-governance planning, isolated Development harness rules, and the explicit pause after B7a.1d2a handoff.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-08-14/novari-logging-delegation; reuse_rule=use for the current logging Spec/Plan/Matrix after confirming their current state; this is governance, not authorization to start a new implementation slice.

## Task 1: Update logging test matrix, Development-harness/removal gates, and pause

### rollout_summary_files

- rollout_summaries/2026-08-14T20-47-39-cDrG-novari_logging_test_matrix_and_paused_handoff.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-14/novari-logging-delegation, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-14T22-47-39-01a00207-c9b2-79f3-8a9d-561617142590.jsonl, updated_at=2026-08-16T02:07:18+00:00, thread_id=01a00207-c9b2-79f3-8a9d-561617142590, success: Spec/Plan/Matrix updated; B7a.1d2b remains paused)

### keywords

- Novari_Logging_Test_Coverage_Matrix.md, D1-B1, D1-P1, D1-L1, D2-B, F1, development-harness, CURRICULUM_TEST_REPLICA_SET_URI, B7a.1d2b, keinen neuen thread starten

## User preferences

- when the user said “kein veränderter Ablauf ohne automatisierte Regressionstests und nachvollziehbare Prüfevidenz” -> maintain a row-level Producer/route/UI/BFF coverage matrix with concrete automated evidence, event count/codes, Request-ID, retry/replay/race/crash/delivery/cleanup/privacy evidence. [Task 1]
- when the user required Portal and LMS to be tested separately -> backend console or fixture proof is not evidence of the respective UI/BFF, toast, inline error, Request-ID, or `Support-Information kopieren` behavior. [Task 1]
- when the user said “bitte nach abschluss keinen neuen thread starten und erstmal stoppen” -> after the completed handoff, finish only already-running read-only review and wait for explicit authorization; do not start B7a.1d2b or another slice. [Task 1]

## Reusable knowledge

- Temporary Development surfaces are exact-server-side-`development` only and must exercise real product routes/services/role checks/transactions/audit/HiDrive primitives using synthetic isolated data and bounded, stoppable triggers. D1 has positive run evidence; D2 removes the surface only after documented green Backend, Portal, and LMS runs and retains negative non-registration/404 tests. [Task 1]
- F1 is read-only and blocked by OPEN rows, unjustified N/A, manual-only evidence, or visible applicable real Replica/Race/Crash skips. Historical positive harness tests are not durable product regression after removal. [Task 1]
- The Plan’s current minimum is 57 implementation slices, 28 completed and 29 remaining; F1/F2 are gates, not implementation slices. [Task 1]

## Failures and how to do differently

- Do not treat a visible applicable Replica/Race/Crash skip as an F1 waiver; only concrete true non-applicability permits N/A. [Task 1]
- A Portal fixture proves only Portal parser/BFF/UI consumption. Backend persistence/transaction/audit requires backend evidence, while real Portal-to-Backend behavior requires the Portal harness. [Task 1]

# Task Group: Novari backend logging-system B1–B7 exactly-once audit ownership and retention safety
scope: Completed JavaScript-backend `refactor/logging-system` slices that establish the producer inventory, stop unverified retention deletion, move evidence to schema-v1 events, and assign route-owned success audit evidence exactly once.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=use only after reading `AGENTS.md`, the current logging spec/slice plan, and confirming the active branch/remote; keep each named slice, the JavaScript backend, and real-write prohibition as hard boundaries.

## Task 1: Update the logging contract and create code-free slice delegation

### rollout_summary_files

- rollout_summaries/2026-08-12T14-50-55-iFjs-novari_logging_v2_delegation_review_and_slice_sizing.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/12/rollout-2026-08-12T16-50-55-019ff674-7846-7760-83ba-fcf0f7c0ab5a.jsonl, updated_at=2026-08-21T19:25:37+00:00, thread_id=019ff674-7846-7760-83ba-fcf0f7c0ab5a, success: code-free coordinator and post-F1 slice-sizing audit)

### keywords

- Novari_Logging_Error_Handling_und_Audit_Spec.md, no-legacy, reuse-first, LOG_HASH_SALT, pending → uploaded → verified → deleted, development-simulation, refactor/logging-system, delegation-thread

## Task 2: Document the B1 audit producer inventory

### rollout_summary_files

- rollout_summaries/2026-08-14T21-13-07-zE9F-novari_b1_audit_producer_inventory.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-14T23-13-07-01a0021f-1820-7cc2-b3e4-fce86244b1cf.jsonl, updated_at=2026-08-14T21:28:31+00:00, thread_id=01a0021f-1820-7cc2-b3e4-fce86244b1cf, success: docs-only inventory committed/pushed `3693f871`)

### keywords

- B1, audit-producer-inventory.md, logAuditEvent, persistSecurityAuditEvent, auditWriteActions, auditSuccessfulAccess, requirePersistence, A1–A9, current-plan-update-needed

## Task 3: Remove successful WorkRevision Continuity-read audit (B3)

### rollout_summary_files

- rollout_summaries/2026-08-14T21-43-18-nPmy-novari_b3_continuity_success_audit_removed.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-14T23-43-18-01a0023a-b9de-7e70-a878-de9b41835c2a.jsonl, updated_at=2026-08-14T21:56:37+00:00, thread_id=01a0023a-b9de-7e70-a878-de9b41835c2a, success: committed/pushed `bfaeac79`)

### keywords

- B3, auditContinuityRead, curriculumWorkRevisionController.js, not_persisted, pdl, lmsSupport, continuityReadService, logAuditEvent

## Task 4: Cut Employee-Archive deletion audits to the central policy (B4b)

### rollout_summary_files

- rollout_summaries/2026-08-14T22-53-44-3ovO-b4b_employee_archive_audit_cutover.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T00-53-44-01a0027b-3763-71f2-9774-bbb05ac3a76c.jsonl, updated_at=2026-08-14T23:16:56+00:00, thread_id=01a0027b-3763-71f2-9774-bbb05ac3a76c, success: committed/pushed `19fa20a7`)

### keywords

- B4b, ArchiveAuditLog, employeeArchiveController, audit.employee_archive_deleted, audit.employee_archive_partial_deleted, withTransaction, requirePersistence, skipGenericWriteAudit, privacy sentinel

## Task 5: Keep WorkRevision success evidence route-owned exactly once (B7a.1a)

### rollout_summary_files

- rollout_summaries/2026-08-15T14-21-19-XxZF-b7a1a_exactly_once_ownership_and_takeover_replay.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T16-21-19-01a005cc-70f4-7122-a837-be2f51dfb35b.jsonl, updated_at=2026-08-15T14:53:53+00:00, thread_id=01a005cc-70f4-7122-a837-be2f51dfb35b, success: 25-route matrix committed/pushed `339e7196`)

### keywords

- B7a.1a, skipGenericSuccessfulWriteAudit, auditWriteActions, curriculumExactlyOnceRoutes.test.js, CURRICULUM_WORK_REVISION_TAKEOVER_NOT_REQUIRED, 25-route matrix

## Task 6: Make Incident Legal Hold audit atomic (B7a.1b)

### rollout_summary_files

- rollout_summaries/2026-08-15T15-08-36-6igc-b7a_1b_incident_legal_hold_atomic_audit.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T17-08-36-01a005f7-bbcc-7333-b323-8807a68c87d4.jsonl, updated_at=2026-08-15T15:33:34+00:00, thread_id=01a005f7-bbcc-7333-b323-8807a68c87d4, success: atomic audit committed/pushed `31414c20`)

### keywords

- B7a.1b, incidentLegalHoldController.js, mongoose.connection.transaction, logAuditEvent, session, persistSecurityAuditEvent, legal hold, post-commit logger

## Task 7: Implement Applicant Workflow exactly-once (B7a.1c1)

### rollout_summary_files

- rollout_summaries/2026-08-15T16-01-02-iGsR-b7a_1c1_applicant_workflow_exactly_once.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T18-01-02-01a00627-bdaf-7dc1-9721-f27a7e360405.jsonl, updated_at=2026-08-15T16:17:28+00:00, thread_id=01a00627-bdaf-7dc1-9721-f27a7e360405, success: five-route slice committed/pushed `d53dd43d`)

### keywords

- B7a.1c1, applicantWorkflowController.js, runWorkflowTransaction, skipGenericSuccessfulWriteAudit, applicantWorkflowTransactionRetry.test.js, committed attempt

## Task 8: Implement Applicant-to-Employee Conversion exactly-once (B7a.1c2)

### rollout_summary_files

- rollout_summaries/2026-08-15T16-27-46-atQ0-b7a1c2_applicant_conversion_exactly_once.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T18-27-46-01a00640-34d5-78f1-9bbc-848cefb5aebc.jsonl, updated_at=2026-08-15T16:47:22+00:00, thread_id=01a00640-34d5-78f1-9bbc-848cefb5aebc, success: conversion slice committed/pushed `7917900b`)

### keywords

- B7a.1c2, convert-to-employee, pendingEmissions, APPLICANT_ALREADY_CONVERTED, convertedEmployeeRef, DuplicateKey 11000, committed attempt

## Task 9: Implement Closing Course Archive exactly-once (B7a.1c4)

### rollout_summary_files

- rollout_summaries/2026-08-15T17-27-09-D9Su-b7a1c4_closing_course_archive_exactly_once.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T19-27-09-01a00676-9382-78f3-989b-54385d08a6ae.jsonl, updated_at=2026-08-15T17:47:03+00:00, thread_id=01a00676-9382-78f3-989b-54385d08a6ae, success: route-local archive slice committed/pushed `1b22656e`)

### keywords

- B7a.1c4, POST /auth/classmanager/closing-reports/:id/archive-course, audit.course_archive, generateCertificatesForCourse, permission_denied, session sentinel

## Task 10: Implement Student-Archive Confirmation exactly-once (B7a.1c5)

### rollout_summary_files

- rollout_summaries/2026-08-15T18-00-40-RX4l-student_archive_confirmation_exactly_once.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T20-00-40-01a00695-41b6-7a01-a491-6d25aabfb861.jsonl, updated_at=2026-08-15T18:19:54+00:00, thread_id=01a00695-41b6-7a01-a491-6d25aabfb861, success: CAS confirmation committed/pushed `f5ef0b12`)

### keywords

- B7a.1c5, PATCH /auth/classmanager/students/archives/:archiveId/confirm, findOneAndUpdate, confirmed, decryptArchive, student_archive.confirmed

## Task 11: Add unconnected certificate-correction operation foundation (B7a.1d2a)

### rollout_summary_files

- rollout_summaries/2026-08-16T00-39-55-tbmo-b7a1d2a_certificate_correction_foundation.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-16T02-39-55-01a00802-c86f-77e3-8251-674a622d2fa0.jsonl, updated_at=2026-08-16T01:10:10+00:00, thread_id=01a00802-c86f-77e3-8251-674a622d2fa0, success: additive foundation committed/pushed `2a00cd37`)

### keywords

- B7a.1d2a, certificate-correction, CertificateCorrectionOperation, partial-unique-index, operationKey, fencing, HiDrive, CERTIFICATE_CORRECTION_DELETE_FAILED

## User preferences

- when the user said Development/current Production logs are “völlig egal” for the first cutover and required “kein Legacy-Archivdatensystem” -> do not add legacy readers, dual reads, backfills, archive imports, or compatibility layers; never execute a destructive cutover without explicit maintenance authorization. [Task 1][Task 5][Task 6]
- when the user required “erst mal überprüfen” existing Backend/Frontend functionality and Reuse-first -> inventory existing logger, error, auth/session, retry, notification, UI, and test mechanisms before creating a new surface. [Task 1]
- for named B1–B4b slices, the user repeatedly required JavaScript backend only, no worktree/replacement branch, independent review, RED→GREEN/focused tests, narrow commit, normal push, and no adjacent slice work -> treat all as start and handoff gates. [Task 2][Task 3][Task 4][Task 5][Task 6]
- when the user said “ausschließlich Backend-Slice” and, for c3, “EXAKT DREI ROUTEN” -> set the route/producer allowlist before editing; no adjacent route, certificate, HiDrive, Lead, schema, logger, or follow-up-slice work without a new decision. [Task 11][Task 12][Task 13][Task 14][Task 15][Task 16]
- when the user required `skipGenericSuccessfulWriteAudit`, never `skipGenericWriteAudit`, and B5 as the sole failure owner -> suppress only generic successful writes; leave B5 responsible for 400/409/422/5xx and remove domain-failed duplicates. [Task 11][Task 12][Task 13][Task 14][Task 15][Task 16]
- when the user required an additive, unconnected B7a.1d2a -> do not wire route/controller/bootstrap, mutate Student/archive/live references/status/audit/response, or perform real HiDrive I/O; stop at that boundary. [Task 17]
- when the user required existing CAS-/Kompensations-Restzustände to be proven but not repaired -> document the current non-atomic Lead behavior and do not add a transaction, CAS/idempotency/lock/outbox reform without a separate user decision. [Task 15]

## Reusable knowledge

- Existing logging surfaces are `libs/observability/logger.js`, `libs/observability/auditStore.js`, `models/audit/securityAuditEventSchema.js`, `router/securityAuditRouter.js`, and after B4a `libs/observability/securityAuditEventPolicy.js`. Reuse current `LOG_HASH_SALT` HMAC-SHA-256 behavior; no second secret/vault/rotation is needed for the first cutover. [Task 1][Task 5]
- The B1 matrix separates current persistence, target class (`required`, `best_effort`, `not_persisted`), reuse boundary, gap/later slice, and open decision. `logAuditEvent` is best effort unless `requirePersistence: true`; generic post-response `auditWriteActions`/`auditSuccessfulAccess` cannot enforce fail-closed required evidence. [Task 2]
- B2 leaves filtering/sort/batch limits intact but returns truthful `deletionBlocked`/`blockedCount` with `deletedCount: 0`; the authenticated cleanup cron must not emit `audit.retention_deleted` without a deletion. B8 owns eventual verified HiDrive batch/manifest/checksum/retry/exact-ID deletion. [Task 3]
- Successful Continuity context reads are `not_persisted`: remove only `auditContinuityRead`; retain role guards, response/error behavior, and audit for Review/Takeover/Patch/Changes/Publish/Export/denials. [Task 4]
- B4a validates producer-specific event/action/outcome/code tuples, server-owned immutable event/timestamp data, route/request IDs, bounded safe context, and an 8-KB limit. Cutover tooling defaults dry-run and binds deployment identity, collection UUID, and immediately rechecked full inventory hash. [Task 5]
- B4b uses B4a `logAuditEvent` inside the Mongo transaction for exactly one full/partial Employee-Archive deletion event; execute the post-commit success audit only from the final `withTransaction` result, bind test doubles to the same session, and suppress generic route audit. [Task 6]
- Exactly-once success ownership uses `res.locals.skipGenericSuccessfulWriteAudit`, never `skipGenericWriteAudit`: the latter would also suppress B5 failure telemetry. Use an exact allowed-route matrix; any newly found active producer is a stop-gate for user approval, not a silent expansion. [Task 7][Task 9][Task 10]
- Transaction retry effects must be attempt-local. Return response projection and pending post-commit emission from the transaction callback, then emit only the final committed attempt; do not accumulate callbacks in an outer array. `logAuditEvent` takes one options object with `session` inside it. [Task 8][Task 9][Task 10]
- For Applicant conversion, turn DuplicateKey `11000` into `APPLICANT_ALREADY_CONVERTED`/409 only after a post-abort fresh read confirms that same applicant's `convertedEmployeeRef`; preserve all other duplicate-key errors and the authorized 201 response. [Task 10]
- Controller-owned successes use route-local `skipGenericSuccessfulWriteAudit` and either required transactional audit (c3/c4/c5) or local no-throw best-effort audit (c6/c7/c8). Placement c6 is intentionally last-write: only controller-local `STUDENT_ARCHIVE_PLACEMENT_FORBIDDEN` emits no-throw `AUDIT_PERMISSION_DENIED`; expected 404 stays event-free. A route-local Store/Pino failure must not recursively log or convert an already valid 200/201/403 into a different response. [Task 11][Task 12][Task 13][Task 14][Task 15][Task 16]
- For transaction-backed c3/c4/c5, keep query/mutation/audit, response projection, cleanup, and post-commit callback attempt-local; only the final committed attempt emits. Cleanup or `endSession` errors after a proven commit cannot rewrite success, while cleanup after abort cannot hide the primary error. [Task 11][Task 12][Task 13]
- C4 is not end-to-end certificate-atomic: `generateCertificatesForCourse` can already create HiDrive/certificate/student effects and certificate audit before the archive transaction; that residual behavior belongs to B7a.1d1. C6/C7 deliberately retain new-action replay and last-write concurrency; C8 deliberately retains its non-atomic Lead CAS/compensation semantics. [Task 12][Task 14][Task 15][Task 16]
- B7a.1d2a operation identity binds Student, course, predecessor document identity, and canonical correction-input SHA-256. States are exactly `pending`, `uploading`, `uploaded`, `references_committed`, `error`, `finalized`; fail closed unless the exact full and partial unique indexes are ready. Revalidate exact `development`/`production`, deterministic target path, current live path, content hash, and fencing before remote effects. [Task 17]

## Failures and how to do differently

- Symptom: retention cleanup appears successful without verified archival -> block deletion truthfully; do not pre-implement B8 architecture or emit a success event. [Task 3]
- Symptom: required audit can be swallowed or a cutover target is only loosely identified -> required producers need `requirePersistence: true` failure tests, and destructive tooling needs stable deployment/collection identity plus an immediate full drift recheck. [Task 5]
- Symptom: retry transaction emits an old success audit or tests only fake rollback -> take the final `withTransaction` result and assert every query/mutation/audit uses the same session. [Task 6]
- Replica-Set rollback/race tests skipped without `CURRICULUM_TEST_REPLICA_SET_URI` are visible residual risk, not successful execution. Do not claim concurrency proof from mock tests. [Task 8][Task 9][Task 10]
- Symptom: old callback/response state leaks across a transaction retry or a final No-op -> derive and overwrite it inside each attempt, then use only the final `withTransaction` result. [Task 11][Task 12][Task 13]
- Symptom: Mongoose test setup creates an empty isolated DB before proving freshness -> use random task-local names, `autoCreate: false`/`autoIndex: false`, verify absence, explicitly create collection/indexes, and drop only after exact name/collection/emptiness proof. [Task 17]
- Test doubles must follow the actual persistence primitive: after C5 switched to `findOneAndUpdate`, stale `findByIdAndUpdate` stubs buffered/hung. For c6, run tests with `--import ./tests/setupEncryptionKeys.js` (or `npm test`) so `DATA_ENCRYPTION_ACTIVE_VERSION` exists, and assert canonical event codes rather than raw names. Isolate unrelated full-suite timing flakes before changing the slice. [Task 13][Task 14][Task 15]

# Task Group: Novari logging-system B5/B6 error telemetry, fail-closed envelopes, and safe support copy
scope: Implemented JavaScript-backend, LMS BFF, and Portal slices for exactly-once relevant write-error persistence, server-owned fail-closed error envelopes, and presentation-only support information.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=reuse the central-policy and verification patterns after checking the active logging-system contract/branch; do not widen a named slice into controller, TypeScript, B7/P2/L1, or other observability work.

## Task 1: Persist relevant request errors exactly once (B5)

### rollout_summary_files

- rollout_summaries/2026-08-14T23-23-35-SWg5-b5_request_errors_exactly_once.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T01-23-35-01a00296-8b19-7131-ac0e-74decc3b218d.jsonl, updated_at=2026-08-14T23:50:26+00:00, thread_id=01a00296-8b19-7131-ac0e-74decc3b218d, success: committed/pushed `23aefcef`; 6608 backend tests passed)

### keywords

- B5, requestErrorEvent, exactly-once, globalErrorHandler, httpLogger, finish, close, auditWritePolicy, persistSecurityAuditEvent, REQUEST_WRITE_FAILED, REQUEST_UNEXPECTED_ERROR, requestId

## Task 2: Implement the server-side error-envelope allowlist (B6)

### rollout_summary_files

- rollout_summaries/2026-08-14T23-56-12-wqVL-b6_serverseitige_error_envelope_allowlist.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T01-56-12-01a002b4-6623-77e0-8813-9c92a528a715.jsonl, updated_at=2026-08-15T00:44:19+00:00, thread_id=01a002b4-6623-77e0-8813-9c92a528a715, success: committed/pushed `e055c321`; focused 78/78 and full suite green)

### keywords

- B6, errorEnvelopePolicy, sendErrorResponse, httpError, globalErrorHandler, allowlist, fail-closed, employee-projection, Mongoose ValidationError, CastError, GitHub, rate-limit

## User preferences

- when a logging-system task says “ausschließlich Slice B5” or excludes B7/P2/L1, TypeScript, controller sweeps, and replacement branches -> keep the active JavaScript backend/branch and named slice as a hard boundary. [Task 1][Task 2]
- for this family, the user required Start-Gate, reuse-first, bounded read-only scouts, independent final review, focused then full tests, a narrow commit, and normal push -> retain that verification sequence. [Task 1]
- preserve safe response/`headersSent`/`next(err)` behavior, non-blocking best-effort telemetry, and privacy without raw error data; public versus employee output must come from exact catalog entries and backend-verified roles, never `shareholder` or client data alone. [Task 1][Task 2]

## Reusable knowledge

- B5 uses `libs/observability/auditStore.js::persistSecurityAuditEvent` directly, not legacy `logAuditEvent`; `libs/observability/requestErrorEvent.js` coordinates the global handler and direct Finish/Close path with a response-local claim, so each request produces at most one `request.error` log and relevant event. [Task 1]
- Put shared POST/PUT/PATCH/DELETE eligibility/exclusions in the pure `middleware/auditWritePolicy.js` alongside `auditWriteActions.js`; retain method, status, auth, export/download/preview/PDF/sensitive, and `skipWriteAudit` exclusions to avoid classification drift. B5 event codes/details are fixed and request IDs only correlate, never deduplicate separate requests. [Task 1]
- Best-effort persistence is fire-and-forget: contain synchronous policy errors and async store rejections, emit at most one safe `request_error.persistence_failed` log, never retry/loop/create an unhandled rejection, and never alter the original response. [Task 1]
- B6 centralizes policy in `error/errorEnvelopePolicy.js` and uses `error/httpError.js` plus `error/globalErrorHandler.js`; emit versioned server-owned envelopes with fixed German messages, exact code/status pairs, bounded semantic details/retry data, fixed GitHub guidance, and public fallback. B5 claim/store semantics remain separate. [Task 2]
- Recognize real Mongoose `ValidationError`/`CastError` concrete framework types; inherited/prototype-only fake `name` fields must not gain normalization authority. [Task 2]
- Server and BFF layers own classification and allowlisting. Direct 4xx/5xx `json`/`send` paths must fail closed unless they carry the server-owned marker; malformed or hostile shapes never gain authority. Preserve the original response and keep B5's exactly-once claim separate. [Task 3][Task 4][Task 5][Task 6]
- UI support copy is presentation-only: retain full `BackendErrorDetails` through the carrier, format a fixed safe field order with optional `actionHint` and Berlin time, deduplicate persistent toasts only by valid `requestId`, and copy no raw backend/user data. Treat Clipboard API `false` as failure and clean the DOM fallback in `finally`. [Task 7][Task 8]

## Failures and how to do differently

- Symptom: direct 4xx/5xx errors silently get no B5 telemetry -> fallback-safely claim candidates at 400/409/422 or 5xx, log once, and if an exclusion remains unclear, do not persist while preserving the response. An independent B5 review caught this P1 path. [Task 1]
- Symptom: an allowlist seems covered by happy-path tests -> add hostile descriptor/proxy, circular/sparse oversized array, Unicode/byte-bound, whitespace/noncanonical-path, unknown-code/role/wrong-status, and direct-versus-thrown B5 tests. The first B6 review also caught missing real GitHub code/status pairs and unbounded numeric detail indices. [Task 2]
- Do not reduce errors to `message/requestId` before safe consumers need them; carry complete safe details from exam, GitHub, sidebar, and locked-content adapters, while local browser/offline/socket errors remain without support-copy. [Task 7][Task 8]

# Task Group: Novari backend dev review, release gates, and scoped contract fixes
scope: Evidence-first review and narrow JavaScript-backend repairs on `dev`; separates code/test proof from operator-controlled release gates and sandbox limitations.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=use only for the JavaScript backend after reading `AGENTS.md`, confirming the exact base/HEAD and whether work is read-only or an authorized scoped fix; never inspect the separate TypeScript backend.

## Task 1: Cross-repo release review and narrow ticket/training fixes

### rollout_summary_files

- rollout_summaries/2026-08-14T04-00-01-K4L9-novari_cross_repo_release_review_and_two_backend_fixes.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/14/rollout-2026-08-14T06-00-01-019ffe6d-4586-7ed3-95a4-e7b51163793b.jsonl, updated_at=2026-08-14T06:54:12+00:00, thread_id=019ffe6d-4586-7ed3-95a4-e7b51163793b, partial review: contracts aligned but operator gates remain unverified; success: two focused fixes)

### keywords

- origin/main...dev, WorkRevision Phase 3, CURRICULUM_WORK_REVISION_PATCH_CHANGES_ENABLED, production gates, ticketCourseSnapshotService, paused Student, TRAINING_ENCRYPTED_LEAVES, toTrainingResponse, listen EPERM, CURRICULUM_TEST_REPLICA_SET_URI

## User preferences

- when the user requires a “strictly read-only” review and says “Nie die TypeScript-Backend-Variante lesen” -> stay exclusively in `novari-education-backend`, perform no PR/production/database action, and distinguish code findings from operator-gate evidence. [Task 1]
- for reviews, the user requested complete `origin/main...dev` diffs, `AGENTS.md`, P0–P3 findings with exact file/line/root cause/minimal fix/test contract, and explicit no-findings statements -> report only locally verified, evidence-backed defects. [Task 1]
- when supplied exact finding IDs/root causes/minimal fixes, the user requested RED→GREEN plus focused/broad/full checks and independent final review -> preserve narrow scope; update docs/CHANGELOG only “falls nötig.” [Task 1]
- when the user clarified “Es Brauch auch keine andere Zeitzone behandelt werden. Nur Deutschland” -> implement the fixed `Europe/Berlin` domain contract, not configurable/general timezone support. [Task 2]

## Reusable knowledge

- WorkRevision Phase 3 is fail-closed unless `CURRICULUM_WORK_REVISION_PATCH_CHANGES_ENABLED` is exactly `true`; collaboration-index readiness remains mandatory independently. Production compaction, encryption migration, index provisioning, and legacy backfills are operator-controlled gates: source/tests cannot establish release readiness. [Task 1]
- Ticket course attribution requires an `active` or `paused` Student, class, exact roster course, and optional ClassManager scope; retain bounded `.limit(2)` plus generic fail-closed errors, and exclude `dropped`/`completed`. Staff tickets retain null snapshots. [Task 1]
- Encrypted training leaves are `select: false`: mutation reads must `.select(TRAINING_ENCRYPTED_LEAVES)` and return `toTrainingResponse(training)` so decrypted `declineReason`/attachment filenames survive transforms without exposing ciphertext. [Task 1]
- `validFrom`/`validTo` are German calendar dates. Use DST-aware Berlin-day helpers, never UTC midnight or fixed 24-hour arithmetic: availability is `validFrom < start of next German day`, `validTo >= start of current German day`, and `archivedAt: null`. Archive eligibility/status calculations require the same 23-/25-hour-safe contract. [Task 2]
- Repeated archive on an already archived certified measure returns `CERTIFIED_MEASURE_ALREADY_ARCHIVED`; training-encryption migration filters/counts retired fields with `$exists: true`, including empty strings/nulls, while the plan removes empty values without payload generation. [Task 2]

## Failures and how to do differently

- Symptom: integration/browser tests fail `listen EPERM: operation not permitted 127.0.0.1` -> classify as sandbox loopback limitation, separately from product regressions. Missing `CURRICULUM_TEST_REPLICA_SET_URI` means replica-set coverage is skipped and remains a release limitation. [Task 1][Task 2]
- Symptom: CodeRabbit cannot review a very large diff (`too_many_files`, 401 files vs 300 limit) -> preserve the exact limitation and continue with local, split-by-surface review; do not call it a successful review result. [Task 2]
- Symptom: UTC-oriented tests fail after the Germany-only decision -> implement the Berlin/DST helper first, then update expectations for the fixed domain contract. [Task 2]

# Task Group: Novari Curriculum WorkRevision Phase-2 contract and Phase-3 Instructions continuity
scope: Contract-first JavaScript-backend/Portal collaboration work; separates an unimplemented Phase-2 proposal from the pushed, browser-validated Phase-3 Instructions slice and its unresolved manual follow-up.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend and /Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=read the current contract and choose the specific checkout before editing; no production writes, migrations, CRDT, or generic collaboration platform work by default.

## Task 1: Specify Phase-2 shared WorkRevision collaboration

### rollout_summary_files

- rollout_summaries/2026-08-05T22-37-28-VWFw-novari_workrevision_phase3_instructions_and_fresh_diagnosis.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/06/rollout-2026-08-06T00-37-28-019fd413-15b3-7b03-aa77-44774e53ffae.jsonl, updated_at=2026-08-12T22:20:52+00:00, thread_id=019fd413-15b3-7b03-aa77-44774e53ffae, partial: specification only; no Phase-2 runtime implementation)

### keywords

- CurriculumWorkRevision, createdBy, editSessionFence, Sequence, CAS, Recovery, pdl, lmsSupport, curriculum-work-revision-continuity-phase-2

## Task 2: Implement and diagnose Phase-3 Instructions collaboration

### rollout_summary_files

- rollout_summaries/2026-08-05T22-37-28-VWFw-novari_workrevision_phase3_instructions_and_fresh_diagnosis.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/06/rollout-2026-08-06T00-37-28-019fd413-15b3-7b03-aa77-44774e53ffae.jsonl, updated_at=2026-08-12T22:20:52+00:00, thread_id=019fd413-15b3-7b03-aa77-44774e53ffae, success: implementation/review/push; manual-symptom diagnosis opened separately)

### keywords

- Instructions, overview_page_block_field, dc4d13f5, bd0b9b67, getAttribute('value'), inputValue, Presence, Changes, compare, restore, 019ff80f-ee0e-71a3-aa37-b3e47f1d5306

## User preferences

- the user required “ausschließlich dieses JavaScript-Backend”, minimal invasive changes, no Production data/migrations/deployments, and no automatic merge magic -> reuse existing Sequence/CAS/Fence/EditSession/Recovery/Audit contracts and checkpoint at real persistence or authorization uncertainty. [Task 1][Task 2]

## Reusable knowledge

- Phase 2 was only an additive specification: `CurriculumVersion` is structural/lifecycle, `CurriculumOverview` planning, and `CurriculumWorkRevision` editable/reviewed/published state. Do not treat the proposed shared Primary design as implemented; owner-bound authorization occurs beyond Open and needs a full boundary inventory. [Task 1]
- Phase 3 uses allowlisted semantic targets and target-hash plus global sequence DB-CAS; no arbitrary JSON Patch or last-write-wins. The backend (`dc4d13f5`) and Portal (`bd0b9b67`) were pushed after green tests/reviews, but manual reports of missing Presence, delayed Changes visibility, repeated server-version conflicts, broken compare/restore, and broad diffs remain unresolved in fresh diagnosis thread `019ff80f-ee0e-71a3-aa37-b3e47f1d5306`. [Task 2]

## Failures and how to do differently

- Symptom: controlled textarea appears stale -> `getAttribute('value')` is invalid observability; use live `.value`/`inputValue` and report limited value-free Changes logs as an open observability constraint, not a product defect. [Task 2]

# Task Group: Novari backend current-branch security finding triage
scope: Read-only, evidence-led validation of Codex/Daybreak backend findings against the current JavaScript backend, including conservative dashboard-status triage.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=use for current-branch security finding triage after checking the live branch, route/middleware/controller path, and applicable product policy; static triage is not runtime exploitation or authorization to patch.

## Task 1: Verify stale signup escalation and unauthenticated bootstrap findings against current HEAD

### rollout_summary_files

- rollout_summaries/2026-08-11T11-29-53-ZsMp-current_branch_security_finding_triage.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/11/rollout-2026-08-11T13-29-53-019ff096-0e7a-7881-926b-a8f52ce8f861.jsonl, updated_at=2026-08-11T15:25:48+00:00, thread_id=019ff096-0e7a-7881-926b-a8f52ce8f861, success: historical IT-support finding fixed; empty-AuthModel bootstrap confirmed current)

### keywords

- Codex Security, Daybreak Blue, current HEAD, git ancestry, requireAnyRole, itSupport, hrManager, gf, bootstrapSignupGuard, AuthModel.estimatedDocumentCount, csrfProtectionWhenAuthenticated

## Task 2: Triage 98 dashboard findings conservatively and document evidence

### rollout_summary_files

- rollout_summaries/2026-08-11T11-29-53-ZsMp-current_branch_security_finding_triage.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/11/rollout-2026-08-11T13-29-53-019ff096-0e7a-7881-926b-a8f52ce8f861.jsonl, updated_at=2026-08-11T15:25:48+00:00, thread_id=019ff096-0e7a-7881-926b-a8f52ce8f861, success: 98 evidence records, nine conservative closures, 89 findings still open)

### keywords

- SECURITY_FINDINGS_README.md, 98 findings, 79 confirmed, 13 needs_review, 6 not_actionable, exact duplicate, source/control/sink, object authorization, unscoped decrypted DTOs, Socket.IO rooms

## User preferences

- when the user asks whether a security finding is still a problem “im aktuellen branch” -> inspect current HEAD and git ancestry rather than trust the scanner’s cited commit. [Task 1]
- HR/HRManager creating GF accounts is intended -> distinguish the reported low-privilege actor path from broader role provisioning; do not call intended HRManager→GF provisioning a vulnerability without contrary policy evidence. [Task 1]
- close only fully fixed claims, exact duplicates, or clear non-product false positives; keep partial fixes, deployment/state-dependent claims, and every `needs_review` finding open. [Task 2]
- for every finding, retain prerequisites, impact, source/control/sink, counterevidence or proof gaps, and fix direction rather than only a title or final status. [Task 2]

## Reusable knowledge

- Current post-bootstrap signup is guarded by `requireAnyRole(["gf", "hrManager"])` in `router/authRouter.js:74-101`; `itSupport` was removed and remediation commit `e3a0e31c` is an ancestor, so the historical escalation path is blocked before validation/controller execution. [Task 1]
- The unauthenticated bootstrap remains confirmed: public `/auth` reaches `bootstrapSignupGuard`, which calls `AuthModel.estimatedDocumentCount()` and `next()` when count is zero; unauthenticated CSRF is also bypassed. Student signup uses `StudentModel` without AuthModel, so a student-only state can leave this boundary open. A secure fix removes unauthenticated HTTP bootstrap or requires a one-time setup secret/out-of-band provisioning. [Task 1]
- The durable per-finding record is `SECURITY_FINDINGS_README.md`: 98 numbered triages; final static classification was 79 `confirmed`, 13 `needs_review`, 6 `not_actionable`; nine entries were closed and 89 remained open. `npm run lint` and `git diff --check` passed; application files were not modified. [Task 2]
- Recurring causes in that triage were missing object-level course/employee authorization, unscoped decrypted DTOs, Socket.IO room/active-role gaps, unsafe URL schemes, absent rate/resource limits, and migration/index/readiness assumptions; search the report before treating a new title as novel. [Task 2]

## Failures and how to do differently

- Symptom: a scanner says a finding is patched or points at an old commit -> inspect the current route, middleware, controller/service, and ancestry; changelog/README language is not runtime evidence. [Task 1]
- Symptom: related findings look alike -> do not close them on title similarity; require the same route, control, and sink/effect. A partial authorization fix stays open if a read or alternate path remains exposed. [Task 2]
- Symptom: static triage lacks production index, deployment, role-policy, or frontend-sink evidence -> record the gap as `needs_review`, not an assumed-safe verdict. [Task 2]

# Task Group: Novari Curriculum WorkRevision Phase-3 Instructions browser validation
scope: Backend/Portal semantic Instructions collaboration and two-profile browser evidence; preserves the Phase-2/no-CRDT boundary.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-backend and /Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=use after reading the current contract and selecting the repository-specific cwd.

## Task 1: Validate Instructions collaboration with two Chrome profiles

### rollout_summary_files

- rollout_summaries/2026-08-08T23-08-11-Q5QG-phase_3_instructions_collaboration_browser_validation.md (cwd=/Users/mrbubbles/dev/novari/novari-education-backend, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/09/rollout-2026-08-09T01-08-11-019fe3a2-4b08-7683-bde9-6faff2f16b66.jsonl, updated_at=2026-08-12T20:45:06+00:00, thread_id=019fe3a2-4b08-7683-bde9-6faff2f16b66, success: backend `dc4d13f5` and Portal `bd0b9b67` pushed; final live-DOM gate GREEN)

### keywords

- WorkRevision, Instructions, overview_page_block_field, instructionBlockId, textarea.value, getAttribute('value'), 5517, dc4d13f5, bd0b9b67

## User preferences

- for browser validation, use the explicitly authorized two-profile Chrome/browser-client flow; do not substitute In-App Browser, Playwright CLI, or raw DevTools. Keep checkpoints value-free and stop at a genuine discrepancy. [Task 1]

## Reusable knowledge

- Instructions targets are page-specific, use stable `instructionBlockId`, and must not route through the legacy generic adapter. Title/content use scalar semantics; recommendations use ordered whole-list CAS. Duplicate/malformed IDs produce no receipt/change/write; missing valid targets are idempotent `TARGET_NOT_FOUND`. [Task 1]
- Controlled textarea state must be read from live `.value`/`inputValue`, never `getAttribute('value')`. The final gate found equal nonempty live values, 7 sections, 33 structurally matching recommendation controls, saved state, and no warnings. [Task 1]

## Failures and how to do differently

- Symptom: an attribute read looks stale -> it is not authoritative React controlled-input state. Use live properties or authoritative Open/Changes evidence; backend log limits on ordinary Changes remain observability-open, not a product failure. [Task 1]

# Task Group: Novari Portal LMS canonical tags and shared multi-select selector
scope: LMS-editor-only canonical tag data and the reusable `TagsSelector` behavior; ticket and PDL tags are separate boundaries.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=reuse for LMS editor tag-list or shared selector changes after checking existing Base UI primitives and working-tree scope; do not apply to ticket/PDL tags or unrelated single-select fields.

## Task 1: Adopt canonical LMS tags and improve the shared selector

### rollout_summary_files

- rollout_summaries/2026-08-11T23-10-27-a0Zl-lms_canonical_tags_and_multiselect_selector.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/12/rollout-2026-08-12T01-10-27-019ff317-726f-7461-bb1c-08a47c538d5b.jsonl, updated_at=2026-08-12T01:19:30+00:00, thread_id=019ff317-726f-7461-bb1c-08a47c538d5b, success: canonical list and selector validated)

### keywords

- LMS, PREDEFINED_TAGS, TagsSelector, Combobox, Base UI, shadcn, multi-select, canonical-tags, touch-hitbox, z-index, overflow-popover, `Tag ... entfernen`

## Task 2: Commit only the LMS tag-selector task package

### rollout_summary_files

- rollout_summaries/2026-08-11T23-10-27-a0Zl-lms_canonical_tags_and_multiselect_selector.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/12/rollout-2026-08-12T01-10-27-019ff317-726f-7461-bb1c-08a47c538d5b.jsonl, updated_at=2026-08-12T01:19:30+00:00, thread_id=019ff317-726f-7461-bb1c-08a47c538d5b, success: scoped commit `acc9631f`; not pushed)

### keywords

- acc9631f, `feat: improve LMS tag selection and topic metadata`, git diff --cached --check, 14 files, curriculum-workrevision-continuity-phase-3

## User preferences

- when the user said “mir geht das jetzt um die LMS Editor Tags” -> limit canonical-list changes to LMS editor tags; do not touch ticket or PDL tags. [Task 1]
- when the user said “Wir brauchen gerade hier keinen UI-Polish ... Mir geht das hier nur um die Texts.” and later requested not to use `impeccable` -> do not introduce design work or that skill for a list/text-only change. [Task 1]
- before UI implementation, the user wanted examination and assessment first -> inspect the existing implementation, primitives, and concrete failure before changing it. [Task 1]
- when asked to commit “die Sachen, die du jetzt hier in diesem Script gemacht hast” -> stage only the cohesive task scope and preserve unrelated working-tree changes. [Task 2]

## Reusable knowledge

- LMS tags are `src/components/lms/markdown-editor/editor/constants/predefined-tags.ts`; ticket tags are `src/libs/utils/defaultTickettags.ts`, while PDL feedback tags come from `/pdl/content-feedback/tags`. The final `PREDEFINED_TAGS` list has 219 unique tags: all 209 canonical tags plus 10 retained legacy Portal tags, sorted with `localeCompare(..., 'de')` and guarded for count, duplicates, and sort order. [Task 1]
- `TagsSelector` is shared at about ten LMS/Curriculum locations. Use the existing `src/components/ui/combobox.tsx` Base UI primitive with `multiple`, searchable/scroll-bounded list, keyboard focus, free comma-separated deduplicated tags, and accessible whole-badge remove buttons. Do not refactor ordinary single-selects. [Task 1]
- Render three visible badge rows and `+N` overflow. Because `.touch-hitbox` uses `z-index: 9999`, use a local Portal container and overlay z-index `10000`; prevent overflow-popover autofocus so focus remains on `+N`, the popover stays open after removal, and clicks do not reach fields beneath. [Task 1]
- Verification passed 341 test files / 3392 tests, typecheck, production build, focused ESLint/Prettier, and `git diff --check`. Commit `acc9631f feat: improve LMS tag selection and topic metadata` was created from exactly 14 staged related files; no push occurred. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: test still asserts the old badge DOM -> update it to the complete accessible button name `Tag ... entfernen`, rather than weakening coverage. [Task 1]
- Symptom: repository-wide ESLint is red -> four known unrelated errors in `ClosingReportStudentDialog.tsx`, `courseContext.tsx`, `courseManagerContext.tsx`, and `closing-reports.lazy.tsx` remain baseline; run and report focused ESLint for this slice. [Task 1]
- Symptom: `bunx --bun shadcn@latest` fails with `PermissionDenied` for Tempdir -> treat it as sandbox environment, not a code failure; use permitted read-only project/docs inspection where available. [Task 1]

# Task Group: Bubbles-verse documentation taxonomy refactor
scope: Documentation-only monorepo reorganization into navigable, ownership-scoped `docs/` folders while preserving fixed artifact paths and historical evidence.
applies_to: cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse; reuse_rule=reuse the taxonomy and verification sequence for documentation-only changes in this monorepo; branch, HEAD, and uncommitted state are checkout-specific.

## Task 1: Establish Bubbles-Verse documentation conventions before the refactor

### rollout_summary_files

- rollout_summaries/2026-07-29T18-52-12-0C2q-orchestrate_webmcp_docs_and_live_troubleshooting.md (cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/29/rollout-2026-07-29T20-52-12-019faf38-54a1-7353-9feb-54f586c2fcbe.jsonl, updated_at=2026-08-10T19:25:30+00:00, thread_id=019faf38-54a1-7353-9feb-54f586c2fcbe, conventions and live-troubleshooting summary)

### keywords

- bubbles-verse, documentation, docs, apps/*/docs, packages/*/docs, docs/README.md, contracts, architecture, development, operations, archive, AGENTS.md

## User preferences

- when the user said the documentation was “mega geworden” but requested “sortierten ordner in den docs ordnern” -> create navigable topic folders and local README indexes rather than leaving large flat directories. [Task 1]
- the user required `docs/superpowers/specs/product-brief-private-recipe-library.md` to remain exactly there -> preserve explicitly fixed artifact paths during adjacent reorganizations. [Task 1]
- when the user requests no commit or push for a documentation refactor -> leave it uncommitted and report the exact branch, HEAD, and worktree status. [Task 1]
- when requesting the Bubbles-Verse convention, the user said `documentation/` should be `docs/` at root, app, and package level -> retain root monorepo docs versus code-near `apps/*/docs` and `packages/*/docs`; make topic folders only where content exists. [Task 2]

## Reusable knowledge

- `docs/`, never `documentation/`: root docs own monorepo-wide architecture, setup, tooling, and cross-cutting contracts; app/package material belongs under its owning workspace’s `docs/`. [Task 1]
- Use `architecture/`, `contracts/`, `design/`, `development/`, `operations/`, and `archive/` only where content exists; do not create empty taxonomy folders. Generated April 2026 snapshots belong in `archive/2026-04-05/`; Codex handoffs belong in `archive/codex-handoffs/`. [Task 1]
- Update local README indexes and active navigation after moves. The fixed recipe spec remained byte-identical (blob `583171237a73b1d978bb94602f33e29e092640a2`). [Task 1]
- Verification used `git diff --check`, a repository-wide relative Markdown-link scan after path-depth corrections, and `bun run lint` plus `bun run typecheck` across 13 tasks; lint had existing warnings only. [Task 1]

## Failures and how to do differently

- Symptom: deep document moves break relative links -> calculate depth changes before moving, then run a repository-wide Markdown-link resolver immediately afterward. [Task 1]
- Symptom: broad Prettier reports existing warnings -> format selected navigation files and state “targeted formatting passed,” not that the entire documentation tree is formatted. [Task 1]
- Historical handoffs retain old paths as historical evidence -> do not rewrite them wholesale unless explicitly requested; distinguish historical references from active navigation. [Task 1]
- The earlier convention rollout ended before its refactor was verified -> inspect branch, status, actual directories, and diff before declaring a documentation migration complete. [Task 2]

# Task Group: Bubbles-verse private recipe-library WIP specification
scope: Product-boundary and document-placement guidance for the private Family & Friends recipe library specification.
applies_to: cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse; reuse_rule=reuse product constraints and fixed target path for this specification; verify branch/worktree and actual file location before claiming a move or commit completed.

## Task 1: Create and place the private recipe-library specification

### rollout_summary_files

- rollout_summaries/2026-07-29T18-52-12-0C2q-orchestrate_webmcp_docs_and_live_troubleshooting.md (cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/29/rollout-2026-07-29T20-52-12-019faf38-54a1-7353-9feb-54f586c2fcbe.jsonl, updated_at=2026-08-10T19:25:30+00:00, thread_id=019faf38-54a1-7353-9feb-54f586c2fcbe, recipe-library documentation/spec context)

### keywords

- recipe-library, rezeptbibliothek, private, Family & Friends, product-brief-private-recipe-library.md, docs/superpowers/specs, noindex, moderation, normalized title, alternative, e98afbd

## User preferences

- the user wanted a “reine Sammlung” -> no advertising, affiliates, subscriptions, sales, or marketing. [Task 1]
- contributors may correct only their own uploads; foreign uploads remain hidden until Owner approval. Duplicate titles are suggestions for review, not an automatic block; divergent recipes become linked alternatives. [Task 1]
- when correcting the target, the user said “die Markdown-Datei in den Specs Ordner reinmachen ... keine Unterordner” -> use the exact direct path and confirm it before mutation. [Task 1]

## Reusable knowledge

- Desired final path: `docs/superpowers/specs/product-brief-private-recipe-library.md`; the original was created at `_bmad-output/planning-artifacts/product-brief-private-recipe-library.md` in commit `e98afbdabc1afc0b37c61a9cb22a0384a084bb44`. [Task 1]
- The intended product includes explicit Family & Friends access, protected internal links, owner-granted separate read/write rights, camera/image/PDF import with structured extraction and required-field review, noindex, sources, bundled in-app notifications, and visible “wartet auf Freigabe” status. [Task 1]

## Failures and how to do differently

- Symptom: a single-document change receives an unnecessary Codex worktree/branch -> use the main worktree when the user asks for a small, clear scoped edit, subject to current repo rules. [Task 1]
- Symptom: `spec`/`specs` or extra feature folders cause iterations -> confirm the literal path, then check `git status` and `find` before moving. Do not claim the later move/commit is complete until verified. [Task 1]

# Task Group: Novari Logging, error handling, audit, and support-information specification and delegation
scope: Updated Novari logging/audit implementation contract and code-free delegation setup; use to route planned logging-system work without treating the coordinator/spec itself as product implementation.
applies_to: cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc; reuse_rule=verify repository facts in /Users/mrbubbles/dev/novari/novari-education-backend and the active `refactor/logging-system` slice before reuse; coordinator assessment is not independent review evidence.

## Task 1: Review the existing logging, roles, and privacy contracts

### rollout_summary_files

- rollout_summaries/2026-08-12T14-50-55-iFjs-novari_logging_v2_delegation_review_and_slice_sizing.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/12/rollout-2026-08-12T16-50-55-019ff674-7846-7760-83ba-fcf0f7c0ab5a.jsonl, updated_at=2026-08-21T19:25:37+00:00, thread_id=019ff674-7846-7760-83ba-fcf0f7c0ab5a, success: code-free delegation setup)

### keywords

- logging, audit, securityAuditEventSchema, securityAuditRouter, LOG_HASH_SALT, hashLogValue, HMAC-SHA-256, no-legacy, reuse-first, lmsSupport, shareholder, Development simulation

## Task 2: Create the minimal logging/error/audit specification

### rollout_summary_files

- rollout_summaries/2026-08-12T14-50-55-iFjs-novari_logging_v2_delegation_review_and_slice_sizing.md (cwd=/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/12/rollout-2026-08-12T16-50-55-019ff674-7846-7760-83ba-fcf0f7c0ab5a.jsonl, updated_at=2026-08-21T19:25:37+00:00, thread_id=019ff674-7846-7760-83ba-fcf0f7c0ab5a, success: delegation contract and slice-sizing audit)

### keywords

- Novari_Logging_Error_Handling_und_Audit_Spec.md, no-legacy, reuse-first, pending → uploaded → verified → deleted, 12 Monate, 24 Monate, required audit, Development simulation, refactor/logging-system

## User preferences

- when the user asked for “möglichst halbwegs minimalen Aufwand” and no “Amazon- oder OpenAI-Level”-Logsystem -> extend the existing structure; do not introduce a SIEM, new observability platform, event bus, or speculative architecture. [Task 1]
- when the user said current Development/Production logs are “völlig egal” for this cutover and required “kein Legacy-Archivdatensystem” -> allow the clean cutover but do not add legacy readers, dual reads, backfills, imports, or compatibility layers. [Task 1][Task 2]
- when the user required a delegation thread that “schreibt keinen direkten selber eigenen Code” -> keep coordination code-free; use fresh implementation threads and require an independent reviewer rather than treating coordinator assessment as review. [Task 2]
- when the user clarified that no `admin` or `security` role is planned and `shareholder` is an account class -> bind operational access to existing roles/capabilities; do not treat shareholder as a new active role. [Task 1]
- when the user required that every user can copy safe support information -> keep the copy action universal and use the Request-ID for internal LMS Support lookup. [Task 1]
- when the user asked for the spec only -> create an implementation-neutral contract without Backend/Portal edits; later adoption needs a separate documentation commit. [Task 2]

## Reusable knowledge

- Central backend surfaces are `libs/observability/logger.js`, `auditStore.js`, `models/audit/securityAuditEventSchema.js`, and `router/securityAuditRouter.js`. `LOG_HASH_SALT` is required in production; existing `hashLogValue` uses HMAC-SHA-256, so the first implementation needs neither a second HMAC secret nor a vault. [Task 1]
- Best-effort telemetry must neither block normal business actions nor recursively log its own failure. Separately, audit-required mutations, sensitive exports, permission changes, and comparable evidence actions must fail closed if their audit evidence is absent. [Task 1]
- Safe support copy contains only a short German message, stable error code, Request-ID, area, application, and timestamp—never raw JSON, URLs, IDs, stack traces, or secrets. [Task 1]
- Draft policy: 30 days hot MongoDB events; archive `pending → uploaded → verified → deleted`; no hot deletion after HiDrive, manifest, or checksum failure. Standard 12-month and defined administrative/security 24-month archives remain subject to DSB confirmation, not settled legal advice. [Task 1][Task 2]
- Explicit non-goals are SIEM, ELK/OpenSearch, Kafka/Event-Bus, OpenTelemetry, Session Replay, request/response capture, ML anomaly detection, a new ticket system, new `admin`/`security` roles, and unlimited HiDrive live search. [Task 2]
- Each implementation slice must inventory/reuse existing logger, error, auth/session, export, retry, notification, UI, and test mechanisms first; commit/push only after focused tests/review on `refactor/logging-system`. Development timing checks, when needed, use a bounded synthetic simulator and retain automated tests. [Task 1][Task 2]

## Failures and how to do differently

- Symptom: “technical error logging must not fail” becomes an unclear blanket rule -> state immediately that the original user error remains visible, only the additional best-effort logging failure must not recurse; audit-required actions are a separate fail-closed class. [Task 1]
- Symptom: a generic security/admin role matrix is proposed -> the actual need is bounded LMS Support visibility; archive deletion, secret access, and policy changes are not normal Portal actions. [Task 1]
- Do not treat the spec/coordinator as implementation or independent-review approval: sensitive product changes proceed only through delegated slice threads; DSB retention confirmation and some policy decisions remain separately scoped. [Task 2]

# Task Group: Novari Portal Curriculum WorkRevision Phase-3 collaboration continuity
scope: Portal-only Phase-3 collaboration continuity, reconnect-safe subscriptions, strict checkpoint notification hints, and proportionate future Presence design.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal; reuse_rule=use only after reading the current Phase-3 collaboration/autosave contract and `AGENTS.md`; backend writes, browser/production work, later writer slices, and Presence implementation remain opt-in scope.

## Task 1: Slice 4a continuity and reconnect-safe ticket subscriptions

### rollout_summary_files

- rollout_summaries/2026-08-09T15-04-30-4K5N-curriculum_workrevision_phase3_slice4a_readonly_gate.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/09/rollout-2026-08-09T17-04-30-019fe70d-d280-7dc3-bf8f-b6400aa2e0bf.jsonl, updated_at=2026-08-12T20:45:18+00:00, thread_id=019fe70d-d280-7dc3-bf8f-b6400aa2e0bf, uncertain implementation context; success: green two-profile read-only gate)

### keywords

- WorkRevision, Slice4a, overviewRowId, exerciseNotes, teacherInstructions, IndexedDB, SocketProvider, io server disconnect, ticket-room, connected, 52844d4d

## Task 2: 6a2a exact checkpoint notification contract

### rollout_summary_files

- rollout_summaries/2026-08-09T15-04-30-4K5N-curriculum_workrevision_phase3_slice4a_readonly_gate.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/09/rollout-2026-08-09T17-04-30-019fe70d-d280-7dc3-bf8f-b6400aa2e0bf.jsonl, updated_at=2026-08-12T20:45:18+00:00, thread_id=019fe70d-d280-7dc3-bf8f-b6400aa2e0bf, green live-DOM validation; HTTP Changes observability remains open)

### keywords

- 6a2a, checkpoint_resync_required, operationKind, isExactObject, useCurriculumWorkRevisionNotifications, HTTP Changes, cursor high-water, 6a2b, 6a2c, 4752017b

## Task 3: Repair durable coalesced Phase-2 fallback and truthful persistence state

### rollout_summary_files

- rollout_summaries/2026-08-12T22-22-01-cLl2-novari_phase3_collaboration_continuity_fix_and_runtime_lifec.md (cwd=/Users/mrbubbles/.codex/worktrees/12e3/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-13T00-22-01-019ff811-75b2-7700-a195-87a67d3f0354.jsonl, updated_at=2026-08-12T23:48:15+00:00, thread_id=019ff811-75b2-7700-a195-87a67d3f0354, success: test-first fix, five-file commit `460f29a2`, pushed)

### keywords

- Phase-2 fallback, coalescing, IndexedDB, phase2FallbackFollowUpRequestRef, collaborationStoreChainRef, LOCAL_FAILED, local_only, base_stale, useCurriculumWorkAutosave, 97/97, 178/178, 460f29a2

## Task 4: Isolated agent-owned Portal Vite runtime lifecycle

### rollout_summary_files

- rollout_summaries/2026-08-12T22-22-01-cLl2-novari_phase3_collaboration_continuity_fix_and_runtime_lifec.md (cwd=/Users/mrbubbles/.codex/worktrees/12e3/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-13T00-22-01-019ff811-75b2-7700-a195-87a67d3f0354.jsonl, updated_at=2026-08-12T23:48:15+00:00, thread_id=019ff811-75b2-7700-a195-87a67d3f0354, success: isolated port 5174 started, verified, and removed cleanly)

### keywords

- Vite, VITE_API_BASE_URL, VITE_API_SOCKET_URL, backend.local.test:5527, 127.0.0.1:5174, strictPort, port 5173, temporary symlink, sandbox curl

## Task 5: Bind Continuity polling to editor lifecycle and exact identity (P1)

### rollout_summary_files

- rollout_summaries/2026-08-14T21-57-47-9CZL-novari_portal_p1_continuity_polling_lifecycle.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-14T23-57-47-01a00247-fcd7-7140-afe3-ca597a8f34f5.jsonl, updated_at=2026-08-14T22:22:17+00:00, thread_id=01a00247-fcd7-7140-afe3-ca597a8f34f5, success: committed/pushed `09b9bc1a`)

### keywords

- P1, useCurriculumWorkRevisions.ts, useCurriculumWorkRevisionContinuityContext, TanStack Query, AbortSignal, QUIET_REQUEST, visibility, query cancellation, 401, 403, 404, StrictMode

## User preferences

- for these Phase-3 slices, the user required strict scope, RED→GREEN, independent review, Commit-Writer, push only after review, and stopping before later slices -> retain this gated workflow. [Task 1][Task 2]
- the user prohibited unsafe sends, automatic conflict resolution, unstable index/title/slug targets, backend writes, unrelated UI work, and unapproved later slices -> preserve the fail-closed Portal-only boundary. [Task 1][Task 2]
- when the user required exactly five changed files and no commit/push before final review -> stage and verify only the explicitly named files. [Task 2]
- for the durable-fallback repair, the user required B durable before cleanup, A→B→A coalescing preserved, no overlapping writes, and fail-closed storage-error truth -> verify IndexedDB durability and post-receipt status, not refs or UI alone. [Task 3]
- for read-only diagnosis, the user required “zunächst strikt read-only,” no browser/server/Git mutation, no queue/IDB deletion, recovery clicks, or races -> classify each symptom independently from contracts, code, and tests before any fix. [Task 3]
- for a detached-worktree handoff, the user required exact reviewed five-file staging, Commit-Writer, no merge/rebase, foreign-worktree preservation, and explicit push proof -> verify ancestry/refs before staging and push `HEAD:<branch>` explicitly when appropriate. [Task 3]
- when the user said “ausschließlich Slice P1”, no Backend changes, no UI reform, and stop at scope expansion -> bind polling to the existing Portal contracts rather than creating a general polling manager. [Task 5]
- for Novari architecture, use the real codebase, current use case, and today’s scale; prefer small, correct, understandable solutions using existing primitives. Do not introduce separate platforms, registries, pollers, caches, heartbeats, outboxes, or protocols for hypothetical load: the 400–500 concurrent-user estimate is portal-wide and long-term, not a target for one feature or room. Expand only against measured requirements. [ad-hoc note]

## Reusable knowledge

- Semantic targets are exactly `overviewRowId + exerciseNotes` and `overviewRowId + teacherInstructions`; never reconstruct target identity from array index, title, or slug. Existing IndexedDB draft storage is the local snapshot/queue authority; only exact server receipts may consume queue entries or claim Saved. [Task 1]
- Socket ownership belongs in the shared `SocketProvider`; notification hooks must not independently handle `io server disconnect`. Ticket-room consumers join only when `connected === true`, rejoin on `false → true`, and do not emit stale `leave` events while disconnected. [Task 1]
- Notification contract: Patch is exactly `{eventId,cursor,workRevisionSequence,operationKind:'patch',target}`; checkpoint is exactly `{eventId,cursor,workRevisionSequence,operationKind:'checkpoint_resync_required'}` and has no `target`. Unknown, extra, mixed, target-bearing checkpoint, targetless Patch, malformed IDs, unsafe cursors, and invalid operation kinds fail closed. [Task 2]
- Both variants are hints only: advance ephemeral per-identity cursor high-water and wake the existing coalesced HTTP Changes drain; never persist/adopt hint data or claim Saved. 6a2b (autosave/review/merge) and 6a2c (import/topic/aggregate/publish) writers remain disabled in 6a2a. [Task 2]
- A newer coalesced fallback cannot live only in `phase2FallbackFollowUpRequestRef`: persist it immediately through the serialized store operation; follow-up sends reread the durable IndexedDB draft/hash behind generation, mount, and hash fences. Cleanup awaits both `collaborationEventChainRef.current` and `collaborationStoreChainRef.current` before closing IndexedDB. [Task 3]
- An older A receipt may coexist with a newer dirty local B: project `LOCAL_SAVED` as `local_only` only when `dirty && !baseIsStale`; if B persistence fails, re-dispatch `LOCAL_FAILED` while mounted so an A receipt cannot mask `storage_error`. [Task 3]
- Validation for the repair: autosave collaboration suite `97/97`, combined Phase-3 matrix `178/178`, changed-file ESLint, Prettier, and `git diff --check` passed. Repository-wide typecheck stayed red only for unrelated pre-existing fixture/generated route-tree errors, with no diagnostics in changed files. [Task 3]
- Isolated runtime shape: inspect env key names without printing values; use a distinct strict port, verify one listener and HTTP response, preserve user port 5173, then stop only the owned process and remove only owned temporary symlinks. [Task 4]
- P1 reuses TanStack Query `AbortSignal`, exact query keys/cancellation, and local visibility listeners. Poll only for a visible, mounted, authorized editor with exact user/role/version/WorkRevision/EditSession/claim identity; `401`/`403`/`404` stop, while transient network/5xx failures get at most two jittered/backoff retries. [Task 5]
- Continuity service accepts an optional `AbortSignal` while retaining `QUIET_REQUEST`; exact identity-bearing query keys prevent old generation data adoption. Backend/management contracts, autosave/collaboration wiring, Request-ID, and Toast behavior stay unchanged. [Task 5]
- For expected WorkRevision Presence of typically 1–2 and at most about 4 simultaneous people, the existing authorized exact room/socket and small full snapshots are sufficient; no global user load or separate Presence infrastructure. Show no UI for self alone; from two people show all present including self, label self “Du” in the popover, and expose only shortened name plus approximate module area. [ad-hoc note]

## Failures and how to do differently

- Symptom: TypeScript says `Type 'object' is not assignable to type 'Record<string, unknown>'` in notification validation -> use the existing `isExactObject` guard directly rather than assigning an `object` to a record. [Task 2]
- Symptom: a narrow documentation patch has invalid context or an awkward line break -> inspect exact surrounding text before patching. [Task 2]
- Symptom: full lint is red while the changed diff is clean -> retain baseline errors separately; use focused tests, typecheck, build, changed-file ESLint/Prettier, and `git diff --check` for the change gate. [Task 1][Task 2]
- Symptom: a newer B fallback disappears after unmount -> B existed only in a React ref while A was in flight -> serialize immediate durable persistence and await the store chain during cleanup. [Task 3]
- Symptom: an A receipt reports `server_confirmed` after B storage failure, or `LOCAL_SAVED` masks `base_stale` -> re-project `LOCAL_FAILED`; gate local-only projection by `!baseIsStale`. [Task 3]
- Symptom: readiness curl cannot reach an agent-owned Vite listener -> it may be a sandbox-context boundary, not a process failure -> repeat the probe in the same execution context before diagnosing startup. [Task 4]
- Symptom: terminal polling behavior looks covered but hidden→visible/focus/reconnect is untested -> add lifecycle tests before final review. The P1 reviewer caught this P2 gap; full repo lint/Prettier remained red only for pre-existing files, while changed files, typecheck, full 3704-test suite, and diff checks were green. [Task 5]

# Task Group: Novari shared Curriculum WorkRevision Continuity Phase 2
scope: Cross-repo Phase-2 contract for one shared Curriculum WorkRevision Primary, truthful autosave/recovery, role-bound review actions, and the blocked index-readiness gate.
applies_to: cwd=/Users/mrbubbles/dev/novari/novari-education-portal and /Users/mrbubbles/dev/novari/novari-education-backend; reuse_rule=use only with the Phase-2 JavaScript-backend contract/branch; do not bypass the explicit duplicate-data decision or treat portal mock tests as real two-browser acceptance.

## Task 1: Implement shared server-side Primary and fail-closed bootstrap

### rollout_summary_files

- rollout_summaries/2026-08-05T18-21-33-u3xO-phase_2_shared_curriculum_workrevision_continuity.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/05/rollout-2026-08-05T20-21-33-019fd328-c980-7261-b59e-270efa8e800c.jsonl, updated_at=2026-08-08T11:47:41+00:00, thread_id=019fd328-c980-7261-b59e-270efa8e800c, success: backend and Portal implementation reviewed/pushed; real E2E blocked)

### keywords

- phase-2, shared-primary, activePrimary, whole-snapshot-CAS, Recovery, AUTH_ROLE_STALE, INDEX_NOT_READY, UNIQUE_INDEX_COLLISION, curriculum_work_revision_shared_primary_open_unique, CURRICULUM_WORK_REVISION_TAKEOVER_NOT_REQUIRED

## Task 2: Align Portal discovery, autosave truth, and shared review permissions

### rollout_summary_files

- rollout_summaries/2026-08-05T18-21-33-u3xO-phase_2_shared_curriculum_workrevision_continuity.md (cwd=/Users/mrbubbles/dev/novari/novari-education-portal, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/05/rollout-2026-08-05T20-21-33-019fd328-c980-7261-b59e-270efa8e800c.jsonl, updated_at=2026-08-08T11:47:41+00:00, thread_id=019fd328-c980-7261-b59e-270efa8e800c, cross-repo contract evidence)

### keywords

- activePrimary, ownPrimary, hasOpenWorkRevision, hasOwnOpenWorkRevision, WORK_REVISION_SAVED, WORK_REVISION_RECOVERY_SAVED, AUTH_TOKEN_INVALID, AUTH_ROLE_STALE, autosave, takeover, submit, withdraw

## User preferences

- when the user requested Phase 2, they said “nicht dieses komplette System wieder neu umzubauen” and the UI/UX was “perfekt” -> reuse Sequence, Fence, EditSession, Recovery, and Autosave contracts; make logic/status/test changes only, not a redesign. [Task 1][Task 2]
- when the user required all currently authorized PDL and LMS Support users to work on the same overview -> treat `createdBy` as provenance only, never the normal access-control gate. [Task 1][Task 2]
- the user wanted regular Commit-Writer commits/pushes and clarification at real uncertainty -> checkpoint before risky persistence, authorization, or migration choices; keep authorized implementation blocks reviewable. [Task 1]
- when real two-browser acceptance was blocked, the user accepted contract/mock/fixture tests but no workaround -> report the gate plainly and do not perform DB cleanup, index installation, deployment, or production writes. [Task 2]

## Reusable knowledge

- Phase 2 has one version-wide shared server Primary. Current `pdl`/`lmsSupport` authorization is checked on every mutation; role removal/deactivation invalidates existing session writes. Whole-snapshot Sequence-CAS never silently overwrites: stale writes create a typed Recovery under the same Primary, with no automatic merge/fork. [Task 1]
- Bind review, submit, publish, import/export, topic/structure, and GitHub-path operations to the exact shared WorkRevision ID, Sequence, Basis, and Fence. PDL and LMS Support may Submit/Withdraw; Request Changes, Approve, Reopen, and Publish remain PDL-only. [Task 1][Task 2]
- `activePrimary` and `hasOpenWorkRevision` are authoritative; `ownPrimary` and `hasOwnOpenWorkRevision` are additive rollout-compatible aliases. Normal takeover UI/calls are removed, while historical `handed_over` data and exact receipt replays stay readable; new takeover mutations return 409 `CURRICULUM_WORK_REVISION_TAKEOVER_NOT_REQUIRED`. [Task 1][Task 2]
- Display saved only after adopting an exact matching `WORK_REVISION_SAVED` sequence. `WORK_REVISION_RECOVERY_SAVED`, failed local adoption, foreign sequence advances, 401, `AUTH_TOKEN_INVALID`, and `AUTH_ROLE_STALE` preserve local data/request IDs and block subsequent writes pending explicit resync/recovery. [Task 2]
- Readiness is fail-closed: read-only duplicate preflight, exact partial-unique-index verification/installation, then serving and background workers. Start workers only after DB, index, GitHub, job-recovery, heartbeat, and HTTP-bind readiness; stop timers first on shutdown. [Task 1]
- A local same-target Resolution identity/generation fence is Phase-3 defense-in-depth, not a Slice-4b blocker: the current Portal contract remounts on version/EditSession changes, standard accounts do not switch role, and shareholder roles retain the same persisted persona/Draft identity. Recheck if account, `userID`, `curriculumVersionId`, or `workRevisionId`/Draft identity can change inside one mounted autosave hook, or if remount/cleanup boundaries are removed. Then bind Store commit, reload, and hook adoption to exact `collaborationGeneration` and record identity; test a delayed Resolution across an identity change. [ad-hoc note]

## Failures and how to do differently

- The preflight found exactly two `UNIQUE_INDEX_COLLISION` cases for `curriculum_work_revision_shared_primary_open_unique`. Do not deduplicate, rewrite owners, install the index, or write DB/Production data without a separately approved manual data decision; `INDEX_NOT_READY` is the intended fail-closed result, not an implementation defect. [Task 1][Task 2]
- Do not represent a stale receipt or Recovery as a successful autosave checkpoint. Keep the candidate dirty and require resync so the next write cannot reuse an unsafe sequence. [Task 2]
- Four Portal lint errors/four warnings and 470 Prettier files were pre-existing. Keep these baseline defects separate from changed-file gates and do not widen this scope to fix them. [Task 2]

# Task Group: Codex orchestration, shared-project safety, and proportional reasoning
scope: Auditing Orchestrate against global/project AGENTS rules, selecting a safe pilot moment in shared Novari work, and assigning reasoning effort by role and uncertainty.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat; reuse_rule=safe as a cross-project Codex workflow default; always read applicable global and project-local AGENTS.md before action and keep project contracts authoritative.

## Task 1: Assess Orchestrate compatibility with global and project-local AGENTS rules

### rollout_summary_files

- rollout_summaries/2026-07-29T18-52-12-0C2q-orchestrate_webmcp_docs_and_live_troubleshooting.md (cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/29/rollout-2026-07-29T20-52-12-019faf38-54a1-7353-9feb-54f586c2fcbe.jsonl, updated_at=2026-08-10T19:25:30+00:00, thread_id=019faf38-54a1-7353-9feb-54f586c2fcbe, success: no material conflict found)

### keywords

- orchestrate, AGENTS.md, assignments/AGENTS.md, shared Novari project, subagents, distinct ownership, leaf workers

## Task 2: Choose a safe Orchestrate pilot for the active Curriculum Refactor

### rollout_summary_files

- rollout_summaries/2026-07-29T18-52-12-0C2q-orchestrate_webmcp_docs_and_live_troubleshooting.md (cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/29/rollout-2026-07-29T20-52-12-019faf38-54a1-7353-9feb-54f586c2fcbe.jsonl, updated_at=2026-08-10T19:25:30+00:00, thread_id=019faf38-54a1-7353-9feb-54f586c2fcbe, success: use only on the next decomposable task)

### keywords

- Curriculum Refactor, final review, Git handoff, shared work, pilot, next larger task, /Users/mrbubbles/dev/novari/novari-education-portal

## Task 3: Assign reasoning effort for scouts, workers, and orchestrators

### rollout_summary_files

- rollout_summaries/2026-07-29T18-52-12-0C2q-orchestrate_webmcp_docs_and_live_troubleshooting.md (cwd=/Users/mrbubbles/Documents/Codex/2026-07-29/realtime-voice-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/29/rollout-2026-07-29T20-52-12-019faf38-54a1-7353-9feb-54f586c2fcbe.jsonl, updated_at=2026-08-10T19:25:30+00:00, thread_id=019faf38-54a1-7353-9feb-54f586c2fcbe, partial: workflow guidance, not account-specific measurement)

### keywords

- reasoning_effort, Scout, Worker, Smart Worker, low, medium, high, token use, context size, tool usage

## User preferences

- The user calls ChatGPT “Mika” and refers to Mika as female. [ad-hoc note]
- when discussing shared Novari work, the user said they work with another person and want to avoid “damit wir nachher anderen nichts kaputt machen” -> audit shared-project rules read-only first; do not rewrite communal AGENTS files or inject personal workflow preferences without approval. [Task 1]
- when the active Curriculum Refactor was already in final review/Git handoff, the user did not want shared work disturbed -> do not inject Orchestrate late; use the next larger, not-yet-started, clearly decomposable task as the pilot. [Task 2]
- when choosing the orchestrator level, the user did not want High used globally -> choose reasoning by role and difficulty rather than defaulting every agent to High. [Task 3]
- when the user said they were “extrem zufrieden” with the current workflow and `sol-advisor` might be “way too much” -> retain the lightweight Orchestrate flow; make Luna an optional consideration, not a mandated/default model route. Keep model-specific guidance in a separate paragraph so general ownership rules are not misread as Luna-specific. [Task 4]
- for Novari architecture, use the real codebase, current use case, and current scale first; do not introduce multi-instance/platform-scale infrastructure, registries, pollers, caches, heartbeats, outboxes, or protocols without a measured requirement. For WorkRevision collaboration, design for typically 1–2 and at most about 4 simultaneous people, not hundreds in one revision. [ad-hoc note]
- the user normally works on Novari Monday–Friday around 09:00–16:00; AI-agent-supported estimates may assume roughly 2–3× conventional manual implementation speed, while weekend/private-project work is flexible rather than a delivery commitment. [ad-hoc note]

## Reusable knowledge

- Orchestrate has no material conflict with the audited global/project AGENTS rules: it governs execution, while AGENTS rules add domain contracts, review requirements, shared-project boundaries, and safety constraints. Do not remove global AGENTS rules to use it. [Task 1]
- Trivial work need not be split. For substantive work, use focused scouts with distinct ownership and no overlap; the coordinator integrates results and leaf workers do not delegate. The `assignments` wording is a possible refinement, not proof that every task must spawn agents. [Task 1]
- Orchestrate is a work mode, not a reason to rebuild active work or remove AGENTS.md. A task already using separate reviews/checks and nearing handoff is better finished unchanged. [Task 2]
- Scout = low/light for narrow read-only research; Worker = medium for routine implementation/checks; Smart Worker = high for difficult, uncertain, or coordinating work. Use medium for the orchestrator by default and high only for material uncertainty, risk, or complex coordination. Token usage has no verified special cost for switching levels; it also depends on model, context, tool usage, task length, and actual thinking depth. [Task 3]
- For very clear, bounded, independently verifiable work, Luna may be considered with `reasoning_effort: "high"` and `fork_turns: "none"`. Its assignment must itself supply context, constraints, paths, acceptance criteria, and expected output; a leaf worker does not delegate further. Terra remains a situational option, not a fixed rule. [Task 4]
- During Codex cleanup, preserve `/Users/mrbubbles/Documents/Codex/2026-05-21/files-mentioned-by-the-user-4fde6af8` (Nova-Pet), `/Users/mrbubbles/Documents/Codex/2026-07-25/wir` (Lio/Mika/Ember assets), Codex Memories, generated images, and the attachment store by default. Reassess attachments only after related tasks were deleted in the app and orphan status was verified. [ad-hoc note]
- For WorkRevision presence, the existing Socket and authorized exact WorkRevision room are sufficient: small complete snapshots are appropriate; do not globally load users or add separate presence infrastructure. Show no UI for one person; from two people, show everyone including self, label self “Du” in the popover, and expose only shortened name plus approximate module area. [ad-hoc note]

## Failures and how to do differently

- Symptom: a late-stage shared task is retrofitted with delegation -> this adds context and handoff risk. Finish it, then pilot on a new explicitly decomposable task. [Task 2]
- Symptom: token guidance is stated as account-specific fact -> it was only general documentation/community guidance. State the uncertainty rather than claiming a measured switching surcharge. [Task 3]
- Symptom: model-specific context guidance is embedded in the general orchestration paragraph -> it makes later general rules appear model-specific. Isolate optional Luna routing in its own paragraph. [Task 4]

# Task Group: Codex thread monitoring, heartbeat, and fail-closed macOS sleep
scope: Creating and using the installed `watch-codex-threads` workflow to monitor a fixed snapshot of selected active Codex tasks, clean up its heartbeat, and sleep the Mac only after verified clean completion; host timeouts must fail closed.
applies_to: cwd=/Users/mrbubbles/Documents/Codex/2026-07-21/{ich,new-chat}, /Users/mrbubbles/Documents/Codex/2026-07-22/new-chat, /Users/mrbubbles/Documents/Codex/2026-07-30/new-chat, /Users/mrbubbles/Documents/Codex/2026-08-14/new-chat, /Users/mrbubbles/Documents/Codex/2026-09-02/watch-codex-threads-users-mrbubbles-codex, and /Users/mrbubbles/dev/Codex/2026-09-07/new-chat; reuse_rule=safe for related Codex Desktop thread-monitoring runs on this Mac; exact target IDs, automation IDs, scheduler timing, quarantine paths, and completion state are run-specific.

## Task 1: Monitor all selected active tasks hourly and cancel the sleep gate on an unprovable completion

### rollout_summary_files

- rollout_summaries/2026-08-30T02-14-43-QfMM-watch_codex_threads_hourly_sleep_gate_cleanup.md (cwd=/Users/mrbubbles/Documents/Codex/2026-08-30/new-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T04-14-43-01a05072-9bc2-7c43-a97e-44e00a6e301c.jsonl, updated_at=2026-08-30T04:19:36+00:00, thread_id=01a05072-9bc2-7c43-a97e-44e00a6e301c, monitor and sleep gate safely cleaned up)

### keywords

- watch-codex-threads, alle; 1h, list_threads, wait_threads, read_thread, afterCursor, sleep_gate.sh --cancel, sauber abgeschlossen, braucht Aufmerksamkeit, no-sleep

## Task 2: Stop the 30-minute monitor immediately and leave sleep fail-closed

### rollout_summary_files

- rollout_summaries/2026-09-02T02-04-50-vrau-watch_codex_threads_stop_cleanup.md (cwd=/Users/mrbubbles/Documents/Codex/2026-09-02/watch-codex-threads-users-mrbubbles-codex, rollout_path=/Users/mrbubbles/.codex/archived_sessions/rollout-2026-09-02T04-04-50-01a05fdc-a228-78b2-847b-e26ad3d2e2fe.jsonl, updated_at=2026-09-02T10:02:27+00:00, thread_id=01a05fdc-a228-78b2-847b-e26ad3d2e2fe, temporary heartbeat and gate fully stopped)

### keywords

- watch-codex-threads, alle; 30m, 01a044dc-379d-77f1-9b6d-9777d1d96d08, 01a05fdc-a228-78b2-847b-e26ad3d2e2fe, Überwachung stoppen, timeoutMs:0, idle, completed, read_thread, sleep gate is not armed, Exit 66

## Task 3: Monitor a single Logging-V2 task and trigger sleep after explicit user confirmation

### rollout_summary_files

- rollout_summaries/2026-09-07T00-27-19-m2n6-watch_logging_v2_task_and_trigger_sleep.md (cwd=/Users/mrbubbles/dev/Codex/2026-09-07/new-chat, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/07/rollout-2026-09-07T02-27-19-01a07943-281e-70f0-8da0-e0a7d6551c20.jsonl, updated_at=2026-09-07T02:23:36+00:00, thread_id=01a07943-281e-70f0-8da0-e0a7d6551c20, heartbeat removed and macOS sleep trigger succeeded after explicit confirmation)

### keywords

- watch-codex-threads, Logging V2 Abschluss koordinieren, tempor-rer-logging-v2-30m-20260907, rrule, FREQ=MINUTELY;INTERVAL=30, limit:50, turnLimit:10, idle, completed, Nutzerbestätigung, sleep_gate.sh --trigger

## User preferences

- when monitoring a task under a limit, the user said “bei 20% limit use (also 80% left) er soll stoppen” -> use that exact, explicitly reported usage threshold; never infer usage from token counts, and do not portray a message to the target as an enforced interrupt. [Task 1]
- when sleep was requested after that stop rule -> sleep only after confirmed clean or rule-conform self-stop; an unclear target status remains `braucht Aufmerksamkeit`. [Task 1]
- when the user says “alle; 1h” -> select the fixed set of clearly active foreign tasks, exclude the monitor itself, use the hourly interval, and do not automatically add later tasks. [Task 1]
- when the user says “überwachung stoppen” -> directly stop the known temporary heartbeat and cancel/verify the linked sleep gate; do not run another monitoring cycle or trigger sleep. [Task 2]
- when technical status was `idle`/`completed` but no final assistant message was retrievable, the user explicitly said “Der task is fertig” and “Ich bin hiermit die abschließende Nachricht 😜” -> accept that only as an additional confirmation after a fresh error-free terminal snapshot; otherwise remain fail-closed. [Task 3]

## Reusable knowledge

- `list_threads` accepts at most `limit: 50`; `limit: 100` returns `limit: Too big: expected number to be <=50.`. Repeated `wait_threads({targets:[...], timeoutMs:0})` hangs are an unknown-status signal, not a terminal state. [Task 1]
- Cancel the armed gate first and verify `sleep gate is not armed` (exit 66). If official `automation_update` deletion/pause remains blocked, only the exact identified heartbeat directory may be moved to a documented, recoverable quarantine after gate deactivation; this verifies containment, not official automation deletion. [Task 1]
- `idle`, `notLoaded`, or `latestTurn.status: completed` alone is not clean completion: read the final answer. Keep the cursor only after a `read_thread` check; if any selected task lacks a retrievable completed outcome, delete the heartbeat, cancel the gate, confirm the arm session is `cancelled`, remove the state path, and do not sleep. [Task 1]
- Safe order from the 30-minute run: verify gate status → `wait_threads(timeoutMs:0)` → on status change `read_thread` → only after a retrievable clean result delete heartbeat, freshly verify, then trigger. An `idle` completed target without an accessible final answer is `braucht Aufmerksamkeit`; the observed stop ended with heartbeat deleted, arm session `cancelled`, and `sleep gate is not armed` (exit 66). [Task 2]
- API bounds: use `list_threads({limit:50})` or fewer and `read_thread({turnLimit:10})` or fewer. A 30-minute heartbeat uses `rrule:"FREQ=MINUTELY;INTERVAL=30"`, not an interval object. [Task 3]
- In the confirmed terminal case, safely remove the heartbeat, take a fresh `wait_threads(timeoutMs:0)` snapshot, arm a new gate, then trigger; a previously cancelled gate must not be reused. [Task 3]

## Failures and how to do differently

- Symptom: `wait_threads({timeoutMs:0})` repeatedly hangs -> stop polling, cancel the sleep gate, prevent sleep, and report `braucht Aufmerksamkeit`; do not assume a terminal target state. [Task 1]
- Symptom: no real thread-interrupt tool and `automation_update` is blocked -> `send_message_to_thread` can request a self-stop but cannot enforce one. After confirmed gate cancellation, use a narrowly scoped reversible quarantine only for the exact stuck heartbeat folder; do not edit or broadly remove automation files. [Task 1]
- Symptom: monitoring finds an open P2 or incomplete final review -> do not arm sleep just because other subtasks look done; report the blocker and stop the gate. [Task 2]
- Symptom: a manual stop is interpreted as permission to broadly modify Codex state. Fix: act only on the known temporary automation and its associated gate; verify the gate is unarmed and report no automatic sleep. [Task 2]
- Symptom: `idle`/`completed` has no readable completion content. Fix: delete the heartbeat and cancel the gate; inform the user. Only a fresh error-free terminal snapshot plus explicit user confirmation permits a later new-gate trigger. [Task 3]
# Task Group: Inlyra durable card decisions and bounded IMAP review reads
scope: Card-first, provider-neutral local-agent review work: durable local Composer decisions, browser-safe review projections, and fail-closed one-message IMAP reads.
applies_to: cwd=/Users/mrbubbles/dev/private/projects/inlyra; reuse_rule=safe for related Inlyra review-ui/local-agent work; branch/commit status is checkout-specific, while provider-action and bounded-read safety rules are reusable.

## Task 1: Persist durable local Composer decisions

### rollout_summary_files

- rollout_summaries/2026-06-22T00-44-05-O7Pw-inlyra_handoff_current_dirty_worktree.md (cwd=/Users/mrbubbles/dev/private/projects/inlyra, rollout_path=/Users/mrbubbles/.codex/sessions/2026/06/22/rollout-2026-06-22T02-44-05-019eecc8-d604-7a93-bee1-f4387b227ab6.jsonl, updated_at=2026-09-05T12:54:26+00:00, thread_id=019eecc8-d604-7a93-bee1-f4387b227ab6, current dirty-worktree handoff)

### keywords

- inlyra, card-first, composer, localStorage, inlyra.review.codexWorkItems.v1, queuedInstruction, decisionId, Review, Queue, Working, Done

## Task 2: Enforce bounded IMAP review reads and capability remediation

### rollout_summary_files

- rollout_summaries/2026-09-05T12-57-09-IH3b-inlyra_bounded_gmail_proof_and_start_connect_plan.md (cwd=/Users/mrbubbles/dev/private/projects/inlyra, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T14-57-09-01a071a4-ecb6-7c70-ab68-8e80400c4d91.jsonl, updated_at=2026-09-05T17:52:22+00:00, thread_id=01a071a4-ecb6-7c70-ab68-8e80400c4d91, browser-boundary hardening and one-message proof)

### keywords

- IMAP, ESEARCH RETURN (MIN), boundedReadOnly, boundedSearchUnavailable, candidateCanRetryBoundedSearch, IMAP-Begrenzung erneut prüfen, snapshot-fingerprint, stateDir, State Doctor, 90209b4

## Task 3: Update the existing continuation handoff while the Goal is paused

### rollout_summary_files

- rollout_summaries/2026-06-22T00-44-05-O7Pw-inlyra_handoff_current_dirty_worktree.md (cwd=/Users/mrbubbles/dev/private/projects/inlyra, rollout_path=/Users/mrbubbles/.codex/sessions/2026/06/22/rollout-2026-06-22T02-44-05-019eecc8-d604-7a93-bee1-f4387b227ab6.jsonl, updated_at=2026-09-05T12:54:26+00:00, thread_id=019eecc8-d604-7a93-bee1-f4387b227ab6, canonical handoff refreshed while paused)

### keywords

- docs/codex-handoffs/2026-06-22-inlyra-card-first-continuation.md, paused Goal, 90209b4, reactivation prompt, handoff-only, prettier --check

## Task 4: Repair the Gmail-session probe and prove one bounded local-card flow

### rollout_summary_files

- rollout_summaries/2026-09-05T12-57-09-IH3b-inlyra_bounded_gmail_proof_and_start_connect_plan.md (cwd=/Users/mrbubbles/dev/private/projects/inlyra, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T14-57-09-01a071a4-ecb6-7c70-ab68-8e80400c4d91.jsonl, updated_at=2026-09-05T17:52:22+00:00, thread_id=01a071a4-ecb6-7c70-ab68-8e80400c4d91, one-message proof complete; normal connection flow planned)

### keywords

- Gmail-session, start-login.command, chmod: --: No such file or directory, local-agent, 127.0.0.1:5173, one-email test, Composer, Queue, Working, Done, inlyra.mrbubbles-src.dev

## User preferences

- when shaping Inlyra, the user required a Codex-native inbox sweep: "one card, explanation, proposed action, scoped Composer, saved decision, next card" -> preserve this low-mental-load loop and avoid mail-client or Gmail-dashboard drift [Task 1]
- the user requires German text with umlauts, Lio as assistant name, `codex/...` branches, in-app Browser verification, lightweight review before finalization, and cleanup of self-started servers -> apply these defaults in similar Inlyra work [Task 1]
- provider-visible actions must never happen without explicit approval -> keep local queue/feedback state distinct from send/archive/delete/move/mark-read/unsubscribe actions [Task 1][Task 2]
- when the user said “stop erstmal alles was du machst und beende alle deine persönlichen toolcalls” -> stop agents/processes/tool calls and make no further edits until explicit reactivation. [Task 2][Task 3]
- technical source failures belong in source remediation/troubleshooting, not hidden or silently retried [Task 2]
- when the delegated request said to update the existing concise handoff and stop because the Goal is paused -> modify only the canonical continuation document; do not create a duplicate or resume feature work [Task 3]

## Reusable knowledge

- `apps/review-ui` work items are browser-local fallback state under `inlyra.review.codexWorkItems.v1`: defensively parse, clear invalid state, cap history at 100, and replace a card’s old item when it is re-queued. Items carry `decisionId`, `decisionKind: "queuedInstruction"`, timestamps, card identity, prompt, and `queued|working|done` status. [Task 1]
- IMAP review reads require exact limit `1`, server-side `ESEARCH RETURN (MIN)`, and fetch only the discovered UID. Reject unbounded arrays, malformed ESEARCH fields, invalid cursor ranges, and mismatched fetched UIDs before persistence. [Task 2]
- Record missing ESEARCH as snapshot-bound `boundedSearchUnavailable`; a successful same-snapshot read or changed configuration clears it. The retry (`candidateCanRetryBoundedSearch` / `IMAP-Begrenzung erneut prüfen`) remains bound to source, sweep, snapshot fingerprint, run version, and max one message. [Task 2]
- Browser-safe responses need explicit allowlist DTO projections and strict nested guards; `approvalRef` must be opaque, server-keyed, bound to exact action intent, and remain local evidence rather than executing a provider action. Rich runtime/CLI diagnostics stay server-side. [Task 2]
- Canonical continuation artifact: `docs/codex-handoffs/2026-06-22-inlyra-card-first-continuation.md`. On `codex/inlyra-durable-card-decisions` the refreshed handoff distinguishes its current 56 tracked/3 untracked dirty-worktree evidence from historical checks and directs a future independent hardening-diff review before commit/push. [Task 3]
- One explicitly approved technical-only Gmail-session proof used `/v1/review-read` with max one message: exactly one message/card was created and Composer → Queue → Working → Done survived reload. It did not evaluate mail content or perform any provider action; the sweep was disabled again afterward. [Task 4]
- Normal connection work is planned, not implemented: start with the local starter, reconnect an already configured Gmail-session account, then address deployed pairing only after HTTPS deployment and synthetic browser validation. Do not weaken loopback-only CORS or reuse sweep-oriented LaunchAgent modules as the normal agent server. [Task 4]

## Failures and how to do differently

- Symptom: a React-memory-only queue appears durable during one session -> explicitly test persistence and reload behavior before calling a UI slice durable. [Task 1]
- Symptom: a persisted capability blocker has no recovery path -> expose an explicit fail-closed bounded retry that rechecks capability before UID search, and test both persistence and successful clearing. [Task 2]
- Symptom: loopback HTTP integration tests fail with `listen EPERM 127.0.0.1` -> distinguish sandbox binding limits from application assertion failures; do not report that as a product-test regression. [Task 2]
- Symptom: historical green checks are reported as final state. Fix: inspect the canonical handoff and current dirty diff; require independent review, a full rerun, commit, and push before calling the hardening slice complete. [Task 1][Task 2][Task 3]
- Symptom: normal connection planning drifts into another live-mail run or bypasses browser security. Fix: implement the local starter first and keep deployed-origin pairing blocked by loopback-only CORS until a deployed HTTPS origin and synthetic validation exist. [Task 4]

# Task Group: Faverelay bookmark-profile UX, multi-way sync design, and browser-adapter continuation
scope: macOS SwiftUI profile work plus equal-participant multiway design, capability-gated safe fallback, and the completed Chromium mutation Slice 18.
applies_to: cwd=/Users/mrbubbles/dev/private/projects/faverelay; reuse_rule=safe for future Faverelay UI/sync-flow/design work in this checkout; live browser QA, branch state, and Task 17 authorization must be rechecked.

## Task 1: Analyze the current sync contract and define multi-way synchronization

### rollout_summary_files

- rollout_summaries/2026-07-18T20-41-53-xDPF-refresh_faverelay_multiway_sync_handoff.md (cwd=/Users/mrbubbles/dev/private/projects/faverelay, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/18/rollout-2026-07-18T22-41-53-019f76f6-cbcb-7d70-a46d-d40f2ba25327.jsonl, updated_at=2026-09-05T12:55:33+00:00, thread_id=019f76f6-cbcb-7d70-a46d-d40f2ba25327, verified continuation handoff)

### keywords

- Faverelay, mergeOnly, multi-way-sync, SyncRule, BookmarkSyncPlan, tombstones, conflicts, Slice-14, stop-rule, backupRetentionLimit, hosted-preview

## Task 2: Implement and stop after Slice 16 New Browser Setup Assistant

### rollout_summary_files

- rollout_summaries/2026-07-18T20-41-53-xDPF-refresh_faverelay_multiway_sync_handoff.md (cwd=/Users/mrbubbles/dev/private/projects/faverelay, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/18/rollout-2026-07-18T22-41-53-019f76f6-cbcb-7d70-a46d-d40f2ba25327.jsonl, updated_at=2026-09-05T12:55:33+00:00, thread_id=019f76f6-cbcb-7d70-a46d-d40f2ba25327, verified continuation handoff)

### keywords

- NewBrowserSetupService, NewBrowserSetupTransaction, NewBrowserSetupLedger, Task 16, Task 17, capability-gated, 03d4d04, worker queue, continuation gate

## Task 3: Implement, verify, and stop after Slice 18 Chromium multiway mutation

### rollout_summary_files

- rollout_summaries/2026-07-18T20-41-53-xDPF-refresh_faverelay_multiway_sync_handoff.md (cwd=/Users/mrbubbles/dev/private/projects/faverelay, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/18/rollout-2026-07-18T22-41-53-019f76f6-cbcb-7d70-a46d-d40f2ba25327.jsonl, updated_at=2026-09-05T12:55:33+00:00, thread_id=019f76f6-cbcb-7d70-a46d-d40f2ba25327, Slice 18 baseline and explicit stop gate)

### keywords

- Slice 18, codex/multiway-sync-profiles, ChromiumBookmarkMutator, MultiwayRunAvailability, relay IDs, recovery checkpoint, swift test -j 1, 448 tests in 41 suites, c835e6b

## Task 4: Harden live matrix, complete Firefox, and preserve Safari's write gate

### rollout_summary_files

- rollout_summaries/2026-09-05T12-58-21-ZYL6-faverelay_slices_19_21_live_matrix_firefox_safari_gated.md (cwd=/Users/mrbubbles/dev/private/projects/faverelay, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T14-58-21-01a071a6-0620-7d91-9cea-b9113cc549b0.jsonl, updated_at=2026-09-05T16:56:00+00:00, thread_id=01a071a6-0620-7d91-9cea-b9113cc549b0, Slices 19–21 complete; Safari remains read/source-only)

### keywords

- Slice 19, --allow-profile, hard Chrome rejection, Faverelay Live Matrix, 22f80ad, Slice 20, Firefox, Places schema 86, efd23ad, Slice 21, Safari, SafariTabs.db, b097d6a, 537 tests

## User preferences

- when the user said “bis jetzt noch nichts implementieren, wir reden jetzt gerade nur” -> inspect and explain the current sync contract before editing during design discussion. [Task 1]
- the user wants browser profiles as equal participants; keep safe additive mode available, make true multiway the intended default, explain the distinction in onboarding, and allow Settings to switch it. [Task 1]
- when the user corrected “du solltest doch aufhören wenn der slice fertig ist.” -> once the requested slice is complete, stop immediately and report remaining work instead of continuing autonomously. [Task 1][Task 2]

## Reusable knowledge

- Slice 16 (`03d4d04`) adds a five-step capability-gated New Browser Setup Assistant. Verified-empty joining is additive-only; existing joiner content contributes to the union and active peer stores are not written. Real production adapters were not promoted, so no installed-app/live-browser QA was run. [Task 2]
- Invalid target-local mappings are isolated to the target; valid targets continue. A source change with old source-owned selected/excluded keys fails closed until the user confirms draft-only `Rebind Selection to This From Profile`; rebind clears only source-specific bootstrap keys and preserves Relay IDs, mappings, scope policy, and browser data until Save. [Task 1]
- `SafariTabs.db` is the Safari-profile source; bookmark folders are not browser profiles. Use the existing immutable read-only SQLite/file-grant path and fail closed on unusable discovery. `documentation/browser-adapters.md` and `CHANGELOG.md` in the current repo remain authoritative. [ad-hoc note]
- Slice 18 implemented Chromium create/update/rename/move/reorder/delete by native node ID, exact plan/revision/deletion-policy binding, post-write verification, idempotent recovery, Relay-ID selection, and capability gating. It passed build, parser, App Store source baseline, diff check, independent correctness/data-safety review, and `448` tests in `41` suites; `c835e6b` is clean on `codex/multiway-sync-profiles`. [Task 3]
- The refreshed handoff is `documentation/codex-handoffs/2026-07-19-multiway-sync-profiles.md` at documentation commit `7b12ac9`. Slices 1–18 are completed despite stale early plan checkboxes; Slices 19–23 remain pending and require explicit reactivation. Slice 19 first hardens `--live-matrix` with explicit profile allowlists, hard Chrome rejection, marker-only synthetic scope, backup/restore, and redacted reporting. [Task 1][Task 3]
- Slice 19 uses explicit absolute `--allow-profile` entries, hard Chrome exclusion, marker-only synthetic scope, exact backup/restore, and redacted opaque reports; it proves mutator/planner restoration, not all product UI/scheduler/Ledger paths. Slice 20 supports only verified existing Firefox Places schema 86 stores. [Task 4]
- Slice 21 (`b097d6a`) validated UUID-backed Safari favorites mapping and access, but Safari remains read/source-only: sparse native lists and lossless-serialization risks must fail closed until installed-app native write/reopen/restore is separately proven. Slice 22/23 were intentionally not started. [Task 4]

## Failures and how to do differently

- The first source-ownership fix made changed-source drafts unsaveable; preserve the fail-closed gate and offer an explicit confirmation-driven rebind rather than weakening it. [Task 1]
- Green tests alone were insufficient: independent review found the missing rebind path. Require review and current-state verification before calling a slice complete. [Task 1]
- Do not infer general browser/product QA from the live matrix: it is marker-scoped and Chrome is never accessed. [Task 4]
- Symptom: Safari native data has sparse folders or an XML/plist round-trip would alter values. Fix: reject preparation/write with the lossless-serialization gate; do not infer productive Safari support from fixtures, access audit, or copied-store mutation. [Task 4]
# Task Group: Bubbles-verse Bubblophy status, agent contracts, and Phase-2 handoff continuity
scope: Bubblophy MVP status, branch/history verification, repo-local handoff usage, and the user’s preference for committed continuation artifacts inside the Bubbles-verse monorepo.
applies_to: cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse and related Bubblophy worktrees; reuse_rule=safe for future Bubblophy continuation/status tasks in this monorepo, but branch names, commits, and local worktree state are checkout-specific.

## Task 1: Audit Bubblophy MVP scope and agent access

### rollout_summary_files

- rollout_summaries/2026-07-18T13-35-08-lkcr-bubblophy_phase_2_handoff_and_status_audit.md (cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/18/rollout-2026-07-18T15-35-08-019f7570-17dc-7d33-a6c4-17044c0be30b.jsonl, updated_at=2026-09-05T13:00:40+00:00, thread_id=019f7570-17dc-7d33-a6c4-17044c0be30b, verified Phase-2 status and handoff)

### keywords

- bubblophy, MVP_STATUS, agent-projects, agent-runs, runs:update, remote-MCP, Supabase OAuth 2.1, human-approved runs

## Task 2: Implement Issue-Review notifications and preserve the Phase-2 stop boundary

### rollout_summary_files

- rollout_summaries/2026-07-18T13-35-08-lkcr-bubblophy_phase_2_handoff_and_status_audit.md (cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse, rollout_path=/Users/mrbubbles/.codex/sessions/2026/07/18/rollout-2026-07-18T15-35-08-019f7570-17dc-7d33-a6c4-17044c0be30b.jsonl, updated_at=2026-09-05T13:00:40+00:00, thread_id=019f7570-17dc-7d33-a6c4-17044c0be30b, Phase-2 scope and stop boundary audited)

### keywords

- issue-review-notifications, IssueReviewProjectScope, `(issueKey, updatedAt)`, projectIsArchived, `--maxWorkers=1 --no-file-parallelism`, 205/205, bf67ca8, runs:update, plans:write

## Task 3: Continue Phase 2 only; keep Phase 3 out of the active slice

### rollout_summary_files

- rollout_summaries/2026-09-05T13-01-12-RcRS-bubblophy_phase_2_a3_safe_activity_details.md (cwd=/Users/mrbubbles/dev/private/projects/bubbles-verse, rollout_path=/Users/mrbubbles/.codex/sessions/2026/09/05/rollout-2026-09-05T15-01-12-01a071a8-a26e-7a10-b188-9f76c284ac54.jsonl, updated_at=2026-09-05T16:30:25+00:00, thread_id=01a071a8-a26e-7a10-b188-9f76c284ac54, A3 safe audit-details slice committed locally)

### keywords

- Phase 2, Phase 3 out of scope, A3, safe audit details, activity-details-database.ts, ActivityEventDetails, membership/resource-bound Access-Read, 5472558, 1100/1100, ahead 6

## User preferences

- when the user said “stop was du machst und beende alle deine persönlichen toolcalls” -> immediately stop commands/sub-agents; preserve uncommitted work and do not test, format, edit, or commit until reactivated. [Task 1][Task 2]
- when asking “was fehlt noch” or “was war noch gleich der MVP umfang” -> distinguish completed MVP, intentional non-goals, and real post-MVP work with repo evidence rather than a generic status summary. [Task 1]
- handoffs must live permanently in the project; after an explicit stop, document the continuation and require explicit reactivation plus concrete-slice selection before feature work resumes. [Task 2]
- when the recommended Agent-Handoff UX was explained, the user authorized the concrete A3 slice with “ja klingt gut mach” -> explain the outcome and confirm the selected small slice before productive changes; retain separate review/documentation/commit boundaries. [Task 3]

## Reusable knowledge

- `apps/bubblophy/MVP_STATUS.md` is the compact MVP source of truth. The local human-in-the-loop MVP is feature-complete; autopilot, cloud runners, automatic agent starts, and free agent write rights are not MVP. Agent reads require `issues:read`; `runs:update` can only update run status/message/result JSON, while issue/plan/run creation scopes remain reserved. [Task 1]
- The Issue-Review slice (`bf67ca8`) uses a live paginated review page separate from run `needs_review`, revalidates membership/project/issue/status/timestamp, returns empty on an archive race, and keys the local resolve overlay by `(issueKey, updatedAt)`. Focused `205/205`, lint/typecheck/build, and review passed; two parallel full-suite timing/dialog failures were isolated green. [Task 2]
- Current Phase-2 handoff: `docs/archive/codex-handoffs/2026-09-05-bubblophy-phase-2-continuation.md`, committed as `2a292cc` on `feature/bubblophy-phase-2` (`+1/-0` vs Origin, not pushed at observation). It records completed Remote-MCP/OAuth/role/invitation/dashboard/review-feed work and explicitly parks staging smoke, deployment/monitoring/backups, scaling checks, invitation delivery, OAuth grant management, and visual regression testing. [Task 2]
- A3 projects audit details only in the final membership-/resource-bound Access-Read: status/priority/role transitions preserve before/after (including JSON `null`), while content/assignment/invitation families disclose stored field names only. Candidate/browser DTOs must exclude raw payloads, internal IDs, reasons, and sensitive data; sample/fallback rows have no detail button. [Task 3]
- A3 retained A1/A2 filters, URL request fingerprints, cursor pagination, and access control. It passed 301 focused tests, 1,100/1,100 total tests, lint/typecheck/format/diff-check/build and independent HIGH-REVIEW PASS; `5472558` was locally committed and the branch was ahead 6, not pushed. [Task 3]

## Failures and how to do differently

- Symptom: a test command appears to have no output -> first observe or deliberately stop the existing process; never blindly start another Vitest pool. Run heavy checks serially with `--maxWorkers=1 --no-file-parallelism` when resource pressure is relevant. [Task 2]
- The committed Issue-Review slice is complete, but the larger Phase-2 Goal remains blocked after the explicit stop. Do not treat its Remote-MCP/OAuth/controlled-write/security/RLS/deployment work as done or continue it without reactivation. [Task 2]
- Symptom: a handoff broadly claims actor permissions or treats a recommended UX slice as already authorized. Fix: preserve deliberate `authUserId` member/assignee contracts, keep personal OAuth distinct from project agent tokens, and require a fresh user selection before implementation. [Task 1][Task 2]
- Symptom: a Bun/Vitest run is silent and grows to about 9 GB RAM. Fix: stop it cleanly, avoid parallel test pools, and use Node/Vitest serially with `--maxWorkers=1 --no-file-parallelism` and a bounded heap. SQL contract tests do not replace a real PostgreSQL/Auth/Staging E2E proof. [Task 3]
