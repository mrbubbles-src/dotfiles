# Security Review Reference

## Trust Boundaries

- Identify untrusted input: request bodies, query params, headers, files, URLs, rich text, AI output, webhooks, local storage, cookies.
- Validate before persistence and before privileged actions.
- Keep authorization checks close to resource access.
- Check object-level authorization, not just route-level role checks.

## Web Security

- CSRF and cookie settings for state-changing requests.
- XSS through HTML/Markdown/rich text, unsafe URLs, script injection, or dangerously-set inner HTML.
- Open redirects and unsafe return URLs.
- SSRF/file path traversal through URLs, filenames, archives, or storage keys.
- Sensitive data in logs, browser console, errors, analytics, cache, or client bundles.

## Secrets And Auth

- Do not expose tokens, cookies, private keys, service credentials, or PII.
- Preserve request IDs without dumping raw payloads.
- Expected auth denials should be handled quietly; real failures should be traceable.

## Reporting

- Security findings should state attacker capability, impacted asset, reachable path, and smallest fix.

