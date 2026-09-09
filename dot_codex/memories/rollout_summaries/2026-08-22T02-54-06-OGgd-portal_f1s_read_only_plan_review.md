thread_id: 01a02763-cb34-79c2-bf27-3426f6722875
updated_at: 2026-08-22T03:00:47+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/22/rollout-2026-08-22T04-54-06-01a02763-cb34-79c2-bf27-3426f6722875.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only F1s Plan-Review für Portal Logging V2 abgeschlossen

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der F1s-Plan für die GitHub-Topic-Aktion „Als Entwurf übernehmen“ vollständig read-only gegen AGENTS.md, relevante Skills, aktuelle V2-Spezifikation/Visualisierung, Dokumentation, Changelog und aktuellen Code geprüft. Keine Edits, Tests, Formatter, Fetch/Pull oder Git-Mutationen.

## Task 1: F1s Scope- und Phasenprovenienz-Review

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „vollständig frischer repositorygebundener READ-ONLY-Plan-Reviewer“, „findings-first“ und P0–P3 mit Datei/Zeile -> bei ähnlichen Logging-Slices zuerst aktuelle Evidenz selbst prüfen, Findings priorisieren und bei Scope-/Baseline-Abweichungen fail-closed stoppen.
- Der Nutzer gab eine exakte Produktions-/Test-/Doku-Allowlist sowie ausdrücklich unveränderte Abläufe vor -> Allowlist und ausgeschlossene Produktpfade künftig explizit gegen jeden Diff-Abschnitt prüfen.
- Der Nutzer verlangte keine Delegation/Subagents -> diese Einschränkung als maßgeblich behandeln, auch wenn allgemeine Orchestrierungsregeln Delegation nahelegen.

Key steps:

- Repositoryzustand bestätigt: Branch `chore/logging-improvements`, HEAD/Baseline `9885ddd9f9d66365e737bd176f605940b90fff42`, sauberer Worktree, Upstream `0/0`.
- Normative V2-Spec und Visualisierung vollständig gelesen; F1s korrekt als §2.2 Fall 6 eingeordnet.
- Bestehende Dialog-, Service-, Hook-, Axios- und Testpfade verfolgt; insbesondere lokale Toast-Ownership, Structured-Issue-Priorität, Auth-Replay und alle `getTopicById`-Consumer geprüft.
- Findings-first-Ergebnis: keine P0/P1-Findings; zwei konkrete P2/P3-Korrekturen am Plan identifiziert.

Failures and how to do differently:

- P2: Eine gemeinsame `useRef`-Phase wäre bei überlappenden Aktionen race-/stale-anfällig. Stattdessen handler-lokale Union-Variable verwenden, direkt vor dem jeweiligen Request setzen und unmittelbar nach erfolgreichem `await` löschen; nicht in `finally` löschen, damit ein Requestfehler seine richtige Area behält.
- P3: Der Plan behauptete fünf weitere Production-Consumer. Tatsächlich wurden vier gefunden: `useLmsTopics.ts`, `self-learning-manager-dialog.tsx`, `self-learning-editor-form.tsx` und `TeachingPlanLmsTopicLink.tsx`; der Re-Export ist kein zusätzlicher Consumer. Plan und Regressionserwartungen entsprechend korrigieren.
- Kein unnötiges Mikroslicing oder neue Abstraktion: GET und Adoption-Claim bleiben als zwei serielle Producer derselben Nutzeraktion und desselben lokalen Failure-Owners zusammen.

Reusable knowledge:

- `getTopicById` kann mit einem minimalen optionalen lokalen Ownership-Opt-in erweitert werden; der Default-Aufruf muss byte-/verhaltensgleich bleiben. Nur der F1s-Dialog setzt den Opt-in.
- Der Adoption-Claim nutzt die vorhandene `locallyHandledErrorConfig`; wegen Axios-Signatur ist die minimale Form `post(url, undefined, locallyHandledErrorConfig)`.
- `apiClient` bewahrt `skipGlobalErrorToast` beim Auth-Replay über das originale Request-Config; bestehende Auth-Retry-Regressionstests decken diesen Vertrag ab.
- Structured GitHub Issues haben Vorrang und dürfen keinen Toast erzeugen. Lokale Fehler bleiben bei exakt zwei Toastargumenten; sichere Backend-Fallbacks bleiben bei drei Argumenten, ohne `undefined`.
- Ausgeschlossene F1s-Schritte sind Bildkonvertierung/-upload, lokale Speicherung, Navigation, Mapping-/Rollenlogik, Draft-/LocalStorage-Verhalten, Claim-ID/Expiry/Markdown/Image-Manifest sowie F1p/F1k/F1q/F2.

References:

- Produktions-Allowlist: `src/components/lms/github-curriculum/github-topic-change-review-dialog.tsx`, `src/libs/lmsTopicService.ts`, `src/libs/githubCurriculumService.ts`.
- Test-Allowlist: `src/components/lms/github-curriculum/__tests__/github-topic-change-review-dialog.support-information.test.tsx`, `src/libs/__tests__/lmsTopicService.test.ts`, `src/libs/__tests__/githubCurriculumService.test.ts`, `src/libs/__tests__/apiClient.authRetry.test.ts`.
- Relevante Stellen: Dialog `handleOpenInEditor` etwa Zeilen 235–361; `getTopicById` in `src/libs/lmsTopicService.ts` etwa Zeilen 47–58; Claim in `src/libs/githubCurriculumService.ts` etwa Zeilen 564–572; Axios-Replay in `src/libs/apiClient.ts` etwa Zeilen 64–103.
- Abschluss: „Keine P0/P1-Findings“, P2 Phasenprovenienz und P3 falsche Consumerzahl; korrigierter Plan danach freigabefähig, Repository unverändert.
