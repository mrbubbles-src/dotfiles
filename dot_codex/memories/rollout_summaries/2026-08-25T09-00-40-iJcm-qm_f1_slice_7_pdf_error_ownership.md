thread_id: 01a03826-78f9-7423-8cbb-f33d674ffb72
updated_at: 2026-08-25T09:15:43+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-00-40-01a03826-78f9-7423-8cbb-f33d674ffb72.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# QM F1 Slice 7/7 wurde erfolgreich umgesetzt und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline `8df6f746afa142a08e7b4b846977c2d641444ffc`. Start-Gate war sauber; Spec-Hashes stimmten. Der Scope war strikt auf Request-Opt-outs und lokale Fehler-Owner für QM-Erstellung sowie PDF-Export begrenzt.

## Task 1: Quarterly Create und QM-PDF-Fehlerownership

Outcome: success

Preference signals:

- Der Nutzer verlangte einen „kleinsten coherent reviewable slice“, eine exakte Allowlist, unveränderte Produktflüsse und Stop bei Scopeabweichung -> zukünftige Logging-Slices ebenso eng planen und vor Änderungen Branch, Baseline, Allowlist und unveränderte Grenzen explizit prüfen.
- Der Nutzer verlangte Findings-first-Baseline→Kandidat-Review und Re-Review nach Korrekturen -> niemals direkt committen; vollständigen Diff unabhängig prüfen und Findings vor Commit beheben.
- Blob-/PDF-Bodies durften nicht gelesen, dekodiert oder als JSON behandelt werden -> PDF-Tests müssen echte opake Blob-Fehlerkörper verwenden und nur statische Fehlerprojektion beziehungsweise validierte Request-ID prüfen.

Key steps:

- `createQuarterlyReview` erhielt `skipGlobalErrorToast`; der bestehende `showPromiseToast` bleibt alleiniger Owner.
- Quarterly-, Management- und Intern-Audit-PDF-Requests erhielten lokalen Interceptor-Opt-out.
- Quarterly, Management und Audit verwenden statische lokale PDF-Fehlerdarstellung. Management/Audit opten den Draft-Save nur innerhalb der lokalen Draft→Export-Gesamtoperation aus; Reihenfolge blieb unverändert.
- `exportZielePdf` blieb unverändert.
- Tests für Create, PDF-Services und Detailansichten ergänzt beziehungsweise angepasst; ein initialer Audit-Test-Harness-Fehler wurde nur in der Test-Allowlist korrigiert.
- Nach einem Review-Fund wurden PDF-Tests auf echte opake Blob-Fehlerkörper und `requireValidatedAxiosMessage` umgestellt.

Failures and how to do differently:

- Der erste fokussierte Lauf hatte zwei Audit-Testfehler, weil der Test auf einen nicht vorhandenen Button wartete; der Harness wurde auf die Audit-Überschrift als Lade-Signal korrigiert.
- Der erste Typecheck meldete neue Axios-Typfehler für `skipGlobalErrorToast`; die Blob-Konfiguration wurde mit `{ ...locallyHandledErrorConfig, responseType: 'blob' }` typisiert.
- Gesamt-Lint und Typecheck enthalten weiterhin Fremdfehler außerhalb des Slice: Gesamt-Lint 4 Fehler/6 Warnungen; Typecheck 3 Fehler in `PortalEntryEditor`/`useHelpPortal`. Fokussiertes ESLint war sauber.
- Ein initialer Review-Fund zeigte unrealistische JSON-Fehlerkörper in Blob-Tests; künftig bei Blob-Slices von Anfang an echte `Blob`-Daten im Fehlerresponse verwenden.

Reusable knowledge:

- Validierter Commit: `f013140721a0095d5381a002deb590b098c1b860` mit Message `fix: give QM PDF exports one local error owner`.
- Validierte Allowlist umfasste 14 Dateien: 6 Runtime-Produktdateien, 6 Testdateien sowie `docs/development/error-handling.md` und `CHANGELOG.md`.
- Fokus-Tests: 6 Testdateien, 51/51 bestanden. Gesamtsuite: 512 Testdateien, 6060/6060 Tests bestanden.
- Push erfolgreich nach `origin/chore/logging-improvements`; finaler Worktree sauber, HEAD und Origin beide auf `f0131407...`.

References:

- [1] Start-Gate: Branch/HEAD/Origin `8df6f746...`, Worktree 0/0, beide Spec-SHA256-Hashes korrekt.
- [2] Fokussierter Lauf: `Test Files 6 passed`, `Tests 51 passed`.
- [3] Gesamtsuite: `Test Files 512 passed (512)`, `Tests 6060 passed (6060)`.
- [4] Push: `8df6f746..f0131407 chore/logging-improvements -> chore/logging-improvements`.
