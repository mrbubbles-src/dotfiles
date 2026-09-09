thread_id: 01a03e71-8d9f-7092-9362-1ba8394654ae
updated_at: 2026-08-26T14:51:59+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/26/rollout-2026-08-26T16-20-24-01a03e71-8d9f-7092-9362-1ba8394654ae.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/0e35/novari-education-backend
git_branch: codex/temp-dev-backend-sentinels

# Temporärer Backend-Sentinel-Slice mit nachträglichen P1/P2-Korrekturen erfolgreich abgeschlossen

Rollout context: Im isolierten JavaScript-Backend-Worktree `/Users/mrbubbles/.codex/worktrees/0e35/novari-education-backend` wurden vier Dev-only Test-Sentinels auf einem technischen temporären Branch implementiert. Die Zielbasis und beide `chore/logging-improvements`-Refs blieben auf `5b95632051b649a742ad3309ff9b01a080bc90e5`; es wurde weder gepusht noch übertragen.

## Task 1: Dev-only Backend-Sentinels implementieren

Outcome: success

Preference signals:

- Der Nutzer verlangte wiederholt „ausschließlich“ den temporären Backend-Slice, „kein Push/Transfer“ und eine exakte Produktions-Allowlist -> zukünftige Agents sollten Scope, Branch, erlaubte Dateien und Freeze-Bedingungen vor jeder Änderung hart prüfen.
- Der Nutzer forderte bestehende reale Endpunkte/Handler, unveränderte Normalpfade, Auth/Rolle vor Triggern und keine neue Architektur -> Tests und Implementierung müssen direkt an vorhandenen Ownern ansetzen, nicht Router/Middleware/Parallelserver/Eventstore erweitern.
- Der Nutzer verlangte fokussierte Tests, Lint, unabhängigen Findings-first-Review sowie Commit-/Allowlist-Selbstcheck -> diese Reihenfolge sollte bei ähnlichen Slice-Aufgaben beibehalten werden.

Key steps:

- Start-Gate: sauberer Worktree; `HEAD`, lokale Zielbranch und `origin/chore/logging-improvements` exakt auf `5b956320...`.
- Technischen Branch `codex/temp-dev-backend-sentinels` erstellt.
- Einheitliches Triggerprotokoll eingeführt: `__novariDevSentinel`, nur bei `NODE_ENV === 'development'`.
- GitHub-Inventory: Query-Wert `github-sync-connection-failed`; erzeugt den echten `GITHUB_SYNC_CONNECTION_FAILED`-503-Pfad über `globalErrorHandler`, ohne GitHub-Anfrage, mit genau einem erlaubten Support-Event.
- Hardware-PDF: Query-Wert `hardware-pdf-stream-failed`; absichtlich bytefreier Fehler vor dem ersten Byte über den bestehenden `streamGeneratedPdfToResponse`-Lifecycle.
- Socket `class:join`: Payload-Feld `socket-unknown-fallback`; nutzt den bestehenden statischen `join_failed`-Fallback ohne DB/Room/Broadcast-Nebenwirkung und mit Exactly-once-Ack.
- Zertifikat/Kursabschluss: Query-Wert `certificate-generation-failed`; nutzt den bestehenden Teilnehmer-Failure-Pfad mit `CERTIFICATE_GENERATION_FAILED`, HTTP-200/Summary und Legacy-Failure-Event, ohne PDF/HiDrive-Nebenwirkung.
- Fokussierte Tests decken Development-Aktivierung, Production/falsche/fehlende Sentinel-Werte, Rollen-Gates, Normalpfade, Response-/Persistenzverträge und Nebenwirkungsfreiheit ab.

Failures and how to do differently:

- Die erste Vollsuite lief mit 7.235 bestandenen, 51 übersprungenen und 2 unveränderten HR-Baselinefehlern (`JobCoach`-ObjectId-Cast und erwartete Rollenliste). Beide Fehler wurden isoliert reproduziert und nicht scopewidrig repariert.
- Für Tests/Lint war ein temporärer `node_modules`-Symlink nötig; er wurde vor jedem finalen Check/Commit entfernt. Solche temporären Ressourcen müssen explizit bereinigt werden.

Reusable knowledge:

- Relevante Produktionsdateien waren exakt `_lms/controller/githubCurriculumRepositoryInventoryController.js`, `controller/hardwareController.js`, `sockets/socketServer.js` und `_classManager/controller/certificateCompletionController.js`; nur sechs fokussierte Testdateien kamen hinzu.
- `globalErrorHandler` persistiert das speziell allowlistete GitHub-Inventory-Event best effort, höchstens einmal pro Request, ohne Response-Veränderung oder Retry.
- Socket-Authentifizierung ist vor `connection` registriert; `class:join` verwendet den bestehenden `projectSocketError`-Fallback.
- Der PDF-Stream-Owner entfernt vor dem ersten Byte die PDF-Header und delegiert den Fehler an `next`, sodass der globale sichere JSON-Fehler greifen kann.

## Task 2: P1-Korrektur am Zertifikat-Sentinel

Outcome: success

Preference signals:

- Der Nutzer stellte klar, dass der Sentinel nur bei expliziter Teilnehmerauswahl aktiv sein darf und fehlende/ungültige/leere Listen den normalen Produktpfad unverändert lassen müssen -> bei optionalen Auswahlparametern immer zwischen expliziter Auswahl und bestehendem All-Items-Fallback unterscheiden.

Key steps:

- `hasExplicitStudentSelection = Array.isArray(req.body?.studentIds) && req.body.studentIds.length > 0` ergänzt.
- Sentinel wird nur noch bei dieser Bedingung aktiviert; Bildung von `requestedStudentIds`, Validierung und Fallback auf alle Kursteilnehmer blieben unverändert.
- Tests für fehlende Liste, nicht-array, leere Liste, ungültige Auswahl und Einzelauswahl ergänzt.
- Verifiziert: 76/76 fokussierte Tests und vollständiger Lint grün; Commit zunächst auf `9b4172cf...` amendiert.

## Task 3: P2-Korrektur der Socket-Parent-Parität

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich Parent-Parität für `class:join(null/undefined)`, einschließlich keinem Ack und identischem synchronem/Promise-Fehlerpfad -> bei Änderungen an Callback-Handlern müssen auch Null-/Undefined-Parametersemantik und Fehlerzeitpunkt erhalten bleiben.

Key steps:

- Optionales Payload-Handling entfernt und die ursprüngliche Destrukturierung wiederhergestellt; das Sentinel-Feld wird als computed property in derselben Destrukturierung gelesen.
- Dadurch scheitern `null` und `undefined` wieder vor Ack-Erzeugung und Handlerkörper mit Promise-`TypeError`.
- Paritätstests bestätigen: kein Ack, keine DB-Abfrage, kein Room-Join, keine Broadcasts; gültiger Sentinel bestätigt weiterhin genau einen `join_failed`-Ack.
- Abschlusschecks: 78/78 fokussierte Tests grün, vollständiger `npm run lint` grün, Allowlist grün, Worktree sauber, kein `node_modules`-Symlink.
- Finaler amendierter Commit: `8f6b2e3dadeeca02a1891355afddaaef74f47d61`, Parent `5b95632051b649a742ad3309ff9b01a080bc90e5`.

References:

- [1] Finaler Branch: `codex/temp-dev-backend-sentinels`.
- [2] Finaler Commit: `8f6b2e3dadeeca02a1891355afddaaef74f47d61` (`feat: add development failure sentinels`).
- [3] Finaler Parent/Zielbranch: `5b95632051b649a742ad3309ff9b01a080bc90e5`.
- [4] Triggerfeld: `__novariDevSentinel`.
- [5] Triggerwerte: `github-sync-connection-failed`, `hardware-pdf-stream-failed`, `socket-unknown-fallback`, `certificate-generation-failed`.
- [6] Verifikation: `node --experimental-test-module-mocks --import ./tests/setupEncryptionKeys.js --test tests/error/globalErrorHandlerPersistence.test.js tests/lms/githubCurriculumRepositoryIntegrationController.test.js tests/hardware/hardwarePdfStreamLifecycle.test.js tests/socket/socketAckErrorProjection.test.js tests/classManager/certificateControllerCutover.test.js tests/auth/shareholderRoleWorkflows.test.js` -> 78/78 bestanden.
- [7] `npm run lint` -> erfolgreich.
