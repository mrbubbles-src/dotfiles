# General Code Review Reference

## High-Signal Review Questions

- Does the change satisfy the user-facing goal without changing unrelated behavior?
- Are API contracts, data shapes, and error semantics still aligned across callers?
- Could this fail only in production, SSR, mobile, slow networks, empty data, expired sessions, or permission-denied states?
- Are expected failures handled intentionally rather than logged or retried noisily?
- Are tests updated where behavior changed?
- Did the change introduce global state, hidden side effects, race conditions, or cleanup leaks?

## Evidence Standard

Report a finding only when one of these is true:

- The code path proves the bug.
- A test, build, typecheck, lint, or runtime check proves it.
- A documented API contract is violated.
- A plausible production path exists and the risk is material.

Avoid:

- "Maybe" style opinions without evidence.
- Formatting and naming nits unless they cause real ambiguity or violate explicit repo rules.
- Broad rewrites when a localized fix addresses the issue.

## Git Context

Useful commands:

```sh
git status --short
git branch --show-current
git rev-parse --short HEAD
git remote -v
git merge-base HEAD origin/main
git diff --stat
git diff --name-only
git diff main...HEAD
git log --oneline --decorate -20
```

Pick the base branch from repo context. If ambiguous, ask.

## Common Bugs

- stale closure or dependency omission
- off-by-one pagination
- client-only API used during SSR
- missing cleanup for timers, sockets, listeners, observers
- duplicate requests from unguarded effects
- filtering/sorting on display labels instead of stable IDs
- swallowing backend request/correlation IDs
- broad catches that hide failed writes
- optimistic UI without rollback
- incomplete enum handling
- unbounded loops, unbounded fetches, unbounded DOM lists

