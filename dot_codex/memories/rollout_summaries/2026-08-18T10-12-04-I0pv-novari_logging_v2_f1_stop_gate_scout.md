thread_id: 01a0145b-52b7-7603-aee4-810c731f00ed
updated_at: 2026-08-18T10:16:12+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T12-12-04-01a0145b-52b7-7603-aee4-810c731f00ed.jsonl
cwd: /Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-next-slice-scout

# Read-only Novari Logging V2 Scout identifiziert F1 als blockierten nächsten Kandidaten

Rollout-Kontext: Vollständig read-only; aktuelle V2-Spec, Visualisierung und Repository-AGENTS wurden geprüft. Keine Dateien geändert, keine Tests, kein Fetch, kein Commit/Push.

## Task 1: Aktuellen Repositorystand verifizieren

Outcome: success

Key steps:
- Backend: `chore/logging-improvements`, HEAD `88c7c6b64e87b23696edf795589cf35735595a28`, sauber, Upstream identisch.
- Portal: `chore/logging-improvements`, HEAD `ed327fed999ffffcdd941f8bcb752ef74ed5a989`, sauber, Upstream identisch.
- LMS: `chore/logging-improvements`, HEAD `90d0ff21d3d11f93f77c54cebfe0448a64ab19da`, sauber, Upstream identisch.
- Alle drei Checkouts waren lokal `0 ahead / 0 behind`; kein Fetch wurde ausgeführt. Jeweils gilt die Root-`AGENTS.md`.

## Task 2: Nächsten Slice und Normenkonflikt bestimmen

Outcome: partial

Findings:
- Nach E3 sind normativ F1 und F2 offen; ein F3 existiert in der aktuellen Spec nicht.
- F1 (Portal-Supportinformation) ist der kleinste sinnvolle Kandidat, weil der Portal-Toast und Clipboard-Helfer bereits zentral vorhanden sind und F2 zusätzlich LMS/BFF umfasst.
- F1 ist derzeit nicht implementierbar: §13 beschreibt F1, §2.2 erlaubt additive Portal-Runtimeänderungen aber nur in E1/E3. Ein F1-Hunk lässt sich aktuell keinem erlaubten Fall 1–7 zuordnen.
- Der bestehende Backend-Fehlervertrag liefert sichere Meldung, Code und Request-ID, aber keinen für F1 erforderlichen serverseitigen Zeitpunkt oder sicheren Funktionsbereich. Das Portal darf diese Werte nicht selbst erraten; eine Backendänderung würde gegen „ein Repository pro Slice“ verstoßen.
- Die konkrete Code-/Feld-Allowlist ist ebenfalls noch nicht vollständig normativ festgelegt.

Relevante aktuelle Bausteine:
- Backend-Producer: `error/globalErrorHandler.js`, `error/httpError.js`; Response `{ error: { code, message, requestId, ... } }`.
- Portal-Parser: `src/libs/utils/backendError.ts`.
- Zentrale Darstellung: `src/libs/utils/toast.ts`; persistenter Toast mit `Referenz kopieren`, derzeit wird ausschließlich die Request-ID kopiert.
- Clipboard-Reuse: `src/libs/utils/clipboard.ts` mit Clipboard-API und DOM-Fallback.
- Weitere zentrale Consumer: `src/libs/apiClient.ts`, `src/libs/utils/errorHandling.ts`, `src/libs/utils/error-handler.ts`, `src/libs/queryClient.ts`.

## Task 3: §14-Plan und offene Abnahme

Outcome: partial

Der vorbereitete F1-Plan ist erst nach normativer Auflösung und separatem Nutzer-Go gültig:
- Repository: ausschließlich Portal.
- Baseline: `ed327fed999ffffcdd941f8bcb752ef74ed5a989`.
- Ziel: sichere, feste Supportinformation mit Kurzmeldung, allowlist-basiertem Code, Request-ID, Anwendung, serverseitigem Funktionsbereich, serverseitigem UTC-Zeitpunkt und optionaler freigegebener Handlungsempfehlung.
- Verboten: URLs, Parameter, Rohdaten, Stacks, Bodies, Header, Cookies, Tokens, Pfade, PII und nicht allowlistierte Freitexte.
- Vorgesehene Tests: Toast, Clipboard, Backend-Error-Parser, Error-Handling, Error-Handler und API-Client; danach Portal-Test, Typecheck, Lint und Build sowie Browser-/Network-Abnahme.
- Unabhängiger Reviewer muss den vollständigen tatsächlichen Diff ab Baseline selbst prüfen; erst danach Commit/Push und nur nach Nutzer-Go.

Trotz E1–E3 offen: normative F1-Freigabe und Serververtrag, F2, reale befüllte E3-Gruppenkarte/Drilldown mit D1-Daten, G/H, Development-Testflächen I1–I3, Cleanup-/Nichtregistrierungstests, J1–J3-AGENTS-Governance und vollständige §19-Abnahme.
