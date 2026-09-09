thread_id: 01a0385c-354b-7592-b790-20f17ac7b5f8
updated_at: 2026-08-25T10:09:47+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/25/rollout-2026-08-25T11-59-22-01a0385c-354b-7592-b790-20f17ac7b5f8.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Integrationsplanung für dev in Logging-Baseline

Rollout context: Im Repository `/Users/mrbubbles/dev/novari/novari-education-portal` wurde strikt read-only geprüft, wie `origin/dev` in `chore/logging-improvements` integriert werden kann. Der einzige erlaubte Fetch gelang; es wurden keine Tests oder Edits ausgeführt.

## Task 1: Branch- und Integrationsanalyse

Outcome: success

Key steps:
- Normative Skills, `AGENTS.md`, Logging-Spezifikation und Visualisierung vollständig gelesen; beide vorgegebenen SHA-256-Werte verifiziert.
- `git fetch --no-tags origin dev chore/logging-improvements` erfolgreich ausgeführt; `origin/dev` aktualisiert auf `f2cf9853453667dbee6e3980b7b4cf7e4c83cb35`.
- Start-Gate bestanden: aktiver Branch `chore/logging-improvements`, sauberer Arbeitsbaum/Index, lokale und Remote-Baseline exakt `3c9ef9afc76ec2933d5158320268d08039e6af56`, Merge-Base `86b5002d86cb1aa50acb3155ef42b58795cc0630`, Logging-Seite 133 Commits voraus, dev-Seite 67 Commits voraus.
- Logging-Diff seit Merge-Base: 416 Dateien, +67.582/-2.215; dev-Diff: 230 Dateien, +15.055/-859.
- `merge-tree` prognostizierte 25 echte Textkonflikte sowie 21 weitere semantische Overlaps. Es wurde ausdrücklich festgestellt, dass kein pauschales „ours/theirs“ zulässig ist.
- Die empfohlenen acht Logging-Abschlussstände wurden als besonders schützenswert identifiziert: Incident-Reads, Console-Datenschutz, studentische Reads, DropCases, CM/HR-Owner, opake Dokumentdownloads, QM-PDF-Owner und fail-closed Corrective.

Findings/Risks:
- P1: Ein normaler Merge muss manuell kombinierend aufgelöst werden; Martins Produktänderungen und Logging-V2-Owner dürfen nicht gegeneinander gewählt werden.
- P1: Neue dev-Mutationspfade in Contracts, Freelancer-Billing und Jobcoach-Timesheets nutzen direkte `showErrorToast(..., extractErrorMessage(error))`; dadurch fehlen Request-ID/Supportkopie, Rohmeldungen können durchscheinen und globale/lokale Toasts können doppelt erscheinen.
- P1: Mehrere neue Reads erzeugen bei Fehlern False-Empty oder dauerhaftes False-Loading, u.a. Jobcoach-Timesheets/Reviews, Freelancer-Billing, Credit-Note-/Settlement-Ansichten und `my-documents.tsx`.
- P1: QM `draftHelpers.ts` liest direkt `error.response.data` einschließlich `missingKpiEvaluations`, `missingKpiComments`, `invalidKpiEvaluations` und rohem `data.message`; sichere serverseitige Projektion ist ungeklärt und daher Stop-Gate.
- P2: Neue QM-Aktionen müssen ihre bestehenden Error-Owner und die Reihenfolge Draft speichern → Submit/Export bewahren.
- P2: Es fehlen fokussierte Regressionstests für genau einen Toast-Owner, Request-ID/Supportkopie, opaque Blob-Fehler, False-Empty/False-Loading und Schutz vor rohen Error-Payloads.

Recommended strategy:
- Normalen Merge von `origin/dev` in `chore/logging-improvements` verwenden, nicht cherry-picken.
- Danach semantische Reconciliation und drei enge Korrekturslices für Freelancer-/Jobcoach-/QM-Pfade; anschließend vollständige Review- und Testprüfung.
- Vorgeschlagene Slices: (1) Merge/Konfliktauflösung, (2) Contracts/Freelancer-Billing-Reads und Owner, (3) HR-Freelancer-Rechnungsannahme, (4) Jobcoach-Stundenzettel, (5) QM-KPI/Managementreview, (6) finale Integrationsprüfung.
- Jede Slice-Allowlist soll exakt sein; keine API-, Persistenz-, Rollen-, Berechtigungs-, Transaktions-, Polling-, Retry- oder Produktablaufänderungen ohne separates Go.

Validation/status:
- Abschlussprüfung bestätigte weiterhin sauberen Arbeitsbaum und Baseline-HEAD `3c9ef9afc76ec2933d5158320268d08039e6af56`.
- Keine Tests ausgeführt, da die Nutzeranweisung ausschließlich Planung erlaubte; keine Dateien, Indexeinträge oder Branches verändert.
