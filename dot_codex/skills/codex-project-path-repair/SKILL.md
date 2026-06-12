---
name: codex-project-path-repair
description: Repair local Codex project state after a workspace folder was moved or renamed, especially when project chats disappear from the sidebar, old cwd paths remain in ~/.codex, session_index.jsonl is stale, or a faverelay-style path migration script is needed. Use for diagnosing and generating safe backup-first scripts for ~/.codex/config.toml, .codex-global-state.json, state_5.sqlite, session_index.jsonl, rollout files, zoxide entries, and the edge case where threads exist but the sidebar shows "No chats".
---

# Codex Project Path Repair

Use this skill when a local Codex project was moved or renamed and its chats no longer appear, appear under the wrong project, or contain stale `cwd` paths.

## Workflow

1. Diagnose before editing:
   - Confirm old and new absolute project paths.
   - Verify the new path exists.
   - Query `~/.codex/state_5.sqlite` for matching threads.
   - Inspect `~/.codex/session_index.jsonl` and `~/.codex/.codex-global-state.json`.
   - Use `codex_app.list_threads` when available to compare what the app can see with what the sidebar shows.

2. Generate a repair script with `scripts/make_project_path_repair.py`.

3. Tell the user to quit Codex fully with Cmd-Q before running the generated script.

4. Run or ask the user to run the generated script. It must:
   - Refuse while Codex is running.
   - Back up every touched file.
   - Replace old path references in primary Codex state.
   - Update `threads.cwd` in SQLite.
   - Patch rollout files that contain the old path.
   - Add `thread-workspace-root-hints` for active threads.
   - Ensure the new path is present in saved/project root lists.
   - Update zoxide if available.

5. Restart Codex and check the project sidebar.

6. If the app API can find/read the threads but the sidebar still says `No chats`, handle the sidebar materialization edge case:
   - Prefer reading `references/sidebar-edgecase.md` first.
   - Run the generated script again with `--refresh-sidebar-index`.
   - Explain that this may make sidebar timestamps look current even though chat contents are unchanged.

## Script Generator

Use:

```bash
python3 /Users/mrbubbles/.codex/skills/codex-project-path-repair/scripts/make_project_path_repair.py \
  --name bubbles-verse \
  --old /Users/mrbubbles/dev/bubbles-verse \
  --new /Users/mrbubbles/dev/private/projects/bubbles-verse \
  --output /Users/mrbubbles/.codex/fix-bubbles-verse-environment-path.sh
```

For the sidebar-only edge case:

```bash
python3 /Users/mrbubbles/.codex/skills/codex-project-path-repair/scripts/make_project_path_repair.py \
  --name bubbles-verse \
  --old /Users/mrbubbles/dev/bubbles-verse \
  --new /Users/mrbubbles/dev/private/projects/bubbles-verse \
  --output /Users/mrbubbles/.codex/fix-bubbles-verse-environment-path.sh \
  --refresh-sidebar-index
```

After generation, inspect the script, run `bash -n <script>`, and make it executable.

## Important Guardrails

- Never edit `~/.codex` state while Codex is running.
- Never delete session or rollout files for this repair.
- Do not assume missing sidebar chats are lost. First verify with SQLite and `codex_app.list_threads`.
- Treat fresh sidebar timestamps as a workaround, not as canonical history.
- Preserve backup files made by the repair scripts.
