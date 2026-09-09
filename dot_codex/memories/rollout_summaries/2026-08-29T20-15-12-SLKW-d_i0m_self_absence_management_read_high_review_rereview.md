thread_id: 01a04f29-7597-7b71-b5c0-c6ee215d87ba
updated_at: 2026-08-29T20:26:52+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/29/rollout-2026-08-29T22-15-12-01a04f29-7597-7b71-b5c0-c6ee215d87ba.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# High-Review und gezielter Re-Review des Logging-V2-Slices D-I0m

Rollout context: Read-only Review im JavaScript-Repository `/Users/mrbubbles/dev/novari/novari-education-backend`, Branch `chore/logging-improvements`, gegen unveränderte Baseline `78757c74eb7bd3c1335044c704f4c4a64debe090`. Der Kandidat ergänzt sichere schema-v2 Support-Events für fünf Self-Absence-Verwaltungsreads.

## Task 1: Initialer High-Review des D-I0m-Kandidaten

Outcome: partial

Preference signals:
- Der Nutzer verlangte strikt read-only, exakte Kandidatenidentität, Findings zuerst und reale Express-/Ownerpfade statt Claims oder mock-only Tests -> künftige Reviews müssen diese Gates vor Inhaltsbewertung prüfen.
- Der Nutzer verlangte ausdrücklich, dass Tests keine interne Ownerkette wegmocken -> positive Tests müssen reale Router-, Controller- und `catchAsync`-Pfade beweisen.

Key steps:
- Branch/HEAD/Upstream, acht Allowlist-Dateien, Spec-SHA, Zielblobs, Full-index-Diff und Stable Patch-ID wurden bytegenau bestätigt.
- Die Runtimeprüfung fand keine weitere Vertragsabweichung: exakte fünf Routen, sichere Tuple-Allowlist, HMAC actorHash, statische Fingerprints, request-lokaler Höchstens-ein-Versuch-Schutz, keine PII und response-neutrale Persistenz.
- Fokussierte Tests liefen nach genehmigter Socket-Ausführung mit `129/129`; D-I0j/k/l mit `16/16`; ESLint, Syntax und diff-check waren grün.

Failures and how to do differently:
- Der neue positive Routertest ersetzte zunächst alle fünf finalen Controller-Handler durch synthetisches `next(error)`. Dadurch wurden Router/Unwind/Global Handler, aber nicht die reale Controller-`catchAsync`-Kette geprüft.
- Finding: `[P2]` in `tests/selfAbsence/managementReadErrorProjection.test.js` bei der ursprünglichen Handler-Ersetzung. Kleinster Fix: echte Controller beibehalten und Fehler an ihren realen DB-, Decrypt-/Serialisierungs-, Enrichment- oder Aggregationsgrenzen injizieren.

## Task 2: Gezielter Re-Review des akzeptierten P2 und neuen Freeze-Kandidaten

Outcome: success

Key steps:
- Die Korrektur änderte ausschließlich `tests/selfAbsence/managementReadErrorProjection.test.js`; sieben frühere Zielblobs blieben unverändert.
- Die fünf positiven Fälle verwenden jetzt reale Controller-/`catchAsync`-Handler und injizieren Fehler an passenden echten Grenzen: `CourseModel.find`, Decrypt/Serialisierung, Employee-Enrichment, `SelfAbsenceModel.find` und Aggregation.
- Negative Tests und Ausschlussrouten blieben erhalten.
- Fokussierte D-I0m + D-I0j/k/l-Suite: `145/145` grün. Korrigierte Datei: lokales ESLint und `node --check` grün. `git diff --check` grün.
- Identität bestätigt: HEAD/Upstream/Direct Remote `78757c74eb7bd3c1335044c704f4c4a64debe090`, Tracking `0/0`, acht Allowlist-Dateien, nichts staged, Testblob `dd45cccaf298c9a3de7bef72dd5b7668913304b9`, Diff-SHA-256 `cd26a6a7a6ce40871bd3edd6578ab837d7f1ab633daeb79b8d240b49fb71fe1c`, Patch-ID `ce08ee3175619af4dba70008f8e0adf2573aa65f`.

Reusable knowledge:
- Nach Express-Router-Unwind kann `req.baseUrl` leer sein und `req.route.path` nur das relative Template enthalten. Sichere Route-Identität benötigt daher eine private Router-Markierung plus exakte Methode/Route/Status/Fehlercode-Prüfung.
- `SUPPORT_ERROR_ATTEMPTED` muss am Requestobjekt hängen, nicht an der Request-ID: gleiches Requestobjekt höchstens ein Persistenzversuch; verschiedene Requests mit gleicher Request-ID bleiben getrennt.
- Bei realen Controller-Tests sollten Fehler an den tatsächlich aufgerufenen Modell-/Transformationsgrenzen injiziert werden; synthetisches Ersetzen des finalen Handlers ist für Ownerketten unzureichend.

Restunsicherheit: Full Suite und Prettier wurden im Re-Review nicht erneut ausgeführt. Ein früher `npx prettier --check` scheiterte wegen fehlender Netzwerkauflösung (`ENOTFOUND`), ohne Änderung.
