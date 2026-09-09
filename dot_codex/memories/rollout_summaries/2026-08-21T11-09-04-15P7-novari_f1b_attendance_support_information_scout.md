thread_id: 01a02402-975a-7a90-a2e2-6afbc70ff88d
updated_at: 2026-08-21T11:15:16+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T13-09-04-01a02402-975a-7a90-a2e2-6afbc70ff88d.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only F1b Scout für Novari Portal abgeschlossen

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, erwartete Baseline F1a `808f006953f73d576ee300ac2c92ac8adaa2a07d`. Auftrag war ausschließlich Analyse und ein §14-fähiger Plan; keine Edits, Tests, Formatter, Fetch, Commit oder Push.

## Task 1: Kleinsten direkten Portal-F1b-Caller-Slice bestimmen

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich „read-only“, „keine Implementierung, keine Edits, keine Tests“ und „kein Go ableiten“ -> Bei ähnlichen Logging-Slices zuerst nur prüfen und planen, niemals stillschweigend umsetzen.
- Der Nutzer verlangte findings-first, konkrete Dateien/Zeilen, exakte Allowlist, Stop-Gates und unveränderte Flows -> Handoffs sollten diese Struktur vollständig und nachvollziehbar liefern.
- Der Nutzer verlangte fail-closed-Verhalten, insbesondere echtes Axios-Objekt, vollständiges verschachteltes `data.error`-Envelope, Request-ID-Konflikte und ignoriertes `actionHint` -> Keine permissive Projektion oder neue Abstraktion vorschlagen.

Key steps:
- Alle verbindlichen Spezifikations-, Visualisierungs-, AGENTS- und Skill-Dateien gelesen.
- Start-Gate geprüft: Repo korrekt, Branch korrekt, HEAD exakt `808f006...`, sauberer Status, Upstream `origin/chore/logging-improvements`, Ahead/Behind `0/0`, Remote korrekt; kein Fetch.
- Direkte `showBackendErrorToast`-Caller inventarisiert und echte Backendfehler von Erfolgsfolge-/Cleanup-Warnungen, Inline-only-Flows und LMS/F2 getrennt.
- Kleinsten kohärenten Slice ausgewählt: Attendance-Interventions-Schreibfehler in `src/hooks/useAttendanceInterventions.ts`.

Reusable knowledge:
- F1b-Kandidat: `src/hooks/useAttendanceInterventions.ts`, lokaler Helper `showAttendanceWriteError` (ca. Zeilen 34–58), vier echte Backend-Schreibpfade: `addEvent`, `updateDecision`, `updateAv`, `closeCase`.
- Ende-zu-Ende-Pfad ist belegt: Attendance-API wirft unveränderten Axios-Fehler; `apiClient` reicht ihn mit `Promise.reject(error)` weiter; TanStack-Mutation ruft den lokalen Fehler-Helper auf; vorhandener `extractBackendSupportInformation` und `showBackendErrorToast` können direkt wiederverwendet werden.
- Der Slice benötigt voraussichtlich genau eine Runtime-Datei und eine fokussierte Testdatei. Keine Änderung an zentralen F1a-Dateien, API, Backend, Rollen oder Produktlogik.
- Statischer Bereich: `Anwesenheitsinterventionen`. Supportkopie enthält nur sichere Meldung, Code, Request-ID, `Anwendung: Portal`, statischen Bereich und optional validiertes HTTP-`Date` als ISO-UTC-Zeitpunkt.
- `500/502/503` werden im bestehenden Helper weiterhin früh beendet und zentral durch F1a behandelt; keine Toast-Duplikation.
- Erfolgs-, Query-Invalidierungs-, Retry-, Mutation- und Cleanup-Verhalten bleiben unverändert.
- Vorgeschlagene Allowlist: Runtime `src/hooks/useAttendanceInterventions.ts`; Tests `src/hooks/__tests__/useAttendanceInterventions.test.tsx`; Doku `docs/development/error-handling.md`, `README.md`, `CHANGELOG.md`.
- §2.2-Fall 6 gilt nur für den zusätzlichen Supportinformations-Parameter am bestehenden Toast; jeder Runtime-Diff muss einzeln zugeordnet werden.
- Geplante Tests: echter Axios-Fehler mit vollständigem Envelope; fehlende/ungültige Felder; Plain-Object-Spoof; Body/Header-Request-ID-Konflikt; ungültiges/fehlendes `Date`; `actionHint` ignoriert; Erfolgsfall ohne Fehlertoast; unveränderte Beschreibung und Mutationsergebnisse.

Failures and how to do differently:
- Die erste breite `rg`-Suche war wegen großer/trunkierter Ausgabe unübersichtlich; danach wurde gezielt nach produktiven `showBackendErrorToast`-Callern, zentralen Extractor-Dateien und konkreten Kandidaten gesucht. Für ähnliche Scouts direkt bekannte Pfade und Ausschluss-Globs verwenden.
- Viele LMS-Dateien vermischen echte Hauptfehler mit Lease-/Session-Cleanup oder Post-Commit-Warnungen. Diese nicht in einen Portal-F1-Slice ziehen; separat als F2 oder spätere Kandidaten klassifizieren.
- `useFeedbackQuestions.ts` ist ein möglicher späterer F1c-Kandidat, aber wegen fehlender Hook-Testfläche nicht kleiner als Attendance. Rollenwechsel-Caller sollten gemeinsam betrachtet werden, nicht isoliert.

References:
- Start-Gate: `git rev-parse --show-toplevel && git branch --show-current && git rev-parse HEAD && git status --short --branch && git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' && git rev-list --left-right --count HEAD...'@{upstream}' && git remote -v`
- Baseline: `808f006953f73d576ee300ac2c92ac8adaa2a07d`
- Commitvorschlag: `feat: add attendance intervention support information`
- Zentrale Verträge: `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`, `src/libs/apiClient.ts`, `src/libs/utils/errorHandling.ts`, `src/libs/utils/error-handler.ts`
- F1a-Testvertrag: `src/libs/utils/__tests__/backendError.supportInformation.test.ts`; Toast-Vertrag: `src/libs/utils/__tests__/toast.test.ts`
- Ergebnis: Kein Go, keine Umsetzung, kein Commit und kein Push wurden ausgeführt.
