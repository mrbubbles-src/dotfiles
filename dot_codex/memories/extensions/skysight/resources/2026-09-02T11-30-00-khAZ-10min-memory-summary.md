---
title: Novari Website Lead Flow QA
description: You tested Novari website lead and advisor flows in Chrome after reviewing a Codex thread about Google Ads conversion tracking. You avoided relying on a fake lead submission and instead checked form behavior, CAPTCHA flow, advisor navigation, download, and external browser handoff.
applications: [cc.ffitch.shottr, com.apple.dock, com.apple.finder, com.google.Chrome, com.microsoft.edgemac, com.openai.codex]
suggestion:
  type: skill
  name: Novari lead-flow QA
  description: Turn my Novari website lead-flow checks into a reusable QA skill for forms, tracking-risk notes, downloads, and external handoffs.
---

## Memory summary

The user moved from incidental file/download handling into Novari website QA and Ads-conversion follow-up. The active work centered on checking Novari lead-entry paths in Chrome: a consultation/contact path, the funding-check form, CAPTCHA behavior, advisor-page links, an information-download button, and a participant-referral/external-browser handoff. A visible Codex conversation for `novari-education-website` / `Google Tag für Ads prüfen` showed an earlier decision to leave the Ads/conversion setup unchanged and wait for the first real inquiry instead of creating a fake lead that could pollute operational data or analytics.

### Relevant prior context

Earlier Skysight summaries show the user had already been coordinating Novari website Ads/GTM conversion verification. The relevant prior state was that the website tracking setup had enough confirmed signals to leave unchanged, with follow-up deferred until a genuine inquiry occurs and the Ads status can update.

### Important non-obvious context about the user

`Google Tag für Ads prüfen` - active Codex thread under `novari-education-website`; it framed the current browser testing around Ads/conversion confidence and whether to avoid fake submissions.

`novari-education-website` - Codex project visible and selected during the window; likely the relevant project for follow-up website QA or tracking questions.

`Förderung für IT-Weiterbildung prüfen | Novari Education` - Chrome page title for the funding-check flow the user exercised.

`Informationen für Berater und Jobcoaches | Novari Education` - Chrome page title for the advisor/jobcoach page the user checked near the end of the window.

`Shottr` - used twice around the website checks, suggesting the user captured visual evidence during the flow, but no saved screenshot path was visible.

`Microsoft Edge` - opened from a Novari website action near the end, likely indicating an external-browser handoff from a button/link.

## Recording summary

### Download And Finder Activity

- At the beginning of the window, Chrome showed a save dialog from a video-downloader tab with the save location set to Downloads.
- The user switched briefly to ChatGPT/Codex, then Finder, selected Downloads, clicked a newly downloaded MP4 file, and opened a Finder preview/overview.
- This looked incidental to the later Novari work; no durable development or operational decision was visible from the video-download activity.

### Codex Ads/Conversion Context

- The user switched back to ChatGPT/Codex, where the sidebar included the Novari Education project group and `novari-education-website`.
- The visible active thread was `Google Tag für Ads prüfen`. The visible conversation state said the safer decision was to wait for a real inquiry rather than submit a fake test lead, because a fake request could affect real inquiries, analytics events, or downstream workflows.
- The same visible Codex context summarized that the general Ads tag was live, the successful-form trigger was aligned, the conversion tag was assigned correctly, and Google Ads had already recognized the general tag. This was presented as the reason for leaving the setup unchanged for now.

### Novari Website Form And CAPTCHA Testing

- In Chrome, the user opened the Novari site and clicked a consultation/request call-to-action.
- The user interacted with a form and CAPTCHA flow, including a visual CAPTCHA challenge, next-challenge control, answer-check control, and send/request action.
- The user then navigated into the funding-check form and selected several dropdown values while testing the flow: employment/status, likely funding provider, funding status, desired start timing, and prior-knowledge chips.
- After toggling the consultation-request option in that flow, the user entered form text that was suppressed in the event stream and then attempted another CAPTCHA and submit action. The actual submitted text and whether a real request was accepted are not established safely by the events.

### Advisor Page And Link Checks

- After the funding-check interaction, the user clicked through navigation items for course inquiry, funding voucher, Reha/LTA, eligibility check, course inquiry start, and advisor content.
- On the advisor/jobcoach page, the user clicked an email/contact link and later returned to the same page.
- The user clicked an information-folder/download button twice; a macOS save dialog appeared, then Chrome returned to the advisor page. The recording does not establish that a file was successfully saved.
- The user clicked a participant-referral button several times. Microsoft Edge opened to a new tab afterward, suggesting the referral action may hand off externally or trigger a browser/app transition.
- The window ended with focus on ChatGPT/Codex and then Microsoft Edge’s new tab page.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-02T11-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-02T11-30-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-02T00-00-00-mudS-10min-memory-summary.md
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-02T00-10-00-DmoI-10min-memory-summary.md