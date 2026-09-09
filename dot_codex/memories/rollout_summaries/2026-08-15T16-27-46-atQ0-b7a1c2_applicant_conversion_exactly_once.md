thread_id: 01a00640-34d5-78f1-9bbc-848cefb5aebc
updated_at: 2026-08-15T16:47:22+00:00
rollout_path: /Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T18-27-46-01a00640-34d5-78f1-9bbc-848cefb5aebc.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: refactor/logging-system

# B7a.1c2 Applicant→Employee Conversion Exactly-once abgeschlossen

Rollout context: Im JavaScript-Backend `/Users/mrbubbles/dev/novari/novari-education-backend` wurde ausschließlich Slice B7a.1c2 auf `refactor/logging-system` umgesetzt. Startzustand war sauber bei `d53dd43d`, lokal/remote `0/0`; B7a.1c3 und andere Folgeslices blieben unangetastet.

## Task 1: Applicant→Employee Conversion Exactly-once

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich einen „ausschließlich“ auf `POST /auth/hr/applicants/:applicantId/convert-to-employee` begrenzten Slice, ohne Scope-Expand -> zukünftige Arbeiten in diesem Logging-Programm müssen Route, Dateien und benannte Ausschlüsse strikt einhalten.
- Der Nutzer verlangte vor der Lösungswahl ein echtes Replica-Set-Concurrency-Stop-Gate mit realen Unique-Indizes und sichtbaren Skips bei fehlender URI -> Race-/Rollback-Behauptungen künftig nicht aus Mock-Tests ableiten.
- Der Nutzer verlangte unabhängigen Review, fokussierte Tests, vollständigen `npm test`, engen Commit und normalen Push -> diese Sequenz beibehalten.

Key steps:

- Bestehende Transaktion, `createEmployeeAccount`, `logAuditEvent`, B5 und `skipGenericSuccessfulWriteAudit` wiederverwendet.
- Conversion-Route routeweise mit `skipGenericSuccessfulWriteAudit` markiert; `skipGenericWriteAudit` wurde nicht verwendet, damit B5-Fehlertelemetrie aktiv bleibt.
- `pendingEmissions` in den Transaction-Callback verschoben; nur der endgültig zurückgegebenen Transaktion zugehörige Pino-Emission wird nach Commit ausgeführt, und `201` wird erst danach gesendet.
- Enge Duplicate-Key-Behandlung ergänzt: Nur wenn ein post-abort Fresh-Read desselben Applicants einen gesetzten `convertedEmployeeRef` bestätigt, wird `APPLICANT_ALREADY_CONVERTED`/409 erzeugt. Andere `11000`-Fehler bleiben unverändert.
- Tests für Route-Marker, Retry-Leak, Duplicate-Replay, Rollback, Concurrency und Privacy hinzugefügt.
- Dokumentation in `CHANGELOG.md`, `docs/project-docs/security/audit-producer-inventory.md` und dem bestehenden Conversion-Abschnitt von `docs/project-docs/people/applicant-management.md` aktualisiert.

Failures and how to do differently:

- RED bestätigte zunächst fehlenden Marker und Callback-Leak (`[1,2]` statt nur committed attempt). Nach routeweisem Marker und attempt-lokalen Emissionen waren die Unit-Tests grün.
- Die echten Replica-Set-Rollback-/Race-Tests liefen wegen fehlendem `CURRICULUM_TEST_REPLICA_SET_URI` nicht; sie wurden sichtbar geskippt, nicht als ausgeführter Beweis ausgegeben.
- Ein anfänglicher Testfehler nahm die falsche Express-Stackposition an; der Marker liegt korrekt vor der Validation an Position 0.

Reusable knowledge:

- Der autorisierte `201`-Response-Body mit Employee-ID, Vorname, Nachname, E-Mail und Rolle blieb unverändert.
- Der fachliche Required-Owner `audit.applicant_converted_to_employee` ist der einzige Success-Owner; `audit.data_write` wird nur für diese Route unterdrückt.
- Erwartete 404 bleiben eventfrei; 400/409/422/5xx bleiben B5-eigene Fehlertelemetrie. Der Replay-409 erzeugt keine fachliche Mutation und kein Success-Audit.
- Commit `7917900bd59996958b666d9f01aacce2e38830ea` wurde normal nach `origin/refactor/logging-system` gepusht; Branch/Remote sind danach `0/0`, Worktree sauber.
- Checks: fokussiert 32 bestanden/0 fehlgeschlagen/4 erwartete Skips; Gesamt-Lint grün; vollständiges `npm test`: 6.657 bestanden, 0 fehlgeschlagen, 57 Skips; unabhängiger Review ohne P0–P3-Findings.

References:

- Runtime: `_hrManager/controller/applicantController.js`, `_hrManager/routes/applicantRouter.js`
- Tests: `tests/hr/applicantConversionDuplicateReplay.test.js`, `tests/hr/applicantConversionExactlyOnce.integration.test.js`, `tests/hr/applicantConversionExactlyOnceRoutes.test.js`, `tests/hr/applicantConversionTransactionRetry.test.js`
- Audit inventory: `docs/project-docs/security/audit-producer-inventory.md`
- Conversion contract: `docs/project-docs/people/applicant-management.md`
