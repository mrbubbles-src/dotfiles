thread_id: 01a030e7-0302-7511-8d35-6137c960433b
updated_at: 2026-08-23T23:18:15+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T01-14-01-01a030e7-0302-7511-8d35-6137c960433b.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Freeze-Review des Portal-Logging-V2-F1-Onboarding-Slices mit zwei Findings

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der Branch `chore/logging-improvements` strikt read-only geprüft. Der Start-Gate war bytegenau erfüllt: HEAD `085b93dc41a9b1eb942268fa1c98fb3fad6b584f`, Upstream `0/0`, Freeze-SHA256 `683c57d1db6bb3eb648d5acbec6a012edaf088d08722f17934aa4b31bafd4acd`, tracked diff 5027 Bytes, Gesamtfreeze 27992 Bytes, exakt vier Allowlist-Pfade und zwei neue Tests. AGENTS/CLAUDE, die V2-Spezifikation, Visualisierung und Review-Referenzen sowie der vollständige Diff und beide Tests wurden gelesen. Es wurden keine Tests, Edits, Formatierungen oder Git-Mutationen ausgeführt.

## Task 1: Onboarding-PDF-Generation und Error-Ownership reviewen

Outcome: partial

Preference signals:

- Der Nutzer verlangte ausdrücklich einen „frischen repositorygebundenen unabhängigen Reviewer“, strikt read-only, „keine Spekulation“, findings-first mit P0–P3 und Stop bei Gate-Abweichungen -> zukünftige Reviews sollen exakt diese Evidenz- und Scope-Disziplin beibehalten.
- Der Nutzer verlangte eine exakte Allowlist, vollständige Diff-/Testlektüre und keine Tests oder Mutationen -> Handoff-Behauptungen dürfen nicht als Ersatz für eigene Prüfung verwendet werden.

Key steps:

- Start-Gate und kanonischen Freeze zweimal ausgeführt; beide Läufe identisch.
- Runtime-Diff geprüft: WeakMap-Claim pro QueryClient, Key aus `userID + role + contractStartDate`, lokaler Axios-Config mit `undefined`-Body und `skipGlobalErrorToast`, `retry: 0`, lokale Support-/Fallback-Fehleranzeige und bestehende `my-onboarding`-Invalidierung.
- Auth-/Axios-Replay, QueryClient-Isolation, Auth-Userwechsel und TanStack-Query-Cache-Entfernung untersucht.
- Zwei unabhängige Reviewer hinzugezogen: Runtime-Review ohne Findings; Test-Review identifizierte eine echte Testlücke.

Failures and how to do differently:

- [P1] In `src/hooks/useMyOnboarding.ts:68-71` verwirft der lokale Fallback bei unvollständiger Support-Envelope eine vorhandene Request-ID und zeigt nur den kurzlebigen Standardtoast. Da der globale 5xx-Toast per `skipGlobalErrorToast` deaktiviert ist, muss bei vorhandener sicherer Request-ID ein persistenter `showBackendErrorToast` ohne Support-Aktion verwendet werden; nur ohne ID ist `showErrorToast` korrekt.
- [P2] `src/components/dashboard/onboarding/__tests__/OnboardingWidget.pdfGeneration.test.tsx:149-177` testet finale Fehler und Replay nur mit vollständig gemocktem Hook bzw. synchronen Zählungen. Die Tests erzeugen keinen echten gesettelten Mutation-Fehler und beweisen weder 401→Refresh→503 noch das Zusammenspiel von echtem Axios-Interceptor, Claim und Remount. Ein realer Hook-/QueryClient-Test sollte den Replay vollständig abwarten, anschließend mit demselben QueryClient remounten und weiterhin genau einen logischen Versuch prüfen.
- Backend-Idempotenz wurde nicht repositoryübergreifend geprüft; das bleibt ausdrücklich unbestätigt.

Reusable knowledge:

- Der Runtime-Claim ist QueryClient-lokal und synchron; dadurch werden StrictMode-Rehearsal und parallele Widgets desselben QueryClients dedupliziert, während andere Nutzer, Rollen oder Vertragsstartdaten neue Keys erhalten.
- Der Claim bleibt bei finalen Fehlern bestehen und wird nur bei bestätigtem nicht qualifizierendem Zustand (`pdfGenerated` oder nicht abgeschlossen) freigegeben.
- Der Erfolgspfad bleibt still und invalidiert genau `['my-onboarding']`; Auth-Refresh/Axios-Replay bleibt innerhalb einer logischen Mutation.
- Die zentrale Support-Projektion ist fail-closed und verwendet den statischen Bereich `Erzeugen des Onboarding-Datenblatts`; Rohmeldungen, URLs, Querywerte und IDs werden nicht in die Supportkopie übernommen.

References:

- Freeze command: `ruby -rdigest -e '... NOVARI-FREEZE-V1 ...'` mit Ergebnis SHA256 `683c57d1db6bb3eb648d5acbec6a012edaf088d08722f17934aa4b31bafd4acd`, tracked `5027`, Gesamt `27992`.
- Runtime-Dateien: `src/components/dashboard/onboarding/OnboardingWidget.tsx`, `src/hooks/useMyOnboarding.ts`.
- Testdateien: `src/components/dashboard/onboarding/__tests__/OnboardingWidget.pdfGeneration.test.tsx`, `src/hooks/__tests__/useGenerateOnboardingPdf.errorOwnership.test.tsx`.
- V2-Spezifikation: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md`.
- Präzise Findings: P1 Request-ID-Fallback in `useMyOnboarding.ts:68-71`; P2 Attrappen-Test in `OnboardingWidget.pdfGeneration.test.tsx:149-177`.
