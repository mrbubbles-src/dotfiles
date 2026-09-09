---
name: scoped-feature
description: Use when implementing a net-new capability or an intentional change to observable product behavior, including a UI, workflow, API, integration, or supported use case. Keep the change within the requested capability while preserving unrelated behavior and UI. Do not use when only restoring an intended existing contract or only restructuring internals while observable behavior should remain unchanged.
---

# Scoped Feature

Use the approved capability and acceptance criteria as the change boundary.

- Add or change only the behavior and contracts necessary for the requested capability.
- Allow new UI, components, APIs, state, dependencies, or abstractions when the capability genuinely requires them; prefer adequate existing project primitives.
- Preserve adjacent behavior, UI/UX, contracts, and structure.
- Exclude unrelated redesign, cleanup, modernization, and framework-level generalization.
