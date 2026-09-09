thread_id: 01a05399-1b98-7e53-8ab4-88b686914967
updated_at: 2026-08-30T17:07:40+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T18-55-38-01a05399-1b98-7e53-8ab4-88b686914967.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/b01f/novari-education-backend

# Read-only HIGH-Review des uncommittierten C-Projection-Kandidaten

Rollout context: Backend-Worktree `/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend`, Express 5/JavaScript, normative Spec SHA-256 `6f1cb92db2994da087aee2ab1d799dd78d90b6501f18777894eb056a30214fe6`. Der Review war strikt read-only und auf die freigegebene Sechs-Dateien-Allowlist begrenzt.

## Task 1: C-Projection Backend-Review

Outcome: fail

Preference signals:
- Der Nutzer verlangte „strikt read-only“, „Findings-first“, exakte Identitäts-/Scope-Gates, keine Delegation und keine Änderungen. Künftige Reviews dieses Projekts sollten diese Gates vor jeder inhaltlichen Bewertung verifizieren und keinen impliziten Go ableiten.
- Der Nutzer verlangte die vollständige Prüfung aller 92 C-Requirements sowie die Trennung von Slice-, D-Producer-, PR- und Gesamt-Readiness. Künftige Bewertungen sollten Teil-PASSes nicht als Feature- oder PR-Abschluss darstellen.

Key steps:
- Kandidatenidentität vor und nach dem Review bestätigt: detached HEAD `35e3c4dd7d40e0888efe91d0328ec4af501382e5`, exakt sechs Dateien, 620 Einfügungen/89 Löschungen, Full-Index-Diff-SHA `cbf7afb45b9f2872f30ad531b8ab7f10743d9a44b39236914ba532b80c7971c1`, Stable Patch-ID `c454b4a1294a75e08fd13103259d89e412d12a82`.
- Hauptcheckout blieb sauber auf `chore/logging-improvements`; HEAD, Upstream und `origin` waren identisch, 0/0.
- Fokussierte Tests bestanden: `globalErrorHandler` 26/26, `httpError` 13/13, `httpLogger` 14/14. Syntax, fokussiertes ESLint und `git diff --check` bestanden.
- Zwei bekannte Altverträge wurden read-only reproduziert und als zusätzliche Test-Allowlist bestätigt: `tests/pdf/generatedPdfStreamLifecycle.test.js:181` und `tests/profile/profileImageErrorProjection.test.js:787`.

Findings and how to do differently:
- [P1] `error/globalErrorHandler.js:579-598`: `err.expose !== false` behandelt fehlendes `expose` als Freigabe und sendet bei gewöhnlichen 4xx rohe `error.message`. Kleinster Fix: nur explizit sichere Freigabe (`err.expose === true`) akzeptieren; sonst generische Meldung. Origin: pre-existing, im Kandidaten nicht geschlossen.
- [P1] Die beiden Altassertions verlangen das bewusst entfernte rohe Log-`error`-Objekt bzw. dessen interne Meldung. Nur diese Tests an den neuen Vertrag anpassen: `errorCode === 'INTERNAL_ERROR'`, kein eigenes `error`-Feld und keine Rohmeldung. Produktions-Allowlist nicht erweitern. Origin: introduced-by-branch.
- [P2] `libs/observability/httpLogger.js:106-121`: `try/catch` verhindert nur werfende Getter; ein nicht werfender Getter für `route.path` wird als Route-Template übernommen. Nur eigene Datenproperties akzeptieren, Accessors/Proxy ablehnen und auf `/` fallen.
- [P2] `libs/observability/httpLogger.js:130-140`: beliebige Query-Key-Freitexte, einschließlich E-Mail-förmiger Schlüssel, gelangen in Logs. Ohne server-owned Allowlist Querykeys nicht persistieren; Negativtest ergänzen.
- Prettier war nicht verifizierbar: lokal nicht installiert, `npx` scheiterte wegen fehlendem Netzwerk mit `ENOTFOUND`. Nicht als bestanden darstellen.

Reusable knowledge:
- Der zentrale Projektor ist absichtlich fail-closed; direkte `sendErrorResponse`-Aufrufer dürfen keine beliebigen Objekt-Details/Issues weiterreichen, während `sendProjectedErrorResponse` nur zentral validierte Erweiterungen zulässt.
- `headersSent`-Delegation blieb erhalten; Logging-/Persistenzfehler werden best-effort abgefangen und verändern nicht den Response-Pfad.
- Request-local At-most-one-Persistenz blieb unverändert; kein neues Event-Owner-, Retry- oder Exactly-once-System wurde eingeführt.
- Ein temporärer `node_modules`-Symlink zum Hauptcheckout wurde ausschließlich für Tests/Checks verwendet und anschließend entfernt.
- Codex Security wurde nicht durchgeführt: Der Start scheiterte vor Preflight mit `Working-tree contents changed after they were selected. Select Uncommitted changes again.` Es gab keine `scanId`; TAC, Preflight und Scan dürfen daher nicht als abgeschlossen bezeichnet werden.

References:
- Spec: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md`
- Plan: `/Users/mrbubbles/Documents/Codex/2026-08-17/novari-logging-v2-delegation/logging-v2-matrix-derived-slice-plan-v2.md`
- Matrix: `S5-*`, `S5.1-*`, `S5.2-*`, `S13-R4A1..S13-R4E`; alle C-Zeilen blieben `partial`/`not accepted`.
- Ergebnis: `HIGH REVIEW FAIL — commit-ready: nein`; Spec und Plan blieben aligned, aber F1 darf auf diesem Kandidaten nicht beginnen.
