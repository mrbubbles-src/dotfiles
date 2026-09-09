thread_id: 01a05412-42dc-7cb2-a042-cfbba62a37af
updated_at: 2026-08-30T19:20:18+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T21-07-58-01a05412-42dc-7cb2-a042-cfbba62a37af.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/83be/novari-education-backend

# C-Projection korrigiert und veröffentlicht

Rollout context: Im Backend-Repository `/Users/mrbubbles/dev/novari/novari-education-backend` wurde ein eng begrenzter Compliance-Fix auf Branch `chore/logging-improvements` durchgeführt. Baseline war `33c6bdcd6b5c433ba1c774f12e4db4ac382fca47`; zunächst wurde ein separater High-Review abgewartet. Danach erfolgten Commit und Push.

## Task 1: Nicht freigegebenes REQUEST_FAILED-Fehlerpaar entfernen

Outcome: success

Preference signals:

- Der Nutzer verlangte einen „kleinsten Fix“ mit exakt einer Produktions- und einer Testdatei sowie „Keine anderen ... ändern“ -> zukünftige Änderungen in diesem Projekt sollen strikt auf die benannte Allowlist und den direkten Fehlerumfang begrenzt werden.
- Der Nutzer verlangte ausdrücklich „Noch kein Commit/Push bis separatem High-Review“ und später „Keine weiteren Edits oder Reformatierung“ -> erst Review/Freigabe abwarten und danach nur den eingefrorenen Kandidaten veröffentlichen.
- Der Nutzer verlangte einen präzisen deutschen Handoff mit Baseline, Dateiliste, Diff-SHA/Patch-ID, Tests und bekannten Formatgrenzen -> Abschlussberichte sollen diese Nachweise explizit enthalten.

Key steps:

- Branchgebundenen Checkout geprüft: `chore/logging-improvements`, clean, HEAD=Upstream=Baseline, 0/0.
- Ursache bestätigt: `error/globalErrorHandler.js` erlaubte für `REQUEST_FAILED` zusätzlich `Sichere Meldung`, obwohl kein Production-Caller existierte.
- Genau zwei Dateien geändert: Produktions-Allowlist entfernte `Sichere Meldung`; der Fallback-Test wurde auf `Modul konnte nicht aktualisiert werden.` umgestellt.
- Syntaxprüfung, `git diff --check` und `npm run lint` waren erfolgreich.
- Fokustests: 68/69 im Sandboxlauf; der einzige Fehlschlag war ein Sandbox-`EPERM` beim Binden von `127.0.0.1`. Der unveränderte Realpfad-Test lief autorisiert mit 8/8 erfolgreich.
- Normaler Prettier-Check meldete bereits bestehende Baseline-Formatabweichungen; kein Reformatting. Der Differentialcheck zeigte nur die drei erwarteten inhaltlichen Ersatzzeilen.
- Gestagter Kandidat: exakt `error/globalErrorHandler.js` und `tests/error/globalErrorHandler.test.js`; Diff-SHA256 `b7875cf915aeee2b8c68b5e15518e4472da52efa70ad0ce4a47da1476291f0fb`, Patch-ID `41ee56b1750cc79698e8e78ef225465115a07bf2`.
- Nach High-Review PASS ohne P0-P3 wurde mit `fix: remove unapproved REQUEST_FAILED message` committed und nach `origin/chore/logging-improvements` gepusht.

Failures and how to do differently:

- Der erste Worktree war detached und daher nicht freeze-konform; der benannte Repository-Checkout war maßgeblich.
- Sandbox blockierte zunächst Git-Index-Schreiben und den lokalen Listener. Autorisierte Wiederholung löste beides; den Listener-Fehler nicht als Produktfehler interpretieren.
- Prettier nicht mit `--write` ausführen, wenn dadurch ein großer Baseline-Diff entsteht; die bekannte Formatgrenze dokumentieren und nur differenziell prüfen.

Reusable knowledge:

- Die öffentliche Fehler-Allowlist in `error/globalErrorHandler.js` ist fail-closed und muss exakte Code-/Nachrichtenpaare enthalten.
- `REQUEST_FAILED` bleibt als 4xx-Fallback gültig; nur die reale freigegebene Meldung `Modul konnte nicht aktualisiert werden.` darf exponiert werden.
- Finalzustand ist Commit `aab92a322474df194a6bf296657dde7954229442`, HEAD=Upstream, 0/0, Working Tree clean.

References:

- `error/globalErrorHandler.js`: `REQUEST_FAILED`-Allowlist.
- `tests/error/globalErrorHandler.test.js`: öffentlicher 4xx-Code-Fallback.
- `tests/lms/moduleControllerErrorBoundary.test.js`: Realpfad-Regression, autorisiert 8/8.
- Commit: `aab92a322474df194a6bf296657dde7954229442 fix: remove unapproved REQUEST_FAILED message`
