thread_id: 01a04600-ca1c-71a2-bd36-fb2807c88521
updated_at: 2026-08-28T01:43:51+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/28/rollout-2026-08-28T03-34-12-01a04600-ca1c-71a2-bd36-fb2807c88521.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only normative Neubewertung von V-B

Rollout context: Im Portal-Repository wurde die aktuelle Logging-V2-Spec vollständig gegen Matrix, Plan, Implementierung, Tests und gehashte reale Evidenz geprüft. Keine Dateien, Tests, Browserläufe, Daten, Branches oder Commits wurden verändert.

## Task 1: V-B-Kriterien normativ adjudizieren

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich eine ausschließlich read-only Prüfung, keine Delegation, keine neuen Läufe und keine Scope-Erweiterung. Künftige ähnliche Reviews sollten diese Grenzen strikt einhalten und nur vorhandene Evidenz neu bewerten.
- Der Nutzer verlangte die Trennung zwischen normativem Specwortlaut und Handoff-/Plan-Beweismethoden. Künftige Bewertungen sollten manuelle oder Browserpflichten nicht aus Plantexten ableiten, wenn sie nicht in der Original-Spec stehen.

Key steps:
- AGENTS.md, Orchestrate-Skill, die 1.211-zeilige Original-Spec und relevante Matrix-/Planabschnitte wurden gelesen; Spec-SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6` bestätigt.
- Portal-Baseline `8ab63d7e5affa0eda3913d7bb9707b0712a2a495` und Backend-Baseline `af21c988c51b88fd47a4f2989614654c3b46a846` waren sauber, Upstream-identisch und 0/0.
- Die finale Evidenz wurde gegen die Spec neu eingeordnet: K1–K7 PASS; K8 durch reale Cancellation plus automatisierten Late-Response-/Race-Test ausreichend; K9 durch automatisierte Claim-Abdeckung ausreichend; K10 durch vorhandenen realen 21-Poll-No-write-Beleg plus unveränderten Owner ausreichend.
- `V-B-RET-1` änderte nur Query-/Focus-Optionen im Portal-Hook; Service/API/Persistenz/Audit-Owner wurden nicht verändert. Der frühere No-write-Beleg bleibt daher gültig.

Failures and how to do differently:
- Ein früherer High-Review wertete K8 wegen fehlender manueller Late-Response-Erzeugung als STOP. Das war ein strengerer Prüfvertrag, nicht zusätzlicher Specwortlaut. Künftig zuerst die Original-Spec gegen die verlangte Testmethode prüfen.
- Der frühere Bericht wertete K7 wegen fehlender Backend-Request-ID bei einem vor Response-Headern abgebrochenen Request unvollständig. Die Spec verlangt dafür keine Backend-ID; eindeutiger nativer Cancel-Status und Poll-Stopp genügen.

Reusable knowledge:
- Spec §10, Zeilen 578–593: Polling nur bei geöffnetem/gemountetem Editor, aktiver WorkRevision, sichtbarem Tab und gleicher Identität; bei hidden, Unmount, Identitäts-/Rollenwechsel oder Editorverlassen Timer/Requests beenden und alte Generationen verwerfen; erfolgreiche Polls erzeugen kein persistiertes Event.
- Spec §7.1, Zeilen 461–468 und §19, Zeilen 1150–1151/1161: erfolgreiche Polls, Statusabfragen und Routine-Reads werden nicht dauerhaft gespeichert.
- Spec §17.1/§17.3 fordert eine Development-Testfläche und manuelle Szenarien, aber nicht zwingend einen Browserlauf für jede Identitätsdimension oder eine künstlich eintreffende Late Response. Der Plan/Handoff konkretisiert Methoden, erweitert aber nicht die Norm.
- Automatisierte Portaltests decken vollständige Identität, Claim/Visibility, 15-s-Takt, Abort, Return, sechs Identitätsdimensionen, Late-Response-Verwerfen, terminale Fehler und Backoff ab; fokussierte Suite war auf dem Commit mit `36/36` grün belegt.
- Reale Evidenz: sichtbare 15-s-Polls, `visible → hidden → visible`, 55,965 s hidden ohne Poll, genau ein Return-Poll und Unmount-Cancel mit >58 s Poll-Stopp. Historischer No-write-Beleg: 21 Poll-Request-IDs mit 0 Auditereignissen; fachliche Dokumente und Auditgesamtcount unverändert.

References:
- `src/hooks/lms/useCurriculumWorkRevisions.ts:101-203` — lifecycle-gated query, vollständige Identität, Claim/Visibility, Cancellation und Retry-Regeln.
- `src/hooks/lms/__tests__/useCurriculumWorkRevisionContinuityContext.test.tsx:118-688` — konkrete automatisierte Lifecycle-, Identity-, Race-, Retry- und Managementtests.
- Original-Spec §10: Zeilen 576–593; §17.1–17.3: Zeilen 997–1071; §19: Zeilen 1143–1199.
- `audit-work/slice-evidence/v-b.md:65-74` — 21-Request-No-write-Nachweis.
- Ergebnis: V-B kann mit einer kurzen Coordinator-Adjudikation geschlossen werden; kein weiterer manueller Lauf, keine Planänderung und kein Corrective sind normativ erforderlich.
