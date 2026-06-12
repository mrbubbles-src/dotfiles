# React Review Reference

## State And Effects

- Effects should be gated by real prerequisites.
- Avoid setting state after unmount or after stale async responses.
- Check dependency arrays for stale closures and accidental loops.
- Avoid derived state when `useMemo` or direct derivation is enough.
- Clean up subscriptions, event listeners, observers, sockets, and timers.

## Data Fetching

- Queries depending on auth, route params, selected IDs, open dialogs, or permissions should use `enabled` or equivalent gates.
- Expected 401/403/404 responses should not retry or create global noise.
- Keep cache keys stable and complete.
- Avoid global providers fetching role-specific or route-specific data.

## UI

- Loading states should match the surface.
- Empty/error states should be user-facing and actionable.
- Buttons with icon-only content need accessible names.
- Text should not overflow or overlap on mobile.
- Avoid nested card shells unless the design system expects them.

