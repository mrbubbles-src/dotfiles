thread_id: 01a02690-a510-77a3-adc5-3d0c7ba5e609
updated_at: 2026-08-21T23:19:51+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T01-03-28-01a02690-a510-77a3-adc5-3d0c7ba5e609.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Portal F1p Curriculum-Ziel-GET Supportinformation implementiert und gepusht

Rollout context: Novari Portal, Branch `chore/logging-improvements`, baseline `a9646dd2270ca83fb3240025b2781b1ac6dc795d`. Der Nutzer autorisierte einen eng begrenzten F1p-Slice ohne Delegation, mit exakter Allowlist und anschließendem Commit/Push nach unabhängigem Review.

## Task 1: F1p implementieren und verifizieren

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich „nur an diesem Slice“, „keine Scope-Erweiterung“, „nicht committen/pushen“ bis zum unabhängigen Review und eine exakte Produktions-Allowlist. Das zeigt eine starke Präferenz für fail-closed Scope-Kontrolle, frische Start-Gates und eingefrorene Review-Kandidaten.
- Der Nutzer spezifizierte, dass Default-Aufrufe unverändert bleiben, Transport-Ownership explizit opt-in erfolgt und alle Folgeabläufe unverändert bleiben. Ähnliche Änderungen sollten additive Optionen verwenden und bestehende Consumer standardmäßig nicht beeinflussen.

Key steps:
- Start-Gate bestätigt: korrekter Branch, exakter HEAD, sauberer Worktree, Upstream `0/0`.
- Service `getCurriculumVersionDetail(versionId, quietTransport=false)` erweitert; Default bleibt `apiClient.get(endpoint)` mit einem Argument, Opt-in nutzt `{ skipGlobalErrorToast: true }`.
- Hook um `handledLocally?: boolean` erweitert; nur `handledLocally === true` reicht das zweite Serviceargument weiter. Query-Key, Enabled-Gate, Retry, Refetch, Stale-Time und Loading blieben unverändert.
- Nur `GithubTopicChangeReviewDialog` setzt `handledLocally: true`. Nach endgültigem Queryfehler wird der bestehende Support-Extractor für `GitHub-Topic-Entwurfsziel` verwendet.
- Tests decken gültige 4-Argument-Supporttoasts, ungültige/flat/incomplete/hostile/konfligierende IDs mit 3 Argumenten, lokale Fehler mit 2 Argumenten, Retry/403-Verhalten, identische Query-Keys, Service-Transport und 401-Replay ab.
- Fokussierte Tests: 4 Dateien, 100/100 grün. Volltests: 363 Dateien, 4066/4066 grün. Prettier, fokussierter ESLint, Typecheck und Build grün. Voll-Lint meldete nur bekannte Baseline-Befunde außerhalb der Allowlist (4 Fehler, 6 Warnungen). Lokaler Diff-Review: keine Findings; unabhängiger Voll-Diff-Review: keine P0–P3 Findings, Kontinuität aligned.

Failures and how to do differently:
- Der erste `git add` scheiterte wegen `.git/index.lock`/Berechtigung (`Operation not permitted`); ein erneuter autorisierter Lauf mit erhöhten Rechten funktionierte. Bei verwalteten Checkouts Git-Schreibrechte als separates Gate behandeln und nicht den Codezustand verändern.

Reusable knowledge:
- Der vollständige Review-Diff hatte SHA-256 `acef36d01215c1a25679e599bb15027d9f57253acd7701a58d6efa549b1a2e1b`; 9 Dateien, `+377/-9`.
- Die zentrale Supportprojektion ist strikt fail-closed und akzeptiert nur echte Axios-Response-Fehler mit verschachteltem `data.error`-Envelope.

References:
- Runtime-Dateien: `src/components/lms/github-curriculum/github-topic-change-review-dialog.tsx`, `src/hooks/lms/useLmsCurriculum.ts`, `src/libs/lmsCurriculumService.ts`.
- Testdateien: `src/components/lms/github-curriculum/__tests__/github-topic-change-review-dialog.support-information.test.tsx`, `src/hooks/lms/__tests__/useLmsCurriculum.test.tsx`, `src/libs/__tests__/lmsCurriculumService.test.ts`, `src/libs/__tests__/apiClient.authRetry.test.ts`.
- Dokumentation: `docs/development/error-handling.md`, `CHANGELOG.md`.

## Task 2: F1p committen und pushen

Outcome: success

Key steps:
- Nach Review und Hashprüfung ausschließlich die 9 Allowlist-Dateien gestaged.
- Exakter Commit erstellt: `75c6ca236377050ee8fbfdef9f7aae8890e8a70e` mit Nachricht `feat: add GitHub draft target support information`.
- Normal zu `origin/chore/logging-improvements` gepusht; Remote bestätigt denselben Commit.
- Finaler Zustand: sauberer Worktree, Upstream `0/0`, kein Amend und kein Force-Push.

References:
- Push: `a9646dd2..75c6ca23 chore/logging-improvements -> chore/logging-improvements`.
- Commitstat: 9 Dateien, `377 insertions(+), 9 deletions(-)`.
