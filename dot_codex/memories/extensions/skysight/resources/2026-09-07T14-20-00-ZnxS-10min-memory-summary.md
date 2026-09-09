---
title: Novari production curriculum data inspection
description: You continued investigating a Novari Portal GitHub curriculum setup failure and moved from portal checks into MongoDB production data inspection. You also tried to reconnect MongoDB Atlas in ChatGPT/Codex after the agent reported disabled MCP access.
applications: [com.google.Chrome, com.openai.codex, com.apple.dock, com.mongodb.compass, in.sinew.Enpass-Desktop]
---

## Memory summary

The user continued the Novari Portal production issue around GitHub curriculum setup for “Fullstack Web Developer mit KI-Kompetenz.” They confirmed the connected curriculum repository state in the portal, briefly checked a security-maintenance page, then returned to the Codex task where the active agent needed production data access to diagnose the structure failure. The user tried to make MongoDB Atlas available through ChatGPT/Codex, then switched to MongoDB Compass and began querying the production `novari_nexus` database directly; the window ended while a structural projection query against a draft curriculum version was being submitted.

### Relevant prior context

The preceding summaries show this work came from a production GitHub setup failure in the Novari Portal. Render logs had shown HTTP 409 failures with `GITHUB_TOPIC_STRUCTURE_INVALID`, and the active Codex task had started debugging the backend/portal setup path on a fix branch. Earlier in the same sequence, the user created `Novari-Education/fullstack-web-ki_curriculum_backup_prod` from the `fullstack-web-ki_curriculum` template and confirmed the portal still showed `fullstack-web-ki_curriculum` as the connected repository.

### Important non-obvious context about the user

- `fullstack-web-ki_curriculum`: connected curriculum repository shown in the Novari Portal setup state for the Fullstack Web KI course.
- `GITHUB_TOPIC_STRUCTURE_INVALID`: production error being investigated from the previous window; this appears to be the reason the user moved into production data inspection.
- `novariEducationProdHorst`: MongoDB Compass production connection the user opened during this window.
- `novari_nexus`: MongoDB database selected in Compass for the production investigation.
- `curriculumTemplates`: Compass collection selected/search-filtered before opening the mongosh shell.
- `templateId:ObjectId("6a736c4c63f0d9aa00ecf576")`: template ID used to look up matching draft/active curriculum versions.
- `curriculumVersion ObjectId("6a736c4c63f0d9aa00ecf578")`: draft version returned by the first Compass shell query and used for the follow-up structure inspection.
- `portal.local.test:5173/teaching-plans?curriculumVersionId=6a6baf6f3842d03f6cbf7d03`: local portal URL visible in Chrome showed a connection-refused network error, suggesting the local dev server was not running for that page at that moment.

## Recording summary

### Portal and role context

- The window opened in Chrome on the Novari Portal curriculum program-type setup page. The visible course/program context was “Fullstack Web Developer mit KI-Kompetenz.”
- The setup state showed a GitHub connection for `fullstack-web-ki_curriculum`. The portal indicated the repository was connected, Markdown files still needed topic assignment, and the repository structure still needed to be accepted.
- The user opened the portal role switcher from a curriculum-oriented role and chose “Geschäftsführung.” The portal showed a confirmation dialog, then switched to the dashboard with the Geschäftsführung role visible in the navigation.
- The user navigated to the portal incidents/security area and opened the `Security-Wartung` tab. The visible maintenance scheduling state included a planned date and timeline-style status items, but no clear edit or completion action was captured.
- The user opened the role switcher again while on the security-maintenance page and then returned to Codex.

### Codex access troubleshooting

- In the ChatGPT/Codex desktop app, the active thread showed the agent had edited files and run commands for a “Logging fix” task, then reported that Render logs were available but the concrete structure cause required reading production data. The same visible agent status said the local DB did not contain the course type and MongoDB Atlas MCP access was disabled.
- The user typed a response indicating that MongoDB Atlas was connected and that the portal page in Chrome could also be used.
- The user asked why the access was disabled, noting that access had worked before.
- The user opened the Plugins area in ChatGPT/Codex and started the “Connect MongoDB Atlas” flow. A Chrome OAuth authorization window opened for MongoDB Atlas, then focus returned to Codex.
- The user then told the agent to try again, with the portal or MongoDB Compass as alternatives.

### Browser and local portal state

- Chrome briefly showed a local `portal.local.test` teaching-plans page with a network error. The visible message indicated the local site was not reachable because the connection was refused.
- The user switched back to the production Novari Portal dashboard afterward.
- Enpass appeared briefly and was closed or dismissed, with no durable task details captured.

### MongoDB Compass production inspection

- The user opened MongoDB Compass and connected to `novariEducationProdHorst`.
- In Compass, the user expanded the production connection and selected the `novari_nexus` database. The sidebar showed many collections, and the search/filter field contained `curriculumTemplates`.
- The user selected `novari_nexus.curriculumTemplates`, then opened the Compass mongosh shell for `novariEducationProdHorst`.
- In the shell, the user ran a query against `curriculumVersions` filtering by `templateId:ObjectId("6a736c4c63f0d9aa00ecf576")` and status in `active` or `draft`, projecting `_id`, `version`, and `status`. The visible result returned one draft version: `_id:ObjectId("6a736c4c63f0d9aa00ecf578")`, `version:"1.0"`, `status:"draft"`.
- The user then pasted and submitted a JavaScript IIFE that loads that curriculum version’s `modules` field and returns `moduleCount`, keys from the first module, and a nested structure of module order/slug, submodule order/slug, and topic `topicId`, `githubPathPosition`, and `orderIndex`. The recording ended before a visible result for that structural projection appeared.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T14-20-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-07T14-20-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T14-10-00-ASWq-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-07T14-00-00-asKp-10min-memory-summary.md