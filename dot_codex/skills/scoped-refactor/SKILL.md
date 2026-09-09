---
name: scoped-refactor
description: Use when implementing an explicitly requested internal restructuring, extraction, consolidation, migration, or replacement whose primary outcome is structural improvement while specified external behavior remains invariant. Keep the change within the agreed structural boundary and compatibility constraints. Do not use merely because a fix or feature requires several files or a deeper internal change.
---

# Scoped Refactor

Use the approved structural goal and affected area as the change boundary.

- Permit substantial internal restructuring within that boundary.
- Identify and preserve the external and user-facing behavior, UI/UX, APIs, data contracts, permissions, and persistence compatibility that must remain invariant.
- Treat any intended change to those invariants as an explicit part of the approved boundary, not an incidental result of restructuring.
- Exclude neighboring systems, unrelated redesign, and adjacent refactor opportunities.
