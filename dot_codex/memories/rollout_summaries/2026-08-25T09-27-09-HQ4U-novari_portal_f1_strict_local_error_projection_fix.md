thread_id: 01a0383e-b93f-7b53-94a5-fefd3ac061c8
updated_at: 2026-08-25T09:33:18+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-27-09-01a0383e-b93f-7b53-94a5-fefd3ac061c8.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# F1-Corrective-Fix für fail-closed lokale Fehlerprojektion erfolgreich umgesetzt

Rollout context: Eng begrenzter Novari-Portal-Fix auf `chore/logging-improvements`, Baseline `f013140721a0095d5381a002deb590b098c1b860`, mit exakter Produktions-/Test-Allowlist und Logging-V2-Scope-Gates.

## Task 1: Strikte Nicht-Axios-Fehler sicher projizieren

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „additiv“, „keine unrelated Produktänderung/Refactor/neue Infrastruktur“, eine exakte Allowlist und Stop bei Scopeabweichung -> bei ähnlichen Novari-Slices zuerst Branch, Baseline, Arbeitsbaum, Spec-Hashes und Allowlist prüfen und strikt innerhalb dieser Grenzen bleiben.
- Der Nutzer verlangte Findings-first Baseline→Kandidat-Review, Re-Review, engen Commit und normalen Push -> nicht direkt editieren, sondern erst den konkreten Befund reproduzieren, danach vollständigen Diff unabhängig prüfen.
- Der Nutzer verlangte, dass Blob-Bodies, Owner-Anzahl, Caller und Produktabläufe unverändert bleiben -> bei Fehlerprojektionen nur die minimale Projektionsgrenze ändern und Blob-Inhalte niemals dekodieren.

Key steps:

- Start-Gate bestätigt: Branch, HEAD und Origin exakt auf `f013140…`, sauberer Arbeitsbaum, Spec-Hashes korrekt.
- Baseline-Fund reproduziert: Bei `requireValidatedAxiosMessage=true` gab `extractErrorMessage` für gewöhnliche `Error`-/`TypeError`-Instanzen weiterhin rohe `.message` zurück.
- Minimalfix in `src/libs/utils/errorHandling.ts`: Im Nicht-Axios-/statuslosen Zweig liefert der strikte Modus jetzt `ERROR_MESSAGES.UNKNOWN`; Axios-Netzwerkfallback, validierte Nested-Envelopes/Request-IDs und nicht-strikter Modus bleiben unverändert.
- Regressionstests für zentrale `Error`-/`TypeError`-Sentinels sowie repräsentativ DropCases und Timesheet ergänzt; Dokumentation und Changelog aktualisiert.
- Kandidaten-Review ohne P0–P3-Findings; Spec-Kontinuität `aligned`.

Failures and how to do differently:

- Vollständiges ESLint und Typecheck bleiben wegen bestehender Fehler außerhalb der Allowlist blockiert; diese wurden gemäß Stop-Regel nicht verändert. Fokussierte Checks separat bewerten.
- Erstes `git add` scheiterte an `.git/index.lock`-Berechtigungen; derselbe eng begrenzte Vorgang funktionierte mit autorisierter Ausführung. Nicht als Codefehler behandeln.

Reusable knowledge:

- Strikter Modus ist eine fail-closed Projektionsgrenze: Nur vollständige validierte Axios-Backend-Envelopes dürfen dynamische Meldungen liefern. Nicht-Axios-Fehler fallen statisch auf `ERROR_MESSAGES.UNKNOWN`, Axios-Transportfehler auf die statische Netzwerkmeldung.
- Erfolgreiche Verifikation: fokussierte Vitest-Suite 3 Dateien / `63/63`, fokussiertes ESLint, Prettier und `git diff --check` bestanden.
- Commit `3c9ef9afc76ec2933d5158320268d08039e6af56` (`fix: fail closed for strict local error messages`) normal nach `origin/chore/logging-improvements` gepusht; Abschlusszustand sauber und `0/0`.

References:

- Produktionsdatei: `src/libs/utils/errorHandling.ts`
- Tests: `src/libs/utils/__tests__/errorHandling.test.ts`, `src/components/dashboard/flexpanels/__tests__/dropCases.errorOwnership.test.tsx`, `src/components/timesheets/__tests__/TimesheetReviewDetail.test.tsx`
- Docs: `docs/development/error-handling.md`, `CHANGELOG.md`
- Fokussierter Testbefehl: `npm test -- src/libs/utils/__tests__/errorHandling.test.ts src/components/dashboard/flexpanels/__tests__/dropCases.errorOwnership.test.tsx src/components/timesheets/__tests__/TimesheetReviewDetail.test.tsx`
- Fremdfehler: ESLint-Fehler u.a. in `ClosingReportStudentDialog.tsx`, `courseContext.tsx`, `courseManagerContext.tsx`, `closing-reports.lazy.tsx`; TypeScript-Fehler in Help-Portal-Dateien.
