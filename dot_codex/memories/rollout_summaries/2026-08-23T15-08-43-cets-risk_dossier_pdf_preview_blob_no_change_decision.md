thread_id: 01a02f2a-b5db-7d33-a030-a82efeb5070a
updated_at: 2026-08-23T15:15:13+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/23/rollout-2026-08-23T17-08-43-01a02f2a-b5db-7d33-a030-a82efeb5070a.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Risk-Dossier-Preview-GET-Analyse endet mit belegter No-Change-Entscheidung

Rollout context: Im Portal-Repository wurde auf `chore/logging-improvements` gegen Baseline `e97ee4a44a90be806e28bd65b32dbf9a25cd182b` ausschließlich read-only untersucht. Worktree war sauber, Upstream `0/0`; keine Edits, Tests, Formatierung, Fetches oder Git-Mutationen.

## Task 1: GET `/risks/:riskId/dossier-pdf` Ende-zu-Ende prüfen

Outcome: success

Preference signals:
- Der Nutzer verlangte einen „kleinsten kohärenten“ Slice, exakte Allowlist, explizite Ausschlüsse, echte Interceptor-/UI-Grenzentests und fail-closed Stop-Gates -> künftige Logging-Pläne müssen Scope und sichtbares Verhalten vollständig prüfen, bevor Änderungen vorgeschlagen werden.
- Der Nutzer verlangte strikt read-only und „keine Umsetzung“ -> bei solchen Reviews keine Tests oder Korrekturen ausführen und nur belegte No-Change- oder nächste-Plan-Entscheidungen liefern.

Key steps:
- Pfad nachvollzogen: `riskService.dossierPdfUrl` liefert nur den relativen Pfad; `RiskList` öffnet nach vorhandener bzw. erfolgreicher PDF-Erzeugung `DocumentPreviewModal`; das Modal führt den GET mit `responseType: 'blob'` und `AbortController.signal` aus.
- Zentralen Axios-Interceptor geprüft: 401 erhält einmal Auth-Refresh/Re-Play mit unverändertem request-local `skipGlobalErrorToast`; 500/502/503 erzeugen ohne Opt-out einen globalen persistenten Backendfehler-Toast.
- Fehlerverhalten belegt: 400/403/409/422 zeigen nur Inline-Fehler; 401 replayed einmal; 500/502/503 erzeugen globalen Toast plus Inline-Fehler; Netzwerkfehler zeigen `Network Error`; Abort bleibt still.
- Axios liefert bei `responseType: 'blob'` auch JSON-Fehlerkörper als Blob. Der bestehende fail-closed `extractBackendSupportInformation`-Projektor dekodiert keinen Blob und wertet `Content-Type` nicht zur Projektion aus. Dadurch bleibt nur eine eventuell aus `X-Request-Id` stammende Referenz-ID verfügbar, nicht die vollständige Supportinformation.
- Zusätzliche UI-Probleme festgestellt: „Erneut versuchen“ funktioniert im Risk-Register nicht, weil das Modal unmounted wird, bevor `onOpenChange(true)` ausgeführt wird; der Neutab-Fallback öffnet vor erfolgreichem Blob-Laden die relative API-URL statt garantiert die konfigurierte API-Base-URL.

Failures and how to do differently:
- Ein bloßes `skipGlobalErrorToast` am Blob-GET würde den Doppeltoast beseitigen, aber die Supportreferenz und Nutzerinformation verschlechtern; ein lokaler Toast würde weiterhin Inline- plus Toast-Owner erzeugen.
- Das gemeinsame `DocumentPreviewModal` wird von 16 Flächen genutzt; eine pauschale Änderung wäre kein kleiner Risk-spezifischer F1-Slice.
- Kein Blob-Decoder ohne ausdrücklich festgelegte Content-Type-, Größen-, JSON-Shape- und Offenlegungsgrenzen.
- Abort ist kein Nutzerfehler und soll stumm bleiben.

Reusable knowledge:
- Der bereits abgeschlossene POST-Slice ist vom Preview-GET getrennt und bleibt unverändert: `riskService.ts` nutzt request-local `skipGlobalErrorToast`; `useGenerateDossierPdf` besitzt lokalen Toast, `retry: 0` und zwei Invalidierungen.
- Abnahmefähige Preview-GET-Änderungen benötigen eine separate Produkt-/Architekturentscheidung zu Blob-Fehlerdekodierung, Fehlerowner (Inline oder Toast), Referenz-ID/Supportkopie, Retry und Neutab-Fallback.
- Für die aktuelle No-Change-Entscheidung ist die Allowlist leer: 0 Produktionsdateien, 0 Testdateien, 0 Docs/Changelog.

References:
- Baseline/Branch: `chore/logging-improvements`, `e97ee4a44a90be806e28bd65b32dbf9a25cd182b`, sauber, Upstream `0/0`.
- Relevante Dateien: `src/components/dashboard/hr/documentPreviewModal.tsx` (223 Zeilen, 16 Konsumenten), `src/components/dashboard/qualityManager/risk/components/RiskList.tsx` (162), `src/libs/apiClient.ts` (105), `src/libs/utils/backendError.ts` (711), `src/libs/riskService.ts`, `src/hooks/useRisks.ts`.
- Bestehender POST-Test: `src/hooks/__tests__/useRisks.dossierPdfErrorOwnership.test.tsx` (448 Zeilen); er beweist den POST-/Interceptor-Pfad, nicht den echten Preview-GET/UI-Pfad.
- Axios-Transportbeleg: `responseType: 'blob'` verwendet `request.response`; JSON-Fehler werden daher als Blob geliefert.
