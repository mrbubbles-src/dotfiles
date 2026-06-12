# Novari Review Reference

Use for Novari repositories or when repo instructions mention Novari.

## Portal UI

- Preserve the current portal design as source of truth.
- Keep interfaces dense, operational, mobile-first, and dark-mode safe.
- Reuse established components/utilities such as `Container`, `StyledPanel`, `glass-card`, `text-text-*`, `surface-*`, `border-*`, compact headers, and existing skeleton patterns.
- Do not create unnecessary wrapper `<div>` elements.
- Do not blame or remove `touch-hitbox`.
- Loading skeletons must live in separate files when new skeletons are added.
- Do not add marketing-style hero sections or unrelated palettes to product UI.
- Icon-only buttons need `aria-label`.
- Check text overflow/overlap on mobile.

## Performance Guardrails

- Do not preload role-specific, route-specific, editor, dashboard, or LMS data from global providers unless the current user and route need it.
- Gate TanStack Query reads with `enabled` when they depend on auth, permissions, selected IDs, open dialogs, visible panels, or route params.
- Expected 401/403/404 responses are not transient failures and should not retry.
- Keep heavy optional dependencies lazy and mounted only when relevant.
- Backend dashboard list endpoints should support narrow filters and limits.

## Error Handling

- Preserve backend `requestId` values from response bodies or `X-Request-Id` headers.
- Real backend failures must show user-facing error UI/toasts with reference IDs when available.
- Backend error toasts stay open until dismissed and include copy action when a request ID exists.
- Do not log raw backend payloads, tokens, cookies, headers, or PII to browser console.
- Prefer `/security-events` for internal support/debug flows when backend audit data is available.

## TypeScript And Docs

- Avoid `any`, `unknown`, and `never` unless there is no better option.
- Add concise JSDoc for new functions/components where repo instructions require it.
- Update relevant docs, README, and CHANGELOG when behavior, routes, reusable patterns, or developer-facing contracts change.

## Checks

- Run `npm run typecheck` when checking errors and report errors exactly.
- Run `npm run lint`; fix relevant lint issues and report unrelated existing failures separately.
- Run relevant tests when functionality changes.

