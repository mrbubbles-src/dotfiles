thread_id: 01a02c8e-f4a8-7be2-9d5f-7654c94716ab
updated_at: 2026-08-23T03:01:27+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T04-59-21-01a02c8e-f4a8-7be2-9d5f-7654c94716ab.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only F1-Scout für Attendance-POST

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde auf Branch `chore/logging-improvements` ausschließlich read-only der aktive `POST /teacher/attendance`-Producer gegen die Logging-V2-Spec geprüft. HEAD und Baseline waren identisch (`bd4fb25582d2991dcc1bd5cb6de6b45d47ae5832`), der Arbeitsbaum sauber. Es wurden keine Edits, Tests, Formatter, Git-Mutationen oder Browser-Aktionen ausgeführt.

## Task 1: Enge Allowlist- und Implementierungsplanung für Attendance-F1

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „Read-only, keine Tests/Edits/Formatter/Fetch/Gitmutationen/Browser/Scan/Delegation“ und „Keine Umsetzung“ -> Bei ähnlichen Vorbereitungsaufträgen zuerst nur Primärquellen, Scope und Gates verifizieren und keine Umsetzung vornehmen.
- Der Nutzer verlangte einen „freigabefähigen engen Plan“ mit exakter Allowlist, Testmatrix, 4-3-2-Arity, Leaks, Request-ID und Stop-Gates -> Pläne sollen konkrete Dateien, Argumentpositionen, Kontrollfluss-Erwartungen und Abbruchbedingungen enthalten, nicht nur allgemeine Empfehlungen.

Key steps:

- Branch, HEAD, Baseline und Arbeitsbaum verifiziert; HEAD entsprach der Baseline.
- `AGENTS.md`, aktuelle V2-Spec, Visualisierung, bestehende Error-Handling-Dokumentation und relevante Attendance-Dateien gelesen.
- Aktuellen Producer geprüft: `submitAttendance` ruft `apiClient.post('/teacher/attendance', attendanceData)` aktuell mit nur zwei Argumenten auf.
- Aktuellen UI-Catch geprüft: `AttendanceManagementPanel` verwendet derzeit `extractErrorMessage` und `toast.error`, nicht `showHandledApiErrorToast`.
- Bestehenden Attendance-API-Test gefunden; passender Error-Ownership-Test für das Panel fehlt.

Failures and how to do differently:

- Der Start-Suchlauf war teilweise durch große/trunkierte Ausgaben und einen fehlerhaften Shell-Quoting-Aufruf (`zsh: unmatched '`) erschwert. Für ähnliche Scouts Ausgaben enger begrenzen und Pfade mit Leerzeichen sauber quoten.
- Die aktuelle Implementierung erfüllt den geplanten F1-Vertrag noch nicht: kein request-lokales `skipGlobalErrorToast` und kein lokaler Support-Toast. Das ist ein Finding/Planungsbedarf, keine Implementierungsfreigabe.
- F0→F1-Voraussetzung, separates F1-Teilslice-Go und vollständiger unabhängiger Diff-Review bleiben erforderlich.

Reusable knowledge:

- Exakte Produktions-Allowlist: `src/libs/api/attendanceApi.ts` nur für den aktiven Attendance-POST und `src/components/dashboard/teacher/AttendanceManagementPanel.tsx` nur für dessen lokalen Catch.
- Exakte Test-Allowlist: bestehende `src/libs/api/__tests__/attendanceApi.test.ts` erweitern und neue `src/components/dashboard/teacher/__tests__/AttendanceManagementPanel.errorOwnership.test.tsx` anlegen.
- Exakte Doku-Allowlist: `docs/development/error-handling.md` und `CHANGELOG.md`; keine Änderungen an `apiClient`, MutationCache, GET/PUT, Interventionspfaden, README oder UI-Struktur.
- Geplanter API-Vertrag: `apiClient.post('/teacher/attendance', payload, { skipGlobalErrorToast: true })`; die dritte Argumentposition muss exakt geprüft werden.
- Geplanter lokaler Catch: `showHandledApiErrorToast('Anwesenheit erfassen fehlgeschlagen', error, 'Standard-Anwesenheit')`.
- Test-Arity-Matrix: vollständiges sicheres Envelope → 4-Argument-`showBackendErrorToast`; unvollständiges/widersprüchliches Envelope → 3-Argument-Referenzfallback; nicht-Axios/lokaler Fehler → 2-Argument-`showErrorToast`.
- Erfolgs-Payload/Response, Success-Toast, Reset, Invalidation und `onSubmit` müssen unverändert bleiben. Fehler dürfen Reset, Invalidation und `onSubmit` nicht ausführen; `isSubmitting` muss über `finally` zurückgesetzt werden.
- Supportkopie darf nur sichere Allowlist-Felder enthalten; `actionHint`, `details`, `issues`, URLs, Queries, Header, Payload, JSON und interne Werte müssen als Leaks ausgeschlossen werden.
- Scope-Gates: höchstens zwei Runtime-Produktdateien; jeder Diff-Abschnitt eindeutig Fall 6 der V2-Spec; bei Datei außerhalb der Allowlist, Ablaufänderung, fehlendem sicheren Envelope oder Hash-Mismatch sofort stoppen.

References:

- Baseline: `bd4fb25582d2991dcc1bd5cb6de6b45d47ae5832`
- Producer: `src/libs/api/attendanceApi.ts:23-43`
- UI-Catch: `src/components/dashboard/teacher/AttendanceManagementPanel.tsx:144-185`
- Bestehende Tests: `src/libs/api/__tests__/attendanceApi.test.ts`
- Error helper: `src/libs/utils/errorHandling.ts:109-129`
- Dokumentation: `docs/development/error-handling.md:38-55`
- V2-Spec: Abschnitt 2.2 Fall 6, Abschnitte 14–17; separates F1-Teilslice-Go und unabhängiger vollständiger Diff-Review erforderlich.

Der Abschluss war ein freigabefähiger Plan, aber ausdrücklich noch keine Implementierungsfreigabe.
