---
name: watch-codex-threads
description: Aktive Codex-Tasks auflisten, eine einfache nummerierte Auswahl mit einem temporären Heartbeat standardmäßig ungefähr alle 30 Minuten beobachten und den Mac nach nachweislich sauberem Abschluss aller ausgewählten Tasks in den Ruhezustand versetzen. Verwenden, wenn der Nutzer laufende Threads oder Tasks in 30- bis 60-minütigen Abständen überwachen, nach Abschluss automatisch schlafen, auf gemeldete Limits oder Fristen reagieren oder optional einen Task vor dem Sleep-Modus stoppen lassen möchte.
---

# Codex-Tasks beobachten

Aktive Codex-Tasks über einen temporären, threadgebundenen Heartbeat überwachen. Standardmäßig ungefähr alle 30 Minuten prüfen und erst schlafen, wenn alle ausgewählten Tasks sauber abgeschlossen sind. Scheduler-Verzögerungen sind möglich. Zusätzliche Regeln nur übernehmen, wenn der Nutzer sie ausdrücklich nennt.

## 1. Verfügbare Werkzeuge prüfen

Zuerst nach den Codex-Task-Werkzeugen `list_threads`, `wait_threads`, `read_thread` und `automation_update` suchen. Wenn sie nicht direkt in der sichtbaren Werkzeugliste stehen, die verfügbare Tool-Discovery oder Werkzeug-Metadaten aktiv nach diesen exakten Namen durchsuchen und gefundene verzögert geladene Werkzeuge verwenden. Nicht allein aus der anfänglich sichtbaren Kurzliste auf fehlende Verfügbarkeit schließen. Für eine gewünschte Stop-Regel zusätzlich nach einem ausdrücklich dafür vorgesehenen Interrupt-, Cancel- oder Stop-Werkzeug suchen.

Bei fehlendem `list_threads`, `wait_threads`, `read_thread` oder `automation_update` abbrechen und die fehlende Fähigkeit nennen. Für den Standard mit automatischem Sleep zusätzlich ein lokales Command-Werkzeug benötigen. Nicht ersatzweise Prozesslisten, lokale Codex-Datenbanken oder Rollout-Dateien als Live-Status verwenden.

## 2. Laufende Tasks zur Auswahl zeigen

`list_threads` ohne Suchquery aufrufen. Den Aufruf bei einem Transport- oder Hostfehler höchstens zweimal wiederholen und danach sicher abbrechen. Nur Einträge mit `status: active` als gerade arbeitend behandeln.

- Den aufrufenden Monitor-Task selbst immer ausschließen. Seine eindeutige Kombination aus `threadId` und `hostId` aus dem App-/Task-Kontext oder einem dafür vorgesehenen Task-Werkzeug übernehmen. Fehlt diese direkte Identität, nur dann ersatzweise über Titel, Beschreibung, Preview, Arbeitsordner und Aktualisierungszeit zuordnen, wenn genau ein aktiver Eintrag eindeutig zum aktuellen Aufruf passt. Andernfalls abbrechen, statt eine Selbstbeobachtung zu riskieren.
- Die identifizierte Monitor-ID speichern und unmittelbar vor dem ersten `wait_threads`-Aufruf bestätigen, dass sie in keinem ausgewählten Ziel vorkommt.
- `idle` und `notLoaded` nicht als arbeitend anzeigen.
- Nicht erreichbare Hosts kurz erwähnen, aber deren Status nicht erraten.
- Neue Tasks, die später erscheinen, nicht automatisch zur Auswahl hinzufügen.

Eine knappe nummerierte Liste ausgeben:

```text
Gerade aktiv:
1. Novari Education GitHub Sync — novari-education-portal
2. Faverelay Multiway Sync — faverelay

Welche soll ich beobachten? Antworte z. B. mit `1,2` oder `alle`.
Optional: `1,2; bei gemeldetem Limit stoppen und schlafen`.
```

Wenn kein anderer Task aktiv ist, mitteilen, dass derzeit nichts beobachtet werden kann. Den Mac dann nicht schlafen legen.

## 3. Auswahl und Regeln festhalten

Ohne Zusatzangabe diesen Standard verwenden:

- alle ausgewählten Tasks beobachten;
- ungefähr alle 30 Minuten prüfen;
- erst handeln, wenn jeder ausgewählte Task sauber abgeschlossen ist;
- danach den Mac in den Ruhezustand versetzen.

Kompakte natürliche Angaben akzeptieren, zum Beispiel:

- `alle`
- `1,3`
- `alle; Intervall 60 Minuten`
- `2; zusätzlich bei gemeldetem Limit stoppen und schlafen`
- `alle; spätestens um 02:00 stoppen und schlafen`

Die verstandene Auswahl, das nominelle Intervall und die maximale Laufzeit von 24 Stunden in einem Satz bestätigen. Darauf hinweisen, dass Scheduler-Verzögerungen zum Intervall hinzukommen können. Nur bei Mehrdeutigkeit nachfragen. Eine Stop-Regel niemals aus Wörtern wie „Limit beobachten“ ableiten; dafür muss der Nutzer ausdrücklich `stoppen`, `abbrechen` oder Gleichwertiges angeben.

## 4. Sleep-Gate scharfstellen

Für den Standard mit automatischem Sleep das mitgelieferte `scripts/sleep_gate.sh` verwenden. Den absoluten Pfad relativ zu dieser `SKILL.md` auflösen.

1. Den Helper einmal mit `--check` prüfen.
2. Einen nicht existierenden, zufälligen Zustandspfad im Format `/private/tmp/watch-codex-threads-<UUID>` wählen.
3. Den Helper mit `--arm <Zustandspfad> 86400` in einer laufenden Command-Session starten. Diese Armierung vor Beginn der Beobachtung mit der erforderlichen Systemfreigabe außerhalb der Sandbox ausführen. Keine dauerhafte breite Befehlsfreigabe verlangen.
4. Auf die Ausgabe `armed:<Zustandspfad>` warten und Session-ID sowie Zustandspfad festhalten.

Die Arm-Session ist der einzige absichtlich gestartete Hintergrundprozess. Sie wartet ohne weitere Freigabe auf `--trigger`, führt dann `/usr/bin/pmset sleepnow` aus und beendet sich ohne Trigger nach 24 Stunden automatisch. Wenn Armierung oder Freigabe fehlschlägt, die automatische Beobachtung nicht mit einem falschen Sleep-Versprechen beginnen. Den Nutzer stattdessen entscheiden lassen, ob nur beobachtet werden soll.

Bei Abbruch, Aufmerksamkeit, Fehler oder einer Regeländerung ohne Sleep den Helper mit `--cancel <Zustandspfad>` beenden und das Ende der Arm-Session sowie die Entfernung des Zustandsordners bestätigen. Wenn die Arm-Session vorzeitig endet, nicht schlafen. Nur nachdem das Command-Session-Werkzeug mit einem Exit-Status bestätigt hat, dass der Prozess beendet ist, einen verbliebenen eigenen Zustandsordner mit `--cleanup-confirmed <Zustandspfad> session-ended` entfernen. Ohne diesen externen Nachweis nicht bereinigen.

## 5. Temporären Heartbeat anlegen

Nach erfolgreicher Armierung mit `automation_update` einen Heartbeat im aufrufenden Monitor-Task anlegen. Keinen Cron-Job und keinen neuen Codex-Task erstellen.

- Standardintervall: nominell 30 Minuten.
- Auf ausdrücklichen Wunsch: 60 Minuten oder ein anderes eindeutig genanntes Intervall.
- Einen eindeutigen temporären Namen verwenden.
- Den zurückgegebenen Automation-Identifier festhalten und die Automation anschließend so aktualisieren, dass ihr Prompt denselben Identifier enthält.
- Keine unveränderten Zwischenstände benachrichtigen.

Im Heartbeat-Prompt vollständig speichern:

- Automation-Identifier und Monitor-`threadId`;
- ausgewählte `threadId`-/`hostId`-Paare samt Anzeigenamen;
- Intervall und vereinbarte Zusatzregeln;
- absoluten Pfad zu diesem Skill;
- Zustandspfad und Session-ID des Sleep-Gates;
- Anweisung, Abschnitt 6 dieses Skills auszuführen und keine neuen Tasks hinzuzufügen.

Wenn das Anlegen fehlschlägt, das Sleep-Gate abbrechen und keinen aktiven Monitor behaupten. Wenn das Anlegen erfolgreich war, aber die anschließende Prompt-Aktualisierung fehlschlägt, die bereits erstellte Automation über ihren zurückgegebenen Identifier löschen und danach das Sleep-Gate abbrechen. Nach erfolgreicher Einrichtung das nominelle Intervall, mögliche Scheduler-Verzögerungen, die ausgewählten Tasks und die 24-Stunden-Grenze bestätigen. Den aktuellen Turn danach beenden.

## 6. Bei jedem Heartbeat prüfen

1. Diesen Skill erneut lesen und Automation-Identifier, Zielmenge, Regeln und Sleep-Gate-Daten aus dem Heartbeat-Prompt übernehmen.
2. Das Sleep-Gate mit `scripts/sleep_gate.sh --status <Zustandspfad>` prüfen. Bei fehlendem, abgelaufenem oder stale gemeldetem Gate die Automation löschen und einen eventuell noch laufenden Helper mit `--cancel` beenden. Über die gespeicherte Session-ID das Prozessende bestätigen und einen verbliebenen Zustandsordner erst danach mit `--cleanup-confirmed` entfernen. Nicht schlafen und den Nutzer informieren.
3. `wait_threads` einmal mit `timeoutMs: 0` für alle ausgewählten `threadId`-/`hostId`-Paare aufrufen. Höchstens acht Ziele zulassen.
4. Jeden zurückgegebenen Eintrag mit verändertem Cursor, Task-Status oder Turn-Status auswerten. Betroffene Tasks mit `read_thread` prüfen, bevor neue Cursor als verarbeitet gelten.
5. Wenn alle Tasks weiterarbeiten, die Automation unverändert aktiv lassen und den Heartbeat ohne Nachricht beenden.

Bei einem Fehler von `wait_threads` oder `read_thread` höchstens zweimal erneut versuchen. Einen ungültigen Cursor einmal verwerfen und den betroffenen Task anschließend mit `read_thread` neu einordnen. Bei erneutem Fehler, verlorenem Host oder weiterhin unklarem Status die Automation löschen, das Sleep-Gate abbrechen, auf `braucht Aufmerksamkeit` wechseln und nicht schlafen.

## 7. Abschluss streng klassifizieren

Für jeden ausgewählten Task genau einen Zustand führen:

- `arbeitet`: Der Task ist noch aktiv oder hat keinen belastbaren Endzustand.
- `sauber abgeschlossen`: Der letzte Turn ist abgeschlossen, enthält keinen Fehler und die letzte Antwort belegt, dass die angeforderte Aufgabe erledigt wurde.
- `absichtlich gestoppt`: Eine ausdrücklich vereinbarte Stop-Regel wurde mit einem echten Stop-Werkzeug ausgeführt und der beendete Zustand anschließend bestätigt.
- `braucht Aufmerksamkeit`: Der Task fragt nach Eingabe oder Freigabe, meldet einen Blocker, ein Limit, einen bekannten offenen Pflichtschritt oder einen unklaren/teilweisen Abschluss.
- `fehlgeschlagen`: Der Turn oder ein maßgeblicher Pflichtcheck ist mit Fehler beendet.

`idle` oder `latestTurn.status: completed` allein nicht als sauberen Aufgabenabschluss behandeln. Die letzte Antwort auf Aussagen wie „blockiert“, „teilweise“, „noch offen“, „nicht verifiziert“, „brauche deine Entscheidung“, fehlgeschlagene Checks oder ausstehende Pflichtarbeit prüfen. Bei Zweifel `braucht Aufmerksamkeit` wählen.

Ein Limit nur dann als erreicht behandeln, wenn Codex oder der Task dies ausdrücklich im Status oder in der Antwort meldet. Keine verbleibenden Tokens oder Usage-Grenzen schätzen.

## 8. Standardaktion sicher ausführen

Im Standard nur fortfahren, wenn **alle** ausgewählten Tasks `sauber abgeschlossen` sind. Bei einer ausdrücklich konfigurierten Stop-Regel nur fortfahren, wenn jeder ausgewählte Task entweder `sauber abgeschlossen` oder regelkonform `absichtlich gestoppt` ist.

1. Einen knappen Abschlussstatus mit den Task-Namen ausgeben.
2. Sicherstellen, dass außer der weiterhin benötigten und scharfgestellten Arm-Session keine für diese Beobachtung selbst gestarteten Hilfsprozesse übrig sind.
3. Das Sleep-Gate erneut mit `--status` prüfen.
4. Den temporären Heartbeat löschen. Wenn das Löschen fehlschlägt, das Sleep-Gate abbrechen und nicht schlafen.
5. Nach dem Löschen mit `wait_threads` und `timeoutMs: 0` unmittelbar einen frischen Snapshot aller ausgewählten Ziele abrufen. Die zuletzt verarbeiteten Cursor mitsenden und jeden geänderten Eintrag auswerten.
6. Wenn ein Task wieder aktiv ist, Aufmerksamkeit benötigt oder nicht eindeutig terminal ist, einen neuen temporären Heartbeat mit derselben Konfiguration anlegen und dessen Identifier wieder in den Prompt schreiben. Wenn das nicht gelingt, das Sleep-Gate abbrechen und den Nutzer informieren.
7. Erst nach unverändert bestätigtem Endzustand und gelöschtem Heartbeat ankündigen, dass der Mac jetzt in den Ruhezustand versetzt wird.
8. Ohne weitere Zwischenarbeit `scripts/sleep_gate.sh --trigger <Zustandspfad>` ausführen. Wenn der Trigger-Aufruf fehlschlägt, den Helper mit `--cancel` beenden, Session-Ende und Cleanup bestätigen und den Nutzer informieren. Nach einem erfolgreichen Trigger keine neue Freigabe anfordern und keine weitere Arbeit beginnen.

Nur den Trigger als ausgelöst melden, nicht einen technisch noch nicht beobachtbaren Ruhezustand als erfolgreich behaupten. Auf anderen Betriebssystemen keinen Befehl raten, sondern die fehlende Implementierung melden.

Bei `braucht Aufmerksamkeit`, `fehlgeschlagen` oder unklarem Status standardmäßig **nicht** schlafen. Zuerst den temporären Heartbeat löschen und das Sleep-Gate abbrechen, danach den betroffenen Task und den Grund kompakt nennen und auf die Entscheidung des Nutzers warten.

## 9. Optionale Regeln sicher anwenden

Zusätzliche Trigger ergänzen den Standard und ersetzen ihn nur bei ausdrücklicher Formulierung.

### Gemeldetes Limit

Bei einer Regel wie `bei gemeldetem Limit stoppen und schlafen` nur auf ein ausdrücklich gemeldetes Limit reagieren. Den betroffenen Task ausschließlich mit einem echten Interrupt-, Cancel- oder Stop-Werkzeug beenden und den Stopp bestätigen.

Bei mehreren ausgewählten Tasks standardmäßig nur den betroffenen Task stoppen und die übrigen weiter beobachten. Erst schlafen, wenn jeder ausgewählte Task entweder `sauber abgeschlossen` oder gemäß der ausdrücklichen Regel `absichtlich gestoppt` ist. Alle noch arbeitenden Tasks nur dann gemeinsam stoppen, wenn der Nutzer ausdrücklich eine globale Regel wie `sobald einer das Limit erreicht, alle stoppen und schlafen` festgelegt hat.

### Frist oder Uhrzeit

Eine konkrete lokale Frist in der Zeitzone des Nutzers berücksichtigen. Das Heartbeat-Intervall so wählen, dass spätestens zur Frist geprüft wird. Keine sekundengenaue Ausführung versprechen; wenn die gewünschte Genauigkeit mit dem Intervall nicht erreichbar ist, vor Beginn darauf hinweisen.

### Stoppen

Stoppen ist destruktiver als Beobachten und benötigt eine ausdrückliche Anweisung. Nur ein dafür bestimmtes Task-Werkzeug verwenden.

- `send_message_to_thread` nicht als sofortigen Stopp darstellen.
- `handoff_thread`, Prozess-Kills oder Änderungen an lokalen Codex-Daten nicht als Ersatz verwenden.
- Einen fehlgeschlagenen oder unbestätigten Stop-Versuch als `braucht Aufmerksamkeit` behandeln und nicht schlafen.
- Wenn kein echtes Stop-Werkzeug verfügbar ist, die Stop-Regel nicht vortäuschen. Den Nutzer informieren und standardmäßig weder stoppen noch schlafen. Nur dann ohne vorherigen Stopp schlafen, wenn der Nutzer genau das ausdrücklich erlaubt hat.

## 10. Sicherheitsgrenzen

- Nur die ausgewählten Tasks beobachten oder beeinflussen.
- Keine Tasks archivieren, verschieben, löschen oder umbenennen.
- Außer dem beschriebenen temporären Heartbeat keine Codex-Automationen oder Codex-Tasks anlegen.
- Den temporären Heartbeat bei Abschluss, Aufmerksamkeit, Fehler oder Abbruch löschen.
- Außer der ausdrücklich beschriebenen Sleep-Gate-Session keine Hintergrundprozesse starten. Die Session bei jedem Pfad ohne Sleep abbrechen und ihr Ende bestätigen.
- Wenn der Nutzer die Beobachtung beendet, zuerst den Heartbeat über seinen gespeicherten Identifier löschen und anschließend das Sleep-Gate abbrechen und bereinigen.
- Den aufrufenden Monitor-Task niemals selbst beobachten oder stoppen.
- Nach einer geänderten Auswahl die Zielmenge und Regeln erneut kurz bestätigen.
