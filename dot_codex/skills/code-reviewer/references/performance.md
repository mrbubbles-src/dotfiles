# Performance Review Reference

## Frontend

- First load: look for heavy global imports, route-specific code in app shell, and provider overfetch.
- Data: avoid full-list fetches when the UI needs a narrow filter or page.
- Effects: avoid repeated fetch loops, duplicate auth checks, resize/render loops, and unbounded observers.
- Rendering: avoid unstable keys, excessive re-renders, huge DOM lists, and expensive synchronous work in render.
- Assets: verify lazy loading and cache headers for large images, charts, editors, and devtools.

## Backend

- Check indexes for new filters/sorts.
- Avoid N+1 queries and unbounded pagination.
- Make expensive exports/jobs bounded and observable.
- Do not retry expected 401/403/404 errors as transient failures.

## Reporting

- Prefer measured or strongly evidenced findings.
- Separate "likely performance issue" from "could optimize later".

