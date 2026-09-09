thread_id: 01a0504b-c9b4-7622-9f3f-fdac9f83f877
updated_at: 2026-08-30T02:09:01+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T03-32-19-01a0504b-c9b4-7622-9f3f-fdac9f83f877.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/766d/novari-education-backend

# CloudRun-Kalenderfehler an den globalen Error-Owner delegiert und mit realen Mount-Regressionen veröffentlicht

Rollout context: Novari-Backend-Worktree `/Users/mrbubbles/.codex/worktrees/766d/novari-education-backend`, Branch `chore/logging-improvements`, Baseline `65dbc607f98b20ea0ecc8ff5e121a79344fa1fdd`. Der Nutzer verlangte einen strikt begrenzten A1-Slice ohne Produktionsscope-Erweiterung, Logging-/Auditänderungen oder Commit/Push bis zum separaten Review.

## Task 1: Zentrale Error-Owner-Grenze für Kalendercontroller

Outcome: success

Preference signals:

- Der Nutzer verlangte eine „exakte Production-Allowlist“, keine Subagents, keinen Commit im ersten Turn und fail-closed Stop-Gates -> bei ähnlichen Änderungen zuerst Baseline, Branch, Remote, Cleanliness und Allowlist read-only verifizieren und Änderungen strikt begrenzen.
- Der Nutzer verlangte unveränderte kontrollierte 400/403/Upstream-Responses, Erfolgspayloads, MIME und Bytes sowie keine neue Logging-/Auditlogik -> bestehende lokale Pfade explizit schützen und nur die defekte Owner-Grenze ändern.
- Der Nutzer verlangte reale Controller-/Router-/Global-Handler-Evidenz und hostile-Data-Privacy-Assertions -> zentrale Fehlerpfade nicht ausschließlich mit internen Modul-Mocks testen.

Key steps:

- Ursache bestätigt: Alle drei Kalendercontroller fingen unbekannte Fehler ab und erzeugten lokal einen 500-Envelope, wodurch `globalErrorHandler` strukturierte 502-Fehler und unerwartete Fehler nicht erreichten.
- Kleinste Produktionsänderung: `next` zur Signatur von `listAgenda`, `listAbsenceMonth` und `listCourseQuarter` ergänzt; nur unbekannte Fehler werden mit `next(e)` weitergereicht. Bekannte `FORBIDDEN_READ`, `INVALID_MONTH_RANGE` und `INVALID_QUARTER_RANGE` bleiben lokal.
- Testdatei auf reale Router-/Auth-/Global-Handler-Pfade erweitert; nur externe `fetch`-Antworten wurden ersetzt. `calendarMapping`, Timing, `cloudRunAuth`, Router, Rollenmiddleware und globaler Handler liefen real.
- Ein zu breiter Log-Privacy-Sentinel verursachte zunächst 20/21; die Sentinels wurden in Provider- und öffentliche Querywerte getrennt. Der finale Fokuslauf war 21/21 grün.

Reusable knowledge:

- Reale Mounts: `app.use('/auth/cloudrun', verifyTokenMiddleware, csrfProtection, cloudrunRouter)` und danach `globalErrorHandler`.
- `globalErrorHandler` delegiert bei `res.headersSent` mit `next(err)` statt eine zweite Antwort zu schreiben.
- A1 ist nur eine corrective prerequisite; unerwartete 500 werden dadurch für den späteren A2-Owner erreichbar, aber A1 selbst fügt keine Persistenz, Audits oder Logs hinzu.

References:

- Fokus: `node --experimental-test-module-mocks --import ./tests/setupEncryptionKeys.js --test tests/calendar/cloudRunErrorProjection.test.js` -> 21/21.
- Regressionen: Global-Handler/Envelope 70/70; Persistenz-/Kalenderregressionen 67/67; zusammen 158/158.
- ESLint, `node --check` für alle vier Dateien und `git diff --check` erfolgreich.
- Produktionsblobs blieben unverändert: Role `f37c0b8733cc7a77bdf64f41c7234e98d5bc41f1`, Absence `6220b0e553120bed1f59f28bf6f50edf80f55103`, Course `098e0c388655d518913e6228374952d27921169b`.

## Task 2: High-Review-Testlücken schließen und Commit/Push

Outcome: success

Preference signals:

- Der Nutzer akzeptierte zwei P2-Testfindings, verlangte aber ausschließlich Testkorrekturen und bytegenau unveränderte Produktionsdateien -> bei Review-Follow-ups nur die bestätigten Evidenzlücken schließen und Produktionsblobs erneut vergleichen.
- Der Nutzer verlangte vor Commit den vollständigen `commit-writer`, exakte vier Dateien, normalen Push sowie anschließende HEAD-/Remote-/Cleanliness-Verifikation -> Commitablauf strikt sequenziell und ohne Amend, Force, Rebase oder Squash durchführen.

Key steps:

- Baseline-Fälle für `/calendars` und Health wiederhergestellt; reale `/auth/cloudrun`-Mounttests für alle drei Kalendercontroller ergänzt.
- `headersSent` realistisch durch einen `send()`-Fehler erzeugt: Header werden während der Antwort markiert, danach wird der Originalfehler geworfen; Controller und globaler Handler delegieren jeweils genau einmal ohne zweite JSON-Antwort.
- Nach unabhängigem High-Re-Review ohne P0-P3-Funde exakt vier Dateien gestaged und Commit geschrieben.
- Normaler Push auf `origin/chore/logging-improvements` erfolgreich; lokaler Tracking-Ref, direkter Remote, Divergenz und beide Worktrees abschließend geprüft.

Failures and how to do differently:

- Der erste Commitversuch scheiterte an einer Worktree-Index-Lock-Sandbox-Beschränkung. Mit erlaubter Schreibfreigabe wurde exakt derselbe Vier-Dateien-Index erfolgreich gestaged; künftig Worktree-Lock-Berechtigungen vor mutierenden Git-Schritten berücksichtigen.
- Der erste korrigierte Testlauf scheiterte nur wegen eines numerisch zu allgemeinen Privacy-Sentinels (`4`), nicht wegen Produktcode. Privacy-Assertions sollten technische Logwerte und öffentliche Request-/Providerwerte getrennt prüfen.

References:

- Commit: `712cf7f0b67beab821fc3f0ccb21fe5f3cec62ce`
- Message: `fix: delegate CloudRun calendar errors globally`
- Commitstatistik: 4 Dateien, 287 Einfügungen, 129 Löschungen.
- Exakte Dateien: `controller/calendarController/absenceCalender.js`, `controller/calendarController/courseCalender.js`, `controller/calendarController/roleCalenderDates.js`, `tests/calendar/cloudRunErrorProjection.test.js`.
- Vor-Commit-Freeze: Diff-SHA-256 `d819330b89dfba613b9a55ed1e5f739b47d3cbb0c1865130f9214cfa360cc5f6`, Stable Patch-ID `5c91d34efad0d87a4489d4233abf5f634fa8941c`, Testblob `1062330f92f9ba1d0cb8d39d7993d56628c83a3b`.
- Push: `65dbc607..712cf7f0 HEAD -> chore/logging-improvements`.
- Abschluss: `HEAD = origin/chore/logging-improvements = direkte ls-remote-Ref`, Divergenz `0/0`, sauber, keine staged/untracked Dateien.
