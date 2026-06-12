# Vite And SPA Review Reference

## Runtime Boundaries

- Confirm environment variables use the correct public prefix and do not expose secrets.
- Check base URLs, proxy assumptions, and deployment host differences.
- Confirm route guards handle refresh, direct deep links, and expired auth.

## Bundling

- Watch for heavy route-specific modules imported into global layout/provider code.
- Prefer lazy loading for role-specific dashboards, editors, charts, and devtools.
- Keep production-only code paths tested when local dev differs.

## UX

- SPAs need clear loading states for direct route loads and auth restoration.
- Avoid redirect loops during auth/bootstrap.

