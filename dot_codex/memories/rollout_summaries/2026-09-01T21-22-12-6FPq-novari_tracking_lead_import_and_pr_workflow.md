thread_id: 01a05ed9-e2cb-7283-8699-3f22745a2e28
updated_at: 2026-09-06T18:45:43+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/09/01/rollout-2026-09-01T23-22-12-01a05ed9-e2cb-7283-8699-3f22745a2e28.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-website
git_branch: dev

# Novari website tracking, lead-import configuration, local Netlify development, and PR workflow documentation

Rollout context: Work occurred primarily in `/Users/mrbubbles/dev/novari/novari-education-website`, with read-only checks against the backend, portal, live site, Google documentation, and Netlify projects.

## Task 1: Audit Google Ads tracking and consent setup

Outcome: success

Preference signals:
- The user wanted a concrete explanation before making changes, including benefits, risks, and whether the setup was really necessary -> future investigations should inspect the repository and live setup first and avoid blindly applying vendor snippets.
- The user was concerned about consent, privacy, and whether tracking was actually blocked -> explain technical behavior and legal/consent implications separately, in plain language.

Key steps:
- Inspected `index.html`, `src/lib/analytics.ts`, `src/components/utility/cookie-notice.tsx`, event tracking, and the privacy page.
- Confirmed the site already dynamically loads GTM container `GTM-KD6H89C5`, with Consent Mode v2 defaults denied and separate analytics/advertising choices.
- Retrieved the published GTM configuration read-only and found GA4 measurement ID `G-DXYH3PRPYN`, existing events, but no concrete `AW-...` Google Ads ID or Ads conversion tag.
- Verified existing lead events: `course_inquiry_submit`, `consultation_request_submit`, `funding_check_complete`, `virtual_page_view`, CTA/contact/download events.
- Researched official Google guidance: the Google tag should not be duplicated; Ads and Analytics may share one tag/container; a tag alone is not sufficient without conversion events; basic Consent Mode blocks Google tags until consent, while advanced mode sends cookieless pings.

Failures and how to do differently:
- Do not paste Google’s suggested `<head>` snippet as a second tag. Add Ads destinations/conversion tags inside the existing GTM container and verify with Tag Assistant.
- Treat “active (misconfigured)” as likely missing or non-recording conversion signals, not necessarily as ads being completely stopped.
- Check browser blockers such as uBlock before diagnosing absent analytics traffic.

Reusable knowledge:
- The website is Vite/React with static prerendering, not Next.js. Shared `index.html` is present on generated pages.
- The current consent implementation is conservative/basic: Google tags are not loaded until at least one optional category is accepted; withdrawals clear known Google cookies and may reload the page.
- Primary Ads conversions should represent successful leads, especially `course_inquiry_submit` and `consultation_request_submit`; page views and preliminary checks should generally remain secondary.

References:
- `index.html:66-120` contains Consent Mode v2 and GTM loader.
- `src/lib/analytics.ts:123-161` updates consent and loads GTM.
- `src/components/utility/cookie-notice.tsx` separates Statistik and Marketing consent.
- Published container: `GTM-KD6H89C5`; discovered GA4 ID: `G-DXYH3PRPYN`.
- Official sources consulted: Google Ads tag setup, Google conversion tracking, Google Consent Mode, Google Tag Assistant, and German TDDDG §25.

## Task 2: Diagnose and restore Website → Netlify Function → Render backend → LMS lead import

Outcome: success

Preference signals:
- When the user challenged the initial explanation because Martin had previously seen real leads, the investigation was expanded instead of assuming isolated tests -> future agents should distinguish current configuration from historical production state and validate actual lead provenance.

Key steps:
- Inspected website function code, backend router/authentication, portal lead model, tests, git history, and Netlify environment metadata.
- Established the integration contract:
  - Website Function reads `LMS_API_BASE_URL` and `LMS_LEAD_IMPORT_TOKEN`.
  - It POSTs to `${LMS_API_BASE_URL}/integrations/lead-process/inquiries` with `Authorization: Bearer ...`.
  - Backend expects `LEAD_IMPORT_TOKEN` and protects `/integrations/lead-process/inquiries`.
- Found both current Netlify projects (`novari-education-website` and `novari-dev`) initially lacked the two LMS variables; only mail/Resend/hCaptcha variables existed.
- Explained why forms could still appear to work: the newer code catches LMS import failures and continues email delivery, so emails succeed while no portal lead is created.
- Identified historical ambiguity: real prior website leads would be distinguishable by `source` values `website-course-inquiry`/`website-consultation`, `inquiryChannel: website`, and a UUID `externalSubmissionId`; manual leads use `source: manual`.
- The user added the required variables, after which the lead import worked.

Failures and how to do differently:
- Do not infer end-to-end production success from unit tests. Existing tests validated payload mapping, schema validation, and backend admission, not live Netlify-to-Render connectivity.
- Do not expose or print token values. Only inspect variable names, scopes, and contexts.
- Keep email delivery independent from optional LMS mirroring; an LMS outage should not suppress notification mail.

Reusable knowledge:
- Production Netlify site: `novari-education-website`; development site: `novari-dev`.
- Production requires `LMS_API_BASE_URL` set to the backend’s base Render URL, not `/auth`, not the full integration path, and not `lms.novari.education`.
- Netlify Function secrets must be configured in Netlify environment variables with Functions scope and require a new deploy to take effect.
- Backend and website tokens must match; dev and production should use distinct tokens.
- The backend import is idempotent by submission UUID/email and preserves website consent values.

References:
- Website: `netlify/functions/_shared/lead-process-import.ts`.
- Backend: `router/leadProcessImportRouter.js`, `middleware/requireServiceBearerToken.js`, `controller/leadProcessInquiriesController.js`.
- Historical commits: website `220508f` introduced the integration; backend `e7c037c6` introduced the protected import route.
- Relevant errors/guards: `LMS lead import is not configured`, `LEAD_IMPORT_UNAUTHORIZED`.

## Task 3: Explain and configure local end-to-end development

Outcome: success

Key steps:
- Checked `package.json`, `netlify.toml`, `.env`, `.gitignore`, and installed tooling.
- Confirmed `npm run dev` only starts Vite; Netlify CLI and `@netlify/vite-plugin` were not installed.
- Recommended `netlify dev` for local Function execution and local redirects, with website `.env` pointing to the local backend and matching `LEAD_IMPORT_TOKEN` in the backend.

Reusable knowledge:
- Local flow should be: local website → local Netlify Function → `http://localhost:<backend-port>` → local backend/database.
- Use a separate local token and development database; never point local tests at production accidentally.
- Existing local `.env` contains mail credentials, so local form submissions may still send real email even when the lead is stored locally. Never commit `.env` or secrets.

References:
- `netlify.toml` defines `functions = "netlify/functions"` and `/api/send-*` redirects.
- Recommended command: `netlify dev` or `npx netlify-cli dev`.

## Task 4: Add PR label and merge authorization rules to Website AGENTS.md

Outcome: success

Key steps:
- Verified clean `dev` baseline and current `origin/dev` before each docs-only change.
- Added the centrally supplied PR workflow block exactly to `AGENTS.md`, repeatedly updated it as the user refined policy, and verified exact content with SHA-256.
- Final Website docs commit: `5e28e44c1124968dcd4116793d97b52becefdc9c`, parent/origin baseline `6b0d95af42b3a893326b6ea8443ce449cb564064`; worktree clean and commit not pushed in this rollout.
- Final rule hash: `e073a66e238505f526b9eeef736957419f5fc63e383f1e42873e2094dd440c20`.

Preference signals:
- The user repeatedly refined the PR policy and required exact propagation across repositories -> future docs changes should use the supplied canonical block verbatim, verify byte-level equality, and avoid paraphrasing.
- The user explicitly distinguishes readiness from authorization: `Ready to Merge` is only a status; a separate explicit merge instruction is required for `dev`; `main` must always be merged manually through the shared Novari account.

Reusable knowledge:
- Blocking labels are `[WIP]`, `[in Agentic Review]`, `[in Human Review]`, and `[not Ready to Merge]`; agents must not merge or enable auto-merge while any is present.
- Agents should proactively check available review results after substantial work blocks/pushes, associate findings with the reviewed commit, and continue independent authorized work while external reviews are pending.
- Agents must not set `Ready to Merge` autonomously during ongoing work or merely because checks are green; wait for a user-requested final readiness assessment.

References:
- `/Users/mrbubbles/dev/novari/novari-education-website/AGENTS.md`
- Canonical source: `/Users/mrbubbles/.codex/.chatgpt-projects/g-p-6a4586156fbc8191b6804e181eaa7edc/pr-review-blocks-20260906/PR-LABEL-RULE.md`
- Final commit: `5e28e44 docs: Add proactive PR review checks`.

