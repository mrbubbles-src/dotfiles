thread_id: 01a05382-80a2-70f3-8586-087ec0a5462d
updated_at: 2026-08-30T18:42:03+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T18-30-56-01a05382-80a2-70f3-8586-087ec0a5462d.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend

# C-Projection im JavaScript-Backend umgesetzt, geprüft, committed und gepusht

Rollout-Kontext: Streng begrenzter Backend-Slice im Worktree `/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend`, Baseline `35e3c4dd7d40e0888efe91d0328ec4af501382e5`, normative Spec SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`. Keine TypeScript-, Portal-, LMS-, Dokumentations- oder Traceability-Änderung.

## Task 1: Zentrale sichere Fehler- und Request-Log-Projektion

Outcome: success

Preference signals:

- Der Nutzer verlangte eine exakte Datei-Allowlist und „kleinsten kohärenten“ Scope -> zukünftige Arbeiten strikt auf die benannten Owner und Tests begrenzen; keine opportunistischen Controller- oder Produktänderungen.
- Der Nutzer verlangte fail-closed Verhalten gegen Getter, Proxy, Circular-/Oversize-Werte, Roh-URLs, Bodies, Stacktraces, PII und Secrets -> adversariale Negativtests als festen Bestandteil einplanen.
- Der Nutzer bestand darauf, dass direkte Legacy-Envelope-Verträge erhalten bleiben, während nur der zentrale Projektionspfad restriktiver wird -> direkte und zentrale Pfade explizit getrennt testen.
- Der Nutzer verlangte unabhängigen HIGH-Review vor Commit/Push und ehrliche Teststatusmeldungen -> keinen Commit aus Selbsteinschätzung ableiten.

Key steps:

- Start-Freeze, Branch-/Remote-Identität, Spec-Hash, AGENTS.md und relevante Skills read-only verifiziert.
- Sichere zentrale Projektion in `error/globalErrorHandler.js`, `error/httpError.js` und `libs/observability/httpLogger.js` umgesetzt: validierte Fehlercodes/Request-IDs, feste Meldungen, bounded Details, route-template-only Logging und Entfernung roher Error-Daten.
- `sendProjectedErrorResponse` als zentralen restriktiven Pfad eingeführt; `sendErrorResponse` bewahrt sichere direkte `issue`-Payloads zur Rückwärtskompatibilität.
- Bestehenden Zertifikats-Auditpfad auf das statische Route-Template `/auth/classmanager/closing-reports/:id/archive-course` begrenzt.
- Tests für zentrale Fehlerprojektion, Request-Logging, hostile inputs, Mongoose-Details, GitHub-Issues, PDF-/Profil-/Zertifikats-Consumer ergänzt bzw. angepasst.
- Nach einem Review-P1 wurden direkte und zentrale `issue`-Semantik korrigiert; finaler fokussierter Lauf 92/92 PASS.

Failures and how to do differently:

- Ein erster P1 entstand, weil `sendErrorResponse` direkte sichere `issue`-Daten entfernte. Korrektur: Legacy-Sender behalten `issue`, ausschließlich `sendProjectedErrorResponse` unterdrückt sie.
- Ein breiter Lauf hatte genau einen bekannten Sandbox-Fehler `listen EPERM: operation not permitted 127.0.0.1` in `tests/lms/moduleControllerErrorBoundary.test.js:297`; nicht als fachlicher Regressionsfehler werten.
- Full Suite blieb bei 7.460/7.513 PASS, 2 bekannten unabhängigen HR-Baselinefehlern in `tests/hr/modelLookupMultiPersona.test.js:62` und `:77`, sowie 51 erwarteten Skips. Nicht „grün“ behaupten.
- Prettier meldete bei neun Dateien Formatabweichungen, die bereits auf der Baseline bestanden; keine breite Formatbereinigung durchführen.

Reusable knowledge:

- Direkte `sendErrorResponse`-Aufrufer und der zentrale Global-Handler sind unterschiedliche Verträge: direkte sichere `issue`-Daten bleiben erhalten; zentrale Responses verwenden die Positivprojektion ohne `issue`.
- Request-Logs verwenden serverseitig ermittelte Route-Templates, nur `queryKeys`, validierte Request-ID und optional `actorHash`; Roh-URL, Querywerte und Error-Objekte bleiben ausgeschlossen.
- Der Zertifikats-Auditowner bleibt unverändert; nur das übergebene Route-Template ist statisch und enthält keine Report-ID oder Query.
- Das Repository verwendet den erforderlichen Testaufruf `node --experimental-test-module-mocks --import ./tests/setupEncryptionKeys.js --test ...`; `npm test` ist die Full-Suite.

References:

- [1] Production-Dateien: `error/globalErrorHandler.js`, `error/httpError.js`, `libs/observability/httpLogger.js`.
- [2] Test-Dateien: `tests/error/globalErrorHandler.test.js`, `tests/error/httpError.test.js`, `tests/observability/httpLogger.test.js`.
- [3] Zentraler Helper: `sendProjectedErrorResponse`; direkter Kompatibilitätspfad: `sendErrorResponse`.
- [4] Fokussierter/Consumer-Lauf: `92/92 PASS`; breiter Lauf `231/232`, einziger Fehler `listen EPERM`.
- [5] Full Suite: `7460 PASS, 2 FAIL, 51 skipped` von `7513`; HR-Baselinefehler wie oben.

## Task 2: Commit, Push und Checkout-Synchronisierung

Outcome: success

Key steps:

- Kandidat vor Commit erneut verifiziert: exakt 10 Dateien, erwarteter Full-index-Diff-Hash `8be8e55b01a9002d3d06366f166f8309d95fd5b4b6fb73b1f89a26be58a6168f`, Patch-ID `998db5ebb6afe969a345951ca85fa59e17eb95fe`, `git diff --check` PASS, kein untracked Inhalt und kein `node_modules`-Link.
- Staging war zunächst wegen fehlender Berechtigung auf dem gemeinsamen Worktree-Index blockiert; derselbe eng begrenzte `git add` wurde anschließend mit expliziter Berechtigung erfolgreich ausgeführt.
- Commit erstellt: `33c6bdcd6b5c433ba1c774f12e4db4ac382fca47`, Parent `35e3c4dd7d40e0888efe91d0328ec4af501382e5`, Nachricht `fix: harden backend error projection`.
- Normal ohne Force auf `origin/chore/logging-improvements` gepusht.
- Hauptcheckout per `git pull --ff-only` aktualisiert.

Reusable knowledge:

- Für Worktrees mit gemeinsamem Git-Metadatenpfad kann `git add` an `index.lock`-Berechtigungen scheitern; nur bei Bedarf gezielt erhöhte lokale Git-Berechtigung verwenden.
- Nach Push müssen Worktree-HEAD, lokale Source-Ref, Tracking-Ref und direkte `git ls-remote`-Ref verglichen werden; Hauptcheckout bei sauberem Fast-Forward normal aktualisieren.

References:

- Commit: `33c6bdcd6b5c433ba1c774f12e4db4ac382fca47`.
- Commit-Statistik: 10 Dateien, `1112 insertions(+), 176 deletions(-)`.
- Remote und Tracking zeigen auf `33c6bdcd6b5c433ba1c774f12e4db4ac382fca47`; beide Checkouts sauber, `0/0`.
- Commit-Dateien: `_classManager/controller/closingReportArchiveController.js`, `error/globalErrorHandler.js`, `error/httpError.js`, `libs/observability/httpLogger.js`, `tests/classManager/closingReportArchive.test.js`, `tests/error/globalErrorHandler.test.js`, `tests/error/httpError.test.js`, `tests/observability/httpLogger.test.js`, `tests/pdf/generatedPdfStreamLifecycle.test.js`, `tests/profile/profileImageErrorProjection.test.js`.
