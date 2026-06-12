---
name: novari-frontend-performance-audit
description: Triage or improve perceived slowness in Novari Portal or LMS. Use for /Users/mrbubbles/dev/novari/novari-education-portal or /Users/mrbubbles/dev/novari/novari-education-lms performance investigations involving first-load latency, excessive auth checks, eager global providers, route data preloading, heavy editors/tables/sidebars, socket/devtools mounting, TanStack Query or Next.js cache behavior, and frontend performance follow-up plans.
---

# Novari Frontend Performance Audit

Use this skill for performance work in:

- `/Users/mrbubbles/dev/novari/novari-education-portal`
- `/Users/mrbubbles/dev/novari/novari-education-lms`

## Orient First

Read the relevant repo `AGENTS.md` and `package.json` before touching code. Then inspect the route, provider, layout, and data-loading path involved in the slowdown.

Also check existing local reports when present:

- Portal: `performance-findings.md`
- Portal: `performance-auth-request-report.md`
- Any docs/changelog entries related to auth, caching, route loading, dashboard, LMS, editor, or sidebar behavior

## Audit Workflow

1. Define the symptom precisely: route, role, browser state, first load vs interaction, dev vs production, and visible network/console symptoms.
2. Map the render/data path:
   - app/root layout and route layouts
   - auth/session checks
   - global providers
   - route-specific providers
   - visible panels, dialogs, editors, tables, sidebars, sockets, and devtools
3. Look for repeat offenders:
   - role-specific data loaded globally
   - queries without `enabled` guards
   - expected 401/403/404 responses being retried
   - duplicate `/auth/reauth` or session checks
   - full dataset fetches followed by client filtering
   - heavy optional dependencies mounted before visible
   - large generated DOM effects or resize-time rerender loops
   - provider layout drift that makes hooks run outside intended scope
4. Prefer small scoped fixes:
   - conditional mount or lazy-load heavy features
   - gate queries by auth, role, IDs, open dialogs, visible panels, and route params
   - move route-specific data out of global providers
   - add backend/BFF filters, limits, pagination, cache tags, or invalidation only where needed
   - preserve request IDs and user-facing error behavior

## Repo-Specific Guardrails

Portal:

- Vite/TanStack Router app.
- Run `npm run typecheck` and relevant lint/tests when feasible.
- Portal is the Novari design source of truth.
- Keep operational UI dense, mobile-first, and token-based.

LMS:

- Next.js app. Read relevant current Next docs from `node_modules/next/dist/docs/` before changing Next-specific APIs.
- Do not use `next-devtools` unless this is actually the Next.js LMS project and the tool is appropriate.
- Preserve light and dark mode.
- Follow request-scoped auth/session and Next cache rules from `AGENTS.md`.

## Evidence To Report

Finish with:

- root cause or strongest hypothesis
- exact files/functions involved
- change made or recommended
- commands run and results
- remaining uncertainty
- whether docs/changelog need updates

Do not present generic performance advice without tying it to the current route and code path.
