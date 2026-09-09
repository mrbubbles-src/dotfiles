thread_id: 01a07e89-56b1-73b1-b9a8-39032a7df48a
updated_at: 2026-09-08T01:32:03+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/09/08/rollout-2026-09-08T03-02-05-01a07e89-56b1-73b1-b9a8-39032a7df48a.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: codex/fix-legacy-session-retry

# Classroom-50-Integration für Novari analysiert und Spec v0.1 erstellt

Rollout context: Der Nutzer bat um eine lesende Prüfung von Backend, Portal und LMS sowie um eine wiederverwendungsorientierte Integrations-Spec für Classroom 50. Keine Dateien, Konfigurationen oder Live-Daten wurden verändert.

## Task 1: Classroom-50-Architektur und bestehende Novari-Struktur prüfen

Outcome: partial

Preference signals:
- Der Nutzer betonte: „Wir müssen nicht alles von Grund auf neu aufbauen“ und möchte vor jeder Neuentwicklung vorhandene Komponenten, Services und Verträge identifiziert und wiederverwendet sehen.
- Der Nutzer möchte weiterhin lesend arbeiten; Implementierung und Provider-Aktionen waren nicht autorisiert.
- Der Nutzer bestätigte als Ziel: kursartbezogene Aufgaben-Master-Organisationen, neue Klassenorganisationen bei Klassenerstellung und gezielte Tagesfreigabe statt vollständiger Vorabfreigabe.

Key steps:
- Classroom-50-Wiki und zwei lokale Deep-Research-Berichte gelesen und mit aktueller Dokumentation abgeglichen.
- Backend auf Branch `dev` bei Commit `64ca928042ae6114bbc813d5d949cf38556c901f`, Portal und LMS lesend untersucht.
- Bestehende Curriculum-GitHub-Anbindung klar von der geplanten Aufgaben-/Classroom-50-Auslieferung getrennt.
- Bestehende Kurs-, Curriculum-, Übungslink-, Content-Grant-, Aufgabenlisten- und Job-Muster inventarisiert.

Reusable knowledge:
- Classroom 50 hat keine Parent-/Child-Classroom-Hierarchie. Eine GitHub-Organisation enthält das private `classroom50`-Repository und mehrere Classrooms.
- Private Assignment-Templates müssen innerhalb derselben Organisation liegen. Private Master-Repositories aus einer separaten Kursart-Organisation können nicht direkt verwendet werden; Novari muss benötigte Vorlagen kopieren oder synchronisieren.
- `locked` schützt private Vorlagen vor Zugriff durch das Classroom-Team. `available-from` steuert nur die Anzeige und entsperrt nicht automatisch. `--unlock` gilt für das gesamte Classroom-Team, nicht für einzelne Schüler.
- Aufgabenmetadaten werden über öffentliche GitHub Pages veröffentlicht; Tests, Lösungen und vertrauliche Daten dürfen deshalb nicht als geheim betrachtet werden.
- Die bestehende GitHub-Curriculum-App ist auf `Novari-Education`, ausgewählte Repositories und enge Berechtigungen festgelegt. Sie sollte nicht für Classroom-50-Aufgaben umfunktioniert werden.
- Backend-Kursmodell bindet Klassen bereits an `type`, `curriculumVersionId`, Startdatum, Lehrkräfte und Teilnehmer. Portal bindet Kursart und Curriculum-Version bei der Klassenanlage.
- Bestehende Aufgabenverwaltung speichert aktuell nur Titel, Beschreibung, Links und `publishAt`; sie führt keine Provider-Erstellung, Accept-Bestätigung, Repository-Zuordnung oder echte GitHub-Entsperrung aus.
- LMS besitzt bereits Aufgabenliste/BFF sowie authentifizierte Topic-Sperrpfade. Die bestehende Lernmaterialfreigabe ist wochenbasiert; Aufgaben sollen eine eigene Tagesfreigabe verwenden, aber denselben Kurskalender nutzen.

Failures and how to do differently:
- Frühere Aussage „Aufgaben erst am jeweiligen Tag anlegen“ war zu eng. Besser: vorab private Aufgaben registrieren, zunächst gesperrt halten, zum Freigabezeitpunkt explizit entsperren.
- Ein bloßes zukünftiges `publishAt` oder Zurückhalten eines Links schützt GitHub-Inhalte nicht.
- Individuelle Vorabfreigaben für einzelne Schüler sind im aktuellen Classroom-50-Vertrag nicht belegt. Nicht als einfachen `unlock`-Aufruf spezifizieren; zuvor Provider-PoC oder alternative Aufgabenidentität prüfen.
- Eine öffentliche Profilabfrage per Username beweist nicht, dass der Schüler das Konto besitzt. Für belastbare Zuordnung GitHub-Identitätsbestätigung beziehungsweise User-to-Server-OAuth verwenden.
- Präfixe wie `ITBT-` eignen sich zur Kandidatensuche, dürfen aber nicht die dauerhafte Identität bilden. Bindung muss Repository-ID, Aufgabenstand/Commit und explizite `overviewRowId`/Aufgabenreferenz speichern.

References:
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/_lms/controller/githubClassroomAssignmentController.js`
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/models/githubClassroomAssignmentSchema.js`
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/models/courseSchema.js`
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/models/lms/lmsContentGrantSchema.js`
- Backend: `/Users/mrbubbles/dev/novari/novari-education-backend/libs/lms/contentAccess.js`
- Portal: `src/components/lms/teaching-plan/TeachingPlanRowContentFields.tsx`
- Portal: `src/components/lms/content-release/TeacherContentReleasePage.tsx` (`StudentReleasePicker`)
- Portal: `src/components/lms/github-classroom-assignments/TeacherGithubClassroomAssignmentsPage.tsx`
- LMS: `app/github-classroom/page.tsx`, `components/layout/github-classroom/github-classroom-page.tsx`
- Classroom 50: `https://github.com/foundation50/classroom50/wiki/How-Classroom-50-Works`
- Classroom 50: `https://github.com/foundation50/classroom50/wiki/Assignment-Templates`
- Classroom 50: `https://github.com/foundation50/classroom50/wiki/Course-Lifecycle-and-End-of-Term`
- Classroom 50: `https://github.com/foundation50/classroom50/wiki/gh-teacher#assignment-lock`

## Task 2: Wiederverwendungsorientierte Integrations-Spec formulieren

Outcome: partial

Key steps:
- Spec v0.1 mit Aufgabenquelle, Curriculum-Bindung, Tagesfreigabe, GitHub-Kontoverknüpfung, Datenmodell, Ablauf, Wiederverwendung und Abnahmekriterien erstellt.
- Vorgeschlagen, zusätzliche Classroom-50-Integration separat unter etwa `libs/classroom50/` zu kapseln.
- Bestehende `LmsContentGrant`-Mechanik als Muster identifiziert; Aufgabenfreigabe soll eigener Scope beziehungsweise eigene Domain bleiben, damit `all`-Content-Grants keine Aufgaben freischalten.
- Bestehende dauerhafte Job-/Lease-/Idempotenzmuster als Vorlage identifiziert, aber Curriculum-Scan-Jobs nicht umwidmen.
- Für GitHub-Profilzuordnung vorgeschlagen: unveränderliche GitHub-User-ID, aktueller Login, Profil-URL und Verifikationszeitpunkt am bestehenden Student-Objekt.

Reusable knowledge:
- Kursart/Curriculum-Version kann als fachlicher Ursprung für Aufgabenreferenzen dienen; vorhandene `exerciseLinks`, `overviewRowId`, `moduleSnapshotId`, `submoduleSnapshotId` und `courseDay` sind geeignete Integrationspunkte.
- Der bestehende WorkRevision-Vertrag erlaubt derzeit bei `exerciseLinks` exakt `exerciseLinkId`, `label`, `url`. Eine strukturierte Aufgabenreferenz erfordert Anpassungen an Hashing, Validierung, Autosave, Snapshot-Adaptern, Merge, Import/Export und Recovery; Legacy-Links müssen kompatibel bleiben.
- `StudentReleasePicker` ist ein wiederverwendbarer UI-Baustein, muss aber zunächst aus der aktuellen lokalen Datei herausgelöst werden.
- Bestehende UI-Primitiven `BaseDialog`, Avatar und Eingabekomponenten können für die GitHub-Profilbestätigung verwendet werden.
- Standardablauf: freigegebene Curriculum-Version → Aufgabenstand mit festem Commit → lokale private Assignment-Templates → gesperrte Classroom-50-Aufgaben → explizites Unlock → Portal/LMS zeigt Accept-Link → bestätigte Repository-Zuordnung.
- Laufende Klassen sollten einen eingefrorenen Aufgabenstand verwenden; Master-Änderungen dürfen nicht unbemerkt bereits laufende Klassen verändern.

Failures and how to do differently:
- Die Spec bleibt teilweise, weil Provider-Berechtigungen, echte Organisationserstellung und individuelle Schülerfreigaben nicht live oder end-to-end nachgewiesen wurden.
- Classroom-50-Organisationen müssen vor `init` existieren; Classroom 50 erstellt sie nicht selbst. Vollautomatische Organisationserstellung ist eigene GitHub-/Enterprise-Integration.
- Eine private GitHub App kann nur im Besitzerkonto installiert werden; für weitere Master-Organisationen muss die App entsprechend installierbar beziehungsweise öffentlich sein, ohne dass Repositories öffentlich werden.
- `Head TA` reicht nicht für alle Operationen: Private Template-Leserechte kann laut Dokumentation nur ein Organisations-Owner vergeben.
- Persönliche PATs nicht als zentrale Portal-Integration einplanen; bevorzugt separate GitHub-App-/Installation-Token-Strategie, deren Classroom-50-Kompatibilität zuerst in einem kleinen PoC geprüft wird.

References:
- Bestehende Kursanlage: `libs/classManager/courseWriteService.js`, `src/components/dashboard/course/addCourseModal.tsx`
- Curriculum-Linkvertrag: `models/lms/curriculumOverviewSchema.js`, `libs/lms/curriculumWorkRevisionPatchValidation.js`, `src/libs/curriculumWorkRevisionHash.ts`
- GitHub-App-Guardrails: `libs/github-curriculum/githubCurriculumConfig.js`, `libs/github-curriculum/githubAppClient.js`
- GitHub-Username-Normalisierung: `libs/githubUsername.js`
- Classroom-50-CLI-Beispiele: `gh teacher assignment add ... --locked`, `gh teacher assignment lock ... --unlock`
- Ergebnis: keine Implementierung, keine Tests und keine Provider-Schreibaktionen ausgeführt.
