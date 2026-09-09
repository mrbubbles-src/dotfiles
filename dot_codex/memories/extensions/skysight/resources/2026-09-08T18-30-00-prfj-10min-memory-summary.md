---
title: Novari GitHub CLI auth setup
description: You shifted from the Novari LMS login-loop triage into GitHub access setup for the Novari repositories. You checked GitHub account/settings context, completed a GitHub CLI browser authorization for the NovariEducation account, verified CLI auth state, and then switched the active CLI account back to mrbubbles-src.
applications: [com.openai.codex, com.google.Chrome, com.apple.dock, com.mitchellh.ghostty, com.logi.cp-dev-mgr, com.apple.LocalAuthentication.UIAgent]
---

## Memory summary

The user worked on GitHub setup after the prior Novari LMS production login-loop investigation. In Codex, they had a German chat titled `GitHub-Setup trotz Abweichungen` visible and an `Lms auth scout` subagent had finished. They moved between Codex, Chrome, and Ghostty while checking GitHub repository/account context and authorizing GitHub CLI access.

The key outcome was that `gh auth login --hostname github.com --web` completed for the `NovariEducation` GitHub account using HTTPS as the Git protocol. `gh auth status` then showed both `NovariEducation` and `mrbubbles-src` available in the keyring, with `NovariEducation` active at first. The user then ran `gh auth switch --hostname github.com --user mrbubbles-src`, and Ghostty showed the active GitHub CLI account was switched back to `mrbubbles-src`. One-time device codes and token details were visible in the recording but are intentionally not retained.

### Relevant prior context

The immediately preceding summary shows the user had reproduced and escalated a production Novari LMS redirect/login-loop problem as top priority. It also notes two lower-priority portal follow-ups: the oversized GitHub-check review-problem list UI and missing Shareholder/Geschäftsführer accounts in employee lists.

### Important non-obvious context about the user

- `~/dev/novari/novari-education-lms`: Ghostty’s top pane was in this repository during the GitHub setup, on branch `codex/setup-recovery-error-details`.
- `GitHub-Setup trotz Abweichungen`: active Codex chat/project thread visible during the workflow.
- `NovariEducation`: GitHub account authorized for GitHub CLI in this window.
- `mrbubbles-src`: existing GitHub CLI account in the keyring; the user switched the active CLI account back to this account after authorizing `NovariEducation`.
- `gh auth login --hostname github.com --web`: command the user used for browser-based GitHub CLI authorization.
- `gh auth switch --hostname github.com --user mrbubbles-src`: command observed switching the active CLI account back after setup.
- `LMS`, `BACKEND`, and `PORTAL`: Ghostty had three tabs with these labels, suggesting parallel local terminal contexts for the Novari repositories.

## Recording summary

### Codex And Project Context

- The window opened in the Codex desktop app. The sidebar showed several Novari Education projects: `novari-education-website`, `novari-education-lms`, `novari-education-portal`, and `novari-education-backend`.
- A Codex chat titled `GitHub-Setup trotz Abweichungen` was visible. The UI also showed `Lms auth scout` as finished and multiple other Novari-related scheduled or saved chats.
- The user opened the project actions menu for `assignments` and removed that project from the Codex app. The dialog text indicated this only removed the project from the app and did not delete files or existing chats.

### GitHub Browser Checks

- The user switched to Chrome on GitHub pull requests for `Novari-Education/novari-education-lms`.
- They opened GitHub account/profile settings and navigated to SSH/GPG settings. The exact page content is not retained, but this was part of checking GitHub account/access state.
- Later, Chrome showed the GitHub device activation flow. The user selected or continued with the `NovariEducation` account, entered a GitHub CLI device code, authorized GitHub CLI, and passed an additional confirmation/authentication prompt. Sensitive codes and authentication factors are omitted.

### Terminal Auth Work

- In Ghostty, the active window was titled `LMS`; it had a vertical split and tabs labeled `BACKEND`, `PORTAL`, and `LMS`.
- The top terminal pane showed `~/dev/novari/novari-education-lms` on branch `codex/setup-recovery-error-details`.
- The user first started `gh auth login --hostname github.com --web`, then canceled the initial device-flow attempt.
- They started `gh auth login --hostname github.com --web` again, chose HTTPS for Git operations, and completed browser authentication.
- Ghostty reported GitHub CLI authentication completed, configured Git protocol, and logged in as `NovariEducation`.
- The user ran `gh auth status`; Ghostty showed both `NovariEducation` and `mrbubbles-src` in the keyring. `NovariEducation` was active immediately after login.
- The user ran `gh auth switch --hostname github.com --user mrbubbles-src`; Ghostty showed the active account was switched back to `mrbubbles-src`.
- The last visible action was the user entering `gh auth status` again after the account switch; the final status output was not captured before the segment ended.
- Segment metadata reports 117 captured events and 9 suppressed events for this 10-minute window.

## Citations

- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T18-30-00Z/events.jsonl
- /Users/mrbubbles/Library/Group Containers/2DC432GLL2.com.openai.sky.CUAService/Library/Caches/ComputerUse/Skysight/segments/2026-09-08T18-30-00Z/metadata.json
- /Users/mrbubbles/.codex/memories/extensions/skysight/resources/2026-09-08T18-20-00-rpII-10min-memory-summary.md