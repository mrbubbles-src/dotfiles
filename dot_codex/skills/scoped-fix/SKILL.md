---
name: scoped-fix
description: Use when implementing a correction for a concrete bug, regression, failure, or existing behavior that violates its intended contract. Restore intended behavior while preserving unrelated behavior and UI. Do not use for a net-new capability, an intentional product behavior change, a general audit, or a refactor whose primary outcome is structural improvement. A deeper or multi-file root-cause repair remains a fix.
---

# Scoped Fix

Use the intended existing behavior or contract as the change boundary.

- Change only the actual cause and directly affected behavior.
- Preserve unrelated behavior, UI/UX, public and data contracts, and structure.
- Allow a deeper or multi-file correction when required by the root cause; keep it limited to the defect.
- Add or reshape implementation only when necessary for the correction. Exclude unrelated cleanup, redesign, generalization, and adjacent fixes.
