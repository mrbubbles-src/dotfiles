# Codex archive memory audit additions

## Yoink continuity and identity protection

- `/Users/mrbubbles/dev/private/projects/yoink` is a private, local-first macOS media-archive app. Continue from the current repository and its repo-local handoffs rather than old chat history.
- The latest verified continuation anchor from the archived threads is `docs/codex-handoffs/2026-06-20-yoink-media-extraction-continuation.md`; verify the current repo before reuse because the handoff snapshot was `main` at `0ee30204`.
- Yoink identity is deliberately protected: before media-extraction work, verify `dist/Yoink.app` remains `Identifier=private.local.yoink`, `Signature=adhoc`, `TeamIdentifier=not set`. Do not package, rebuild, resign, notarize, or change bundle identity without explicit user approval. Existing-bundle app smokes must use isolated support/download roots, stop the exact Yoink process, and recheck identity afterward.
- The archived snapshot removed an incomplete Sweet-Jenna fixture before handoff. The next proposed slice was the eight-image Threads WebP carousel, but treat the current repo/handoff as authoritative and report drift before editing.

Sources: archived threads `019edc12-9f2b-7b33-b2ac-15610e97dac2`, `019e736b-26b0-78f2-940f-58a15862067c`, `019ec8c9-c9a4-7e02-bc25-0364dd9122da`, `019eb819-1aea-71c3-95ca-07c01785f51d`.

## Faverelay Safari profile contract

- Faverelay Safari profiles come from `SafariTabs.db`; normal Safari bookmark folders are not separate browser profiles. The verified visible profiles were Personal and Work, while folder-derived entries such as Novari/AI were invalid and removed.
- Open `SafariTabs.db` through the existing immutable read-only SQLite path so Safari WAL behavior does not require broad or stale grants. Preserve the specific file-grant contract and fail closed on unusable discovery.
- This is also documented in `documentation/browser-adapters.md` and `CHANGELOG.md`; those current repo files remain authoritative.

Source: archived thread `019ed7e5-b38b-7630-8b05-63362fa222f0`.

## Codex cleanup protection boundary

- During Codex cleanup, never delete `/Users/mrbubbles/Documents/Codex/2026-05-21/files-mentioned-by-the-user-4fde6af8` (Nova-Pet) or `/Users/mrbubbles/Documents/Codex/2026-07-25/wir` (Lio/Mika/Ember sprites, animations, outputs, and working assets) without a new explicit user decision.
- Preserve Codex Memories and generated images. The small attachment store should also be preserved by default; reassess only after associated archived tasks have been deleted through the app and orphan status can be verified.

Source: explicit user decisions during the 2026-08-15/16 Codex archive cleanup audit.
