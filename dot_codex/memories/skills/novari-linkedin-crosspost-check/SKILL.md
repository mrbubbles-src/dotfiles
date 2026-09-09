---
name: novari-linkedin-crosspost-check
description: Check Novari Education's LinkedIn company page in logged-in Chrome, decide whether there is a new genuine original company post, and only then prepare crosspost artifacts or Instagram draft state without publishing.
argument-hint: "[optional note]"
disable-model-invocation: true
user-invocable: false
allowed-tools:
  - Read
  - Grep
  - Bash
---

# When to use

Use for recurring Novari Education LinkedIn crosspost checks, especially when the task mentions `@chrome`, Profile 2, Instagram prep, or "only if there is a new original post".

Do not use for general LinkedIn browsing, public guest-mode checks, or workflows that are allowed to publish.

# Inputs / context to gather

1. Confirm whether the task is in the logged-in Chrome-plugin workflow.
2. Read the latest automation memory if present:
   `/Users/mrbubbles/.codex/automations/novari-linkedin-crosspost-check/memory.md`
3. Remember the durable defaults:
   - LinkedIn target: `https://www.linkedin.com/company/novari-education/`
   - Admin verification surface: `https://www.linkedin.com/company/108073781/admin/page-posts/published/`
   - Instagram target profile/account: Profile 2 / `Novari Education` / `@novarieducation`
   - Instagram defaults: size `Original`, no filter, location `Köln, Germany`, add alt text
   - Never click publish/share; keep X as report-only if browser policy blocks it

# Procedure

1. Open LinkedIn in the logged-in Chrome context, not guest/public mode.
2. Navigate proactively to the company page and then to the admin published-posts view if needed.
3. Classify strictly:
   - Count only company-authored original posts.
   - Ignore comments, reposts, shared third-party posts, and interactions.
4. If there is no new original post since the last successful check:
   - Report that briefly.
   - Update memory if part of the automation workflow.
   - Stop. Do not generate crosspost drafts.
5. If there is a new original post:
   - Capture the LinkedIn link and full post text.
   - If media is needed and the feed only shows a preview, open the larger image viewer first.
   - Record which actual media variant loaded.
   - Prepare:
     - X draft under 280 characters with final count.
     - Instagram caption under 2200 characters with final count.
     - Media notes.
     - Brief justification that the post is an original company post.
6. If Instagram staging is requested and media is available:
   - Use Profile 2 / `Novari Education`.
   - Apply `Original`, no filter, location `Köln, Germany`, alt text.
   - Stop at the final pre-publish screen.
7. If X is blocked by security policy:
   - Do not attempt a workaround.
   - Include only the text draft in the report.

# Efficiency plan

1. Check the admin published-posts view first; it is the authoritative surface and avoids wasting time on noisy public/engagement views.
2. Reuse the existing automation memory for the last-successful-check anchor.
3. Stop immediately after the no-new-post decision when applicable.
4. Do not attempt X/browser policy workarounds.

# Pitfalls and fixes

- Symptom: writes target `/automations` and fail.
  Likely cause: `$CODEX_HOME` is unset.
  Fix: use `/Users/mrbubbles/.codex/...` explicitly.

- Symptom: no new original post.
  Likely cause: there simply is no qualifying company-authored new post.
  Fix: report briefly and stop; do not generate drafts.

# Verification checklist

- Confirm the run used logged-in Chrome, not guest mode.
- Confirm only genuine company-authored original posts were counted.
- If media was used, confirm the larger viewer/full asset was inspected rather than only the feed preview.
- If Instagram was staged, confirm Profile 2 / `Novari Education` was used and the flow stopped before publish.
- If X was blocked, confirm no workaround attempt was made.
