thread_id: 01a025c7-daf6-7cb3-8cb4-21c0a0c86b31
updated_at: 2026-08-21T19:39:11+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T21-24-09-01a025c7-daf6-7cb3-8cb4-21c0a0c86b31.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# F1n Portal-Supportinformation für GitHub-Pfadmigrations-Preview umgesetzt und veröffentlicht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `d98a5d6f9c491db066f6a0a5fb22322bfb65684d`. Enger Allowlist-Slice, kein Security-Diff-Scan.

## Task 1: F1n implementieren und verifizieren

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich einen isolierten Slice, exakt fünf erlaubte Dateien, keine Änderung an Hook, Service, Route, Requestbody, CAS-Werten, Reihenfolge oder Folgepfaden und keinen Commit vor unabhängiger Prüfung -> zukünftige Arbeiten strikt anhand von Allowlist, Baseline und Stop-Gates durchführen.
- Der Vertrag verlangt bei fehlender sicherer Projektion exakt drei Toast-Argumente und niemals ein viertes `undefined` -> optionale Argumente nur per Spread hinzufügen, wenn Supportinformation tatsächlich validiert wurde.

Key steps:

- Start-Gate bestätigt: Branch korrekt, HEAD exakt Baseline, Upstream `0/0`, Worktree sauber.
- Runtime-Hunk in `CurriculumWorkRevisionReviewActions.tsx`: Marker vor dem Preview-POST, Supportinformation nur für den gestarteten Axios-POST mit Methode `post` und gültigem fail-closed Envelope, statischer Bereich `GitHub-Pfadmigrationsprüfung`.
- Neue fokussierte Testdatei mit 13 Tests deckt gültigen Envelope, hostile Felder, ungültige/unvollständige Daten, GET/Invalidierung/lokale Fehler, Nachbarpfade, F1l-Vertrag und Erfolg ab.
- Dokumentation in `docs/development/error-handling.md`, `README.md` und `CHANGELOG.md` aktualisiert.

Failures and how to do differently:

- Der erste fokussierte Testlauf hatte einen fehlerhaften Selektor für den bestehenden Dialogbutton (`Bereitstellen`); nur der Test wurde korrigiert, danach 13/13 grün.
- Vollständiges Lint bleibt wegen 4 Fehlern und 6 Warnungen in unveränderten Dateien außerhalb der Allowlist rot. Nicht außerhalb des Slices reparieren; fokussiertes Lint und alle relevanten Tests separat berichten.

Reusable knowledge:

- Supportkopie darf nur sichere Projektion aus `response.data.error` enthalten; `actionHint`, `issue`, `details`, `raw`, URL, Querywerte und technischer Kontext werden nicht übernommen.
- Erfolgreiche Preview-POSTs erzeugen keinen Fehler- oder Supporttoast.
- Volle Testsuite: 362 Dateien, 4030 Tests grün. Typecheck, fokussiertes Lint, Prettier-Allowlist und `git diff --check` grün.

References:

- Runtime: `src/components/lms/teaching-plan/CurriculumWorkRevisionReviewActions.tsx:358-388`
- Tests: `src/components/lms/teaching-plan/__tests__/CurriculumWorkRevisionReviewActions.previewSupportInformation.test.tsx`
- Commit: `26497fddb1a1650c2c52c6bd0464fa35c8a84cc2`

## Task 2: Commit und Push

Outcome: success

Key steps:

- Pre-Commit-Gate erneut bestätigt; exakt fünf Allowlist-Dateien gestaged.
- Genau ein Commit mit `feat: add path migration preview support information` erstellt.
- Normal nach `origin/chore/logging-improvements` gepusht; kein Amend, Force-Push, Rebase oder Fetch.
- Nach Push bestätigt: HEAD und Origin-Tracking-Ref identisch, Upstream `0/0`, Worktree sauber, Baseline→HEAD exakt fünf Dateien und `diff --check` grün.

References:

- Push-Evidenz: `d98a5d6f..26497fdd chore/logging-improvements -> chore/logging-improvements`
- Finaler Status: `HEAD = origin/chore/logging-improvements = 26497fddb1a1650c2c52c6bd0464fa35c8a84cc2`, `0/0`, sauberer Worktree.
