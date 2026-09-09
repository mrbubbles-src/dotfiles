thread_id: 01a02ee8-b3db-79c0-8975-ff5ff09dfc02
updated_at: 2026-08-23T14:12:43+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T15-56-37-01a02ee8-b3db-79c0-8975-ff5ff09dfc02.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# F1 „Nicht-GF Risk Writes“ implementiert, geprüft, eingefroren, committed und gepusht

Rollout-Kontext: Novari Portal `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `b29b2452d3510a9f4d116c9e5ea6375255ad3e8a`. Exakte Allowlist: `src/libs/riskService.ts`, `src/hooks/useRisks.ts`, `src/hooks/__tests__/useRisks.measureDeleteErrorOwnership.test.tsx`.

## Task 1: Risk-Write-Ownership-Slice

Outcome: success

Preference signals:
- Der Nutzer verlangte einen „scoped-fix“ mit „Allowlist exact3“, „no review/commit/push“ zunächst bis zur separaten Freigabe -> Scope strikt auf drei Dateien begrenzen und keine angrenzenden Flows ändern.
- Der Nutzer verlangte ausdrücklich, Returns, Invalidierungen, Retry-Verhalten, Toasttexte und `measureDelete` unverändert zu erhalten -> bei ähnlichen Mutations-Slices bestehende fachliche Semantik und benachbarte Producer nicht refaktorieren.

Key steps:
- Für genau sechs aktive Writes wurde request-lokales `{ skipGlobalErrorToast: true }` ergänzt: Risk-Erstellung, Measure-Erstellung/-Update, Monitoring-Erstellung, Effectiveness-Submit und bodyless Reopen.
- Reopen verwendet exakt `apiClient.post(url, undefined, config)`.
- Die Hooks verwenden lokalen Loading-/Dismiss-/Success-/`showHandledApiErrorToast`-Owner, erhalten Error-Identität und Result-Daten und setzen `retry: 0`.
- Die bestehende Measure-DELETE-Implementierung und ihr ursprünglicher Testblock blieben unverändert.
- Der integrierte Test wurde um echte Hook → Service → Axios-Interceptor → QueryClient-Evidenz erweitert: Status 422/500/502/503, Network, finaler 401, Auth-Replay, Envelope/Header-Projektion, Toast-Arity, Invalidierungsreihenfolge und Return-Verhalten.

Reusable knowledge:
- Fokussierter Test: `61/61` grün; vollständige Suite: `441/441` Testdateien und `5115/5115` Tests grün.
- Typecheck und fokussiertes ESLint grün. Vollständiges Lint hatte 4 bestehende Fehler und 6 Warnungen ausschließlich außerhalb der Allowlist; diese wurden nicht verändert.
- Kanonischer vollständiger Freeze-V1-Hash des Kandidaten: `d62dd8732037800e1903acb69164f346c690d8533b4b5fa408c856ffda6f3f32`, tracked diff `29509` Bytes, untracked `[]`; zweimal identisch reproduziert.
- Der frühere Hash `47ac...` war nur `git diff --binary --full-index ... | shasum -a 256` über den tracked Diff und nicht der vollständige NOVARI-FREEZE-V1-Stream. Die vollständige Serialisierung benötigt Prefix, NUL-Trenner und `UNTRACKED-FILES`-Abschnitt.
- Commit `3babb7cc789a06ba6ce6c8c6c3adbebfc0f0976b`, Message `fix(logging): add risk write error ownership`, normal auf `origin/chore/logging-improvements` gepusht. Worktree sauber, Upstream `0/0`.

Failures and how to do differently:
- Der erste `git add` scheiterte an `.git/index.lock: Operation not permitted`; nach autorisiertem escalated `git add` war das Staging erfolgreich.
- Prettier erzeugte zunächst fremde reine Formatierungshunks; diese wurden entfernt, sodass nur die drei Allowlist-Dateien und der beabsichtigte Slice verblieben.
- Ein initialer Freeze-Check stoppte korrekt wegen falscher Hash-Serialisierung. Künftig NOVARI-FREEZE-V1 von Anfang an vollständig berechnen, nicht den einfachen tracked-Diff-Hash verwenden.

References:
- Runtime-Dateien: `src/libs/riskService.ts`, `src/hooks/useRisks.ts`.
- Integrierter Test: `src/hooks/__tests__/useRisks.measureDeleteErrorOwnership.test.tsx`.
- Canonical command family: `git diff --binary --full-index --no-ext-diff HEAD --`; sortierte raw untracked records und NUL-delimited `NOVARI-FREEZE-V1`-Serialisierung.
- Final push output: `b29b2452..3babb7cc chore/logging-improvements -> chore/logging-improvements`.
