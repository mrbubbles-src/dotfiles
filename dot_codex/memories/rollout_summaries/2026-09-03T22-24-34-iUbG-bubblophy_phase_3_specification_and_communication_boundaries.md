thread_id: 01a0695f-b301-7452-80c7-3dd6b30ef5d4
updated_at: 2026-09-03T22:40:31+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/09/04/rollout-2026-09-04T00-24-34-01a0695f-b301-7452-80c7-3dd6b30ef5d4.jsonl
cwd: /Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc

# Bubblophy Phase-3-Spezifikation erstellt und präzisiert

Rollout context: Im Projektarbeitsbereich `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc` wurde aus vorhandenen Bubblophy-Dokumenten, dem referenzierten Chat und Logging-V2-Erfahrungen eine umfangreiche Feature-Spezifikation erstellt. Die Bubblophy-Anhänge waren nicht im `sources/`-Ordner, konnten aber über `read_thread` aus dem referenzierten Chat gelesen werden.

## Task 1: Bubblophy Phase-3-Feature-Erweiterungsspezifikation

Outcome: success

Preference signals:

- Der Nutzer verlangte ausdrücklich: „Bubblophy ersetzt nicht die normale Chat-Kommunikation“ -> Chats bleiben Arbeits-, Diskussions-, Planungs- und Reviewraum; Bubblophy hält nur relevante, dauerhafte strukturierte Ergebnisse fest.
- Der Nutzer stellte klar, dass Bubblophy keine passive Inbox sein darf -> ein echter Blocker muss zusätzlich aktiv im aktuell verwendeten Chat erklärt werden; ein normaler Finding-, Status- oder Evidence-Eintrag darf nicht allein einen Stopp oder neues Go auslösen.
- Der Nutzer korrigierte die anfängliche read-only-Einordnung -> MCP ist insgesamt nicht read-only; geeignete Arbeitsclients wie Codex und Claude dürfen eng gescoppte, auditierte Writes erhalten. Read-only ist nur ein mögliches frühes ChatGPT-Rolloutinkrement.
- Der Nutzer erwartet bei einem Stop-Gate eine verständliche Chat-Erklärung mit Ereignis, Entscheidungsgrund, Optionen, Empfehlung und weiterhin möglicher Arbeit.

Key steps:

- Bestehende Bubblophy-Grundlagen geprüft: Projekte/Membership, Issues, versionierte Pläne, Runs, Audit, Rollen, Agent-Tokens und Remote-MCP/OAuth.
- Logging-V2-Lehren als Produktanforderungen verdichtet: Work Blocks statt Micro-Slices, getrennte Statusdimensionen, kandidatengebundene Evidence, explizite Supersession, Decision Requests und menschliche Matrix-Aggregation.
- Datei `BUBBLOPHY_PHASE_3_FEATURE_EXTENSION_SPEC.md` mit 22 Abschnitten erstellt und anschließend um Kommunikations- und MCP-Grenzen erweitert.
- Inhalt umfasst Produktziele, Nicht-Ziele, Domainmodell, Invarianten, Rollen, Stop-Gates, Human-in-the-loop, Flows, Multi-Agent-/Multi-Provider-Nutzung, Provenienz, Handoffs, Current Contract Summary, MCP/API-Bedarf, ChatGPT-Anbindung, Readiness und Akzeptanzkriterien.
- Strukturprüfung erfolgreich: Markdown-Codefences ausgeglichen; die zuletzt verifizierte Datei hatte 790 Zeilen und 6.168 Wörter.
- `/mnt/data` war trotz angeforderter Freigabe nicht beschreibbar (`mkdir: /mnt: Read-only file system`). Die Datei blieb daher im persistenten Projektarbeitsbereich und wurde dort in Codex geöffnet.

Failures and how to do differently:

- Der gewünschte `/mnt/data`-Export konnte technisch nicht ausgeführt werden; künftig Zielpfad vor der Erstellung prüfen oder bei Read-only-Sandbox frühzeitig einen alternativen persistenten Pfad anbieten.
- Ein erster Patchversuch schlug wegen nicht passender Kontextzeilen fehl; die Änderung wurde danach anhand tatsächlich gefundener Zeilen erfolgreich angewendet.
- Die Spezifikation durfte nicht „strukturierter Zustand statt Chat“ so formulieren, dass Chats ersetzt werden; die spätere Korrektur verankerte explizit die Zwei-Ebenen-Kommunikation.

Reusable knowledge:

- Bubblophy soll als gemeinsame Zustandsschicht neben normalen Chats funktionieren, nicht als Chatbus oder alleinige Kommunikationsoberfläche.
- Echte Stop-Gates werden doppelt behandelt: strukturierter Decision Request in Bubblophy plus aktive Eskalation im laufenden Chat. Normale Fortschritte werden parallel dokumentiert und laufen ohne unnötiges Nutzer-Go weiter.
- MCP-Writes benötigen je einen eigenen semantisch engen Vertrag, Membership-/Rollenprüfung, Attribution, Konfliktschutz und Auditierung; ein generisches `update_anything` ist ausgeschlossen.
- Sensible Aktionen wie normative Decision-Aktivierung, Supersession, Scopeänderung, Run-Freigabe, Deployment und destruktive externe Aktionen bleiben getrennt beziehungsweise Human-only, sofern kein eigener Vertrag beschlossen wurde.
- Große Matrices brauchen eine menschliche Aggregationsebene; Matrixzahlen dürfen nicht ohne fachliche Verdichtung als Defektzahlen präsentiert werden.

References:

- Datei: `BUBBLOPHY_PHASE_3_FEATURE_EXTENSION_SPEC.md`
- Letzte Prüfsumme: `b9b2075f8691671b5b0ea5900122b439d5f15ae0fe3b314aa259ab41b558563b`
- Verifizierte Schlüsselstellen: `### 4.6 Aktive Kommunikation statt passive Inbox`, `### 9.4 Kommunikationspflicht bei Stop-Gates`, `### 12.1 Chat als Arbeitsraum`, `### 12.2 Keine passive Nutzer-Inbox`, `### 15.1 Grundgrenze: Read und kontrollierter Write`, `## 16. ChatGPT als client-spezifischer read-only Einstieg`.
- Relevante bestehende Bubblophy-Quellen aus dem referenzierten Chat: `README.md`, `MVP_STATUS.md`, `phase-2-roadmap.md`, `mcp-operations.md`, `2026-07-18-bubblophy-mcp-foundation.md`, `2026-07-18-bubblophy-roles-invitations.md`.

