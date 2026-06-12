---
name: yoink-sidecar-explorer
description: Read-only sidecar investigation for the local Yoink macOS app. Use when searching for Yoink feature gaps, extraction/readiness risks, bookmark-import test samples, local-only social URL fixture gaps, rate-limit/session/download safety issues, or the next small product-relevant patch in /Users/mrbubbles/dev/private/projects/yoink.
---

# Yoink Sidecar Explorer

Use this skill for read-only discovery in `/Users/mrbubbles/dev/private/projects/yoink`. The output should help choose the next small, testable Yoink patch without editing files.

## Scope

This skill covers:

- feature-gap and readiness sweeps for Yoink as a private local macOS social-media archive app
- public HTML/JSON media extraction gaps for Instagram, X/Twitter, Threads, Reddit, and Facebook
- local bookmark HTML analysis and representative URL/test fixture selection
- rate-limit, session, download, queue, persistence, recovery, Clop, and no-bypass safety checks
- doc-vs-code drift when it affects the next implementation step

Do not use this as the primary workflow for building, signing, packaging, or debugging macOS launch failures. Use the Build macOS Apps skills for that, especially `build-run-debug`, `signing-entitlements`, and `packaging-notarization`.

## Source Order

1. Read `AGENTS.md`.
2. Read current product context:
   - `README.md`
   - `documentation/current-state.md`
   - `documentation/product-spec.md`
   - `documentation/roadmap.md`
3. Inspect only the relevant Swift files, tests, and docs for the requested focus.
4. If a local bookmark file is provided, parse it locally only. Do not make platform requests.

## Investigation Modes

Choose the narrowest mode that matches the request.

### Gap Sweep

Use for "next gap", readiness, or product-finishedness requests.

Check code and docs for small, product-relevant gaps in:

- Inbox, Gallery, Queue, Settings, selection, and status/error states
- bookmark import and URL classification
- extraction pipeline and media candidate ranking
- 99-item download batching, persistence, reload, recovery, and cleanup
- rate-limit pacing, budgets, cooldowns, local WebKit session use, and safe request boundaries
- documentation that promises behavior not backed by code/tests

### Public Extraction Check

Use for public HTML/JSON/media extractor questions.

Prefer local, testable cases involving:

- `HTMLMediaExtractor`
- `EmbeddedJSONMediaExtractor`
- `MediaExtractionService`
- `LinkClassifier`
- existing `YoinkCoreTests` or focused extractor tests

Look for alias, field, URL-shape, container, dedupe, ranking, and fixture gaps. Avoid login automation, private APIs, bypass behavior, or live network assumptions.

### Bookmark Sample Analysis

Use for local bookmark exports such as Netscape Bookmark HTML.

Parse HREFs robustly, including HTML entities. Classify by platform and URL shape:

- Instagram post/reel/profile/story/media-tab/shortcode variants
- X/Twitter status/media/profile/share/noisy-query variants
- Threads post/profile/xmt/slof variants
- Reddit post/media/gallery/CDN-like shapes
- Facebook photo/video/post/profile variants
- malformed, tracking-heavy, encoded, mobile, redirect, duplicate, or sanitized variants

Return a compact sample of representative URLs for tests or small probes. Do not publish full personal URL dumps unless explicitly requested.

## Safety Rules

- Default to read-only. Do not edit, commit, push, or reset.
- Do not start live platform requests, extraction runs, or downloads unless the user explicitly asks for a live test.
- Do not recommend bypassing private APIs, login automation, scraping walls, or aggressive request behavior.
- Keep local absolute paths out of durable documentation recommendations unless the user asks for local-only notes.
- Respect uncommitted changes: inspect them if relevant, but never revert or overwrite them.
- Keep helper files temporary and outside app source unless the user explicitly allows writing a local report.

## Output

For investigations, return:

- 2-5 prioritized findings or candidate gaps
- exact files, symbols, and tests involved
- why each gap matters for Yoink's product goal
- a minimal test idea or fixture for each actionable gap
- risks and "do not do" boundaries
- one recommended next small patch when the evidence supports it

For code-review style requests, lead with concrete findings and line references. If no issue is found, say so clearly and name the remaining risk.
