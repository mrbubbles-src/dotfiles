thread_id: 01a02c2a-8576-7451-b2f3-2e17fc54a21b
updated_at: 2026-08-23T01:26:57+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T03-09-39-01a02c2a-8576-7451-b2f3-2e17fc54a21b.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# QM-Auditwerte-F1-Slice für Portal Logging V2 implementiert und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `513747b74df2500fa642933bccb2f8cbfc8d0f22`. Exakte 8-Dateien-Allowlist; Kandidat zunächst ungestaged einfrieren, anschließend nach separatem Review committen und pushen.

## Task 1: QM-Auditwerte Error Ownership

Outcome: success

Preference signals:

- Der Nutzer verlangte strikt: „KEINEN unabhängigen Reviewer selbst“ und nach dem Freeze „ohne weiteren Repozugriff“ -> bei solchen delegierten Slice-Tasks muss der Implementierungstask nur Selbst-Review, Scope-/Baseline-Nachweis und Freeze durchführen; der unabhängige Final-Review erfolgt ausschließlich durch den koordinierenden Root.
- Der Nutzer verlangte eine exakte Allowlist und sofortigen Stop bei Abweichungen -> keine opportunistischen Refactors oder zusätzlichen Dateien.
- Der Nutzer verlangte, dass der Kandidat zunächst ungestaged bleibt und weder Commit noch Push vor Review/Freigabe erfolgt -> Freeze- und Commit-Gates strikt einhalten.

Key steps:

- Start-Gate bestätigt: Repository, Branch, HEAD/Baseline, sauberer Worktree und Upstream `0/0`.
- In `qmAuditService.ts` nur die zwei Populate-POSTs und den Goal-PATCH mit typisiertem `skipGlobalErrorToast: true` als drittem Axios-Argument versehen; GET, PDF/Blob und Exporte unverändert gelassen.
- In `QmKennzahlenPanel.tsx` enge Write-Phasen eingeführt: Supporttoast nur für den tatsächlichen Populate-Request; GET-open-, Kein-Audit- und Folgefehler bleiben normale lokale Fehlerpfade.
- In `ZielePage.tsx` enge PATCH-Phase eingeführt; echter PATCH-Fehler erhält Supportinformation, nachgelagerte lokale Fehler bleiben normal; derselbe Fehler wird unverändert weitergeworfen.
- Drei fokussierte Regressionstestdateien ergänzt. Statusmatrix: Basislinie `400/500/599`, Sektor `403/422/502`, Ziel `409/429/503`; zusätzlich Envelope-/Request-ID-Fallbacks, Leak-Sentinels, GET-Abgrenzung, Erfolg/Warnung und Rethrow-Identität.
- Checks: fokussierte Tests `20/20`, vollständige Tests `4474/4474` in `392` Dateien, Typecheck erfolgreich, fokussiertes ESLint erfolgreich, Build erfolgreich, `git diff --check` sauber. Voll-Lint reproduzierte nur Baselinefehler außerhalb der Allowlist: `4` Fehler und `6` Warnungen in unveränderten Dateien.
- Kanonischer `NOVARI-FREEZE-V1` zweimal identisch gebildet: `7fe52fdf48d0e1ec7f2ca899a6f2bab34f3269649b7608446b57f7ddd2b541c1`.
- Separater Final-Review laut späterer Nutzerbestätigung ohne Findings; Freeze blieb unverändert.
- Exakt acht Dateien staged, Commit `b14eb48929a4a9f7faa2ef570b78fb8baac86f7a` mit `fix: unify QM audit error ownership`, normal auf `origin/chore/logging-improvements` gepusht; finaler Worktree sauber, Upstream `0/0`.

Failures and how to do differently:

- Der Task startete zunächst entgegen der späteren Root-Klarstellung einen unabhängigen Reviewer; dieser wurde sofort abgebrochen und sein Ergebnis nicht verwendet. Künftig Delegationsanweisungen zur Context-Isolation vor jedem Spawn nochmals prüfen.
- Der erste Typecheck scheiterte an zwei neuen Test-Fixture-Typisierungen; ausschließlich Testfixtures korrigiert, danach Tests und Typecheck grün.
- Prettier meldete bestehende Formatabweichungen in zwei Production-Dateien. Neue Tests wurden formatiert; bestehende Production-Dateien nicht whole-file formatiert, um fremde Hunks zu vermeiden.
- Der erste `git add` scheiterte wegen `.git/index.lock`-Berechtigung; derselbe autorisierte Vorgang mit erhöhter Berechtigung war erfolgreich.

Reusable knowledge:

- Das Portal nutzt für lokale Error Owner den zentralen `showHandledApiErrorToast(title, error, area)`-Pfad; gültige Axios-Envelopes erzeugen einen vierargumentigen Backendtoast, ungültige Envelopes einen Referenzfallback ohne Supportobjekt.
- Request-Phasen müssen unmittelbar vor dem tatsächlichen Write gesetzt und direkt nach erfolgreichem Await gelöscht werden, damit vorgelagerte GETs und nachgelagerte Folgefehler keine falsche Supportinformation erhalten.
- `skipGlobalErrorToast` ist request-lokal und nur zusammen mit explizitem lokalem Error Owner zu verwenden; keine MutationCache-, Meta- oder Retry-Änderungen nötig.

References:

- Baseline: `513747b74df2500fa642933bccb2f8cbfc8d0f22`
- Freeze: `7fe52fdf48d0e1ec7f2ca899a6f2bab34f3269649b7608446b57f7ddd2b541c1`
- Commit: `b14eb48929a4a9f7faa2ef570b78fb8baac86f7a`
- Allowlist: `src/libs/qmAuditService.ts`, `src/components/dashboard/qualityManager/QmKennzahlenPanel.tsx`, `src/components/dashboard/qualityManager/ziele/ZielePage.tsx`, die drei jeweiligen `*.errorOwnership.test.*`-Dateien, `docs/development/error-handling.md`, `CHANGELOG.md`.

