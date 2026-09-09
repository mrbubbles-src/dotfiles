thread_id: 01a0274c-51eb-7a71-87c5-49af5efe1c94
updated_at: 2026-08-22T02:44:17+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-28-28-01a0274c-51eb-7a71-87c5-49af5efe1c94.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Portal Logging V2 F1r wurde implementiert und veröffentlicht

Rollout-Kontext: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `3848d1b23c1a9cb5fb316a6acf6b97c64223e9ad`. Der Nutzer verlangte einen eng begrenzten F1r-Slice für Review-Desk-Pfadmigrations-Reads, zunächst uncommitted eingefroren, danach separat committed und gepusht.

## Task 1: F1r Review-Desk-Pfadmigrations-Reads implementieren

Outcome: success

Preference signals:
- Der Nutzer verlangte eine „kleinste kohärente“ Änderung mit exakter Allowlist, expliziten unveränderten Abläufen und fail-closed Stop-Gates. Das bestätigt, dass zukünftige Logging-Slices strikt auf die freigegebenen Dateien und den konkreten Spec-Fall begrenzt bleiben sollen.
- Der Nutzer verlangte: „vierter Parameter nur bedingt, nie undefined“. Bei ungültiger Supportprojektion muss der historische Toast-Aufruf exakt drei Argumente behalten.
- Der Nutzer verlangte reale Axios-/Query-Fixtures, Negativtests für unsichere Strukturen und getrennte Deduplizierungs-Refs. Ähnliche Änderungen sollten diese Provenienz-, Arity- und Deduplizierungsprüfungen proaktiv abdecken.

Key steps:
- Start-Gate erfolgreich geprüft: sauberer Branch, korrekte Baseline, Upstream `0/0`.
- Bestehende zentrale Funktion `extractBackendSupportInformation` wiederverwendet; keine neue Abstraktion.
- Eligibility-GET und Status-GET erhielten jeweils eine statische Support-Area und ein bedingtes viertes Toastargument.
- Gültige sichere Envelopes liefern exakt vier Argumente; ungültige, flache, unvollständige, array-basierte, inherited/accessor-basierte oder widersprüchliche Daten bleiben bei exakt drei Argumenten.
- Exakte Allowlist: eine Runtime-Datei, eine Testdatei sowie `docs/development/error-handling.md`, `CHANGELOG.md`, `README.md`.

Failures and how to do differently:
- Der erste Typecheck meldete einen Fixture-Typfehler (`object` war für `AxiosHeaders` zu breit). Die Testhilfe wurde auf `Record<string, string>` eingegrenzt; danach war der Typecheck grün.
- Voll-Lint blieb bei der bekannten Baseline mit 4 Fehlern und 6 Warnungen in unveränderten Dateien. Diese wurden nicht repariert oder in den Slice gezogen.
- Ein Selbstreview fand zunächst eine widersprüchliche historische Changelog-Formulierung, die Eligibility-GETs pauschal als reference-only bezeichnete. Sie wurde auf weiterhin ausgeschlossene Follow-up-Invalidierungen korrigiert.

Reusable knowledge:
- Die bestehende Projektion validiert echte `AxiosError`-Objekte, own-data Properties und verschachtelte `response.data.error`-Envelopes fail-closed; sie projiziert keine Rohdaten, URLs, Querywerte, internen IDs, Accessors oder unsicheren Extras.
- Die beiden Reads verwenden weiterhin getrennte lokale Error-Signaturen/Refs. Identische Fehlerobjekte werden nicht zwischen Eligibility- und Status-Producer unterdrückt.
- Query-Keys, `enabled`, `retry:false`, Polling-Budget, Refetches, Blocking UI, Mutation-/CAS-/Idempotency- und Rollenlogik blieben unverändert.

References:
- Runtime: `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx:215-249`
- Tests: `src/components/lms/teaching-plan/__tests__/CurriculumWorkRevisionReviewActions.previewSupportInformation.test.tsx:414-605`
- Areas: `GitHub-Pfadmigrationsverfügbarkeit`, `GitHub-Pfadmigrationsstatus`
- Fokustest: 23/23 grün
- Angrenzende Tests: 6 Dateien, 107/107 grün
- Vollsuite: 363 Dateien, 4.086/4.086 grün
- Typecheck, fokussiertes ESLint, Prettier, `git diff --check` und Build grün
- Kanonischer Diff-Hash: `fd4a658300b538324a39641648a923983b4e269a7472c710494735bcd722daf8`

## Task 2: F1r committen und pushen

Outcome: success

Preference signals:
- Der Nutzer verlangte vor dem Commit eine exakte Hash-, Allowlist-, Stage- und Diffprüfung sowie „kein amend/force“. Zukünftige Abschluss-Tasks sollten diese Freeze- und Stage-Gates reproduzieren.

Key steps:
- Exakt fünf erlaubte Dateien gestaged; staged Diff und Hash stimmten mit dem eingefrorenen Kandidaten überein.
- Commit exakt mit `feat: add path migration read support information` erstellt.
- Normal nach `origin/chore/logging-improvements` gepusht.

Reusable knowledge:
- Commit `9885ddd9f9d66365e737bd176f605940b90fff42`, 5 Dateien, `+213/-11`.
- Nach Push: Arbeitsbaum sauber, lokaler HEAD und Origin identisch, Upstream `0/0`.
- Kein Amend, Force, zusätzlicher Edit oder Formatter nach dem Freeze.

References:
- Push-Ausgabe: `3848d1b2..9885ddd9 chore/logging-improvements -> chore/logging-improvements`
- Finaler HEAD: `9885ddd9f9d66365e737bd176f605940b90fff42`
