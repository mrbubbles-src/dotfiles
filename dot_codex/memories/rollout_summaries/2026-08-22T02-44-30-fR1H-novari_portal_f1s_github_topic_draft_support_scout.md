thread_id: 01a0275b-0053-7973-88a7-8b5a44ec3da5
updated_at: 2026-08-22T02:51:36+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-44-30-01a0275b-0053-7973-88a7-8b5a44ec3da5.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Scout wählt nächsten kohärenten Portal-Logging-V2-F1-Slice

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde strikt read-only geprüft. Branch `chore/logging-improvements`, HEAD/Baseline `9885ddd9f9d66365e737bd176f605940b90fff42`, Worktree sauber, Upstream `0/0`. Keine Edits, Tests, Formatter, Fetches, Commits oder Pushes.

## Task 1: Nächsten F1-Slice für GitHub-Topic-Entwurfsübernahme bestimmen

Outcome: success

Preference signals:
- Der Nutzer verlangte einen „vollständig frischen ... READ-ONLY-Scout“, Findings-first, exakte Allowlists, explizit unveränderte Abläufe und fail-closed Stop-Gates -> künftige Reviews müssen diese Grenzen strikt einhalten und nicht in Implementierung wechseln.
- Die gewünschte Einheit ist der „kleinste kohärente reviewbare Slice“, nicht zwingend die kleinstmögliche Dateiänderung -> zusammengehörige Producer innerhalb einer Nutzeraktion dürfen gebündelt werden, wenn eine Trennung doppelte Ownership-/Catch-Analyse erzeugen würde.
- Bei fehlender sicherer Projektion gilt weiterhin: „vierter Parameter nur bedingt, nie undefined“ -> exakt die legacy Dreiargument-Toastform beibehalten.

Key steps:
- Normative Spec, Visualisierung, `AGENTS.md`, `docs/development/error-handling.md`, README, CHANGELOG, relevante Codepfade und historische F1-Evidenz wurden gelesen und gegen die aktuelle Baseline abgeglichen.
- Kandidaten wurden nach Producer, Provenienz, Toast-Owner, Arity und Duplicate-Risiko inventarisiert.
- F1s wurde als nächster Slice gewählt: die eine Aktion „Als Entwurf übernehmen“, aber nur die zwei seriellen Backend-Producer Topic-GET und anschließender Adoption-Claim.
- Bildkonvertierung/-upload, lokale Draftspeicherung und Navigation wurden bewusst ausgeschlossen, weil sie eigene Ownership, zwei Consumer und lokale Fehlerpfade haben.

Failures and how to do differently:
- Befund P2: Dialog-Catches existieren bereits, aber Topic-GET und Adoption-Claim unterdrücken den Axios-5xx-Fallback nicht vollständig; eine reine Dialogänderung würde Doppel-Toasts riskieren. Beide konkreten Requests benötigen zusätzlich lokalen Transport-Ownership-Opt-in.
- Nicht behaupten, dass Tests, Formatter, Security Scan oder Implementierung erfolgt seien. Die Security-Prüfung bleibt vor PR als vollständiger separater Gate offen; kein per-Slice Security Scan.

Reusable knowledge:
- F1 erlaubt nur echte Backendfehler mit vollständigem sicherem Axios-Envelope; statische Areas, keine URL-/Query-/User-Input-/Rohdatenprojektion, keine Änderung von Claim, Retry, Rollen, Success-, Navigation-, Post-Commit- oder Follow-up-Flows.
- Vorgeschlagene Production-Allowlist für F1s: `src/components/lms/github-curriculum/github-topic-change-review-dialog.tsx`, `src/libs/lmsTopicService.ts`, `src/libs/githubCurriculumService.ts`.
- Der Topic-GET soll einen rückwärtskompatiblen lokalen Opt-in erhalten; nur der Review-Desk-Aufruf setzt `skipGlobalErrorToast: true`, während die übrigen Consumer und der normale Zweiargument-Aufruf unverändert bleiben.
- Der Adoption-Claim soll die vorhandene `locallyHandledErrorConfig` verwenden; URL, Body, Response, Hook-Key, Retry und Claim-Vertrag bleiben unverändert.
- Vollständiger strikter Envelope -> vier Toast-Argumente; flacher/unvollständiger/feindlicher/widersprüchlicher Envelope -> exakt drei; lokale Fehler bleiben bei Zweiargument-`showErrorToast`.

References:
- Baseline: `chore/logging-improvements`, `9885ddd9f9d66365e737bd176f605940b90fff42`, `git rev-list --left-right --count @{upstream}...HEAD` => `0 0`.
- Normative Quellen: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md`, insbesondere §2.2 Fall 6, §13 F1, §14/14.1, §15; Visualisierung gleicher Pfad, Spezifikation normativ.
- Relevante Funktionen: `getTopicById` in `src/libs/lmsTopicService.ts`; `createGithubCurriculumTopicChangeAdoptionClaim` in `src/libs/githubCurriculumService.ts`; mehrstufiger Catch `handleOpenInEditor` in `github-topic-change-review-dialog.tsx`.
- Test-Allowlist vorgeschlagen: `src/components/lms/github-curriculum/__tests__/github-topic-change-review-dialog.support-information.test.tsx`, `src/libs/__tests__/lmsTopicService.test.ts`, `src/libs/__tests__/githubCurriculumService.test.ts`, `src/libs/__tests__/apiClient.authRetry.test.ts`.
- Doku-Allowlist vorgeschlagen: `docs/development/error-handling.md`, `README.md`, `CHANGELOG.md`.
- Geplante Checks nach separatem Go: fokussierte Suiten, `git diff --check`, `npm run typecheck`, `npm run lint`, vollständiger `npm test`, anschließend eingefrorener unabhängiger Voll-Diff-Review. Commit-Vorschlag: `feat: add GitHub draft preparation support information`.
