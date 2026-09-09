thread_id: 01a025dd-8609-76d2-82d2-df66c2b5908b
updated_at: 2026-08-21T19:53:02+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/21/rollout-2026-08-21T21-47-49-01a025dd-8609-76d2-82d2-df66c2b5908b.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-portal
git_branch: chore/logging-improvements

# Read-only Review des Portal-Slices F1o

Rollout context: Vollständig isolierter, repositorygebundener Planreview ohne Edits, Tests, Formatter, Fetches, Commits oder Pushes. Start-Gate erfüllt: `/Users/mrbubbles/dev/novari/novari-education-portal`, Branch `chore/logging-improvements`, HEAD/Baseline `26497fddb1a1650c2c52c6bd0464fa35c8a84cc2`, Upstream `origin/chore/logging-improvements`, sauber, 0/0.

## Task 1: F1o Topic-Schreibfehler prüfen

Outcome: partial

Preference signals:
- Der Nutzer verlangte einen „vollständig isolierten repositorygebundenen read-only Planreviewer“, „findings-first“, fail-closed bei Gate-Abweichungen und ausdrücklich „keine Umsetzungsgenehmigung“. Künftige Reviews sollen nur aktuelle lokale Evidenz verwenden, keine Änderungen vornehmen und unklare Punkte explizit markieren.
- Der Nutzer verlangte eine exakte Vier-Dateien-Allowlist, keine unnötigen Mikroslices und keine Bündelung angrenzender Producer. Künftige Slice-Pläne sollen Runtime-Hunks, Owner-Grenzen, Tests und unveränderte Pfade einzeln benennen.
- Der Nutzer verlangt nach Abschluss eines Slices proportionale Bündelung statt künstlicher Aufteilung. Die vier Mutationsfamilien dürfen hier gemeinsam behandelt werden, weil beide privaten Helper ausschließlich von ihnen verwendet werden.

Key steps:
- AGENTS.md, Review-/Slicing-Regeln, Novari-Logging-Gates, aktuelle V2-Spec/Visualisierung sowie Runtime-, Hook-, Service-, Extractor-, Toast- und Testverträge gelesen.
- Tatsächliche Topic-Callpaths geprüft: `lmsTopicService` reicht unveränderte AxiosErrors durch; die vier relevanten Mutationen sind `useCreateTopic`, `useUpdateTopic`, `useCreateTopicVersion` und `useUpdateTopicStatus`.
- Bestehende zentrale Projektion `extractBackendSupportInformation` geprüft: nur echte AxiosErrors mit vollständigem verschachteltem `response.data.error`-Envelope, sicherem Code/Request-ID und fail-closed Allowlist; hostile URLs, Querywerte, `actionHint`, Details, Issues und Rohdaten werden nicht projiziert.
- Bestehende Helper `showTopicConflictWithReference` und `showTopicFailureWithReference` sowie Konflikt-Refresh, GitHub-/EditorJS-Owner und globale 5xx-Grenzen geprüft.

Failures and how to do differently:
- [P1] Der Plan behauptete, normale Status-`500/502/503` blieben ausschließlich beim globalen Interceptor. In `useUpdateTopicStatus` wird zwar die Supportprojektion übersprungen, danach aber noch der lokale `showErrorToast` ausgeführt; der Interceptor kann zusätzlich toasten. F1o darf diesen Owner-/Kontrollfluss nicht ändern. Entweder den bestehenden lokalen Fallback ausdrücklich beibehalten oder eine separate normative Freigabe für eine Owner-Änderung einholen.
- [P2] `useCreateTopicReviewNote` ist ein weiterer Topic-Schreibproducer (`POST /lms/topics/:id/review-notes`) und muss ausdrücklich als unverändert außerhalb von F1o genannt werden, ebenso `useDeleteTopic`.
- [P2] „Gültiger sonstiger Backendfehler → vier Argumente“ ist zu breit. Die vierte Projektion darf erst nach bestehenden Owner-Prüfungen erfolgen; `VALIDATION_ERROR`, `GITHUB_*`, fehlende Request-ID, unvollständige/Legacy/flache Envelopes und die bestehenden 5xx-Ausnahmen müssen exakt drei Argumente bzw. ihren bisherigen Owner behalten.

Reusable knowledge:
- Korrigierter F1o-Scope: nur Portal; statischer Bereich `Topic-Speicherung`; beide bestehenden Helper additiv um die optionale vierte Toast-Projektion erweitern; niemals `undefined` als viertes Argument übergeben.
- Exakte Allowlist: `src/hooks/lms/useLmsTopics.ts`, neue `src/hooks/lms/__tests__/useLmsTopics.supportInformation.test.tsx`, `docs/development/error-handling.md`, `CHANGELOG.md`.
- §2.2-Zuordnung: Runtime-Hunks ausschließlich Fall 6. Keine Service-/API-, Payload-, Modell-, Rollen-, UI-, Retry-, Return-, Invalidierungs- oder Conflict-Refresh-Änderung.
- Die bestehende 1091-Zeilen-Datei `src/hooks/lms/__tests__/useLmsTopics.test.tsx` soll unverändert bleiben; neue Tests gehören in die Nachbardatei.
- Künftige Tests müssen alle vier Mutationsfamilien, gültige vollständige Envelopes, CAS-409 plus Refresh/Ursprungsfehler, flache/Legacy/unvollständige/widersprüchliche IDs, hostile Zusatzfelder, EditorJS-Validation, GitHub-Fehler sowie das tatsächliche normale 5xx-Verhalten abdecken.

References:
- [1] Start-Gate: `git status --short --branch && git rev-parse HEAD && git rev-list --left-right --count HEAD...@{upstream}` → sauberer Branch `chore/logging-improvements`, HEAD `26497f...`, 0/0.
- [2] `src/hooks/lms/useLmsTopics.ts:89-143, 243-614` → beide Topic-Helper und vier Mutationsfamilien; normale Status-5xx fallen nach dem Helper weiterhin zu `showErrorToast` durch.
- [3] `src/libs/lmsTopicService.ts:98-164, 190-200` → POST/PUT/PATCH-Schreibpfade sowie separater Review-Notiz-POST.
- [4] `src/libs/utils/backendError.ts:191-309` → strikte `extractBackendSupportInformation`-Projektion; Codes `^[A-Z][A-Z0-9_]{0,127}$`, Request-IDs `^[A-Za-z0-9._-]{1,128}$`, optional striktes IMF-Date.
- [5] `src/libs/apiClient.ts:85-103` → globaler Interceptor für 500/502/503 und optional vierte Projektion.
- [6] Finalurteil: Plan in ursprünglicher Form nicht freigabereif; nach Korrektur kohärente Vier-Familien-Bündelung, weiterhin keine Umsetzungsgenehmigung.
