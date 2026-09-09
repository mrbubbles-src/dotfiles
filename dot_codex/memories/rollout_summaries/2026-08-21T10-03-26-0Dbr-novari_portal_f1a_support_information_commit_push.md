thread_id: 01a023c6-8073-78c1-a467-0706b1eb0901
updated_at: 2026-08-21T11:06:50+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T12-03-26-01a023c6-8073-78c1-a467-0706b1eb0901.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Novari Portal F1a zentrale Support-Information implementiert, geprüft, committed und gepusht

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde der eng begrenzte F1a-Teilslice auf Branch `chore/logging-improvements` umgesetzt. Start-Baseline war `ed327fed999ffffcdd941f8bcb752ef74ed5a989`; die explizite 13-Dateien-Allowlist und die unveränderten Legacy-/Warning-/Retry-Pfade wurden eingehalten.

## Task 1: F1a sichere Supportprojektion

Outcome: success

Preference signals:

- Der Nutzer verlangte einen „kleinsten zentralen Portal-Teilslice“, eine exakte Allowlist, keinen Caller-Massenumbau und fail-closed Verhalten -> zukünftige ähnliche Änderungen strikt auf den autorisierten zentralen Pfad begrenzen und direkte Caller, F2, Backend und Produktlogik unverändert lassen.
- Der Nutzer bestand wiederholt auf „keine weiteren Edits“, exakten Test-/Diff-Gates und einem eingefrorenen Kandidaten -> nach erfolgreicher Prüfung keine opportunistischen Änderungen mehr vornehmen.
- Der Nutzer verlangte deterministischen Kopiertext und verständlichen, konkreten Handoff -> Supporttexte und Verifikationsberichte bytegenau bzw. mit exakten Dateipfaden/Kommandos dokumentieren.

Key steps:

- Start-Gate verifiziert: Branch korrekt, Baseline exakt, sauberer Worktree, Upstream 0/0, Backend-F0-Commit lokal vorhanden.
- Dedizierten `extractBackendSupportInformation`-Extraktor in `backendError.ts` ergänzt; Legacy-`extractBackendErrorDetails` unverändert gelassen.
- F1a akzeptiert nur echte `AxiosError`-Instanzen mit eigenem Datenproperty `isAxiosError === true`, Response-Status 400–599, objektförmigem verschachteltem `response.data.error`, validiertem Code, einzeiliger begrenzter Meldung, eindeutiger Request-ID und statischem Bereich.
- Header-/Proxy-/Accessor-Grenze mehrfach nachgeschärft: eigene Datenproperties, keine Getterauswertung, Proxy-Traps fail-closed, Array-Headercontainer vor jeder Headerenumeration ablehnen.
- Fester Serializer ohne Abschluss-Newline implementiert: `Support-Information`, Meldung, Fehlercode, Referenz-ID, Anwendung, Bereich, optional ISO-UTC-Zeitpunkt aus streng validiertem IMF-fixdate.
- Drei zentrale Erzeuger angebunden: globaler API-Interceptor, `errorHandling.ts` und ausschließlich der Nicht-Warnungs-Pfad in `error-handler.ts`; Warning-, silent-, Auth-Retry-, Skip- und Legacy-Pfade blieben unverändert.
- Dokumentation in `docs/development/error-handling.md`, `README.md` und `CHANGELOG.md` ergänzt.

Failures and how to do differently:

- Initialer Typecheck fand lokale Typfehler in neuem Runtime-/Testcode; diese wurden nur durch enge Typverengungen behoben.
- Ein früher Volltestlauf hatte einen einzelnen zeitabhängigen Fehler in einer unveränderten Autosave-Testdatei; der isolierte Test und der vollständige Wiederholungslauf waren grün. Solche Fehler als Baseline-/Flake-Signal getrennt von F1a-Regressionsfehlern behandeln.
- Review-Findings führten zu den wichtigen Schutzmaßnahmen: keine alleinige `isAxiosError()`-Prüfung, kein geerbter Getter, keine Proxy-Traps und keine Array-Headercontainer. Diese Regressionstests beibehalten.
- Ein Array-Header-Test war zunächst nicht beweiskräftig, weil `requestId: undefined` bereits unabhängig vom Header fail-closed auslöste. Regressionstests müssen die jeweils behauptete Ursache isoliert prüfen.
- Vollständiger Repository-Lint blieb wegen 4 bestehenden Fehlern und 6 Warnungen in unveränderten Dateien nicht vollständig grün; Allowlist-ESLint war sauber. Baselinefehler nicht als F1a-Regression klassifizieren.

Reusable knowledge:

- F1a-Supportinformation ist nur für echte Axios-Fehler mit vollständigem verschachteltem Envelope gültig. Code: `^[A-Z][A-Z0-9_]{0,127}$`; Request-ID: `^[A-Za-z0-9._-]{1,128}$`; Body-/Header-ID müssen bei gemeinsamer Existenz exakt übereinstimmen.
- Headerarrays, Mehrfachheader, kommagetrennte Werte, ungültige Werte und Array-Headercontainer müssen fail-closed abgelehnt werden.
- `actionHint`, Details, Issues, Rohheader, Axios-/URL-/Querydaten, IDs und Roh-JSON dürfen weder gelesen noch projiziert werden.
- F1a nutzt nur statische Entwicklerbereiche; direkte Produktcaller bleiben für spätere autorisierte F1-Teilslices offen.
- Finaler Commit `808f006953f73d576ee300ac2c92ac8adaa2a07d` mit Nachricht `feat: add central portal support information`; direkter Parent ist exakt die Baseline. Normaler Push auf `origin/chore/logging-improvements` erfolgreich.

References:

- [1] `src/libs/utils/backendError.ts:226-237`: `Array.isArray(headers)` vor Headerauswertung.
- [2] `src/libs/utils/__tests__/backendError.supportInformation.test.ts:337-363`: Array-Headercontainer mit eigener `x-request-id`; `ownKeys` wird nicht ausgeführt und Projektion bleibt `undefined`.
- [3] Fokussierte Matrix: 7 Testdateien, 183/183 bestanden.
- [4] Vollsuite: 355 Testdateien, 3847/3847 Tests bestanden.
- [5] Finalstatus: Branch `chore/logging-improvements`, HEAD/Tracking-Ref `808f006953f73d576ee300ac2c92ac8adaa2a07d`, Upstream 0/0, Worktree sauber, Baseline→HEAD exakt 13 Dateien, Diffcheck sauber.
- [6] Unabhängiger Abschlussreview ohne Findings; Security-Scan `6f875bb9-9577-43a1-b417-e0f0f1388ff3`, 0 Findings, Digest `codex-security-snapshot/v1:sha256:7d2f160bb5b478614fe1afdc0381e4097c0a35150ea8f56cdd6386660f6c6511`.
