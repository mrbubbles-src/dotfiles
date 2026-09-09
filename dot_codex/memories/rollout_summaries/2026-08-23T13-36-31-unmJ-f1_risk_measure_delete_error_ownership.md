thread_id: 01a02ed6-4c7d-7172-8c96-80c2aed1544d
updated_at: 2026-08-23T13:52:08+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T15-36-31-01a02ed6-4c7d-7172-8c96-80c2aed1544d.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# F1 aktive Risikomaßnahme löschen wurde eng implementiert, korrigiert, committed und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `b56f861a022460b0fe4fd5e684b1c0a02e9f3512`, exakte Allowlist mit drei Dateien. Der Nutzer verlangte ausschließlich den F1-Scoped-Fix, danach Tests/Freeze und später separat Commit/Push.

## Task 1: F1 deleteMeasure Error Ownership

Outcome: success

Preference signals:

- Der Nutzer verlangte wiederholt „nur“ die drei Allowlist-Dateien und Stop-Gates bei Scope-Erweiterung -> zukünftige Novari-Slices fail-closed auf Allowlist, Baseline, Branch, Upstream und Freeze prüfen.
- Der Nutzer verlangte echte Produktionspfad-Tests statt vollständig gemockter Hilfsfunktionen: Hook → Service → echter `apiClient`-Interceptor; nur Adapter, Auth-Refresh und Toast-Sinks mocken.
- Der Nutzer bestand auf unveränderten UI-/Domain-/Nebenoperationen, exakten Axios-Arity-/Body-Kontrakten und Originalfehleridentität.
- Nach einem Review-Finding verlangte der Nutzer ausdrücklich, das ursprüngliche Service-Ergebnis weiterhin aus `mutateAsync` zurückzugeben und rein mechanische Formatter-Hunks zu entfernen.

Key steps:

- Start-Gate bestätigt: sauberer Branch `chore/logging-improvements`, HEAD/Baseline `b56f861…`, Upstream `0/0`.
- `src/libs/riskService.ts`: `deleteMeasure` nutzt bodyless `DELETE /risks/:riskId/measures/:measureId` mit zweitem Argument `{ skipGlobalErrorToast: true }`; Typgrenze wurde über den bestehenden Axios-Kontrakt gelöst.
- `src/hooks/useRisks.ts`: `showLoadingToast('Wird gelöscht…')`, `finally`-Dismiss, `showSuccessToast('Gelöscht')`, `showHandledApiErrorToast(..., 'Löschen der Risikomaßnahme')`, Originalfehler-Re-Throw, `retry: 0`, Rückgabe des ursprünglichen Service-Ergebnisses.
- Neuer Test `src/hooks/__tests__/useRisks.measureDeleteErrorOwnership.test.tsx` deckt Statusmatrix 4xx/5xx, Netzwerkfehler, finalen 401, erfolgreichen Auth-Replay, sichere Supportprojektion, bodyless DELETE-Arity, Toast-Reihenfolge, Invalidierungen und Fehleridentität ab.
- Erste Version hatte einen P2: async `mutationFn` gab `undefined` statt des Service-Ergebnisses zurück. Korrigiert durch Ergebnisvariable plus `return result`; Test prüft Objektidentität. P3-Formatter-Hunks in `patchMeasure` und `useCreateSnapshot` wurden auf HEAD zurückgesetzt.

Failures and how to do differently:

- Direkte Axios-Konfiguration mit `skipGlobalErrorToast` schlug zunächst im Typecheck fehl; projektspezifische Axios-Config muss typisiert werden.
- Prettier hatte zunächst unerlaubte mechanische Hunks in derselben Allowlist erzeugt; bei strengem Freeze keine automatische Formatierung akzeptieren, sondern irrelevante Hunks exakt auf HEAD zurücksetzen.
- Vollständiger Lint blieb bei bekanntem Baselinefehler außerhalb der Allowlist: 4 Fehler/6 Warnungen in unveränderten Dateien. Nicht ausweiten oder reparieren.

Reusable knowledge:

- Erfolgsinvalidierungen bleiben exakt `['risks']` und `['risks', riskId]`; bei Fehlern keine Invalidierungen.
- Canonical `NOVARI-FREEZE-V1` serialisiert tracked binary full-index diff plus sortierte untracked Rohbytes; zsh-Variablen nicht `path` nennen.
- Finaler Freeze vor Commit: `676155b577dcc69ae022090ebd7e014e0e67715a3c58c56da81f43f793808880`, zweimal identisch; tracked 2770 Bytes, Test 11436 Bytes.
- Commit `b29b2452d3510a9f4d116c9e5ea6375255ad3e8a`, Nachricht `fix(logging): add risk measure delete error ownership`; exakt drei Dateien, normal nach `origin/chore/logging-improvements` gepusht, HEAD/Origin identisch, Upstream `0/0`, Worktree sauber.

References:

- [1] Focus test: `npm test -- --run src/hooks/__tests__/useRisks.measureDeleteErrorOwnership.test.tsx` → 14/14.
- [2] Typecheck, ESLint über drei Dateien und `git diff --check` → grün.
- [3] Vollsuite vor der Korrekturrunde → 441 Testdateien, 5068/5068 Tests.
- [4] Geänderte Dateien: `src/libs/riskService.ts`, `src/hooks/useRisks.ts`, `src/hooks/__tests__/useRisks.measureDeleteErrorOwnership.test.tsx`.
- [5] Finaler Push: `b56f861a..b29b2452 chore/logging-improvements -> chore/logging-improvements`.
