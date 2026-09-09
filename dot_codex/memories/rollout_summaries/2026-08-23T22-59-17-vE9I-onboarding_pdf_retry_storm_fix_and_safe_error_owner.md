thread_id: 01a030d9-88ad-7450-b248-a9c6a362da92
updated_at: 2026-08-23T23:32:05+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/24/rollout-2026-08-24T00-59-17-01a030d9-88ad-7450-b248-a9c6a362da92.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Onboarding-PDF-Retry-Sturm behoben, sicherer Fehlerowner ergänzt und gepusht

Rollout context: Repository `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, Baseline/Start-HEAD `085b93dc41a9b1eb942268fa1c98fb3fad6b584f`, Upstream anfangs 0/0. Der Nutzer verlangte einen strikt begrenzten Vier-Dateien-Slice ohne Commit/Push bis zum abschließenden Freeze-Review; danach wurde der eingefrorene Kandidat separat zum Commit und Push freigegeben.

## Task 1: One-shot automatische Onboarding-PDF-Erzeugung und lokaler Fehlerowner

Outcome: success

Preference signals:

- Der Nutzer gab eine exakte Allowlist, Stop-Gates und unveränderte Produktbereiche vor und verlangte „keine breite Formatierung“ sowie keinen Workflowumbau -> ähnliche Aufgaben strikt auf die autorisierte Datei-/Verhaltensgrenze beschränken.
- Der Nutzer verlangte einen QueryClient-gebundenen synchronen Claim, der StrictMode, echte Remounts und mehrere Widget-Instanzen abdeckt, bei finalem Fehler aber nicht erneut postet -> bei vergleichbaren automatischen Mutationseffekten zuerst einen synchronen, cachegebundenen One-shot-Guard entwerfen.
- Der Nutzer verlangte echte Interceptor-/Production-QueryClient-Tests statt vollständig gemockter Transportpfade und findings-first Reviews -> Integrationsgrenzen real belassen und nur tiefe Transport-/Toast-Sinks mocken.
- Der Nutzer verlangte statische sichere Fallbacks und das Erhalten einer gültigen Request-ID auch bei unvollständigem Envelope -> lokale Fehlerowner müssen Supportprojektion fail-closed behandeln, aber separat sicher extrahierte Referenz-IDs nicht verlieren.

Key steps:

- Start-Gate exakt verifiziert: korrektes CWD, Branch, HEAD, sauberer Status und Upstream 0/0.
- AGENTS, Orchestrate, Scoped-Fix, Code-Reviewer sowie normative Logging-V2-Spezifikation und Visualisierung gelesen; Spec als maßgebliche Quelle behandelt.
- Zwei frische read-only Scouts prüften getrennt Claim-Vertrag und Fehlerowner-/Test-Harness.
- `OnboardingWidget.tsx` erhielt einen synchronen QueryClient-gebundenen Claim pro `userID + response.role + contractStartDate`; nur abgeschlossene, noch nicht generierte Daten qualifizieren. Finaler Fehler behält den Claim; Loading/StrictMode/Remount lösen keinen Repost aus. Bestätigtes `pdfGenerated=true` oder bestätigter nicht abgeschlossener Zustand kann den Claim kontrolliert zurücksetzen.
- `useMyOnboarding.ts` nutzt `POST(url, undefined, { skipGlobalErrorToast: true })`, lokalen `onError`, `retry: 0`, bestehende sichere Supportprojektion und statische deutsche Fallbacks. Bei unvollständigem Support-Envelope wird eine separat valide Request-ID mit persistentem statischem `showBackendErrorToast` erhalten; ohne ID wird `showErrorToast` verwendet. Erfolg bleibt still und invalidiert nur `['my-onboarding']`.
- Erste Abschlussreview fand P2/P3-Testprobleme: ein Reset-Test hatte keinen vorherigen Claim und die Widget-Erfolgsinvalidierung war tautologisch gemockt. Beide wurden behoben; danach fand der Re-Review keine Findings.
- Ein weiterer unabhängiger Freeze-Review fand einen zeitabhängigen realen Widget-Test und zunächst den bereits behobenen Request-ID-/Replay-Kontext. Systemzeit wurde im Integrationsfixture deterministisch auf `2026-08-24` fixiert; anschließend erneut geprüft.

Failures and how to do differently:

- Initialer Widget-Reset-Test gab falsche Sicherheit, weil kein Claim vor dem Reset erzeugt wurde. Tests für Reset-Verhalten müssen erst einen echten Claim etablieren, dann bestätigten unqualifizierten Zustand und anschließende Requalifikation prüfen.
- Eine frühe Erfolgsinvalidierungsprüfung mockte die Invalidierung im Test selbst. Erfolgs-/Cache-Nachweise müssen den echten Hook ausführen; die direkte 2xx-Hook-Suite prüft jetzt die tatsächliche Invalidierung.
- Ein realer Widget-Test verwendete `contractStartDate: '2026-08-18'` ohne feste Uhr und wäre nach dem zweitägigen Abschlussfenster ab `2026-08-26` unqualifiziert geworden. Zeitabhängige Tests mit `new Date()` müssen deterministische Fake-Timer/Systemzeit verwenden und danach Real-Timer wiederherstellen.
- Globales Lint blieb absichtlich nicht grün: vier bestehende Fehler und sechs Warnungen in unveränderten Dateien außerhalb der Allowlist. Fokussiertes ESLint war grün; diese Baseline-Abweichung nicht durch Scope-Erweiterung beheben.

Reusable knowledge:

- Verifizierte Implementierungs-Allowlist: `src/components/dashboard/onboarding/OnboardingWidget.tsx`, `src/hooks/useMyOnboarding.ts`, `src/components/dashboard/onboarding/__tests__/OnboardingWidget.pdfGeneration.test.tsx`, `src/hooks/__tests__/useGenerateOnboardingPdf.errorOwnership.test.tsx`.
- Tests bewiesen StrictMode-Entdoppelung, parallele Widgets mit demselben QueryClient, finale 500/422-Fehler ohne Repost, 401-Refresh/Replay, Nutzer-/Rollen-/Vertragsstart-Schlüsselwechsel, bestätigte Zustandsresets und Loading-Negativpfad.
- Reale Hook-/Interceptor-Suite deckt 400/422/500/502/503, Netzwerk, finalen 401, erfolgreichen Replay, Replay-503, sichere Supportkopie, hostile/invalide Envelopes, Fehleridentität und `retry: 0` ab.
- Tests nach finaler Korrektur: neue Suites 26/26; relevanter Onboarding-/Zentralblock 302/302; Vollsuite 470 Dateien und 5.558 Tests; Typecheck, fokussiertes ESLint, Build und `git diff --check` grün. Build: 6.672 Module, nur bekannte Chunkgrößenwarnung.

References:

- Start-Gate: Branch `chore/logging-improvements`, Baseline `085b93dc41a9b1eb942268fa1c98fb3fad6b584f`.
- Finale Freeze-Prüfung zweimal identisch: SHA-256 `b7453b4371ac2c0a1e27bae7496a79957e916d9b6e9e9b949db08b02839b3012`, tracked diff 5.652 Bytes, Gesamts serialisierung 31.577 Bytes; genau die beiden Testdateien waren untracked.
- Finale unabhängige Reviews: keine P0–P3-Findings, Continuity `aligned`.

## Task 2: Eingefrorenen Kandidaten committen und pushen

Outcome: success

Key steps:

- Vor Staging erneut Branch/HEAD/Upstream/Freeze read-only exakt verifiziert.
- Nur die vier Allowlist-Dateien staged; Indexprüfung meldete `STAGED_ALLOWLIST_OK 4`.
- Conventional Commit erstellt: `fix: prevent onboarding PDF retry storm`.
- Normal auf `origin/chore/logging-improvements` gepusht.
- Read-only-Abschlussprüfung bestätigte sauberen Worktree, Upstream 0/0 und exakt vier Commit-Dateien.

Reusable knowledge:

- Commit: `99a8b7b49871eedb6ec87de2d86abf2b869be0bf`.
- Commit-Dateiliste exakt: `src/components/dashboard/onboarding/OnboardingWidget.tsx`; `src/components/dashboard/onboarding/__tests__/OnboardingWidget.pdfGeneration.test.tsx`; `src/hooks/__tests__/useGenerateOnboardingPdf.errorOwnership.test.tsx`; `src/hooks/useMyOnboarding.ts`.

References:

- Push-Ausgabe: `085b93dc..99a8b7b4 chore/logging-improvements -> chore/logging-improvements`.
- Finaler Zustand: Worktree sauber, Upstream `0/0`.
