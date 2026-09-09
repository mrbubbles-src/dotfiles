thread_id: 01a053d7-8d0d-7222-93d6-fcf9472f08be
updated_at: 2026-08-30T18:10:00+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/30/rollout-2026-08-30T20-03-50-01a053d7-8d0d-7222-93d6-fcf9472f08be.jsonl
cwd: /Users/mrbubbles/.codex/worktrees/d191/novari-education-backend

# Read-only HIGH-Review des Backend-C-Projection-Kandidaten findet einen P1-Auditpfadregress

Rollout context: Der Nutzer verlangte einen unabhängigen, strikt read-only Findings-first-Review des uncommitteten Novari-Backend-Kandidaten gegen Baseline `35e3c4dd7d40e0888efe91d0328ec4af501382e5`, ohne Delegation, Änderungen, Commit/Push oder erneuten Security-Diff-Scan. Der Kandidat umfasste exakt neun geänderte Dateien.

## Task 1: C-Projection Backend High-Review

Outcome: fail

Preference signals:

- Der Nutzer verlangte ausdrücklich „strikt read-only“, „keine Änderungen, kein Commit/Push“ sowie Findings P0–P3 zuerst -> zukünftige Reviews müssen Kandidatenidentität, Scope und Freeze-Grenzen zuerst feststellen und dürfen keine Reparaturen vornehmen.
- Der Nutzer verlangte, frühere Claims nicht ungeprüft zu übernehmen und die sechs Fokusdateien, Syntax, ESLint, Diffcheck und relevante Verträge unabhängig zu prüfen -> Reviewresultate müssen zwischen statischer Evidenz, ausgeführten Checks und blockierten Checks klar unterscheiden.
- Der Nutzer gab eine enge Allowlist und unveränderte Produkt-/Auditlogik vor -> Scope- oder Ownerdrift ist als harter Blocker zu behandeln, auch wenn die eigentliche Sicherheitsprojektion korrekt wirkt.

Key steps:

- Repo- und Kandidatenidentität geprüft: exakt neun Working-Tree-Dateien, 1.078 Einfügungen/134 Löschungen, Diff-SHA-256 `9851036d56e9217ae79d5d7efc67aa405baa4d5ff3bd475021a1fb4e625e6b13`, Stable Patch-ID `997f8d267be8e963d83a4901b30571b0b4d8e910`.
- Spec §5/§5.1/§5.2, Slice-C-Plan und Matrix gegen zentrale Projektion, Request-ID, Route-Template, Querykeys, Fehler-Allowlist und hostile-input-Verhalten abgeglichen.
- Statische Prüfung ergab: fail-closed Fehlerprojektion, leere Querykeys, `req.route.path` als server-owned Route-Deskriptor, keine Rohfehler/Stacks/PII in den geänderten zentralen Logs und korrekte vier zusätzliche statische Meldungspaare.
- Einen P1 gefunden: `getSafeRequestPath(req)` liefert nur `/:id/archive-course`; dieser Wert wird als `originalUrl` an die interne Zertifikatserzeugung übergeben. `certificateCompletionController.js` entscheidet anhand des vollständigen Archivpfads, wodurch das persistierte Zertifikatsaudit auf den Kursabschluss-Pfad zurückfallen kann. Die Teständerung bestätigt den falschen Zwischenwert statt des Auditresultats.
- Syntax und `git diff --check` waren grün. Der abhängigkeitfreie `httpError`-Test lief 14/14. Die übrigen Fokustests waren wegen fehlender lokaler Pakete `mongoose`/`express` nicht ausführbar; ESLint/Prettier waren wegen fehlender Binaries/Dependencies nicht ausführbar. Vollsuite wurde wie verlangt nicht wiederholt; Security-Diff-Scan wurde wie verlangt nicht erneut versucht.

Failures and how to do differently:

- [P1] `libs/observability/httpLogger.js:138` liefert die router-relative Route `/:id/archive-course`; `closingReportArchiveController.js:75` reicht sie als `originalUrl` an den internen Zertifikatsflow weiter, dessen bestehender Vergleich die vollständige Route erwartet. Kleinster Fix: den internen Auditparameter auf die feste vollständige Archivroute begrenzen und Erfolg-/Fehlerauditpfade gezielt absichern. Das erfordert eine separat erlaubte, enge Production-Allowlist-Erweiterung.
- Nicht ausreichend: nur den Test in `tests/classManager/closingReportArchive.test.js:671-672` auf `/:id/archive-course` zu ändern. Das prüft lediglich den fehlerhaften Zwischenwert und verfehlt die unveränderte Persistenz-/Auditvertragsprüfung.

Reusable knowledge:

- In diesem Backend ist `req.route.path` bewusst router-relativ. Für allgemeine Request-Logs ist das korrekt; interne fachliche Auditparameter, die von bestehender Vollroutenlogik abhängen, dürfen dadurch nicht stillschweigend umdefiniert werden.
- `getSafeRequestPath` ist für server-owned Logging-Projektion gedacht, nicht automatisch als Ersatz für jeden bestehenden fachlichen `originalUrl`-Vertrag.
- Fehlende Dependencies sind kein Produktfehler, aber sie machen einen Review nicht runtime-verifiziert: blockierte Tests und Lintchecks separat ausweisen.

References:

- Kandidat: `/Users/mrbubbles/.codex/worktrees/c39c/novari-education-backend`
- Geänderte Kerndateien: `error/globalErrorHandler.js`, `error/httpError.js`, `libs/observability/httpLogger.js`
- P1-Orte: `libs/observability/httpLogger.js:138`, `/_classManager/controller/closingReportArchiveController.js:75`, `tests/classManager/closingReportArchive.test.js:671-672`
- Bestehender Auditvergleich: `_classManager/controller/certificateCompletionController.js:22-25` vergleicht `req.originalUrl` mit `/auth/classmanager/closing-reports/:id/archive-course`.
- Ergebnis: `HIGH REVIEW FAIL — commit-ready: nein`.
