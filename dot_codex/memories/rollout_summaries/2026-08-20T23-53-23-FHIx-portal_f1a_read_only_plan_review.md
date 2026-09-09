thread_id: 01a02197-fbab-7f22-ba83-23888f45a44d
updated_at: 2026-08-21T00:01:15+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T01-53-23-01a02197-fbab-7f22-ba83-23888f45a44d.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Review des Portal-F1a-Teilslices abgeschlossen

Rollout-Kontext: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der vorgeschlagene Novari Logging V2 Portal-F1a-Plan strikt read-only geprüft. Das Start-Gate war erfüllt: Branch `chore/logging-improvements`, HEAD `ed327fed999ffffcdd941f8bcb752ef74ed5a989`, sauber, Upstream `0/0`; Backend-F0-Commit `f195f6e811dfea5b06d37e3614f6efd1bddd30a6` war lokal vorhanden. Es wurden keine Änderungen, Tests, Fetches, Browserläufe, Commits oder Pushes ausgeführt.

## Task 1: F1a-Planreview

Outcome: success

Preference signals:
- Der Nutzer verlangte wiederholt kompakte Nachträge mit harten Zeichenlimits („unter 6.000 Zeichen“, „maximal 2.500 Zeichen“, „maximal 900 Zeichen“) und exakt vorgegebenen Abschnitten -> künftige Handoffs sollen nach einer vollständigen Prüfung in kurze, strikt strukturierte Fassungen konsolidiert werden.
- Der Nutzer bestand auf „findings-first“, exakten Datei-Allowlists, Stop-Gates und einer wörtlichen Go-Formulierung -> Reviewberichte sollen konkrete Datei-/Vertragsbelege und kleinste Planreparaturen liefern, nicht allgemeine Empfehlungen.

Key steps:
- Vollständige AGENTS.md, V2-Spezifikation und Visualisierung gelesen; aktuelle Portaldateien und zentrale Error-/Toast-Pfade untersucht.
- Findings: P1 `actionHint` ist durch F0 nicht serverseitig autorisiert und muss in F1a vollständig ignoriert werden; P1 bestehender Legacy-Extraktor ist kein sicherer Envelope-Nachweis; P2 Bereichstitel/actions sind nur konventionell statisch; P2 bestehender `backendError.test.ts` ist mit 749 Zeilen nahe am 800-Zeilen-Signal; P2 Clipboard-Test deckt den exakten Gesamttext aus dem Toast noch nicht ab. Keine P0- oder P3-Findings.
- Korrigierter Vertrag: ausschließlich echter Axiosfehler mit `response.data.error`; fail-closed Validierung von Meldung, Code, Body-/Header-Request-ID und IMF-fixdate-Date; keine Browserzeit, kein `actionHint`, keine Rohdetails; feste Supportkopie ohne abschließenden Zeilenumbruch.
- Korrigierte Allowlist: fünf Runtime-Dateien, neue `backendError.supportInformation.test.ts`, vier bestehende fokussierte Tests sowie `docs/development/error-handling.md`, `README.md`, `CHANGELOG.md`.

Failures and how to do differently:
- Ein ursprünglicher Plan hätte den allgemeinen Legacy-Extraktor erweitert und `backendError.test.ts` weiter vergrößert. Stattdessen separaten F1a-Extraktor und eigene fokussierte Testdatei vorsehen.
- `actionHint` darf nicht aus `code`, `details`, `issue` oder Meldung abgeleitet werden; dafür wäre eine separate Backend-Vertragsfreigabe nötig.

Reusable knowledge:
- `apiClient.authRetry.test.ts` ist die richtige bestehende Interceptor-Testfläche; `apiClient.test.ts` testet tatsächlich nur Attendance-Helfer und ist sachfremd.
- `toast.ts` nutzt für Backendfehler `duration: Infinity`; `main.tsx` aktiviert `closeButton`. Legacy-Drei-Argument-Aufrufe und `showBackendWarningToast` sollen unverändert bleiben.
- Aktuelle zentrale Erzeuger: `apiClient` globaler 500/502/503-Interceptor, `showHandledApiErrorToast`/`handleApiCall`, und `handleError` im Nicht-Warnungs-Backendpfad.

References:
- Baseline: `chore/logging-improvements @ ed327fed999ffffcdd941f8bcb752ef74ed5a989`
- Allowlist-Testdatei: `src/libs/utils/__tests__/backendError.supportInformation.test.ts`
- Zentraler Extraktor: `src/libs/utils/backendError.ts`
- Toast: `src/libs/utils/toast.ts`
- Exakte Go-Formulierung: „Go für den korrigierten Portal-F1a-Teilslice ... `actionHint` wird vollständig ignoriert; die Zeile `Handlungsempfehlung` entfällt in F1a immer. Supportinformation entsteht ausschließlich aus einem dedizierten fail-closed validierten Axios-`data.error`-Envelope.“
