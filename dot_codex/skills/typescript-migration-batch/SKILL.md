---
name: typescript-migration-batch
description: Use when migrating JavaScript or @ts-nocheck TypeScript in scoped batches, especially behavior-preserving TypeScript migrations with explicit file ownership, parallel agents, or legacy folders such as ___typescript-version.
---

# TypeScript Migration Batch

## Overview

Use this skill for narrow, behavior-preserving TypeScript migration work: converting `.js` files to `.ts`, removing `@ts-nocheck`, migrating legacy helper/router/controller layers, or cleaning up partially converted batches.

The goal is not to redesign the code. The goal is to make the assigned slice type-safe while preserving runtime behavior and playing well with other concurrent workers.

## First Read

Before editing, read only the context needed to understand the batch:

- `AGENTS.md` and any repo-specific migration notes.
- `package.json`, `tsconfig*.json`, lint config, and test scripts.
- The exact assigned files and their nearest imports, tests, schemas, and callers.
- Existing migrated files in nearby folders to copy local typing style.
- Any migration scratch folder mentioned by the prompt, for example `___typescript-version`, `__gateway`, or generated adapter directories.

If the prompt names an exact write-scope, treat it as hard ownership. Do not edit outside it except for unavoidable import/type fixes that are necessary for the assigned files to compile, and call those out.

## Batch Workflow

1. Establish the current state.
   - Run `git status --short`.
   - Use `rg '@ts-nocheck|TODO|any|unknown|module.exports|require\\('` inside the assigned files or directory.
   - Identify the lowest-cost verification command before changing anything.

2. Map runtime contracts.
   - Trace exports/imports before renaming files or changing signatures.
   - For Express/Mongoose/backend code, preserve middleware order, response shapes, status codes, validation behavior, model names, and query semantics.
   - For tests, preserve fixture data and assertions unless the migration note explicitly asks for test repair.

3. Convert incrementally.
   - Rename only files in scope when needed.
   - Prefer local interfaces/types near the file when the type is not shared yet.
   - Reuse existing project types, DTOs, schemas, and helper signatures before introducing new ones.
   - Replace `require`/`module.exports` in the local project style; keep interop wrappers only where required by the existing module system.
   - Remove `@ts-nocheck` only after the file type-checks without weakening the contract.

4. Keep type fixes honest.
   - Avoid blanket `any`, double casts, non-null assertions, and `as unknown as` unless the legacy boundary truly cannot be typed inside the batch.
   - If a boundary is still unsafe, isolate it with a tiny typed adapter and a short comment explaining why.
   - Do not make runtime changes just to please TypeScript.

5. Verify the slice.
   - Run the smallest relevant command first: targeted test, `tsc --noEmit`, package typecheck, or lint for the touched area.
   - If the repo has known unrelated errors, capture the exact command and the first unrelated blocker.
   - Re-run `rg '@ts-nocheck'` for the assigned files before finishing.

## Parallel-Worker Rules

Many migration batches are split across agents. Follow these rules tightly:

- Never revert or reformat files outside your ownership.
- Before editing a file that changed since you read it, re-read it and merge with the current content.
- Avoid broad formatter runs unless the prompt explicitly asks for them.
- Keep import order and style consistent with nearby migrated files.
- Mention any out-of-scope compile errors separately from your own batch result.

## Novari Backend Notes

For `/Users/mrbubbles/dev/novari/novari-education-backend`, be especially conservative:

- `___typescript-version` is a migration staging area, not permission to refactor behavior.
- Treat `__gateway` imports, Express routers, controllers, Mongoose schemas, middleware, and exam/LMS helpers as behavior-sensitive.
- Do not change auth, role checks, validation, cookie/session semantics, deletion rules, or response payloads unless the prompt asks for that exact behavior change.
- When converting tests, keep the existing test intent and only type fixture/setup glue as needed.

## Output

End with:

- Files migrated or cleaned.
- `@ts-nocheck` removed or left, with reason.
- Verification commands and results.
- Any remaining type debt that is outside the assigned scope.
