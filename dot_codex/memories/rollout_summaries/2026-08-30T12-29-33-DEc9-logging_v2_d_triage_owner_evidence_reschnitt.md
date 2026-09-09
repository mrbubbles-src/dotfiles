thread_id: 01a052a5-801c-76f3-a1d2-06284542c439
updated_at: 2026-08-30T12:39:15+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T14-29-33-01a052a5-801c-76f3-a1d2-06284542c439.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# Read-only Neuschnitt der Logging-V2-D-Triage

Rollout context: Vollständige, strikt read-only Spec-/Matrix-/Runtime-Prüfung im Backend `/Users/mrbubbles/dev/novari/novari-education-backend`; keine Runtime-, Test-, Spec-, Matrix-, Plan-, Branch-, Commit- oder Remoteänderung.

## Task 1: Owner- und Evidence-Neuschnitt für D-Triage

Outcome: partial

Preference signals:
- Der Nutzer verlangte ausdrücklich ausschließlich read-only Arbeit, „Findings zuerst“, keine Implementation und keine Artefaktänderung -> bei vergleichbaren Reviews zuerst Identität, Spec und Evidenz unabhängig rekonstruieren und bei Scopeabweichung stoppen.
- Der Nutzer verlangte getrennte Owner und keine Doppelzuordnung zu E1/E2/E3 oder I1–I3 -> Eventproduktion, Suche/Gruppierung, Portalansicht und Integrated Evidence strikt getrennt behandeln.
- Der Nutzer verlangte „höchstens ein persistiertes Ergebnisereignis“, nicht globale Exactly-once-Semantik -> requestlokale Einmaligkeit nicht mit Cross-Request-Deduplizierung verwechseln.

Key steps:
- Kandidat eingefroren: Branch `chore/logging-improvements`, HEAD = Upstream = direkter Remote-Ref `36efd59f2d06c766e48456a8a1fe3595459648e9`, Divergenz `0/0`, Arbeitsbaum einschließlich Untracked-Dateien sauber.
- Original-Spec vollständig geprüft; SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`.
- Matrix, Persistenzsubmatrix, Sliceplan, D-Producer-Evidence und C0-Handoff wurden gelesen und gehasht; die Matrix enthält exakt 68 D-Triage-IDs, 63 mandatory und 5 conditional, derzeit alle `partial`.
- Ownerkorrektur: 38 Backend-Core/Eventproduktion, 5 Backend-Suche/Gruppierung/Controller, 13 Portal-Anzeige/Supportquelle, 3 Development/Integrated Evidence, 9 Governance/finaler Nachweis.
- Direkte Runtimeprüfung bestätigte sichere feste Payloads/Enums, requestdatenunabhängige SHA-256-Fingerprints, Schema-Kohärenz, sichere Request-ID-Projektion, bounded grouping, 30-Tage-Fenster und Seitenlimit 100. Relevante Implementierungen liegen u. a. in `libs/observability/logger.js`, `models/audit/securityAuditEventSchema.js`, `libs/observability/securityAuditGrouping.js`, `libs/observability/auditStore.js` und `controller/securityAuditController.js`.
- Bestehende Testfälle wurden nur statisch geprüft; es wurden in diesem Rollout keine Tests, Linter oder Formatter ausgeführt.

Findings and decision:
- [P2] Der alte D-Triage-Plan mit nur `logger.js`, `securityAuditEventSchema.js` und zwei Tests vermischt fünf fachlich getrennte Closure-Owner. Er kann Portal-, Development-, Gruppierungs- und Governancepflichten nicht schließen.
- [P3] Die fünf E2-Gruppierungs-IDs (`S4.2-R2S–R2W`) sind runtime-seitig bereits umgesetzt und durch bestehende Tests abgedeckt, aber ein aktueller anerkannter Closure-Evidence-Lauf fehlt.
- [P3] Hostingunabhängigkeit und Development-Reproduzierbarkeit sind keine zusätzliche Backend-Runtime-Lücke; sie benötigen Portal-/LMS-/Integrated-Evidence.
- Entscheidung: **C** — mehrere Verträge bleiben fachlich getrennt. Backendseitig zusätzlich **A** — keine konkrete Runtimekorrektur belegt; verbleibende Backendarbeit ist Evidence-/Test-only. D-Triage, PR, integrierte Featureabnahme und Deployment bleiben `NOT READY`.

Startfähiger Gesamtplan:
- Backend-Core-Evidence: read-only Tests/Evidence für 38 IDs; keine Produktions-, Test- oder Dokuänderung.
- E2-Backend-Evidence: read-only Nachweis für Gruppenschlüssel, Count/First/Last, Actor-Untergrenze, Impact, Request-ID-Vorrang, 30-Tage-/100er-Grenzen und Productionfilter; keine Produktionsänderung.
- Portal-E1/E3: separat gegen aktuellen Portal-Kandidaten prüfen; erst ein konkretes Finding rechtfertigt ein eigenes Nutzer-Go und einen eigenen Implementierungsplan.
- I1/I2/I3 plus Integrated Evidence: getrennte reale Backend-, Portal-, LMS-/BFF- und End-to-end-Nachweise; isolierte Mock-Tests schließen keine Cross-Repo-Pflicht.
- Governance/finaler Nachweis: ausschließlich documentaire Evidence, keine Runtime- oder Testdateien.
- `__gateway` und der Cron-Sync mit `COURSE_CALENDAR_SYNC_FAILED` bleiben außerhalb des aktuellen D-Vertrags beziehungsweise spätere Produktentscheidungen.

References:
- `logging-v2-matrix-derived-slice-plan-v2.md:120-134`: alter zu breiter D-Triage-Plan und 2/2-Allowlist.
- `libs/observability/securityAuditGrouping.js:44-159`: sichere Gruppierung nach `fingerprint + environment + release`, konstante Aggregatoren, `count >= 2`.
- `controller/securityAuditController.js:211-257`: exakte Request-ID-Suche bleibt ungruppiert; Gruppenmodus mit begrenztem Zeitfenster.
- `tests/observability/securityAuditController.test.js:348-593` und `tests/observability/auditStore.test.js:1358-1615`: statische Testabdeckung für Filter, Zeitgrenzen, Gruppierung, sichere Projektion und Seitenlimit.
- `router/securityAuditRouter.js:9-15`: bestehende Rollen-/Router-Allowlist unverändert.
- Matrix-Owner-Counts: `38 / 5 / 13 / 3 / 9`; Gesamt `68` IDs.
