---
title: Novari PR Label Sync
description: You continued standardizing GitHub PR-state labels across Novari repositories. You copied label names, descriptions, and colors from backend into LMS and website, while checking portal and backend PRs.
applications: [com.google.Chrome]
---

## Memory summary

The user continued synchronizing GitHub issue/PR labels across Novari Education repositories, using `Novari-Education/novari-education-backend` as the main source for PR-state label names, descriptions, and colors. They copied labels into `novari-education-lms` and later `novari-education-website`, while also checking open PR lists in `novari-education-portal` and `novari-education-backend`. By the end of the window, the website repository label creation was still in progress, with the user actively copying the `[in Human Review]` label content from backend into the website labels page.

### Relevant prior context

The immediately preceding summary shows the user had been creating and refining PR-state labels in `novari-education-backend`, `novari-education-portal`, and Novari organization repository defaults. The same prior summary noted that a reusable repository-label setup skill had already been suggested, so this window does not add a duplicate suggestion.

### Important non-obvious context about the user

`Novari-Education/novari-education-backend`: the user used this repository as the source of truth for copying label names, descriptions, and colors into other Novari repositories.

`Novari-Education/novari-education-lms`: the user created several missing PR-state labels here during this window.

`Novari-Education/novari-education-website`: the user started copying the same PR-state labels here near the end of the window; this was the active unfinished context at 17:40.

`Novari-Education/novari-education-portal`: the user revisited portal PR #185 and its labels while checking consistency with the new label set.

PR-state labels: the label set being synchronized included `Ready to Merge`, `[WIP]`, `[not Ready to Merge]`, `[in Agentic Review]`, and `[in Human Review]`.

Label colors: the user repeatedly reused green `#85cb4f` for `Ready to Merge` and red `#b60205` for several blocking or review-state labels.

## Recording summary

The window opened on GitHub’s Labels page for `Novari-Education/novari-education-portal`. The user selected and copied the text associated with `[not Ready to Merge]`, then switched to `novari-education-backend` and pasted into a label form. They returned to the portal labels page and saved changes to the `[not Ready to Merge]` label.

The user then copied `Ready to Merge` data from backend into portal or another target label form, including the green color `#85cb4f`. They briefly opened the portal PR list and selected PR #185, titled `feat: promote portal logging, billing and account workflows`, before navigating through the Novari organization repository list toward `novari-education-lms`.

In `novari-education-lms`, the user opened repository settings and labels, then began creating missing labels by copying from backend. The observed copied sequence included `Ready to Merge`, `[not Ready to Merge]`, `[in Agentic Review]`, `[WIP]`, and `[in Human Review]`, along with their descriptions and colors. The user used the GitHub `New label`, text fields, color picker/input, and `Create label` controls repeatedly.

The user checked `novari-education-backend` pull requests and opened or selected the PR titled `feat: promote logging, billing, and account workflows to main`. There was a pause of several minutes after this PR-list interaction, then the user moved to `novari-education-website`.

In `novari-education-website`, the user opened the labels page and started adding the same standardized PR-state labels. They copied `Ready to Merge` from backend and created it on the website repository. They then copied `[WIP]`, `[in Agentic Review]`, `[not Ready to Merge]`, and finally `[in Human Review]` from backend toward website. The final visible activity at 17:39:59 was still on the website labels page after copying `[in Human Review]` data from backend, so completion of that last label was not confirmed inside this window.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T17-30-00Z/events.jsonl
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T17-20-00-hqgL-10min-memory-summary.md