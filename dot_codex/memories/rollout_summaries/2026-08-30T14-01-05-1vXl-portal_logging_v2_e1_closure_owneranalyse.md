thread_id: 01a052f9-4ef7-7e21-83b4-61d4565578f3
updated_at: 2026-08-30T14:10:50+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T16-01-05-01a052f9-4ef7-7e21-83b4-61d4565578f3.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Portal-Owneranalyse für den nächsten Logging-V2-Block

Rollout context: Vollständige read-only Rückverfolgung von Spec, Matrix, Persistenzsubmatrix, Sliceplan, C0-Handoff und D-Triage-/E2-Evidence im Portal-Repository. Keine Dateien, Tests, Commits oder Branchzustände wurden verändert.

## Task 1: Nächsten Portalblock nach D-Triage-Backend bestimmen

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich „keine Implementierung, keine Tests ausführen, keine Dateien ändern“ sowie frische Branch-/HEAD-/Upstream-/Remote-/Cleanliness-Prüfung -> bei ähnlichen Aufgaben zuerst strikt read-only prüfen und keine implizite Implementierungsfreigabe ableiten.
- Frühere Labels sollten „nur als Leads, nicht als Beweis“ gelten -> reale Ownerpfade, aktuelle Dateien und ausgeführte Evidence müssen getrennt von Plänen und historischen Claims bewertet werden.
- Der Nutzer verlangte kleinste kohärente Blöcke, exakte Allowlists, unveränderte Grenzen, Stop-Gates und ein separates Nutzer-Go -> keine künstlichen Mini-Slices oder Scope-Erweiterungen einführen.

Key steps:

- Portal frisch verifiziert: Branch `chore/logging-improvements`, HEAD/Upstream/lokaler und direkter Remote-Ref `86a167746d8093b72924312d4bfd39bcae95880a`, `0/0`, sauber.
- Normative Spec identifiziert: `Novari_Logging_Error_Handling_und_Audit_Spec_V2.md`, SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`.
- Matrixstatus bestätigt: 1.288 Zeilen, `fulfilled=0`, `partial=726`, `missing=460`, `intentionally-not-applicable=4`, 98 explizite Nichtziele; Gesamtfeature und alle Repository-PRs `NOT READY`.
- D-Triage-Backend-Core und E2-Backend sind auf Backend-Commit `35e3c4dd7d40e0888efe91d0328ec4af501382e5` jeweils final PASS mit `163/163` fokussierten Tests und unabhängigem High-Review ohne P0–P3. Diese PASSes schließen Portal-, Browser-, Development- oder Integrated-Evidence nicht.
- Portalcode geprüft: sichere Schema-v2-Einzelansicht, Legacy-Darstellung, serverseitige E2-Gruppen, Request-ID-Drilldown, Filtervalidierung, Query-Key-Trennung, sichere Rohdatenbegrenzung und Rollen-Guard existieren bereits.
- Konkrete Lücke: Produkt und Navigation heißen weiterhin `Security Events`, Route bleibt `/security-events`; `/logging-events` fehlt vollständig. Das verletzt vor allem `S11-R2A`–`S11-R2E` sowie zugehörige E1-/Route-Traceability-Zeilen.
- Temporäre Development-Testfläche (`src/routes/logging-v2-development.tsx` und zugehörige Katalogdateien) existiert nicht; diese gehört später zu I2/Integrated Evidence, nicht in den E1-Runtimeabschluss.

## Tatsächlicher nächster Block

Der kleinste kohärente Block ist **E1-Portal-Closure: kanonische Seite `Logging Events` unter `/logging-events` plus automatisierte Portal-Evidence**. Eine enge Runtimeänderung ist nötig, aber keine Neuimplementierung der Einzeltriage oder Gruppierung.

Requirements: `S2.2-R6A1`, `S11-R2A`–`S11-R2H`, `S11-R2IA`, `S11-R2IB`, `S13-R6AA`, `S13-R6AB`, `S13-R6AC`, `S13-R6B`–`S13-R6F`.

Production-Allowlist: `src/routes/__app/security-events.tsx`, `src/routes/__app/security-events.lazy.tsx`, neue `src/routes/__app/logging-events.tsx`, neue `src/routes/__app/logging-events.lazy.tsx`, `src/routeTree.gen.ts`, `src/global/navigation/shared.tsx`, `src/components/dashboard/security-events/SecurityEventsPage.tsx`, `src/hooks/useSecurityEvents.ts`.

Test-Allowlist: neue `src/routes/__tests__/logging-events-route.test.tsx`, `src/global/navigation/__tests__/build-navigation.test.tsx`, `src/components/dashboard/security-events/__tests__/SecurityEventsPage.test.tsx`, `src/components/dashboard/security-events/__tests__/SecurityEventsPage.errorOwnership.test.tsx`, `src/components/app/__tests__/RouteScopedProviders.render.test.tsx`, `src/components/app/__tests__/RouteProviderFallback.test.tsx`.

Unverändert erneut ausführen: `SecurityEventsPageComponents.test.tsx`, `SecurityEventGroupCard.test.tsx`, `useSecurityEvents.test.tsx`, `src/libs/utils/__tests__/roleUtils.test.ts`.

Doku-Allowlist: `README.md`, `CHANGELOG.md`, `docs/security/security-events.md`, `docs/development/error-handling.md`, `docs/development/routes.md`. Historische Reports bleiben unverändert.

Unverändert bleiben Backend-Endpunkte `/auth/security-events` und `/auth/security-events/export`, Responseunion, E2-Filter/Gruppenprojektion, Rollen/Auth/Productionfilter, Query-Keys, Pagination, Cache-/Placeholderverhalten, Export, Persistenz, Auditowner, Produktabläufe und die Semantik „höchstens ein persistiertes Ergebnisereignis“ ohne Exactly-once-Behauptung.

## Offene Stop-Gates

- `S11-R3A1`–`S11-R3A4`: Kategorie-Trennung Fehler/Security/Audit/System ist nicht belegt und darf nicht clientseitig erfunden werden.
- `S11-R3F`: Codefilter deckt aktuell nur `GITHUB_SYNC_CONNECTION_FAILED`; weitere Codes brauchen separaten Backendvertrag.
- `S11-R3Q`: Development-Reproduktionskennung wartet auf reales I-Szenario.
- `S11-R3S`: Archivstatus ist nicht geschlossen; statische 30-Tage-Anzeige ist kein Archivnachweis.
- Aktueller Blobdownload und sichtbarer interner Exportpfad widersprechen §12.1 und gehören zu `G-Export`, nicht E1.
- Portal-/LMS-/Network-/Supportevidence sowie Development-Testfläche und Cleanup bleiben getrennte Folgeblöcke.

Ergebnis: Für die kanonische Route ist keine neue Produktentscheidung nötig. Erforderlich ist ein separates ausdrückliches Go für „Portal-E1-Closure implementieren und automatisierte Evidence ausführen“. Browser-/I2-Evidence und Commit/Push benötigen jeweils eigene Freigaben.
