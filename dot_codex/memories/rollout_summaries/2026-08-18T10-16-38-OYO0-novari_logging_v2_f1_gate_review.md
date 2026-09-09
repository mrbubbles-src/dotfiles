thread_id: 01a0145f-7fd6-7de0-afd6-6bf157095b9c
updated_at: 2026-08-18T10:24:11+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/18/rollout-2026-08-18T12-16-38-01a0145f-7fd6-7de0-afd6-6bf157095b9c.jsonl
cwd: /Users/mrbubbles/Documents/Codex/2026-08-18/novari-logging-v2-f1-gate-review

# Unabhängiger Read-only-Review der Novari-Logging-V2-Gates

Rollout-Kontext: Deutscher findings-first Review ohne Änderungen, Tests, Fetches, Commits, Pushes oder Delegation. Spec, Visualisierung, Skills, AGENTS.md und drei frische Repository-Baselines wurden gelesen bzw. verifiziert.

## Task 1: Stop-Gates und F1-Reihenfolge

Outcome: success

Preference signals:
- Der Auftrag verlangte ausdrücklich einen „vollständig frischen, isolierten unabhängigen read-only Reviewer“ und „keine Spekulation“ -> künftige Reviews sollten nur aktuelle lokale Evidenz verwenden und Unsicherheiten klar markieren.
- Der Nutzer verlangte „findings-first“ sowie klare Nutzerentscheidungen ohne Umsetzung -> Ergebnisse sollten mit priorisierten Findings beginnen und erst danach Pläne bzw. Rückfragen enthalten.

Key steps:
- Baselines bestätigt: Backend `88c7c6b64e87b23696edf795589cf35735595a28`, Portal `ed327fed999ffffcdd941f8bcb752ef74ed5a989`, LMS `90d0ff21d3d11f93f77c54cebfe0448a64ab19da`; jeweils sauber, Branch `chore/logging-improvements`, Upstream `0/0`.
- Spec §2.2, §6.1, §13–§15 und §20 gegen Backend-/Portal-Code geprüft.
- Backend-Envelope, CORS-Header, Portal-Parser, Toast und 19 direkte Toast-Aufrufer nachvollzogen.

Failures and how to do differently:
- F1 ist in §13 genannt, aber durch die abschließenden Fälle §2.2 nicht autorisiert; ein Backend-Vorläufer passt ebenfalls nicht in die bestehenden sieben Fälle. Vor Runtimearbeit ist eine normative Spec-Klarstellung erforderlich.
- F1 kann nicht als ein zentraler Portal-Slice über alle direkten Aufrufer umgesetzt werden: `showBackendErrorToast` erhält aktuell nur Titel, Beschreibung und Request-ID; 19 Runtime-Dateien rufen ihn direkt auf, und ein Gesamtslice überschritte das §14-Gate von zehn Produktionsdateien.
- Der Backend-Envelope liefert aktuell keinen browserlesbaren serverseitigen Zeitpunkt. Der kleinste belastbare Vorläufer ist, den vorhandenen HTTP-`Date`-Header per CORS freizugeben und im Portal strikt zu parsen; Browserzeit darf nicht als Serverzeit ausgegeben werden.

Reusable knowledge:
- §6.1 verlangt keine vollständige Portal-Allowlist aller Fehlercodes. `error.code` kann als opaker, serverautoritativ normalisierter Wert kopiert werden, wenn das Backend ihn syntaktisch bindet und ungültige Werte auf `REQUEST_FAILED` bzw. `INTERNAL_ERROR` zurückfallen lässt.
- `Anwendung: Portal` und ein sicherer Portal-Funktionsbereich dürfen an einer autoritativen Portalgrenze statisch gesetzt werden; sie dürfen nicht aus roher URL, Query oder Backend-Rohdaten erfunden werden.
- Kleinste Reihenfolge: Spec autorisieren -> separater Backend-Vertragsslice -> zentraler Portal-F1a-Slice -> weitere Portal-Teilslices mit echten Fehlerpfaden, jeweils unter dem Größen-Gate -> erst dann F1 abschließen -> F2 separat.
- Backend-Wiederverwendung: `sendErrorResponse`, `libs/http/corsOptions.js`, Standard-HTTP-`Date`, bestehender Request-ID-Vertrag. Keine Controller-, Produktmodell-, Berechtigungs-, Eventpersistenz- oder Transaktionsänderung.

References:
- Spec: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/Novari_Logging_Error_Handling_und_Audit_Spec_V2.md` (§2.2, §6.1, §13–§15, §20).
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/error/httpError.js`, `libs/http/corsOptions.js`, `tests/error/httpError.test.js`, `tests/error/globalErrorHandler.test.js`, `tests/appCorsHeaders.test.js`.
- Portal: `/Users/mrbubbles/dev/novari/novari-education-portal/src/libs/utils/backendError.ts`, `src/libs/utils/toast.ts`, `src/libs/apiClient.ts`, `src/libs/utils/errorHandling.ts`, `src/libs/utils/error-handler.ts`.
- Verifizierter CORS-Vertrag enthält aktuell `X-Request-Id`, aber nicht `Date`.
- Nutzerentscheidungen: (1) Spec um Backend-Vorläufer/F1 erweitern, (2) HTTP-`Date` als Serverzeit akzeptieren, (3) syntaktisch gebundenen opaken Code erlauben, (4) F1 gestuft statt als übergroßen Gesamtslice umsetzen.
