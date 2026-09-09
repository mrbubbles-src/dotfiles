thread_id: 01a033e8-aec2-7d92-935a-8a5dc1d645b4
updated_at: 2026-08-24T14:14:05+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T15-14-42-01a033e8-aec2-7d92-935a-8a5dc1d645b4.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# CloudRun-Kalenderfehler wurden fail-closed projiziert, dokumentiert und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-backend`, Branch `chore/logging-improvements`, Ausgangs-HEAD `f195f6e811dfea5b06d37e3614f6efd1bddd30a6`, zunächst leerer Status und Upstream `0/0`.

## Task 1: Sichere CloudRun-Fehlerprojektion

Outcome: success

Preference signals:

- Der Nutzer verlangte eine „exakte 6-Dateien-Allowlist“, fail-closed Stop-Gates, keine Delegation sowie unveränderte Erfolgs-, Status-, Auth-, Retry- und Gatewaylogik -> bei ähnlichen Novari-Slices zuerst aktive Consumer und den zentralen Fehlerpfad read-only verifizieren und strikt nur die Allowlist ändern.
- Der Nutzer verlangte reale, parametrisierte Tests mit hostile `out.text`, `e.message`, Stack- und PII-Sentinels sowie Request-ID-/Statusprüfung -> Sicherheitsregressionen an realen Router-/Controllergrenzen testen, nicht nur Helper isoliert mocken.

Key steps:

- Start-Gate, AGENTS-Regeln, Logging-V2-Spec und Visualisierung gelesen; aktive Mounts unter `/auth/cloudrun` sowie zentrale `sendErrorResponse`-Projektion verifiziert.
- Die drei Kalendercontroller und `/calendars` wurden so geändert, dass Gatewayantworten ab Status 400 in einen statischen sicheren Envelope projiziert werden; lokale Forbidden-/Range-/Exception-Pfade verwenden ebenfalls `sendErrorResponse`.
- `libs/cloudRunAuth.js` blieb unverändert; die reale Auth0→STS→ID-Token→Gateway-Grenze wurde im Test kontrolliert ausgeführt.
- Neue Datei `tests/calendar/cloudRunErrorProjection.test.js` deckt fünf Grenzen, hostile Bodies/Messages/Stacks/PII, Status, Codes, Request-ID sowie unveränderte Success-Bytes ab.

Failures and how to do differently:

- Der erste fokussierte Testlauf scheiterte bei drei realen Routertests nur an der Sandbox-Portsperre `listen EPERM: operation not permitted 127.0.0.1`; derselbe Test lief außerhalb der Sandbox mit 17/17 grün. Bei lokalen HTTP-Integrationstests diese Umgebungsgrenze früh berücksichtigen.

Reusable knowledge:

- Reale Routen: `app.use('/auth/cloudrun', verifyTokenMiddleware, csrfProtection, cloudrunRouter)`; Routerpfade `/`, `/calendars`, `/calendars/:type/agenda`, `/absence`, `/course`.
- Gemeinsamer Sender `error/httpError.js:sendErrorResponse` erhält `X-Request-Id` und erzeugt sichere öffentliche Envelopes; `globalErrorHandler` verwendet denselben Sender.
- Validierungscodes `VALIDATION_FAILED` und zentrale Logging-/Persistenzpfade wurden nicht verändert.

References:

- Fokussierter Test: `node --experimental-test-module-mocks --import ./tests/setupEncryptionKeys.js --test tests/calendar/cloudRunErrorProjection.test.js`
- Ergebnis: 17/17 bestanden.
- Full Suite: 6.802 Tests, 6.751 bestanden, 51 übersprungen, 0 fehlgeschlagen.
- `npm run lint` und `git diff --check HEAD --` erfolgreich.

## Task 2: Dokumentation, Freeze, Commit und Push

Outcome: success

Preference signals:

- Der Nutzer erlaubte die Scope-Erweiterung ausschließlich um `docs/project-docs/platform/routes.md` und `CHANGELOG.md`, verlangte danach exakte Allowlist, Review, kanonischen Doppel-Freeze und keinen weiteren Scope -> Dokumentation bei Runtime-Slices nur nach ausdrücklicher Freigabe ergänzen.

Key steps:

- `routes.md` dokumentiert nun sichere Error-Envelope/Request-ID-Projektion und Status-/Success-Erhalt; `CHANGELOG.md` enthält einen engen `[Unreleased] → Fixed`-Eintrag.
- `docs/project-docs/security/logging-policy.md` und `libs/cloudRunAuth.js` blieben unverändert.
- Runtime/Test-Stream reproduzierte exakt den früheren Freeze `5f116a298483013bafbad1b19f189d68bb23e290005e9fd4589e8133bda112fe`.
- Neuer vollständiger Doppel-Freeze: `91b0604b8c76573bf72a86a7db8ca2a76c8b11a1c36d1de8a8bbf4d320f884b4`; tracked 8.474 Bytes, serialisiert 20.666 Bytes, untracked Test 12.063 Bytes.
- Commit `99d3e754679b8fe79f61f1b1443d5db43b87454a`, Betreff `fix: harden CloudRun calendar error responses`, normal auf `chore/logging-improvements` gepusht.

Reusable knowledge:

- Kanonische Freeze-Serialisierung: `NOVARI-FREEZE-V1`, `git diff --binary --full-index --no-ext-diff`, danach sortierte untracked Rohbytes mit Pfad, Dezimalgröße und NUL-Frames; Hash zweimal identisch prüfen.
- Nach erfolgreichem Push: Worktree leer, Upstream `0/0`, `git show --name-status` muss exakt die sieben freigegebenen Pfade zeigen.

References:

- Commit: `99d3e754679b8fe79f61f1b1443d5db43b87454a`
- Exakte Dateien: `CHANGELOG.md`, drei Kalendercontroller, `router/cloudrun-health.js`, `docs/project-docs/platform/routes.md`, `tests/calendar/cloudRunErrorProjection.test.js`.
- Push-Ausgabe: `f195f6e8..99d3e754 chore/logging-improvements -> chore/logging-improvements`.

