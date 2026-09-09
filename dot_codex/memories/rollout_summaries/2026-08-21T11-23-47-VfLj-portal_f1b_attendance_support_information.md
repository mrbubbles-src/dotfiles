thread_id: 01a02410-0e93-7ae0-87ac-eda76fc94dc9
updated_at: 2026-08-21T11:55:21+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T13-23-47-01a02410-0e93-7ae0-87ac-eda76fc94dc9.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Portal F1b Attendance-Support-Information implementiert und gepusht

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der ausdrücklich freigegebene, enge F1b-Slice auf Branch `chore/logging-improvements` ab Baseline `808f006953f73d576ee300ac2c92ac8adaa2a07d` umgesetzt. Der Scope war auf exakt fünf Dateien begrenzt; Commit erst nach Review und Nutzerfreigabe.

## Task 1: Attendance-Interventions-Supportinformation

Outcome: success

Preference signals:

- Der Nutzer verlangte eine „exakte Änderungs-Allowlist“ und fail-closed Stop-Gates -> bei ähnlichen Novari-Slices zuerst Repository, Branch, Baseline, Status, Upstream und Dateiliste verifizieren; keine angrenzenden Caller oder Infrastruktur anfassen.
- Der Nutzer verlangte, dass der originale Fehler unverändert durch den bestehenden Pfad läuft und der 500/502/503-Early-Return unverändert bleibt -> keine Normalisierung, neue Helper oder Änderung von Mutation, Retry, Invalidierung oder Error-Owner einführen.
- Der Nutzer verlangte bei ungültigem Envelope den bisherigen Drei-Argumente-Toast exakt beizubehalten -> optionales viertes Argument nur bedingt per Spread übergeben.
- Der Nutzer verlangte keinen Commit/Push vor unabhängiger Prüfung und expliziter Freigabe -> Kandidat zunächst uncommitted einfrieren und Review-/Testnachweise sammeln.

Key steps:

- Start-Gate erfolgreich: exaktes Repository, Branch, HEAD, sauberer Ausgangszustand, Upstream `origin/chore/logging-improvements`, Ahead/Behind `0/0`, korrektes Remote; kein Fetch.
- In `src/hooks/useAttendanceInterventions.ts` `extractBackendSupportInformation(error, 'Anwesenheitsinterventionen')` nach dem unveränderten 5xx-Early-Return ergänzt; gültige Supportinformation wird als viertes Toastargument weitergereicht, sonst bleibt der Drei-Argumente-Aufruf unverändert.
- Hook-Testdatei auf 26 Tests erweitert: alle vier Mutationen, API-Funktionen, Payloads, Aktionstitel, Rückgabewerte, Invalidierung, echte Axios-Envelope, Pflichtfeldfehler, Plain-Object-Spoof, Request-ID-Konflikt, Date-Header, `actionHint`, Statusbeschreibungen und 5xx-Verhalten.
- Dokumentation in `docs/development/error-handling.md`, `README.md` und `CHANGELOG.md` eng um F1b ergänzt.
- Ein erster fokussierter Testlauf scheiterte wegen einer fehlerhaften Testabfrage (`result.current.isError` statt `result.current.addEvent.isError`); nur diese Testabfrage wurde korrigiert. Danach fokussierte Tests `133/133` grün.
- Typecheck, Allowlist-ESLint, Prettier, `git diff --check`, Build und volle Suite erfolgreich. Voll-Lint meldete ausschließlich vier vorbestehende Fehler außerhalb der Allowlist.
- Lokaler vollständiger Code-Review fand zunächst das Vertragsdetail „viertes Argument `undefined`“; bedingter Spread behob es. Danach keine Findings.
- Commit `7d2c5bfb62f806198ca8b02b5d4ed3335eace9ca` mit `feat: add attendance intervention support information` erstellt und normal ohne Force/Amend gepusht.

Reusable knowledge:

- F1a-Extractor ist strikt fail-closed: echte `AxiosError`-Instanz, verschachteltes `response.data.error`, validierte Meldung/Code/Request-ID, übereinstimmende Body-/Header-ID und optional strikt validierter IMF-fixdate-`Date`-Header. `actionHint` wird nicht gelesen/projiziert.
- Nach Push war der Zustand sauber: Branch `chore/logging-improvements`, HEAD und Tracking-Ref `7d2c5bfb62f806198ca8b02b5d4ed3335eace9ca`, Ahead/Behind `0/0`, exakt fünf Dateien, `391 insertions/37 deletions`, kein staged/untracked Diff.
- Security-Plugin-Scan scheiterte zweimal technisch vor Vergabe einer Scan-ID; der Nutzer übersteuerte ausdrücklich nur den fehlenden Scan-Nachweis, nicht Code oder Scope.

References:

- Runtime: `src/hooks/useAttendanceInterventions.ts`
- Tests: `src/hooks/__tests__/useAttendanceInterventions.test.tsx`
- Doku: `docs/development/error-handling.md`, `README.md`, `CHANGELOG.md`
- Fokusprüfung: `npm test -- src/hooks/__tests__/useAttendanceInterventions.test.tsx src/libs/utils/__tests__/backendError.supportInformation.test.ts src/libs/utils/__tests__/toast.test.ts src/libs/__tests__/apiClient.authRetry.test.ts` -> 4 Dateien, 133 Tests bestanden.
- Vollprüfung: `npm test` -> 355 Dateien, 3.871 Tests bestanden.
- Commit: `7d2c5bfb62f806198ca8b02b5d4ed3335eace9ca`
