thread_id: 01a0246b-18dd-7493-83d2-0111d21b23fb
updated_at: 2026-08-21T13:07:31+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T15-03-13-01a0246b-18dd-7493-83d2-0111d21b23fb.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Review des Portal-F1d-Plans für Curriculum-Prüfung abgeschlossen

Rollout-Kontext: Im Portal-Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der Plan für einen eng begrenzten F1d-Teilslice geprüft. Der Reviewer durfte ausschließlich lesen und keine Änderungen, Tests, Formatierung, Fetches, Commits oder Pushes ausführen.

## Task 1: Unabhängige Planprüfung für Curriculum-Prüfungsfehler

Outcome: success

Preference signals:
- Der Nutzer verlangte einen „vollständig frischen, kontextisolierten, unabhängigen read-only Plan-Reviewer“, „findings-first P0–P3“ und „fail closed“ bei jeder Start-Gate-Abweichung -> bei ähnlichen Novari-Slices strikt read-only bleiben, aktuelle lokale Evidenz selbst prüfen und keine Implementierungsfreigabe ableiten.
- Der Nutzer gab eine exakte 7-Dateien-Allowlist und zahlreiche unveränderte Abläufe vor -> jede Runtime-Datei und jeder Diff-Hunk muss einzeln gegen Allowlist und §2.2 gemappt werden; keine Scope-Erweiterung oder zentrale Helperänderung.
- Der Nutzer verlangte, dass unsichere/lokale Fehler den bisherigen Drei-Argumente-/Referenz-Fallback behalten -> bei optionalem viertem Toast-Argument nur konditional anhängen, nicht `undefined` als vierten Parameter übergeben.

Key steps:
- Start-Gate erfolgreich verifiziert: Repository Portal, Branch `chore/logging-improvements`, HEAD/Baseline `aca9fb0ca899cb58f3fa2cc3c0ecf5e71be5ef67`, sauberer Worktree, Upstream `0/0`, korrektes `origin`.
- AGENTS.md, V2-Spezifikation, Visualisierung, Orchestrate-Skill und Novari-Logging-Slice-Gate gelesen; die Runtime-Änderungen wurden ausschließlich §2.2 Fall 6 zugeordnet.
- Tatsächliche Runtime-, Hook-, Service-, Test- und Doku-Pfade geprüft. Beide Submit-Komponenten sind lokale Failure-Owner; der Review-Mutation-Hook nutzt bereits `retry: false` und `skipGlobalErrorToast: true`.
- Keine P0/P1-Findings festgestellt. Drei reparierbare P2- und ein P3-Finding wurden dokumentiert.

Failures and how to do differently:
- P2: Der Plan muss ausdrücklich verlangen, `extractBackendSupportInformation(error, 'Curriculum-Prüfung')` nur bei erfolgreicher Projektion als viertes Argument an `showBackendErrorToast` weiterzugeben. Sonst wäre der Fallback nicht exakt der bisherige Drei-Argumente-Aufruf.
- P2: Bestehende Reviewvalidierungsfehler sind bereits sichere Axios-Envelopes. Die beiden Validation-Testfälle müssen daher vier Argumente mit Support-Information erwarten; Validation-Callback, Meldung und Request-ID bleiben unverändert.
- P2: Preview-/Lease-/Doppelsubmit-Nachweise gelten nur für den Editor. Die Managementübersicht darf keinen neuen Lease- oder Doppelsubmit-Mechanismus erhalten.
- P3: `README.md` verweist bereits auf `docs/development/error-handling.md` und muss nach aktueller Evidenz nicht geändert werden, obwohl es in der Allowlist steht.

Reusable knowledge:
- Sichere Projektion ist fail-closed: echter `AxiosError`, Response-Status 400–599, eigenes Objekt `response.data.error`, sichere Meldung, Code- und Request-ID-Validierung sowie optional strikt validierter IMF-fixdate-`Date`-Header. `actionHint`, Details, URLs, Querywerte, Rohheader, IDs und JSON bleiben ausgeschlossen.
- Bestehender Toast-Fallback und Lease-Folgeaktionswarnung müssen unangetastet bleiben. Submit-/Checkpoint-/Preview-/Lease-/Success-/Berechtigungsablauf darf nicht geändert werden.
- F1d sollte voraussichtlich sechs der sieben erlaubten Dateien ändern: zwei Runtime-Dateien, zwei bestehende Komponententests, `docs/development/error-handling.md` und `CHANGELOG.md`; `README.md` bleibt unverändert.
- Vorgesehene Checks nach einer späteren expliziten Implementierungsfreigabe: fokussierte Vitest-Tests, Prettier nur für die Allowlist, `npm run typecheck`, `npm run lint`, `npm run build`, vollständiges `npm test`, danach Status-, Allowlist- und Diff-Check.

References:
- [1] Start-Gate: `chore/logging-improvements`, `aca9fb0ca899cb58f3fa2cc3c0ecf5e71be5ef67`, status clean, upstream `0 0`, origin `git@github.com:Novari-Education/novari-education-portal.git`.
- [2] Runtime-Dateien: `src/components/lms/teaching-plan/CurriculumWorkRevisionOverviewReviewAction.tsx` und `src/components/lms/teaching-plan/editor/CurriculumWorkReviewControls.tsx`.
- [3] Zentraler Vertrag: `extractBackendSupportInformation(error, 'Curriculum-Prüfung')` plus `showBackendErrorToast`; sicherer Fallback: `...(supportInformation ? [supportInformation] : [])`.
- [4] Bestehende zentrale Helper: `src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`; bestehende Matrix: `src/libs/utils/__tests__/backendError.supportInformation.test.ts`.
- [5] Finaler Commitvorschlag des Plans: `feat: add curriculum review support information`.

Keine Dateien wurden verändert und keine Implementierungsfreigabe erteilt.
