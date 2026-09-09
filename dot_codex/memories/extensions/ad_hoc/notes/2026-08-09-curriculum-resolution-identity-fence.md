# Curriculum Phase 3: Resolution-Identity-Fence vormerken

- Aktuell ist ein zusätzlicher Identity-/Generation-Fence für die lokale Same-target-Konfliktauflösung kein Slice-4b-Blocker, sondern P3 Defense-in-depth.
- Der gegenwärtige Portalvertrag remountet bei Versions- und EditSession-Wechseln; Standardkonten wechseln keine Rolle, und Shareholder-Rollen verwenden dieselbe persistente Persona-/Draft-Identity.
- Erneut prüfen, falls künftig Account-, `userID`-, `curriculumVersionId`- oder `workRevisionId`-/Draft-Identity innerhalb derselben gemounteten Autosave-Hook-Instanz wechseln kann oder bestehende Remount-/Cleanup-Grenzen entfernt werden.
- Dann Store-Commit, Reload und Hook-Adoption zusätzlich an exakte `collaborationGeneration` und Record-Identity binden und mit einer verzögerten Resolution über einen Identity-Wechsel testen.
