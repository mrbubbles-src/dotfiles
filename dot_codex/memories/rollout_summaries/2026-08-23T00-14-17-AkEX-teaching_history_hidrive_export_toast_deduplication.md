thread_id: 01a02bf7-d527-7770-a097-758b7d94b9fb
updated_at: 2026-08-23T00:28:14+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T02-14-17-01a02bf7-d527-7770-a097-758b7d94b9fb.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Teaching-History-HiDrive-Export dedupliziert

Rollout context: Portal-Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`. Der Slice war auf den historischen Teaching-History-POST begrenzt; der aktuelle kanonische Export, Hooks, Komponenten und Blob-/andere Exportpfade blieben ausgeschlossen.

## Task 1: Historischen HiDrive-Export mit einem Toast-Owner versehen

Outcome: success

Preference signals:

- Der Nutzer verlangte einen strikt begrenzten Slice, zunächst exakt vier Dateien, später test-only erweitert auf exakt fünf Dateien. Das bestätigt: Produktionsscope eng halten; mechanisch notwendige Testanpassungen dürfen innerhalb desselben Slices ergänzt werden.
- Der Nutzer verlangte keinen Commit/Push im Implementierungslauf, erteilte danach aber ausdrücklich einen separaten Commit-/Push-Auftrag. Umsetzung und Abschluss daher strikt trennen.

Key steps:

- Start-Gate verifiziert: Branch `chore/logging-improvements`, Baseline/HEAD/Origin `a4ed55661e5100e159b38a9d8319dbb452efa2ad`, Upstream `0/0`, sauberes Worktree.
- `src/libs/teachingPlanService.ts`: Historischer POST erhält `undefined` als Body und `{ skipGlobalErrorToast: true }` als request-lokale Axios-Konfiguration. Endpoint, Response, Erfolgsnachricht und Default-Retry bleiben unverändert.
- Neuer Production-QueryClient-Test deckt 400/409/422/500/502/503, sichere 4-Argument-Projektion, malformed/missing envelope mit 3 Argumenten, Nicht-Axios-Fehler mit 2 Argumenten, Error-Identität, Retry `0`, genau einen Toast und Erfolg ab.
- Bestehender Service-Test mechanisch auf die neue dreiteilige POST-Arity angepasst.
- Dokumentation und Changelog aktualisiert.
- Unabhängiger finaler Review: keine Findings P0–P3.
- Verifikation: fokussiert 33/33, Typecheck grün, Build grün, Format-/Diffcheck und fokussiertes ESLint grün. Full Suite 4422/4424; zwei unveränderte Teaching-Plan-/Autosave-Flakes liefen isoliert jeweils grün. Full Lint reproduzierte die bekannte Baseline mit 4 Fehlern/6 Warnungen außerhalb des Slice.
- Freeze: `NOVARI-FREEZE-V1 40dbfeea5e27a9cfea6d579852458a10a9cc0eaa68ebc8b11c40bd1488b6b706`.
- Commit und Push erfolgreich: `520bb8d8f176a33ae21b6da3997625a755ec5b05`, `fix: deduplicate teaching history export errors`; exakt fünf Dateien, HEAD=Origin, Upstream `0/0`, Worktree sauber.

Failures and how to do differently:

- Der erste fokussierte Lauf schlug wegen einer veralteten Service-Test-Assertion und eines falschen Hook-Inputnamens (`versionId` statt `curriculumVersionId`) fehl. Der Inputname wurde im neuen Test korrigiert; die bestehende Service-Assertion wurde nach expliziter test-only Scope-Erweiterung mechanisch aktualisiert.
- Full-Lint- und zwei Full-Suite-Abweichungen lagen ausschließlich außerhalb des Slice; sie wurden nicht repariert, sondern isoliert und als Baseline/Flakes dokumentiert.

Reusable knowledge:

- In diesem Portal besitzt der Production `MutationCache` den zentralen Toast-Owner. Bei einem lokal request-owned Axios-Opt-out muss der Service-Aufruf exakt `post(url, undefined, { skipGlobalErrorToast: true })` verwenden, während Hook-Meta unverändert bleibt.
- Für neue F1-Ownership-Tests den echten Singleton-`queryClient` mit `QueryClientProvider` verwenden und MutationCache, Toast-Arity, Rohdaten-Redaktion, Retry, Error-Identität und Success-Vertrag prüfen.

References:

- `src/libs/teachingPlanService.ts`, `archiveManagementCurriculumOverviewExports`
- `src/hooks/__tests__/useTeachingPlans.errorOwnership.test.tsx`
- `src/libs/__tests__/teachingPlanService.test.ts`
- `docs/development/error-handling.md`, `CHANGELOG.md`
- Commit: `520bb8d8f176a33ae21b6da3997625a755ec5b05`
- Freeze hash: `40dbfeea5e27a9cfea6d579852458a10a9cc0eaa68ebc8b11c40bd1488b6b706`
