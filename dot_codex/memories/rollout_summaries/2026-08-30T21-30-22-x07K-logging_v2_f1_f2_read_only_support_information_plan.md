thread_id: 01a05494-a30e-7322-889f-bff097f4ae98
updated_at: 2026-08-30T21:37:36+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T23-30-22-01a05494-a30e-7322-889f-bff097f4ae98.jsonl
cwd: /Users/mrbubbles/dev/Codex/2026-08-30/logging-v2-f1-f2-support-information-plan

# Read-only Logging-V2-Planung für F1 Portal und F2 LMS abgeschlossen

Rollout context: Die normative Spec wurde vollständig gelesen und ihr SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6` verifiziert. Beide Ziel-Repositories wurden read-only auf Branch, HEAD, Upstream, direkter Remote-Tracking-Ref, Ahead/behind und Cleanliness geprüft; keine Dateien, Tests, Builds, Browser, Prozesse, Commits oder Pushes wurden ausgeführt.

## Task 1: F1 Portal Supportinformation

Outcome: success

Preference signals:
- Der Nutzer verlangte ausschließlich read-only Planung, exakte IDs/Allowlist/Tests und keine künstliche Implementation -> bei ähnlichen Aufgaben Evidenzabschluss und Runtimeänderung strikt trennen.
- Der Nutzer verlangte, nicht auf weitere Wiederholungsprüfungen zu warten -> bereits erhobene, klar markierte Befunde direkt in eine abschließende Startentscheidung überführen.

Key steps:
- Portal eingefroren auf `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, HEAD/Upstream/Remote `e573ec03cfc68503e07f792393e496b1f150295c`, Divergenz `0/0`, sauber einschließlich Untracked.
- Tatsächlichen Ownerpfad geprüft: `src/libs/utils/backendError.ts::extractBackendSupportInformation`, `toast.ts` für Copy-Allowlist und `apiClient.ts` für globale 500/502/503-Projektion.
- Runtime ist bereits vorhanden: echte Axios-Fehler, verschachteltes sicheres Envelope, opaker Code, Request-ID und statische Portal-Bereichsbezeichnung; `Date` wird nur nach strikter IMF-fixdate-Validierung übernommen, sonst vollständig weggelassen.
- F1 umfasst exakt 50 Requirement-IDs aus `S2.2-R6*`, `S6-R1*`, `S6-R2*`, `S13-R10A*` und `S19-R4`.
- Vorgeschlagener Evidenzlauf: `npm test -- src/libs/utils/__tests__/backendError.supportInformation.test.ts src/libs/utils/__tests__/toast.test.ts src/libs/__tests__/apiClient.f1ToastProjection.test.ts src/libs/utils/__tests__/errorHandling.test.ts src/libs/utils/__tests__/error-handler.test.ts`.

Failures and how to do differently:
- Die Matrix führt die 50 Zeilen weiterhin als `partial`, obwohl der Runtimebefund für F1 bereits erfüllt erscheint; das ist eine Evidenz-/Acceptance-Grenze, kein belegter Codefehler. Nicht als Gesamtfeature-READY interpretieren.

Reusable knowledge:
- F1-Portal benötigt nach diesem Befund keine Produktions-, Test- oder Dokumentationsänderung: Allowlist jeweils leer, kein Commit erforderlich. Nur fokussierte Ausführung und unabhängiger Review sind separat freizugeben.
- Supportkopie enthält ausschließlich Meldung, Fehlercode, Referenz-ID, `Anwendung: Portal`, statischen Bereich und optional serverseitigen Zeitpunkt; Rohdetails, Stack, Cause, Provider-ID, URL, Querywerte und IDs bleiben ausgeschlossen.

References:
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/utils/backendError.ts:284-415`
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/utils/toast.ts:36-127`
- `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/apiClient.ts:141-188`
- Testdatei: `src/libs/utils/__tests__/backendError.supportInformation.test.ts` mit adversarialen Fällen für Accessors/Proxies, Request-ID-Konflikte, ungültige Codes/Meldungen und Date-Header.

## Task 2: F2 LMS Metadata-BFF-Projektion

Outcome: success

Preference signals:
- Der Nutzer verlangte „keine Spekulation“, kleinsten kohärenten Slice und keine erfundenen Blob/PDF-Fälle -> nur die zwei real belegten Metadata-Routen aufnehmen und angrenzende Routen ausdrücklich ausschließen.
- Der Nutzer verlangte separate Go-, Review- und Commitgrenzen -> F2 nicht implizit freigeben; Implementierung, Review, Commit und Push getrennt behandeln.

Key steps:
- LMS eingefroren auf `/Users/mrbubbles/dev/novari/novari-education-lms`, Branch `chore/logging-improvements`, HEAD/Upstream/Remote `f7cb840f50845be25fbddabe0a3dbca0aa37e739`, Divergenz `0/0`, sauber.
- Zentralen server-only Projector in `lib/errors/server/backend-error-projection.ts` geprüft: exakte Envelope-/Code-/Request-ID-Validierung, sichere statusabhängige Fallbacks, Rohdetailausschluss und `BACKEND_UNAVAILABLE`.
- Reale Restlücken isoliert: `app/api/modules/get-entry-metadata/route.ts` nutzt noch den permissiveren Parser, liefert bei Backendfehlern `null` und fängt Netzwerkfehler nicht ab; `app/api/modules/get-self-learning-entry-metadata/route.ts` reduziert Backendfehler auf `{error:'not_found'}`/404 und fängt Netzwerkfehler nicht ab.
- F2 umfasst exakt 33 IDs aus `S2.2-R9*`, `S5-R1B2A/B` und `S13-R10B*`.
- Exakte Allowlist festgelegt: zwei Runtime-Dateien, zwei Integrationstests sowie `docs/development/error-handling.md`, `docs/development/routes.md` und `CHANGELOG.md`.
- Vorgeschlagener Nachweis: `npm test -- --run __tests__/unit/lib/backend-error-projection.test.ts __tests__/integration/api/modules-get-entry-metadata.test.ts __tests__/integration/api/modules-get-self-learning-entry-metadata.test.ts`, danach fokussiertes ESLint/Prettier, `npm run typecheck` und finale relevante Suite.

Failures and how to do differently:
- Bestehende Metadata-Tests erwarten weiterhin `null` bzw. `{error:'not_found'}`; sie müssen im engen F2-Slice auf den sicheren Vertrag aktualisiert werden, ohne Success-Payloads oder bestehende Statussemantik zu verändern.
- Der zentrale Projector ist nicht Teil der Allowlist. Bei notwendiger Änderung daran, einer dritten Runtime-Datei oder einer Status-/Auth-/Cookie-/Retry-/Cacheänderung sofort stoppen und neues Go einholen.

Reusable knowledge:
- F2 darf nur bestehende BFF-Routen ergänzen: Backend-/Netzwerkfehler als `{ error: { code, message, requestId? } }`, fail-closed bei malformed/augmentiertem/non-JSON Body, keine `details`, `stack`, `cause`, `issue` oder `raw`.
- Topic-Metadata muss seinen Backendstatus behalten; SLP-Metadata muss die bestehende aufgelöste 404-Semantik behalten. Erfolgsform, Fetch-Parameter, Auth, Cookies, Replay, Retry und Cache bleiben unverändert.
- F1 und F2 sind nach separatem ausdrücklichem Go parallel startfähig. Browser-/Clipboard-/Development-Acceptance bleibt späteren I2/I3-/Integrated-Gates vorbehalten.

References:
- `/Users/mrbubbles/dev/novari/novari-education-lms/lib/errors/server/backend-error-projection.ts:292-471`
- `/Users/mrbubbles/dev/novari/novari-education-lms/app/api/modules/get-entry-metadata/route.ts:33-44`
- `/Users/mrbubbles/dev/novari/novari-education-lms/app/api/modules/get-self-learning-entry-metadata/route.ts:33-45`
- Tests: `__tests__/integration/api/modules-get-entry-metadata.test.ts:22-43`; `__tests__/integration/api/modules-get-self-learning-entry-metadata.test.ts:22-36`

Gesamtfeature bleibt ausdrücklich `NOT READY`; erforderlich sind ein Go für F1-Evidence und ein separates Go für F2-LMS-Metadata-BFF. Commit und Push benötigen jeweils weitere ausdrückliche Autorisierung.
