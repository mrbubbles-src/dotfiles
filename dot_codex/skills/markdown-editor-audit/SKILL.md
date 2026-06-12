---
name: markdown-editor-audit
description: Use when auditing, hardening, styling, or integrating Markdown, MDX, Editor.js, or Markdown editor/renderer packages, especially when comparing findings against an existing implementation before changing code.
---

# Markdown Editor Audit

## Overview

Use this skill for source-aware Markdown/MDX/editor work: reviewing package choices, validating hardening plans, aligning renderer/editor styling, checking import/export flows, or deciding whether review findings are real.

The output should separate confirmed issues from harmless differences, then either produce a focused implementation or a concise plan with evidence.

## First Read

Start from the local system, not generic Markdown advice:

- `AGENTS.md`, project docs, and any named review or hardening file.
- `package.json` and lockfile entries for Markdown, MDX, sanitization, syntax highlighting, Editor.js, upload, and schema packages.
- Renderer/editor entry points such as `mdx-components.tsx`, Markdown preview components, Editor.js tool config, import/export handlers, and shared design-system components.
- Existing tests, fixtures, stories, screenshots, or reference apps.
- Current docs for third-party packages only when behavior/version details matter; use primary docs or context7 documentation lookup when available.

## Audit Workflow

1. Identify the surface.
   - Is this renderer-only, editor-only, import/export, preview sync, package selection, security hardening, or styling parity?
   - List the user-facing entry points and data flow from raw input to persisted content to rendered output.

2. Trace trust boundaries.
   - Mark where untrusted Markdown, HTML, MDX, JSON, files, links, images, or Editor.js blocks enter the app.
   - Check sanitization, schema validation, upload restrictions, URL handling, escaping, and server/client rendering differences.
   - For MDX, treat executable code paths as high-risk unless the repo explicitly constrains authoring to trusted users.

3. Compare findings to code.
   - Confirm each review finding against the current implementation before accepting it.
   - Classify findings as confirmed, already handled, non-issue, unclear, or outside scope.
   - Prefer small fixes at the boundary where data enters, normalizes, or renders.

4. Preserve authoring ergonomics.
   - Keep preview behavior, scroll sync, keyboard input, focus handling, image behavior, code blocks, tables, lists, and empty states usable.
   - Align styling with the nearest existing content surface before inventing new prose styles.
   - Avoid local font-size overrides when the app already has global Markdown or design-system typography.

5. Verify with realistic content.
   - Use a sample that covers headings, paragraphs, nested lists, links, images, blockquotes, code, tables, long text, empty content, and unsafe HTML/script-like input.
   - Run targeted tests, lint/typecheck, or a local browser check depending on the change.
   - When the user explicitly says Browser or in-app browser, use the Browser plugin.

## Implementation Rules

- Keep package changes minimal and justify each dependency add/remove.
- Do not replace the editor/renderer stack unless the audit proves the current one cannot meet the requirement safely.
- Keep persisted content shape compatible unless a migration is explicitly requested.
- If sanitization is added, document what is allowed and denied near the boundary.
- For UI changes, verify desktop and mobile layouts and avoid one-off CSS that fights the shared Markdown surface.

## Common Findings To Check

- Raw HTML or MDX execution exposed to untrusted authors.
- Link targets without URL validation or safe external-link attributes.
- Image/file imports with missing MIME, size, extension, or storage checks.
- Editor.js tools accepting arbitrary embeds, HTML, or unvalidated block payloads.
- Preview rendering diverging from persisted rendering.
- Scroll sync that assumes equal block heights or misses images/code expansion.
- Duplicate styling between portal, LMS, reference apps, and package-level components.

## Output

For an audit, finish with:

- Confirmed findings with source paths.
- Findings dismissed and why.
- Recommended smallest fix or implementation summary.
- Verification performed or the exact blocker.

For an implementation, finish with:

- Changed files.
- Security/styling behavior changed.
- Tests/browser checks run.
- Remaining risks or follow-up that needs product input.
