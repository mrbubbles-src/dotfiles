# Next.js Review Reference

## Routing And Rendering

- Check server/client boundaries and `"use client"` placement.
- Avoid client-only APIs in Server Components.
- Avoid leaking secrets into client bundles.
- Confirm dynamic/static rendering assumptions.
- Check route handlers for auth, validation, and cache headers.

## Data And Caching

- Make cache behavior explicit for sensitive or personalized data.
- Watch for stale revalidation settings on auth-dependent content.
- Avoid broad prefetch or global fetches that hurt first load.

## Verification

- Prefer official Next.js docs or Context7 for version-specific behavior.
- For runtime page issues, use browser verification when possible.

