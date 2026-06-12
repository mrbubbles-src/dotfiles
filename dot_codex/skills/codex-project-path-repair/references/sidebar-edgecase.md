# Sidebar Materialization Edge Case

Symptoms:

- `state_5.sqlite` has active threads with the correct `cwd`.
- `thread-workspace-root-hints` points those thread IDs to the new workspace.
- `session_index.jsonl` contains entries for the thread IDs.
- `codex_app.list_threads` finds the threads and `codex_app.read_thread` can read them.
- The project sidebar still shows `No chats`.

Observed behavior:

- Re-saving a thread title through `codex_app.set_thread_title` can make that one thread appear.
- Restoring its old timestamp can make it disappear again.
- This implies the sidebar may materialize old moved local threads only when the local index entry is fresh.

Preferred response:

1. Tell the user the chats are intact and readable.
2. Avoid touching chat contents.
3. Use a generated repair script with `--refresh-sidebar-index`.
4. Save the real rollout timestamps to a sidecar JSON file.
5. Accept that sidebar timestamps may display as current for resurrected threads.

Do not call this data loss. It is a sidebar/index materialization problem.
