thread_id: 01a054e5-80e5-7ff3-88cc-3ec2284e8c73
updated_at: 2026-08-30T23:04:14+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T00-58-42-01a054e5-80e5-7ff3-88cc-3ec2284e8c73.jsonl
cwd: /Users/mrbubbles/dev/Codex/2026-08-31/novari-education-f2-traceability-gate

# F2-LMS-Traceability-Corrective reparierte ein unwirksames Regressiongate

Rollout context: Enger, dokumentarischer Corrective ausschließlich in `/Users/mrbubbles/dev/Codex/2026-08-17/novari-logging-v2-delegation`; keine Runtime-, Test-, Produktrepository- oder normative Specänderung.

## Task 1: Roh-Source-Gate für die 16 §6.1/F1-Portal-IDs

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich, die „unveränderten Roh-Sourcezeilen“ vor `applyCurrentTraceability` zu prüfen und F2-Evidence byteidentisch zu lassen -> künftige Correctives müssen die Rohdaten vor jeder positiv überschreibenden Normalisierung validieren und Scopegrenzen strikt einhalten.
- Der Nutzer verlangte exakte Dateien, Hashes und reproduzierbare negative Probe statt einer allgemeinen Behauptung -> Abschlussberichte sollten konkrete Artefakte, Exit-Codes und Hashes enthalten.

Key steps:
- In `audit-work/build-matrix.mjs` wurde `validateRawF1PortalSection61Traceability` ergänzt und vor `applyCurrentTraceability` aufgerufen.
- Die Prüfung verlangt für exakt 16 IDs (`S6-R2B`, `S6-R2CA`, `S6-R2CB`, `S6-R2DA`, `S6-R2DB`, `S6-R2F`, `S6-R2G`, `S6-R2H`, `S6-R2I11`, `S6-R2I12`, `S6-R2I21`, `S6-R2I22`, `S6-R2I31`, `S6-R2I32`, `S6-R2I41`, `S6-R2I42`) bereits in der Roh-Source: Abschnitt `6.1`, `mandatory/partial`, Slice `F1-Portal`, Dependencies `V-F0;C-Projection`, P13-Evidence und den unveränderten F1-Testvertrag; L07 sowie §6.2/LMS-Abgrenzung werden abgewiesen.
- Der Handoff wurde nur mechanisch mit neuem Generatorhash und neuer Zeilenzahl synchronisiert.

Reusable knowledge:
- Vor dem Fix akzeptierte der alte Generator eine manipulierte Source mit allen 16 IDs als `F2-LMS` und §6.2/LMS-klassifiziert, weil `applyCurrentTraceability` diese Werte später positiv auf F1 überschreiben konnte.
- Der korrigierte Generator weist dieselbe Probe vor der Traceability-Anwendung mit Exit 1 ab: `S6-R2B ist in der unveränderten Roh-Source nicht positiv als §6.1/F1-Portalpflicht klassifiziert.`
- `S6-R2A` und `S6-R2E` bleiben ausschließlich `V-F0`.

Failures and how to do differently:
- Eine erste Hash-/Manifestprüfung hatte wegen fehlerhaftem zsh-Quoting `zsh:1: unmatched "`; die Prüfung wurde mit robusterem Quoting erfolgreich wiederholt.
- Der finale lokale Review-Diff wurde zunächst in einem nicht existierenden temporären Arbeitsverzeichnis gestartet; nach dessen separater Erstellung lief der Diffcheck erfolgreich.
- Ein Baseline-Generator akzeptierte die alte Fehlklassifikation weiterhin mit Exit 0; deshalb muss die Regression immer gegen alten und korrigierten Generator ausgeführt werden.

References:
- Geändert: `audit-work/build-matrix.mjs`, SHA-256 `d82421679c0b3024dccd378ba29e39bc719fdafb691a67796c93b9ca2d64d4e7`.
- Geändert: `logging-v2-c0-runtime-handoff.md`, SHA-256 `cfada382dacaf8a56e7934fa5d7fd218b1566b3e441641e99460e2f167b16b7c`.
- Unverändert: Source `1afca8845285cd94f51683e491d9e47820731655b84d2df5195e89f050222853`; F2-Evidence `98374a1d827bd787eef3a570340027e18352f78e74ba88d9cb55521ab3c9d589`.
- Checks: `node --check` PASS; normaler und `--artifacts-only --validate-only` PASS; 1.288 Rows, 1.050 Persistence Rows, 33 Slices; Manifest 32/32 ohne Abweichung; Source/Matrix/Persistenz/Plan-Synchronität PASS; `git diff --check` PASS; fokussierter Review findings-frei; temporäre Proben entfernt.
- Der Corrective änderte keine Matrix-, Persistenz-, Sliceplan- oder F2-Evidence-Datei und führte keinen Commit/Push aus.
