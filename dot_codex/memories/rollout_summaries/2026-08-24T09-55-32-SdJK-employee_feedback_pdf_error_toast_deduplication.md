thread_id: 01a03332-5791-7400-975f-e6d3044b0ed8
updated_at: 2026-08-24T10:36:39+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T11-55-32-01a03332-5791-7400-975f-e6d3044b0ed8.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Employee-Feedback-PDF-Fehlertoasts dedupliziert und gepusht

Rollout context: Im Portal-Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde auf Branch `chore/logging-improvements` aus Baseline `99a8b7b49871eedb6ec87de2d86abf2b869be0bf` ein eng begrenzter Logging-V2-F1-Slice umgesetzt. Exakte Allowlist: `src/hooks/useEmployeeFeedbackPdf.ts` und `src/hooks/__tests__/useEmployeeFeedbackPdf.errorOwnership.test.tsx`.

## Task 1: Ownership-Fix für aktive Mitarbeiterfeedback-PDFs

Outcome: success

Preference signals:

- Der Nutzer verlangte wiederholt eine „kleinste kohärente“ Änderung, eine exakte Zwei-Dateien-Allowlist und ausdrücklich unveränderte Caller-, Success-, Download-, Invalidierungs-, Rollen- und Produktlogik -> zukünftige F1-Slices genauso eng planen und bei Scopeabweichungen fail-closed stoppen.
- Der Nutzer verlangte einen echten Axios-Interceptor-/Production-MutationCache-Test statt eines vollständigen `apiClient`-Mocks -> reale Transportgrenzen testen und nur tiefe Adapter, Auth-Transport sowie finale UI-/Browser-Sinks mocken.
- Der Nutzer verlangte, Blob-Inhalte niemals zu dekodieren und keine PII-/URL-/internen-ID-Leaks zuzulassen -> bei Blob-Fehlern ausschließlich validierte Header-Request-IDs als Referenz zulassen.
- Der Nutzer verlangte unabhängigen findings-first Review und zweimal identischen `NOVARI-FREEZE-V1` vor Abschluss -> Review, Freeze und Implementierung strikt trennen.

Key steps:

- Start-Gate bestätigt: korrekter Branch, HEAD, sauberer Ausgangszustand und Upstream 0/0.
- Beide aktiven Blob-POSTs erhielten nur request-lokal `skipGlobalErrorToast: true`; `responseType: 'blob'`, URL, `{}`-Body und dritte Axios-Argumentposition blieben erhalten.
- Production-`MutationCache` blieb einziger sichtbarer Failure-Owner; Retry blieb 0, Fehleridentität und Auth-Replay-Konfiguration blieben erhalten.
- Tests wurden realitätsnah umgebaut: echte `apiClient`-/`loginClient`-Instanzen, echte Interceptors, Production-QueryClient/MutationCache und Support-/Toast-Helper; nur Adapter, finale Sinks und Browser-Download-Primitiven wurden gemockt.
- Eine anfängliche Testassertion auf globales `JSON.parse` war zu breit, weil Vitest/Axios unabhängig Source Maps bzw. `{}` parsten. Sie wurde auf den exakten Blob-Payload präzisiert; Blob-`text`, `arrayBuffer` und `FileReader` blieben strikt unberührt.
- Ein unabhängiger Review fand zunächst einen P2: Der reale Testumbau hatte den vorherigen DELETE-Fehlertest entfernt. Innerhalb derselben Testdatei wurde ein echter DELETE-Adapter-Fehlertest ergänzt, der Fehleridentität, `retry: 0`, genau einen Mutationseintrag, sichere Supportprojektion und den Ausschluss von `actionHint`, `details` und `raw` prüft.
- Nach Korrektur: fokussiert 25/25 Tests, relevante Suiten 185/185, volle Suite 470/470 Dateien und 5578/5578 Tests, Typecheck, fokussiertes ESLint, Prettier-Check und Build erfolgreich. Globales Lint meldete nur unveränderte Baselineprobleme außerhalb der Allowlist (4 Fehler, 6 Warnungen).
- Re-Review: keine P0-P3-Findings, Kontinuität aligned. Freeze zweimal identisch: SHA-256 `58dc678db93cfba03a5cbeb2952d88e62b333bf05af9067b10cb58ca71d6653c`, tracked 32048 Bytes, serialisiert 32095 Bytes, keine untracked files.
- Nach ausdrücklicher Freigabe wurden exakt die zwei Dateien committed und normal gepusht. Commit `6606fa5cd6514311bdfbb43b49d0b6960b244f5a`, Betreff `fix: deduplicate employee feedback PDF error toasts`; Branch sauber, Upstream 0/0.

Failures and how to do differently:

- Der initiale Testumbau ließ DELETE-Fehlercoverage aus; bei großen Test-Rewrites bestehende Nachbarpfade explizit gegen den Baseline-Testbestand vergleichen.
- Globale `JSON.parse`-Assertions sind für „Blob nie dekodieren“ ungeeignet, weil Testharness oder Axios unabhängig parsen können; exakt den markierten Blob-Payload sowie Blob-/FileReader-Methoden überwachen.
- Den bestehenden `{}`-Body beibehalten: Die Übergabe enthielt widersprüchlich „undefined Body“ und „Body unverändert“; Baseline-Code und der stärkere Unverändert-Vertrag entschieden zugunsten von `{}`.

Reusable knowledge:

- Request-lokales `skipGlobalErrorToast` verhindert den Axios-Globaltoast-Doppelpfad, ohne den Production-MutationCache-Owner oder globale Verträge zu ändern.
- Blob-PDF-Fehler dürfen nicht über `text()`, `arrayBuffer()`, `FileReader` oder JSON-Dekodierung ausgewertet werden. Body-only IDs und JSON bleiben unsichtbar; validierte Header-ID darf höchstens als Referenz kopiert werden.
- Für authentifizierte Blob-Requests muss ein 401-Replay URL, Body, `responseType`, Opt-out und `_authRetry` übernehmen; ein Replay-503 darf nur einen MutationCache-Fehlertoast erzeugen.

References:

- [1] Production-Datei: `src/hooks/useEmployeeFeedbackPdf.ts`; nur die beiden aktiven POST-Configs wurden von `{ responseType: 'blob' }` auf `{ ...locallyHandledErrorConfig, responseType: 'blob' }` erweitert.
- [2] Testdatei: `src/hooks/__tests__/useEmployeeFeedbackPdf.errorOwnership.test.tsx`; reale Adapter-/Interceptor-, Blob-, Replay-, Download-, Support- und DELETE-Fehlertests.
- [3] Commit: `6606fa5cd6514311bdfbb43b49d0b6960b244f5a` — `fix: deduplicate employee feedback PDF error toasts`.
- [4] Verifikation: `25/25`, `185/185`, `470/470` Dateien, `5578/5578` Tests; Freeze `58dc678db93cfba03a5cbeb2952d88e62b333bf05af9067b10cb58ca71d6653c`.
