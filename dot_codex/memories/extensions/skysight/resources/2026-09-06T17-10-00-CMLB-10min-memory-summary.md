---
title: GitHub PR Label Setup
description: You worked in GitHub label settings for Novari repositories, creating and adjusting PR-state labels. You also consulted a ChatGPT project chat to refine short label descriptions and copied one label setup between backend and portal repositories.
applications: [com.google.Chrome, cc.ffitch.shottr]
suggestion:
  type: skill
  name: Repository label setup
  description: Turn my process for defining and syncing GitHub PR-state labels across repositories into a reusable setup skill.
---

## Memory summary

The user spent this window managing GitHub labels for `Novari-Education/novari-education-backend` and `Novari-Education/novari-education-portal`. The main task was defining PR-state labels, including `[WIP]`, `Ready to Merge`, and an in-review/agent-review label draft, with short descriptions indicating review or merge readiness. The user briefly used a ChatGPT project conversation titled `Novari Education - Testfläche neu verdrahten` to refine wording under GitHub’s label-description length constraint, then copied the finalized `[WIP]` description into both repositories.

### Relevant prior context

No relevant prior Skysight summaries were available under the local Skysight resources directory for this window.

### Important non-obvious context about the user

`Novari-Education/novari-education-backend` and `Novari-Education/novari-education-portal`: the user was aligning GitHub issue/PR label conventions across these repositories.

`[WIP]`: used as a PR-state label; by the end of the window it existed in both backend and portal label lists with a short merge-restriction-oriented description.

`Ready to Merge`: created in the backend repository as a PR-state label for merge-ready work.

`[in Agentic Review]`: drafted in the backend repository as a PR-state label for PRs under agentic review; the final save state was not clearly confirmed before the window ended.

`Novari Education - Testfläche neu verdrahten`: a ChatGPT project conversation used to refine concise GitHub label wording.

`cc.ffitch.shottr`: Shottr appeared briefly, likely as a transient screenshot/annotation tool, but the meaningful activity remained in Chrome.

## Recording summary

### GitHub label editing

The window began on GitHub’s Labels page for `Novari-Education/novari-education-backend`. The user filled out a new label form with name `[WIP]`, adjusted a longer description, switched to a ChatGPT conversation for wording help, then returned to GitHub and pasted a shortened description. The first paste still exceeded or otherwise did not fit the desired constraint, so the user consulted ChatGPT again about the 100-character limit and copied a shorter version. They then clicked `Create label`.

The user then created a backend label named `Ready to Merge` with a short description stating that a PR can be merged safely, and clicked `Create label`.

Next, the user opened another new label form in the backend repository and iterated over names including `[Waiting for Review]`, `[Review]`, and finally `[in Agentic Review]`. The description was edited several times toward wording that indicated the PR was under agent review and included merge-restriction semantics. The final visible backend state near the end showed an edit form for `[WIP]` with the finalized short description and red color `#b60205`; the user clicked `Save changes`.

### Cross-repository syncing

The user switched to a visible pull request tab titled `feat: promote portal logging, billing and account workflows...` in `Novari-Education/novari-education-portal`, opened labels, then navigated to the portal repository’s Labels page. They opened `New label`, copied the `[WIP]` name and description from the backend label form, pasted the same description into the portal form, and clicked `Create label`.

After creation, the portal labels page showed 11 active labels including `[WIP]`, confirming that the portal repository gained the new `[WIP]` label. The backend labels page showed active labels including `Ready to Merge` and `[WIP]`.

### Side activity

Shottr briefly became the active app around 17:11, showing its toolbar, then focus returned to Chrome. No durable Shottr artifact or screenshot path appeared in the event stream.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-06T17-10-00Z/events.jsonl