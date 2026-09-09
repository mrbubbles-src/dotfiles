thread_id: 01a033d8-c772-7f73-b2c8-4f95e5d98164
updated_at: 2026-08-24T13:13:32+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T14-57-20-01a033d8-c772-7f73-b2c8-4f95e5d98164.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Portal-F1 Abschluss-Scan identifizierte sieben konkrete Restbereiche

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`; branch `chore/logging-improvements`; verified HEAD `6fe9ad9e436e640c4baee0f3756b680b637d8205`; clean status and upstream 0/0. No edits, tests, fetch/pull, commits, or delegation were performed.

## Task 1: Portal-F1/Logging-V2 Abschluss-Review

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich einen „FRISCHEN repositorygebundenen READ-ONLY Abschluss-Scout“, findings-first, nur current-code-belegt, mit absoluten Datei:Zeile-Links und ohne künstliche Rest-Slices. Künftige Reviews sollten diesen engen, evidenzbasierten Scope und fail-closed Start-Gates beibehalten.
- Der Nutzer verlangte nach dem Scan kompakte, vollständige Listen und ausdrücklich, keinen Restbereich auszulassen. Ergebnisse sollten daher alle konkreten Restpunkte mit Severity und Scope-Klassifikation enthalten.

Key steps:
- Vollständig relevante `AGENTS.md`, Logging-V2-Spezifikation, Visualisierung und Review-Skills gelesen.
- Start-Gate zweimal verifiziert: Branch/HEAD/Status/Upstream stimmten exakt.
- Breite Inventur aktiver Transport-Producer, sichtbarer Fehler-Sinks, Mutations-/Promise-Pfade und Tests; tote/ungenutzte Definitionen wurden getrennt.
- Zentrale Fehlerprojektion, HR-Sensitive-Data-Flow, Blob/PDF-Grenzen, Trainings-, QM-, Exams- sowie Zertifikats-/Vermittlungsabschluss-Pfade anhand konkreter Runtime- und Teststellen verfolgt.

Failures and how to do differently:
- Keine Tests ausgeführt, da der Auftrag ausdrücklich read-only ohne Tests war; der Bericht darf daher nur Code- und Teststruktur-Evidenz behaupten.
- Portal-F1 ist nicht scan-clean: 3 P1- und 4 P2-Restbereiche, keine P0/P3.

Reusable knowledge:
- Zentrale F1-Projektion akzeptiert ein vollständiges verschachteltes `data.error`-Envelope, aber `extractBackendErrorDetails` kann weiterhin Legacy-/Rohmeldungen für sichtbare Toasttexte liefern. Dadurch ist Supportkopie fail-closed, sichtbarer Fehlertext aber nicht vollständig fail-closed.
- `apiClient` zeigt 500/502/503 global, sofern `skipGlobalErrorToast` fehlt. Lokale Handler, MutationCache und `showPromiseToast` müssen pro aktivem Caller eindeutig koordiniert werden.
- Produktiver MutationCache ist der zentrale Owner, wenn Mutation-Meta `errorAction` setzt; lokale Catch-Toasts oder Promise-Toasts erzeugen sonst Doppelanzeigen.
- Blob-Responses (`responseType: 'blob'`) können den JSON-Envelope nicht ohne einen stabilen Backend-Content-Type-/Fehlerbody-Vertrag sicher projizieren; hierfür ist ein separater Product/F2-Scope nötig.
- Aktive `fetch`-Aufrufe beschränken sich auf Feiertagsdienste außerhalb des Backend-F1-Envelopes. `useUpdateRisk`/`useDeleteRisk` sind ungenutzte Definitionen und wurden nicht als Rest-Slice gemeldet.

References:
- [1] Scanabdeckung: 1.801 aktive `src`-Dateien, 211 API-Producer-Dateien, 266 sichtbare Fehler-Sink-Dateien, 474 Testdateien.
- [2] Zentrale Projektion: `src/libs/utils/backendError.ts:313-409,751-825`; `src/libs/utils/errorHandling.ts:109-129`; `src/libs/utils/error-handler.ts:74-133`; `src/libs/apiClient.ts:144-190`.
- [3] HR-Mehrfachowner: `src/hooks/useEmployeeQueries.ts:359-386`; `src/components/dashboard/hr/assets/overview.tsx:71-84,123-135`; `src/libs/queryClient.ts:50-63`.
- [4] Blob/PDF: `documentPreviewModal.tsx:76-101`; QM-Exports in `qmAuditService.ts:371-377,514-520`, `qmQuarterlyReviewService.ts:189-195`, `qmReviewService.ts:85-93`.
- [5] Weitere Restbereiche: Trainings `useTrainings.ts:93-153,251-327`; Exams `examService.ts:250-300`, `useExams.ts:469-542,619-670`; Zertifikate `certificateApi.ts:125-169`, `CertificateIssuePage.tsx:90-124`, `EmploymentExitDialog.tsx:68-122`.
- [6] Finaler kompakter Befund: 1 P1 fail-closed sichtbare Fehlerprojektion; 2 P1 HR-Sensitive-Data Mehrfachowner; 3 P1 Blob/PDF/Preview; 4 P2 Trainings Promise-Toast plus Interceptor; 5 P2 QM-JSON-Schreibfamilien; 6 P2 Exams Delete/Release; 7 P2 Zertifikate/Vermittlungsabschluss.
