---
title: Novari Organization Label Defaults
description: You moved from per-repository GitHub labels into Novari organization repository-default labels. You created or copied PR-state labels across backend, portal, and organization defaults, then applied review labels on the portal PR.
applications: [com.google.Chrome, cc.ffitch.shottr, com.openai.codex]
---

## Memory summary

The user continued setting up PR-state labels for Novari Education GitHub work, moving from repository-specific labels into the organization-level repository defaults. They used the backend repository labels as the source for labels and copied them into the Novari organization default-label settings, then synced labels to the portal repository and applied review labels on portal PR #185. The user appeared to confirm that default labels can be configured organization-wide, but still also created labels directly in existing repositories where needed.

### Relevant prior context

The immediately preceding Skysight summary shows the user had just created and refined PR-state labels in `Novari-Education/novari-education-backend` and `Novari-Education/novari-education-portal`, including `[WIP]`, `Ready to Merge`, and `[in Agentic Review]`. A prior suggestion for turning the repository label setup process into a reusable skill was already recorded, so no duplicate suggestion is included here.

### Important non-obvious context about the user

`Novari-Education`: the user was using GitHub organization settings, specifically repository defaults, to define labels that should be included in new repositories.

`Novari-Education/novari-education-backend`: used as the source repository for copying existing PR-state label names, descriptions, and colors.

`Novari-Education/novari-education-portal`: existing repository where the user continued adding missing labels manually and applying them to PR #185.

`feat: promote portal logging, billing and account workflows`: portal PR #185 was opened and had review-state labels applied from the newly created label set.

GitHub label colors: the user repeatedly copied red `#b60205` and green `#85cb4f` from backend labels into organization/default or portal labels.

## Recording summary

### Organization-level label setup

The recording began on GitHub’s Labels page for `Novari-Education/novari-education-backend`, where the user saved or inspected an edited `Ready to Merge` label, including its green color value. They then opened the portal repository labels page and created a matching `Ready to Merge` label there, using copied name, description, and color values from the backend label.

The user opened a ChatGPT project conversation titled `Novari Education - Testfläche neu verdrahten` and typed a German question asking whether labels could be configured organization-wide or whether it had to be done per repository. After that, they navigated through GitHub organization settings for `Novari-Education`, moving from profile/security/code-quality areas into the `Repository` / `General` settings page where `Repository labels` and `New label` were visible.

On the organization repository-defaults page, the user created default PR-state labels by copying from the backend labels page. The observed sequence included copying `[WIP]`, its description, and red color `#b60205`, then creating the default label. They then copied `Ready to Merge`, its description, and green color `#85cb4f`, and created that label as an organization default.

The user also copied `[in Agentic Review]` from the backend repository into organization defaults, along with its description and red color. The organization repository-defaults page later showed 13 labels, including `[in Human Review]`, `[in Agentic Review]`, `Ready to Merge`, and `[WIP]`, indicating the default label set had expanded beyond GitHub’s standard labels.

### Human-review and blocked-work labels

The user created an organization default label named `[in Human Review]` and typed a short description indicating that a PR is under human review and should not be merged without the PR author’s approval. They selected a yellowish color value for that label and clicked the saving/create control.

Later, the user began creating another organization default label, iterating through drafts including `[DO NOT MERGE]` and `[not Ready to Merge]`, with a description indicating that the PR is still being worked on and should not be merged or auto-merged without author approval. They clicked `Create label`, then copied that label name and description into the portal repository labels page and created a matching portal label in red.

### Applying labels to the portal PR

The user opened the portal repository pull request list, selected `feat: promote portal logging, billing and account workflows`, and opened PR #185. They opened the PR label picker and selected review-state labels, including `[in Agentic Review]` and `[in Human Review]`, from the available labels. The exact final label combination on the PR was not fully visible, but the interaction shows the user was applying the newly standardized review-state labels to that portal PR.

### Side activity

Shottr briefly became active twice, and the Codex desktop app briefly appeared with a `Remove 39569.png` control, suggesting the user was handling or dismissing an image attachment. No durable screenshot path or image content was visible in the segment.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T17-20-00Z/events.jsonl
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-06T17-10-00-CMLB-10min-memory-summary.md