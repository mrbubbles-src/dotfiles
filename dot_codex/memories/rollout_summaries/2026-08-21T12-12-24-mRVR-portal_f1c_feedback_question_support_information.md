thread_id: 01a0243c-93ab-7223-912b-1135b31d5fd7
updated_at: 2026-08-21T12:39:06+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T14-12-24-01a0243c-93ab-7223-912b-1135b31d5fd7.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Portal-F1c QM-Fragenverwaltung: sichere Support-Information implementiert, geprüft und gepusht

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde auf `chore/logging-improvements` ab Baseline `7d2c5bfb62f806198ca8b02b5d4ed3335eace9ca` ein strikt begrenzter F1c-Slice umgesetzt. Die Änderungen waren auf sechs Dateien beschränkt; Commit/Push erfolgten erst nach unabhängiger Freigabe.

## Task 1: F1c-Runtime, Tests und Dokumentation

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich eine „korrigierte 6-Dateien-Allowlist“, keine Änderungen an zentralen F1a-Dateien, API-Runtime, UI, Query-/Invalidierungslogik oder GET-Fehlerverhalten -> zukünftige Slice-Arbeiten strikt fail-closed an Baseline, Allowlist und Stop-Gates ausrichten.
- Der Nutzer verlangte „actionHint vollständig ignoriert“, sicheren Drei-Argumente-Fallback und Support-Projektion nur bei echter validierter Axios-Antwort -> Supportdaten immer positiv allowlisten und bei Unsicherheit vollständig auf den bisherigen Pfad zurückfallen.
- Die neue Hook-Testdatei durfte nicht 400 Zeilen erreichen; nach Verdichtung blieb sie bei 399 Zeilen -> harte Größenlimits während der Testplanung früh berücksichtigen.

Key steps:

- Start-Gate erfolgreich geprüft: korrektes Repo, Branch, HEAD, sauberer Worktree, Upstream 0/0 und korrekter Novari-Remote.
- In `src/hooks/useFeedbackQuestions.ts` den bestehenden lokalen Mutation-Failure-Owner um `extractBackendSupportInformation(error, 'Fragenverwaltung')` ergänzt. Nur bei sicherer Projektion wird das vierte Toast-Argument gesetzt; sonst unveränderter Drei-Argumente-Aufruf.
- Alle fünf Schreibmutationen abgedeckt: Anlegen, Bearbeiten, Deaktivieren, Sortieren und Veröffentlichen. GET bleibt `retry:false`, ohne Hook-eigenen Toast.
- Fokussierte Hook-Tests tabellengesteuert ergänzt; API-Test um Publish-Import, `undefined`-Body, exakte `{skipGlobalErrorToast:true}`-Konfiguration und Reject-Identität erweitert.
- Dokumentation in `CHANGELOG.md`, `README.md` und `docs/development/error-handling.md` um F1c ergänzt.

Failures and how to do differently:

- Der erste Hook-Testentwurf hatte 413 Zeilen, danach 407/406; durch gemeinsame Mutation-Factories und verdichtete Fixtures auf 399 Zeilen reduziert.
- Zwei Tests erwarteten zunächst bei direkten Mutation-Funktionen nur ein Argument. TanStack Query übergab zusätzlich den Mutation-Kontext; Tests wurden auf den tatsächlich beobachteten Vertrag angepasst, Runtime blieb unverändert.
- Der erste Typecheck meldete eine heterogene `act`-Rückgabe im Test. Eine lokale Typverengung behob dies; danach war Typecheck grün.
- Voll-Lint blieb wegen vier vorbestehender Fehler und sechs Warnungen außerhalb der Allowlist rot. Diese Baseline wurde nicht verändert; Allowlist-Lint blieb grün.

Reusable knowledge:

- Sichere Projektion liefert statischen Bereich `Fragenverwaltung`, `Anwendung: Portal`, validierte Meldung/Code/Request-ID und optional nur einen validierten Server-Date-Wert als ISO UTC. `actionHint`, Details, URLs, Querywerte, IDs und Rohwerte gelangen nicht in die Kopie.
- Erfolgreiche Status-/Invalidierungs-/Success-Toast-Logik blieb unverändert; finale 500/502/503-Fehler besitzen genau einen lokalen Fehlertoast.
- Validierung: fokussierte Tests 41/41, F1a/F1b-Regressionsmatrix 180/180, vollständige Portal-Suite 356 Dateien/3909 Tests, Typecheck, Allowlist-ESLint, Prettier, Build und `git diff --check` bestanden. Lokaler Code-Review ohne Findings; Security-Diff-Scan ohne Findings.

References:

- Runtime: `src/hooks/useFeedbackQuestions.ts`
- Hook-Tests: `src/hooks/__tests__/useFeedbackQuestions.test.tsx` (399 Zeilen)
- API-Tests: `src/libs/api/__tests__/feedbackQuestionApi.test.ts`
- Doku: `CHANGELOG.md`, `README.md`, `docs/development/error-handling.md`
- Voll-Lint-Baselinefehler: `ClosingReportStudentDialog.tsx`, `courseContext.tsx`, `courseManagerContext.tsx`, `closing-reports.lazy.tsx`.

## Task 2: Commit und Push des akzeptierten Kandidaten

Outcome: success

Key steps:

- Nach externer Freigabe, unabhängigem Review und Security-Scan wurde exakt die eingefrorene Allowlist gestaged.
- Commit erstellt: `aca9fb0ca899cb58f3fa2cc3c0ecf5e71be5ef67` mit `feat: add feedback question support information`.
- Normal auf `origin/chore/logging-improvements` gepusht; kein Amend und kein Force.
- Nach Push bestätigt: sauberer Worktree, Tracking-Ref und HEAD identisch, Ahead/Behind 0/0, Baseline→HEAD exakt sechs Dateien und Diff-Check sauber.

References:

- Security-Scan: `d978c3fa-7847-4fed-81f4-60edcbec12ec`
- Security-Snapshot: `codex-security-snapshot/v1:sha256:eb1acc46c49fd5632dd01eba481845339c99ea3fc4a313599f0d520a11c3cfb9`
- Push-Ausgabe: `7d2c5bfb..aca9fb0c chore/logging-improvements -> chore/logging-improvements`
