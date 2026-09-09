thread_id: 01a03812-3568-74d0-86ce-929fe1fb1d7c
updated_at: 2026-08-25T08:57:34+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T10-38-32-01a03812-3568-74d0-86ce-929fe1fb1d7c.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# F1 Slice 6/7 umgesetzt: opake Blob-Dokument-/Exportfehler mit genau einem Owner

Rollout-Kontext: Im Portal-Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde auf Branch `chore/logging-improvements` aus Baseline `801c2f0e06a0302f2c2fb98e29260cc68123bd58` ein eng allowlist-konformer F1-Teilslice umgesetzt. Start-Gate, Branch-/Remote-Stand, Worktree und Spec-Hashes waren korrekt.

## Task 1: Opaque Dokument-/Exportfehler

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich: „Body vollständig opak“, „request-lokaler Interceptor-Opt-out“, „lokaler statischer Owner“ und höchstens eine validierte `X-Request-Id` -> bei ähnlichen Blob-/PDF-Fehlern niemals Blob-Inhalte dekodieren oder Produkt-/Downloadabläufe verändern.
- Der Nutzer verlangte Findings-first-Baseline→Kandidat-Review, Behebung akzeptierter Findings und Re-Review vor Commit/Push -> diesen Ablauf künftig standardmäßig einhalten.
- Der Nutzer begrenzte Änderungen auf eine konkrete Produktions-, Test- und Docs-Allowlist und verlangte Stop bei Scopeabweichung -> keine Dateien außerhalb der Allowlist anfassen.

Key steps:

- Baseline-Review identifizierte doppelte globale 5xx-Toasts bei Security-Export, Freelancer-PDF und Student-Dokument sowie fehlenden lokalen Owner beim Lead-Dokument.
- Request-lokales `skipGlobalErrorToast: true` ergänzt; lokale Owner verwenden die bestehende sichere Fehlerprojektion. Erfolgs-, Blob-, Download-, Objekt-URL-, Revoke-, Cache-, Auth- und Retry-Verträge blieben unverändert.
- Neue bzw. erweiterte Tests decken 4xx, 5xx, Netzwerkfehler, malformed Request-IDs, Blob-Opazität und erfolgreiche Öffnen-/Download-/Revoke-Abläufe ab.
- Ein anfänglicher Security-Events-Test erzeugte unhandled Rejections; er wurde auf den echten Service-/Interceptor-/Handler-Pfad umgestellt, ohne Produktionscode außerhalb der Allowlist zu ändern.
- Ein Lead-Erfolgstest hatte wegen eines gemockten globalen `setTimeout` einen Timeout; der Test wurde so korrigiert, dass nur der 60-Sekunden-Revoke-Timer erfasst und bereinigt wird.
- Ein Review-Finding stellte fest, dass der Lead-Catch auch Browser-Öffnen/Revoke umfasst hätte. Der Catch wurde auf ausschließlich den Download-Request verengt.

Failures and how to do differently:

- Vollständiger Typecheck blieb wegen drei vorbestehender Fehler außerhalb der Allowlist rot (`PortalEntryEditor.errorOwnership.test.tsx`, `useHelpPortal.ts`); diese wurden korrekt nicht geändert.
- Vollständiger Lint blieb wegen vorbestehender Fehler/Warnungen außerhalb der Allowlist rot; fokussiertes ESLint war sauber.
- Bei UI-Tests mit `mutateAsync` ohne Catch keine unhandled Rejections erzeugen; den realen Service/Interceptor testen und die Rejection explizit abfangen, wenn der bestehende UI-Flow die Mutation bewusst weiterwirft.
- Catch-Blöcke bei Downloadpfaden nur um den Netzwerk-Request legen, nicht um `createObjectURL`, `window.open` oder Revoke-Timing.

Reusable knowledge:

- Security-Events-Export, Freelancer-Timesheet-PDF, Student-Dokument-Download und Lead-Dokument-Download verwenden denselben sicheren Blob-Vertrag: Body opak, `responseType: 'blob'` unverändert, lokaler Toast-Owner, höchstens strikt validierte Header-Request-ID.
- Reale Tests sollen Blob-Sentinels so konfigurieren, dass `.text()`, `.arrayBuffer()` und JSON-Zugriff fehlschlagen; zusätzlich Toast-/Clipboard-Ausgaben auf verbotene Rohdaten prüfen.
- Ein gültiger Support-Request-ID-Pfad darf nur echte Axios-Fehler mit sicherem Envelope bzw. validierter Header-ID verwenden; Blob-Body-Request-IDs bleiben unlesbar.
- Commit wurde erstellt und normal gepusht: `8df6f746afa142a08e7b4b846977c2d641444ffc`, `fix: keep document download errors opaque`.

References:

- Baseline/Remote: `801c2f0e06a0302f2c2fb98e29260cc68123bd58`
- Final commit: `8df6f746afa142a08e7b4b846977c2d641444ffc`
- Fokussierte Tests: 8 Dateien, 47 Tests bestanden, keine unhandled Fehler.
- Fokussiertes ESLint und Prettier bestanden.
- Push: `origin/chore/logging-improvements`; lokaler Branch, HEAD und Origin stimmten nach Abschluss überein.
- Geänderte Runtime-Dateien: `src/libs/securityEventsService.ts`, `src/libs/freelancerTimesheetService.ts`, `src/components/timesheets/TimesheetReviewDetail.tsx`, `src/libs/studentDocumentService.ts`, `src/routes/__app/student-documents.tsx`, `src/libs/leadProcessService.ts`, `src/components/lead-process/LeadAdmissionDocumentActions.tsx`.
