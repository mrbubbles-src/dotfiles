thread_id: 01a00627-bdaf-7dc1-9721-f27a7e360405
updated_at: 2026-08-15T16:17:28+00:00
rollout_path: /Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T18-01-02-01a00627-bdaf-7dc1-9721-f27a7e360405.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: refactor/logging-system

# B7a.1c1 Applicant Workflow Exactly-once erfolgreich umgesetzt

Rollout context: Backend-Repository `/Users/mrbubbles/dev/novari/novari-education-backend`, Branch `refactor/logging-system`, Ausgangsstand `31414c204eb58e8d06ebaab4e7244ce7c0d4395a`, sauber und lokal/remote synchron.

## Task 1: Applicant Workflow Exactly-once

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich einen strikt begrenzten Slice: ausschließlich fünf aktive Applicant-Workflow-Routen und keine Applicant→Employee Conversion oder Folgeslices -> künftige Agents sollten Scope-Matrizen vor Edits bestätigen und Nachbarbereiche unangetastet lassen.
- Der Nutzer verlangte Reuse-first, unabhängigen Review, fokussierte plus vollständige Tests, engen Commit und normalen Push -> diese Gates sollten bei ähnlichen Datenintegritäts-Slices standardmäßig eingehalten und im Handoff belegt werden.

Key steps:

- Vollständige Spec, Slice-Plan und `AGENTS.md` gelesen; Start-Gate verifiziert.
- RED-Tests reproduzierten fehlende Success-Marker und Retry-Callback-Leak `[1,2]`.
- Exakt fünf Routen mit `skipGenericSuccessfulWriteAudit` versehen, jeweils nach Rollenprüfung und vor Validierung:
  - Technical Interview
  - Sample Lesson
  - Assessment Cancel
  - Assessment Evaluation
  - Final Decision
- `runWorkflowTransaction` korrigiert: Post-Commit-Callbacks werden pro Transaction-Versuch separat gepuffert; nur Callbacks des endgültig commitenden Versuchs werden ausgeführt.
- Tests, Inventar, Applicant-Dokumentation und Changelog eng aktualisiert.
- Unabhängiger Review meldete keine P0–P3-Findings.
- Commit `d53dd43d65bc61670f065650bdba7e31bb5e88e3` normal auf `origin/refactor/logging-system` gepusht; anschließend lokal/remote `0/0`, Worktree sauber.

Failures and how to do differently:

- Der erste fokussierte Testlauf scheiterte erwartungsgemäß an fehlenden Markern und Callback-Leak; nach dem Fix waren die fokussierten Tests grün.
- Echte Replica-Set-Rollback-/Race-Tests waren wegen fehlender `CURRICULUM_TEST_REPLICA_SET_URI` sichtbar geskippt, nicht künstlich grün gestuft. Dieses Restrisiko bei ähnlichen Runs ausdrücklich melden.

Reusable knowledge:

- Der globale Generic-Owner ist `middleware/auditWriteActions.js`; route-owned Success-Audits müssen `skipGenericSuccessfulWriteAudit` nutzen, niemals `skipGenericWriteAudit`, damit B5-Fehlertelemetrie erhalten bleibt.
- Die Applicant-Controller verwenden bestehende sessiongebundene Applicant-/Assessment-/Notification-/Audit-Transaktionen. Erfolgs-Codes bleiben unverändert: `audit.applicant_assessment_assigned`, `audit.applicant_assessment_cancelled`, `audit.applicant_assessment_completed`, `audit.applicant_final_decision`.
- Fokussierte Tests: 33 bestanden, 0 fehlgeschlagen, 2 sichtbare Replica-Set-Skips. Vollständiges `npm test`: 6.652 bestanden, 0 fehlgeschlagen, 55 erwartete Skips. `npm run lint`, `git diff --check` und `git show --check` grün.

References:

- `controller/applicantWorkflowController.js` — `runWorkflowTransaction`
- `router/applicantWorkflowRouter.js` — fünf routeweise Success-only-Marker
- `tests/hr/applicantWorkflowExactlyOnceRoutes.test.js`
- `tests/hr/applicantWorkflowTransactionRetry.test.js`
- `tests/hr/applicantWorkflowExactlyOnce.integration.test.js`
- `docs/project-docs/security/audit-producer-inventory.md`
- `docs/project-docs/people/applicant-management.md`
- `CHANGELOG.md`
