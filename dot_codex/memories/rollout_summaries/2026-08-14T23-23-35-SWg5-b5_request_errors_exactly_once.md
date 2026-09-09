thread_id: 01a00296-8b19-7131-ac0e-74decc3b218d
updated_at: 2026-08-14T23:50:26+00:00
rollout_path: /Users/mrbubbles/.codex/archived_sessions/rollout-2026-08-15T01-23-35-01a00296-8b19-7131-ac0e-74decc3b218d.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: refactor/logging-system

# Slice B5 „Relevante Fehler genau einmal persistieren“ wurde erfolgreich umgesetzt

Rollout context: Ausschließlich JavaScript-Backend im Repository `/Users/mrbubbles/dev/novari/novari-education-backend`, Branch `refactor/logging-system`. Start-Gate war sauber: lokaler und Remote-HEAD `19fa20a77c669ffde6dac1d3503207ca5dc3e619`, keine fremden Änderungen.

## Task 1: Request-Fehler Exactly-once persistieren

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „ausschließlich Slice B5“, keine Worktrees/Ersatzbranches, kein TS-Backend und keine Scope-Ausweitung. Künftige ähnliche Aufgaben sollten strikt auf den benannten Slice und das JavaScript-Backend begrenzt bleiben.
- Der Nutzer verlangte Reuse-first, unabhängige Scouts, unabhängigen Review, fokussierte Tests, engen Commit und normalen Push. Diese Reihenfolge sollte bei ähnlichen Änderungen standardmäßig eingehalten werden.
- Der Vertrag fordert unveränderte sichere Responses, nicht-blockierende Best-effort-Persistenz und keine Rohdaten in Logs/Events. Diese Kriterien sind als harte Abnahmekriterien zu behandeln.

Key steps:

- Bestehenden globalen Error Handler, `httpLogger`-Finish/Close-Latch, Request-ID/ALS, `auditWriteActions`, B4a-Store und schema-v1-Policy geprüft und wiederverwendet.
- `requestErrorEvent.js` als gemeinsamer request-lokaler Owner ergänzt; genau ein `request.error`-Log und höchstens ein Event pro Request-Lifecycle.
- Gemeinsame pure `auditWritePolicy.js` extrahiert, damit Erfolgs- und Fehlerklassifikation dieselben Auth-, Export-, Download-, Preview-, PDF-, Sensitive- und `skipWriteAudit`-Ausschlüsse verwenden.
- Nur relevante fehlgeschlagene POST/PUT/PATCH/DELETE-Requests sowie unerwartete non-write-5xx werden persistiert; feste Codes `REQUEST_WRITE_FAILED` und `REQUEST_UNEXPECTED_ERROR`.
- Privacy-Schutz durch serverseitiges Route-Template, validierte Request-ID, optionalen `actorHash`, keine Message/Cause/Stack/URL/Query/Body/Header/Token/PII/ObjectId/`targetHash`-Daten.
- Synchroner Policy-/Normalisierungsfehler und asynchroner Storefehler werden abgefangen; maximal ein sicherer `request_error.persistence_failed`-Log, kein Retry, keine Rekursion, Response unverändert.
- Ein unabhängiger Review fand zunächst einen P1-Fehler bei synchron scheiternder Direct-4xx-Klassifikation. Der Fix claimt den Pfad sicher, loggt einmalig, persistiert bei unklarer Klassifikation nichts und bewahrt die Response. Der fokussierte Re-Review hatte keine verbleibenden Findings.

Failures and how to do differently:

- `git fetch` scheiterte zunächst wegen eingeschränktem Zugriff auf `.git/FETCH_HEAD`; mit expliziter Berechtigung war der Fetch erfolgreich. Für Remote-Verifikation bei eingeschränkter Umgebung erforderliche Berechtigung früh anfordern.
- Der erste unabhängige Review deckte auf, dass ein synchroner Zugriff auf `res.locals` im direkten relevanten 4xx-Pfad still `false` liefern konnte. Ähnliche Containment-Pfade sollten auch synchron werfende Request-Metadaten testen.

Reusable knowledge:

- Der kanonische Persistenzpfad ist `libs/observability/auditStore.js::persistSecurityAuditEvent`; kein neuer Store, Index, Schema oder Retry nötig.
- `logAuditEvent` ist für B5 ungeeignet, weil es Legacy-Audit-Vokabular und Success-Logs besitzt; B5 verwendet direkt den schema-v1-Store.
- Request-ID dient nur Korrelation, nicht Deduplizierung: getrennte Requests mit gleicher validierter inbound ID erzeugen getrennte Events.
- Global-Handler-Fehler und direkte `res.status(...)`-Fehler müssen über denselben Response-lokalen Claim koordiniert werden; `finish` und `close` dürfen nicht doppeln.

References:

- Commit: `23aefcef6744977a4fb29ccf3b8eb48305630708` (`feat: persist relevant request errors exactly once`)
- Geänderte Kernmodule: `libs/observability/requestErrorEvent.js`, `libs/observability/requestMetadata.js`, `middleware/auditWritePolicy.js`, `error/globalErrorHandler.js`, `libs/observability/httpLogger.js`, `libs/observability/logger.js`.
- Tests: `tests/observability/requestErrorEvent.test.js`, `tests/observability/auditWritePolicy.test.js`, bestehende Error-/HTTP-/Audit-Tests.
- Verifikation: finale fokussierte Suite `93/93`; vollständige Suite `6608 passed, 0 failed, 51 skipped`; `npm run lint`; `git diff --check`.
- Push erfolgreich: `origin/refactor/logging-system`; lokaler und Remote-HEAD identisch; Worktree sauber.
