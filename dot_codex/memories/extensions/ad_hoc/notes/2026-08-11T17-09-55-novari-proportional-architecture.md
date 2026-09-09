# Novari: proportionale Architektur statt hypothetischer Großskalierung

- Bei Novari immer die reale Codebase, den aktuellen Use Case und die heutige Größenordnung als primäre Architekturgrenze verwenden.
- Nicht automatisch Lösungen auf Großanbieter-Niveau, Multi-Instance-Betrieb oder hypothetische Last in fünf bis zehn Jahren auslegen. State of the Art oder maximal skalierbar ist kein Selbstzweck.
- Kleine, korrekte und verständliche Lösungen bevorzugen, wenn bestehende Primitiven ausreichen. Erweiterbarkeit erhalten, aber zusätzliche Plattformen, Registries, Poller, Caches, Heartbeats, Outboxen oder Protokolle erst bei einer realen Anforderung einführen.
- Die grobe Schätzung von eventuell 400–500 gleichzeitigen Personen bezieht sich langfristig auf das gesamte Portal, nicht auf einzelne Funktionen oder Räume.
- Für Curriculum-WorkRevision-Zusammenarbeit ist realistisch mit typischerweise 1–2 und höchstens ungefähr 4 gleichzeitig arbeitenden Personen zu rechnen. Die Lösung soll bei dieser kleinen Gruppe stabil sein, muss heute aber nicht für Hunderte Personen in derselben WorkRevision optimiert werden.
- Wenn zukünftige Last oder Betriebsform tatsächlich steigt, dann gezielt anhand gemessener Anforderungen erweitern.
- Presence-spezifisch: bestehende Socket-Verbindung und der bereits autorisierte exakte WorkRevision-Raum genügen; kleine vollständige Snapshots sind angemessen. Keine globale Benutzerladung oder separate Presence-Infrastruktur.
- Presence-UI: Bei nur der eigenen Person keine Anzeige. Ab zwei Personen alle Anwesenden einschließlich der eigenen Person anzeigen; im Popover den eigenen Eintrag als „Du“ kennzeichnen. Nur gekürzter Name und ungefährer Modulbereich, keine Rolle oder Schreibaktivität.
