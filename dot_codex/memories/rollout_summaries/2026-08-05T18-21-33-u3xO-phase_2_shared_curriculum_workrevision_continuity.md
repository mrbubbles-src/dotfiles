thread_id: 019fd328-c980-7261-b59e-270efa8e800c
updated_at: 2026-08-08T11:47:41+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/05/rollout-2026-08-05T20-21-33-019fd328-c980-7261-b59e-270efa8e800c.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: refactor/curriculum-workrevision-continuity-phase-2

# Phase 2 der Curriculum-WorkRevision-Kontinuität wurde cross-repo orchestriert und code-seitig abgeschlossen

Rollout context: Der Nutzer wollte Phase 2 minimalinvasiv umsetzen: gemeinsamer serverseitiger Arbeitsstand für berechtigte PDL- und LMS-Support-Nutzer, keine Owner-/Claim-/Git-Logik, bestehende UI/UX beibehalten, Orchestrate weiterverwenden, regelmäßig mit Commit Writer committen/pushen, bei Unsicherheiten Rücksprache halten und Spec nach jedem größeren Block erneut evaluieren. Der Haupttask wurde im JavaScript-Backend gestartet; anschließend wurde ein Portal-Task delegiert.

## Task 1: Backend-Analyse, Phase-2-Vertrag und Implementierung

Outcome: success

Preference signals:
- Der Nutzer verlangte ausdrücklich, „nicht dieses komplette System wieder neu umzubauen“, die vorhandene Logik möglichst anzupassen und die UI/UX „niemals das Rad neu [zu] erfinden“ -> zukünftige Änderungen sollten bestehende Sequence-, Fence-, EditSession-, Recovery- und Autosave-Verträge wiederverwenden und neue Plattform-/Collaboration-Abstraktionen vermeiden.
- Der Nutzer verlangte regelmäßige Commit-Writer-Commits und Pushes sowie Rücksprache bei Unklarheiten -> bei längeren Implementierungen in logisch abgeschlossenen Blöcken committen/pushen und vor riskanten Persistenz-, Berechtigungs- oder Migrationsentscheidungen checkpointen.
- Der Nutzer wollte, dass jeder aktuell berechtigte PDL und LMS-Support unabhängig vom ursprünglichen Ersteller arbeiten kann -> `createdBy` bleibt Provenienz, darf aber keine normale Zugriffsschranke sein.

Key steps:
- Phase 2 wurde als backendlastig eingestuft; ein neuer Codex-Thread wurde im vorhandenen JavaScript-Backend-Checkout auf `refactor/curriculum-workrevision-continuity-phase-2` erstellt und mit vollständiger Spec, Orchestrate-Vorgabe, Minimalinvasivitätsgrenzen, Rücksprachepunkten und Portal-Delegationsregel beauftragt.
- Nach Spec-/Contract-Checkpoint wurde ein versionsweiter gemeinsamer Primary-Vertrag festgelegt: berechtigte `pdl`/`lmsSupport` greifen auf denselben Serverstand zu; keine ACL-/Claim-/Takeover-Pflicht für normale Zusammenarbeit; `createdBy` nur Provenienz.
- Whole-Snapshot-Sequence-CAS statt Auto-Merge: stale Writes erzeugen Recovery, überschreiben nie stillschweigend; Recoveries bleiben unter derselben Shared Primary gemeinsam sichtbar und auflösbar.
- Auth-Entzug, Review/Publish/Import/Export/Topic/Structure/GitHub-Path sowie Actor-/Rollen-Provenienz wurden an den gemeinsamen autoritativen Checkpoint gebunden.
- Ein P2-Finding bei Import-vs-Submit wurde behoben: `in_review` darf zur Konfliktfinalisierung gelesen werden, der Write-CAS bleibt auf `draft|changes_requested`; der Verlierer liefert stabil 409 ohne Mutation.
- Ein Bootstrap-Fix verschob Cron-/Background-Worker hinter vollständige DB-, Index-, GitHub-, Job-Recovery- und HTTP-Bind-Readiness; beim Shutdown werden Timer zuerst gestoppt.
- Finaler Backend-Stand: `257193a233f753d23edef28ee432143319509baa`; Working Tree clean, Remote exakt HEAD, `npm lint`, betroffene Bootstrap-Gates 26/26 und finaler Review bestanden.

Failures and how to do differently:
- Der Shared-Primary-Preflight fand zwei bestehende `UNIQUE_INDEX_COLLISION`-Fälle. Korrekt war: keine automatische Bereinigung, keine Owner-Umschreibung, keine Indexinstallation und keine Production-/DB-Writes; stattdessen separates manuelles Datengate und erneuter read-only Preflight.
- Der echte Backend-Bootstrap blieb deshalb erwartungsgemäß fail-closed mit `INDEX_NOT_READY` und sauberem Mongo-Disconnect. Diese Meldung nicht als Implementierungsfehler behandeln.

Reusable knowledge:
- Der Phase-2-Vertrag ist gemeinsamer serverseitiger Primary statt personenbezogener Kopien. Berechtigung wird bei jeder mutierenden Anfrage serverseitig anhand des aktuellen Accounts geprüft; bestehende Sessions verlieren nach Deaktivierung/Rollenentzug Schreibzugriff.
- `WORK_REVISION_SAVED` gilt nur bei exakt bestätigter Sequence als gespeichert. Stale Writes liefern `WORK_REVISION_RECOVERY_SAVED` mit aktuellem Sequence-/Recovery-Kontext.
- Neue Takeover-Mutationen sind in Phase 2 nicht mehr normal erforderlich und liefern 409 `CURRICULUM_WORK_REVISION_TAKEOVER_NOT_REQUIRED`; historische Receipt-Replays und `handed_over`-Provenienz bleiben kompatibel.
- Index-Readiness ist fail-closed: zuerst read-only Duplikat-Preflight, dann exakte Unique-Partial-Index-Installation/Verifikation, erst danach Serving und Background-Start.

References:
- Backend Phase-2-Branch: `refactor/curriculum-workrevision-continuity-phase-2`
- Backend final commit: `257193a2`
- Read-only blocker: genau 2 `UNIQUE_INDEX_COLLISION`-Fälle für `curriculum_work_revision_shared_primary_open_unique`
- Bootstrap safety commit: `257193a2`

## Task 2: Portal-Delegation und minimale UI-/Client-Anpassungen

Outcome: success

Preference signals:
- Der Nutzer bezeichnete die bestehende UI/UX als „perfekt“ und verlangte keine unnötigen Umbauten -> Portal-Änderungen blieben auf Logik, Status-/Fehlerwahrheit, Berechtigungs- und Recovery-Texte sowie Tests begrenzt.
- Der Nutzer verlangte Zwei-Browser-Akzeptanz, aber keine Umgehung des blockierten Backend-Datengates -> Contract-/Mock-/Fixture-Tests fortsetzen, reale E2E-Abnahme klar als blockiert ausweisen.

Key steps:
- Ein Portal-Task wurde auf dem bereits vorbereiteten Checkout/Branch mit dem finalen Backendvertrag und exakten Akzeptanztests eröffnet.
- Implementiert wurden `activePrimary` mit `ownPrimary`-Fallback, `hasOpenWorkRevision` mit Alias-Kompatibilität, Entfernung creator-/ownerbasierter Sperren für regulär berechtigte Nutzer, Ausblendung des normalen Takeover-Flows, Saved-Sequence-Wahrheit, sichtbare Recovery-Konflikte und Auth-Stale-Save-Abbruch.
- Review/Withdraw wurden für PDL und LMS-Support geöffnet; Request Changes/Approve/Reopen/Publish blieben PDL-only. Dirty/stale lokale Zustände werden nicht als eingereicht dargestellt. HiDrive-only-Export blieb unverändert.
- Finaler Portal-Stand: `93c69a73b7cc51431d04c575228be50f520666ab`; Working Tree clean, Remote exakt HEAD, Typecheck, Build, Vollsuite `329 Dateien/2.911 Tests`, Diff-Lint/Prettier und finaler Review bestanden.

Failures and how to do differently:
- Die reale Zwei-Browser-Abnahme blieb wegen der zwei bestehenden Shared-Primary-Duplikate blockiert. Nicht versuchen, das durch lokale Datenbereinigung, Index-Installation oder Production-Writes zu umgehen.
- Repo-weite Portal-Lint-/Prettier-Baselines außerhalb des Curriculum-Diffs bleiben separat: 4 bestehende Lint-Fehler, 4 Warnungen und 470 fremde Prettier-Dateien. Nicht in diesem Scope beheben.

Reusable knowledge:
- Portal darf „Auf Server gespeichert“ nur für eine vom Server bestätigte Sequence anzeigen; fremde Änderungen und Recovery müssen als Konflikt/Resync sichtbar bleiben.
- Takeover darf aus dem normalen Phase-2-Arbeitsfluss verschwinden, historische Provenienz und alte Replays müssen aber lesbar bleiben.

References:
- Portal Phase-2-Branch: `refactor/curriculum-workrevision-continuity-phase-2`
- Portal final commit: `93c69a73`
- Portal Block-Commits: `5bbf0841`, `d3371e50`, `0ca2b350`, `fe0b0074`, `93c69a73`
- Reale Zwei-Browser-Abnahme: blockiert bis manuelles Datengate und explizit freigegebener Index-Rollout abgeschlossen sind.
