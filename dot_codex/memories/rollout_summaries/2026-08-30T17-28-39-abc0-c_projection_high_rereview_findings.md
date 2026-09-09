thread_id: 01a053b7-5667-76f3-951a-f8ae0d5b0eb4
updated_at: 2026-08-30T17:42:19+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T19-28-39-01a053b7-5667-76f3-951a-f8ae0d5b0eb4.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/8877/novari-education-backend

# Unabhängiger HIGH-Re-Review des C-Projection-Backend-Diffs

Rollout context: Read-only Review des detached Kandidaten im JavaScript-Backend `/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend` gegen Baseline `35e3c4dd7d40e0888efe91d0328ec4af501382e5`; keine Änderungen, Delegation, Commits oder Pushes.

## Task 1: C-Projection-Sicherheits- und Vertragsreview

Outcome: fail

Preference signals:
- Der Nutzer verlangte ausdrücklich „findings-first“, strikt read-only, keine Delegation und eine deutschsprachige Ausgabe mit P0–P3-Findings zuerst. Für ähnliche Reviews diese Reihenfolge und Arbeitsgrenze beibehalten.
- Der Nutzer verlangte, frühere Findings nicht ungeprüft zu übernehmen und insbesondere Getter/Proxy/TOCTOU, Rohmeldungen, Route-Herkunft und Query-Schlüssel unabhängig zu verifizieren. Künftige Reviews sollten diese adversarialen Fälle reproduzieren statt nur Mocktests zu akzeptieren.

Key steps:
- Identität geprüft: exakt acht geänderte Dateien, 855 Einfügungen/115 Löschungen, Full-index-Diff-SHA-256 `0c82ea8f30c92f11f88957d57e78fb70298813fcbc8bfaebd0ab784809aec3ac`, Stable Patch-ID `44f0e6167ee5a7a726c606fef927288eab668764`, Spec-Hash `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`.
- Codex-Security-Preflight war `ready`; wegen explizitem Delegationsverbot wurde der Parent-Fallback verwendet.
- Der Codex-Security-Diff-Scan startete nicht: `Working-tree contents changed after they were selected. Select Uncommitted changes again.` Es gab keine `scanId`; der Scan ist nicht abgeschlossen.
- Fokuslauf nach einem ESM-Resolve-/Dependency-Problem erfolgreich mit `NODE_ENV=test LOG_PRETTY=false`: 74/74 Tests bestanden.
- Syntaxprüfung aller acht Dateien, Repository-ESLint und `git diff --check` waren erfolgreich.
- Realer Express-5.2.1-Test zeigte, dass Mount `/auth` bei Request `/AUTH/users/private-123` `baseUrl="/AUTH"` liefert und der Kandidat `/AUTH/users/:userId` loggt.

Failures and how to do differently:
- P1: `createHttpError()` setzt standardmäßig `expose = true`; der Handler interpretiert das als ausdrückliche Freigabe. Dadurch können dynamische 4xx-Meldungen wie `Risiko ${riskId} nicht gefunden` Roh-IDs/Enumeration offenlegen. Fix: Defaultfreigabe entfernen; nur explizit descriptor-gelesenes `true` oder geschlossene exakte Code/Meldungs-Paare zulassen; Regressionstest mit dynamischem `RISK_NOT_FOUND` ergänzen.
- P2: `getSafeRequestPath()` liest zwar nur eigene Daten-Deskriptoren, verwendet aber weiterhin `req.baseUrl`, das Express aus dem tatsächlich gematchten, clientseitig variierbaren Mountpfad setzt. Fix: zunächst nur `req.route.path` oder `/` verwenden; alternativ einen server-owned Marker einführen und einen realen Mounttest behalten.
- Wegen dieser zwei zentralen Offenlegungsprobleme: HIGH REVIEW FAIL und nicht commit-ready.

Reusable knowledge:
- `NODE_PATH` reicht bei Node-ESM nicht für fehlende Worktree-Abhängigkeiten. Ein prozesslokaler `registerHooks`-Resolver auf die vorhandene JavaScript-Installation funktionierte; zusätzlich mussten `NODE_ENV=test LOG_PRETTY=false` gesetzt werden, weil sonst `pino-pretty` nicht aufgelöst werden konnte.
- Die neuen sicheren Grenzen (Query-Key-Projektion `[]`, Code-/Request-ID-Normalisierung, Getter-/Proxy-Fail-closed, PDF-/Profilbild-Envelope, Direct-Envelope-Allowlist) waren im Fokuslauf belegt, schließen aber die beiden oben genannten Vertragslücken nicht.

References:
- Produktionsdateien: `error/globalErrorHandler.js`, `error/httpError.js`, `libs/observability/httpLogger.js`.
- Zusätzliche Tests: `tests/error/globalErrorHandler.test.js`, `tests/error/httpError.test.js`, `tests/observability/httpLogger.test.js`, `tests/pdf/generatedPdfStreamLifecycle.test.js`, `tests/profile/profileImageErrorProjection.test.js`.
- Relevante Stellen: `error/httpError.js:19` für `expose = true`; `error/globalErrorHandler.js:602-615` für die Freigabelogik; `libs/observability/httpLogger.js:138-145` für `baseUrl`; `riskMonitoringController.js:15-30` für dynamische `riskId`-Meldungen.
- Normative Grenzen: Spec §5.1 gegen ungeprüftes `error.message`, Roh-IDs und Enumeration; §5.2 gegen rohe Pfade; Slice C/S13-R4.
- Finale Prüferbewertung: `HIGH REVIEW: FAIL`; `Commit-ready: nein`.
