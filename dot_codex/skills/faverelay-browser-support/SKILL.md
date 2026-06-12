---
name: faverelay-browser-support
description: Add, investigate, or QA browser/profile support in the local Faverelay macOS app. Use for tasks involving Faverelay profile discovery, bookmark readers/writers, Safari/Firefox/Chromium/Arc support, source-vs-target sync behavior, live matrix QA, backups, TCC/Full Disk Access, or safe bookmark sync validation.
---

# Faverelay Browser Support

Use this skill for `/Users/mrbubbles/dev/private/projects/faverelay` work that touches browser discovery, bookmark parsing, sync planning, sync writes, backups, runtime blocking, or browser-specific QA.

## Start Here

1. Read the local truth first:
   - `AGENTS.md`
   - `README.md`
   - `documentation/product-plan.md` when product scope matters
   - `documentation/manual-qa.md` when validating live behavior
   - `Package.swift` for available executables
2. Confirm the requested browser/profile is in scope. Passwords, autofill, cookies, history, tabs, settings, and extensions are out of scope unless the user explicitly changes product scope.
3. Classify the work:
   - Discovery only: browser kind, profile IDs, display names, paths.
   - Read support: parse bookmark/tree data without writing.
   - Write support: add missing bookmarks with backups and runtime blocking.
   - QA/recovery: preflight, doctor, live matrix, backups, restore.

## Safety Rules

- Never kill or quit user browser processes.
- Treat source profiles as read-only. A running source must not block sync by itself.
- Block writes per running target only; one running target must not block closed selected targets.
- Create backups before every live write or restore.
- Keep live QA scoped to synthetic bookmarks/folders whenever possible.
- After synthetic live QA, restore touched real browser data from backups or clearly report what remains.
- Do not treat Chromium `Bookmarks` success as Arc success; Arc user-facing saved items live in `StorableSidebar.json`.
- Treat Safari `Operation not permitted` as a likely TCC/Full Disk Access issue for the installed app bundle identity before blaming parser code.

## Browser Notes

- Chromium-family browsers use profile directories with Chrome-style `Bookmarks` files.
- Arc visible saved items require Arc-specific sidebar handling, not just Chromium bookmark files.
- Safari profiles share `~/Library/Safari/Bookmarks.plist`; profile names and Favorites folders may not match directly, so use Safari metadata and conservative fallbacks.
- Firefox profiles are discovered from `profiles.ini` and `Profiles/*/places.sqlite`; existing Places databases can be read/written while Firefox is closed, but the app should not create a fresh Firefox profile database.

## Implementation Workflow

1. Map existing architecture before editing:
   - `BrowserKind`, `BrowserProfile`, discovery services
   - core bookmark tree/read/write/plan/apply code
   - CLI/status/preflight/doctor paths
   - app UI preview/history/settings paths if behavior is user-facing
2. Add support in small layers:
   - identify browser kind and runtime bundle IDs
   - discover profiles with stable IDs and display names
   - implement read-only parsing
   - add plan/apply support only after read support is stable
   - add docs/changelog updates required by `AGENTS.md`
3. Keep target write behavior conservative:
   - detect real profile files
   - refuse live writes while the matching target browser is running
   - create backups before writes
   - verify planned additions after apply

## Validation

Run the narrowest checks that cover the change, and report exact gaps:

```sh
swift build -j 1
swift run -j 1 FaverelayParserTests
```

For sync behavior changes, prefer:

```sh
./script/build_and_run.sh --verify
./script/build_and_run.sh --verify-signature
```

For installed-app behavior or TCC-sensitive Safari work, package/install and test `/Applications/Faverelay.app` through LaunchServices. For broad browser/profile write changes, use the hidden live matrix QA only when real profile data is disposable and backups/restores are understood.
