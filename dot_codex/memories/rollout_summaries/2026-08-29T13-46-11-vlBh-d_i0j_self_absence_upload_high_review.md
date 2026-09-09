thread_id: 01a04dc5-4d58-7c12-beed-c17ae1089853
updated_at: 2026-08-29T13:50:50+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T15-46-11-01a04dc5-4d58-7c12-beed-c17ae1089853.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# Unabhängiger Read-only High-Review des eingefrorenen D-I0j-Kandidaten

Rolloutkontext: Im JavaScript-Backend `/Users/mrbubbles/dev/novari/novari-education-backend` wurde der uncommittete Kandidat für `POST /auth/self-absence/upload-file` gegen die Logging-V2-Spezifikation und den Matrixplan geprüft. Es waren keine Edits, Staging-, Commits oder Pushes erlaubt.

## Task 1: Self-Absence-Anhang-Upload Logging-V2 Review

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „Findings zuerst, strikt read-only“, unabhängige Verifikation und dass Implementiererclaims nicht als Beweis übernommen werden. Für eingefrorene Kandidaten künftig zuerst Freeze-Identität, Allowlist und Hashes selbst prüfen; keine Änderungen vornehmen.
- Der Nutzer verlangte die vertragliche Formulierung „Ein konkreter relevanter Vorgang beziehungsweise Fehlversuch erzeugt höchstens ein persistiertes Ergebnisereignis.“ Künftige Reviews sollen Request-lokale Einmaligkeit von globaler Deduplizierung unterscheiden.

Key steps:

- Repository-Anweisungen, Orchestrate-/Code-Reviewer-Regeln sowie relevante General-, TypeScript-, Testing-, Novari- und Security-Referenzen gelesen.
- Freeze vor und nach Review unabhängig bestätigt: Branch `chore/logging-improvements`, HEAD/Upstream/Remote-Ref `8fcf3d5f859bf1b1cb5636988020e09be2023d10`, ahead/behind `0/0`, leerer Index, exakt neun erlaubte Dateien, erwartete Zielblobs, Diff-Hash und Patch-ID.
- Normative Spezifikation mit SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6` geprüft; relevante Abschnitte §2.2 Fall 5, §4.1, §7, §8 und §13 gegen Code und Tests abgeglichen.
- Express-Pfad getraced: globale Auth-/CSRF-Middleware vor dem Routermarker, danach Marker, Rollenprüfung, Limiter, Multer und Controller; globaler Error Handler persistiert erst nach der `headersSent`-Grenze.
- Matcher auf serverseitigen Marker, POST, exaktes `/upload-file`, finalen Status 500, `INTERNAL_ERROR`, gültige Request-ID und `Error`-Instanz geprüft.
- Sicheren festen Eventvertrag, Fingerprint, Schema-Allowlist, Ausschluss von `actorHash` und Roh-/Datei-/Providerdaten sowie request-lokale Sperre geprüft.
- Fokussierter abhängiger Testsatz außerhalb der Sandbox erfolgreich mit 123/123 bestanden; gezieltes ESLint und drei Runtime-Syntaxchecks bestanden.

Failures and how to do differently:

- Der erste Testlauf war wegen Sandbox-`listen EPERM` bei lokalen HTTP-Tests rot, nicht wegen Produktcode. Nach read-only Ausführung mit erlaubtem Netzwerk-/Loopback-Zugriff liefen 123/123 Tests grün.
- Prettier war weder lokal installiert noch konfiguriert; der Formatcheck konnte nicht ausgeführt werden. Dies bleibt eine explizite Restunsicherheit und darf nicht als bestanden gemeldet werden.
- Keine Vollsuite auf dem finalen Kandidaten, keine reale MongoDB-/HiDrive-Integration und keine Browser-/Developmentprüfung ausgeführt. Diese Grenzen im Reviewbericht ausdrücklich nennen.

Reusable knowledge:

- Der Kandidat erweitert ausschließlich zentrale Observability-/Schemaflächen und den Self-Absence-Routermarker; bestehende Upload-, Auth-, CSRF-, Rollen-, Limiter-, Multer-, HiDrive-, Verschlüsselungs-, Cleanup-, Transaktions- und Responseabläufe bleiben unverändert.
- Erfolg `201` erzeugt nur das bestehende `audit.data_write`/`create`; Rollen-`403` nur `audit.permission_denied`; kontrollierte `400`/`429`, Downloads und bereits gesendete Responses erzeugen kein Supportevent.
- Der Self-Absence-Supportvertrag ist fest: `request.error`, `self_absence_attachment_upload`, `INTERNAL_ERROR`, `self_absence`, `controller.self_absence.attachment_upload`, `/auth/self-absence/upload-file`, POST, 500, `failedStage=unexpected`, `causeClass=unknown`, `supportDisposition=engineering_investigation`.
- Eventpersistenz ist Best Effort ohne Retry oder Rekursion und verändert die Originalantwort nicht. Der Store-Fehlerpfad bleibt request-lokal einmalig.
- Ergebnis: HIGH-REVIEW PASS, keine P0-P3-Findings; aus Review-Sicht commitfähig, vorbehaltlich der genannten nicht ausgeführten Integrations-/Developmentnachweise.

References:

- `libs/observability/logger.js:954-1090`: exakter Self-Absence-Matcher, fester Payload, request-lokale Sperre und Best-Effort-Persistenz.
- `router/selfAbsenceRouter.js:39-40, 85-103, 308-318`: Routermarker, Uploadroute und unveränderte Multer-Fehlergrenze.
- `error/globalErrorHandler.js:614-643`: Logging, `headersSent`-Grenze und zentraler Persistenzaufruf.
- `middleware/auditWriteActions.js:40-70`: bestehender Success-Audit-Owner.
- `tests/selfAbsence/routerErrorBoundary.test.js`, `tests/error/globalErrorHandlerPersistence.test.js`, `tests/observability/auditStore.test.js`, `tests/observability/logger.test.js`: 123/123 grüne fokussierte Evidenz.
- Post-Review-Freeze: Diff-SHA-256 `5be1f1cd81819fa3e7f3e3c9527320ff080e0602a478d5106e34c7402fa7a6b0`; Patch-ID `cf5ed979b3d9de97e274e3bf8794bd000bf39771`.
