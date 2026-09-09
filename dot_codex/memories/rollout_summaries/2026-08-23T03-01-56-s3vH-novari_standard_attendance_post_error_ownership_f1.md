thread_id: 01a02c91-51f7-76f3-9054-079689cb3199
updated_at: 2026-08-23T04:29:00+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T05-01-56-01a02c91-51f7-76f3-9054-079689cb3199.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Standard-Anwesenheit POST erhielt einen eng begrenzten Logging-V2-F1-Slice und wurde erfolgreich gepusht

Rollout context: Novari Education Portal, Branch `chore/logging-improvements`, baseline `bd4fb25582d2991dcc1bd5cb6de6b45d47ae5832`. Der Nutzer verlangte eine exakt auf sechs Dateien begrenzte Änderung ohne Refactor, Backendänderung, Reviewer oder Commit/Push zunächst; später wurde Commit und Push ausdrücklich freigegeben.

## Task 1: Standard-Anwesenheit POST Error Ownership

Outcome: success

Preference signals:

- Der Nutzer gab eine „exakte 6-Dateien-Allowlist“ und „Kein weiterer Pfad“ vor -> ähnliche Aufgaben strikt auf Allowlist und Scope begrenzen.
- Der Nutzer verlangte unveränderte Payload-, Response-, Success-, Reset-, Invalidation-, `isSubmitting`- und `onSubmit`-Semantik -> bei Error-Ownership-Slices nur den tatsächlichen Toast-/Request-Owner ändern.
- Der Nutzer verlangte TDD, fokussierte Tests, Full-Checks, Selbst-Review und einen kanonischen Freeze; nach Freeze zunächst „kein Repozugriff“ -> Verifikations- und Freeze-Reihenfolge exakt einhalten.
- Nach einem frischen Review akzeptierte der Nutzer ausschließlich die Korrektur eines tautologischen Tests: echter `showHandledApiErrorToast`-Pfad, nur finale Toast-Sinks gemockt -> Produktionstests dürfen zentrale Projektion nicht nachimplementieren.

Key steps:

- Start-Gate bestätigt: Branch `chore/logging-improvements`, HEAD = Baseline, sauberer Arbeitsbaum, Remote vorhanden.
- `submitAttendance` sendet nun eine typisierte request-lokale Axios-Konfiguration `{ skipGlobalErrorToast: true }` als exakt drittes POST-Argument; URL, Payload, Response- und Erroridentity bleiben unverändert.
- `AttendanceManagementPanel` ersetzt ausschließlich den alten `extractErrorMessage`/`toast.error`-Catch durch `showHandledApiErrorToast('Anwesenheit erfassen fehlgeschlagen', error, 'Standard-Anwesenheit')`.
- Tests decken POST-Vertrag, unveränderte GET/PUT-Aufrufe, Response-/Erroridentity, Statusmatrix `400/403/409/422/429/500/502/503/599`, sichere Supportprojektion, 4/3/2-Argument-Fälle, Request-ID-Konflikt, Leak-Blacklist, Success-Nebenwirkungen und Fehler-Nebenwirkungen ab.
- Der zunächst tautologische Panel-Test wurde nach Review korrigiert: echter zentraler Helper/Projektionpfad; nur `showBackendErrorToast` und `showErrorToast` als finale Sinks gemockt.
- Verifikation: fokussierte Tests 25/25 bestanden; Typecheck, fokussierter ESLint, Prettier und `git diff --check` bestanden. Full-Suite: 401 Dateien, 4550 Tests bestanden. Build bestanden. Full-Lint bleibt wegen vier bestehenden Fehlern in unveränderten Dateien rot.
- Freeze vor Commit zweimal identisch: `3d93af6dd5ad18969a99863b79fb6e673661971c058267b877a59ea75cbdb615`; untracked war nur `src/components/dashboard/teacher/__tests__/AttendanceManagementPanel.errorOwnership.test.tsx`.
- Nach expliziter Freigabe wurden exakt sechs Dateien gestaged, Commit `ea030b5627cbf1349143c5b5985817c8d9490d07` mit `fix: secure attendance error ownership` erstellt und normal nach `origin/chore/logging-improvements` gepusht. Arbeitsbaum sauber, Upstream gesetzt.

Failures and how to do differently:

- Ein veralteter TDD-Skill-Pfad schlug fehl; der tatsächlich verfügbare Plugin-Pfad wurde verwendet.
- Der erste Panel-Test hatte Vitest-Mock-Hoisting- und instabile Fixture-Probleme; `vi.hoisted` und stabile Context-Fixtures behoben dies.
- Full-Lint scheitert an vier bestehenden `react-hooks/set-state-in-effect`-Fehlern außerhalb des Slice; nicht als Slice-Regression behandeln.
- Ein Versuch mit `--reporter=basic` war ein ungültiger Vitest-CLI-Aufruf; Projektstandard `npm test` verwenden.
- Erstes `git add` scheiterte an Sandbox-`.git/index.lock`; nach expliziter Eskalationsfreigabe gelang Staging. Bei autorisierten Gitmutationen nötige Berechtigung früh einplanen.

Reusable knowledge:

- Lokale Error-Owner-Requests müssen `skipGlobalErrorToast: true` nur zusammen mit explizitem lokalem Catch setzen, um globale 5xx-Doppeltoast zu vermeiden.
- Der echte sichere Helper validiert Axios-Status, eigenes `isAxiosError`-Datenfeld, nested `data.error`, Code, Message, Request-ID und Headerkonflikte; bei ungültigem Envelope fällt er ohne viertes Argument zurück.
- Supportprojektion erlaubt nur sichere Felder: Message, Code, Request-ID, `Portal`, statischer Bereich und optional validierter HTTP-Date-Zeitpunkt. Rohdetails, IDs, Payload- und URL-Felder bleiben ausgeschlossen.

References:

- `src/libs/api/attendanceApi.ts`: typisierte Config `LocallyHandledRequestConfig`, POST-Aufruf Zeilen 48–55.
- `src/components/dashboard/teacher/AttendanceManagementPanel.tsx`: lokaler Catch Zeilen 180–188.
- `src/components/dashboard/teacher/__tests__/AttendanceManagementPanel.errorOwnership.test.tsx`: echter Helperpfad und 25 Tests.
- `src/libs/utils/errorHandling.ts`: `showHandledApiErrorToast`.
- Freeze hash: `3d93af6dd5ad18969a99863b79fb6e673661971c058267b877a59ea75cbdb615`.
- Commit: `ea030b5627cbf1349143c5b5985817c8d9490d07`.

