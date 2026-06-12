#!/usr/bin/env python3
import argparse
import shlex
import stat
from pathlib import Path


def shell_single(value: str) -> str:
    return shlex.quote(value)


def slug(value: str) -> str:
    out = []
    for ch in value.lower():
        if ch.isalnum():
            out.append(ch)
        elif ch in "-_ .":
            out.append("-")
    result = "".join(out).strip("-")
    while "--" in result:
        result = result.replace("--", "-")
    return result or "project"


def build_script(name: str, old: str, new: str, refresh_sidebar_index: bool) -> str:
    label = slug(name)
    old_q = shell_single(old)
    new_q = shell_single(new)
    label_q = shell_single(label)
    refresh = "1" if refresh_sidebar_index else "0"

    return f"""#!/usr/bin/env bash
set -euo pipefail

old={old_q}
new={new_q}
label={label_q}
refresh_sidebar_index={refresh}
codex_dir="$HOME/.codex"
stamp="$(date +%Y%m%d-%H%M%S)"

if [[ ! -d "$new" ]]; then
  echo "New path does not exist: $new" >&2
  exit 1
fi

if pgrep -f "/Applications/Codex.app" >/dev/null || pgrep -x Codex >/dev/null; then
  echo "Codex is still running. Quit Codex fully with Cmd-Q, then run this script again." >&2
  exit 2
fi

echo "Updating Codex path references:"
echo "  old: $old"
echo "  new: $new"
echo "  refresh sidebar index: $refresh_sidebar_index"
echo

sqlite3 "$codex_dir/state_5.sqlite" "PRAGMA wal_checkpoint(FULL);" >/dev/null

cp "$codex_dir/config.toml" "$codex_dir/config.toml.bak-before-$label-path-$stamp"
cp "$codex_dir/.codex-global-state.json" "$codex_dir/.codex-global-state.json.bak-before-$label-path-$stamp"
cp "$codex_dir/state_5.sqlite" "$codex_dir/state_5.sqlite.bak-before-$label-path-$stamp"
cp "$codex_dir/session_index.jsonl" "$codex_dir/session_index.jsonl.bak-before-$label-path-$stamp"

perl -0pi -e "s#\\Q$old\\E#$new#g" \\
  "$codex_dir/config.toml" \\
  "$codex_dir/session_index.jsonl"

python3 - "$codex_dir/.codex-global-state.json" "$old" "$new" <<'PY'
import json
import sys

path, old, new = sys.argv[1:]

def replace(value):
    if isinstance(value, str):
        return value.replace(old, new)
    if isinstance(value, list):
        return [replace(item) for item in value]
    if isinstance(value, dict):
        return {{
            (key.replace(old, new) if isinstance(key, str) else key): replace(item)
            for key, item in value.items()
        }}
    return value

with open(path, "r", encoding="utf-8") as handle:
    state = json.load(handle)

state = replace(state)

for key in ("electron-saved-workspace-roots", "active-workspace-roots", "project-order"):
    value = state.get(key)
    if isinstance(value, list):
        deduped = []
        for item in value:
            if item not in deduped:
                deduped.append(item)
        if new not in deduped:
            deduped.insert(0, new)
        state[key] = deduped

with open(path, "w", encoding="utf-8") as handle:
    json.dump(state, handle, ensure_ascii=False, separators=(",", ":"))
    handle.write("\\n")
PY

python3 - "$codex_dir/state_5.sqlite" "$old" "$new" <<'PY'
import sqlite3
import sys

sqlite_path, old, new = sys.argv[1:]
with sqlite3.connect(sqlite_path) as db:
    rows = list(db.execute("select id, cwd from threads where cwd like ?", (f"%{old}%",)))
    db.executemany(
        "update threads set cwd = ? where id = ?",
        ((cwd.replace(old, new), thread_id) for thread_id, cwd in rows),
    )
    db.commit()
PY

python3 - "$codex_dir/.codex-global-state.json" "$codex_dir/state_5.sqlite" "$new" <<'PY'
import json
import sqlite3
import sys

state_path, sqlite_path, new_path = sys.argv[1:]

with open(state_path, "r", encoding="utf-8") as handle:
    state = json.load(handle)

with sqlite3.connect(sqlite_path) as db:
    ids = [
        row[0]
        for row in db.execute(
            "select id from threads where cwd = ? and archived = 0",
            (new_path,),
        )
    ]

hints = state.setdefault("thread-workspace-root-hints", {{}})
for thread_id in ids:
    hints[thread_id] = new_path

with open(state_path, "w", encoding="utf-8") as handle:
    json.dump(state, handle, ensure_ascii=False, separators=(",", ":"))
    handle.write("\\n")
PY

python3 - "$codex_dir/state_5.sqlite" "$new" <<'PY' |
import sqlite3
import sys

sqlite_path, new = sys.argv[1:]
with sqlite3.connect(sqlite_path) as db:
    for (rollout_path,) in db.execute(
        "select rollout_path from threads where cwd = ? and rollout_path <> ''",
        (new,),
    ):
        print(rollout_path)
PY
while IFS= read -r file; do
  if [[ -f "$file" ]] && grep -qF "$old" "$file"; then
    cp "$file" "$file.bak-before-$label-path-$stamp"
    perl -0pi -e "s#\\Q$old\\E#$new#g" "$file"
  fi
done

if [[ "$refresh_sidebar_index" == "1" ]]; then
  python3 - "$codex_dir/state_5.sqlite" "$codex_dir/session_index.jsonl" "$new" "$codex_dir/$label-sidebar-index-real-dates-$stamp.json" <<'PY'
import datetime as dt
import json
import sqlite3
import sys
from pathlib import Path

sqlite_path = Path(sys.argv[1])
index_path = Path(sys.argv[2])
project = sys.argv[3]
real_dates_path = Path(sys.argv[4])

with sqlite3.connect(sqlite_path) as db:
    rows = list(
        db.execute(
            "select id, title, updated_at, updated_at_ms from threads where cwd = ? and archived = 0 order by created_at",
            (project,),
        )
    )

ids = {{row[0] for row in rows}}
existing_names = {{}}
kept_lines = []
for line in index_path.read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    try:
        item = json.loads(line)
    except json.JSONDecodeError:
        kept_lines.append(line)
        continue
    thread_id = item.get("id")
    if thread_id and thread_id not in existing_names and item.get("thread_name"):
        existing_names[thread_id] = item["thread_name"]
    if thread_id not in ids:
        kept_lines.append(line)

base = dt.datetime.now(dt.UTC).replace(microsecond=0)
real_dates = {{}}
updates = []
new_entries = []

for offset, (thread_id, title, updated_at, updated_at_ms) in enumerate(rows):
    real_time = dt.datetime.fromtimestamp((updated_at_ms or updated_at * 1000) / 1000, dt.UTC)
    name = existing_names.get(thread_id) or title.splitlines()[0][:80]
    real_dates[thread_id] = {{
        "thread_name": name,
        "real_updated_at": real_time.isoformat().replace("+00:00", "Z"),
    }}
    visible = base + dt.timedelta(seconds=offset)
    updates.append((int(visible.timestamp()), int(visible.timestamp() * 1000), thread_id))
    new_entries.append({{
        "id": thread_id,
        "thread_name": name,
        "updated_at": visible.isoformat().replace("+00:00", "Z"),
    }})

kept_lines.extend(json.dumps(item, ensure_ascii=False, separators=(",", ":")) for item in new_entries)
index_path.write_text("\\n".join(kept_lines) + "\\n", encoding="utf-8")

with sqlite3.connect(sqlite_path) as db:
    db.executemany("update threads set updated_at = ?, updated_at_ms = ? where id = ?", updates)
    db.commit()

real_dates_path.write_text(json.dumps(real_dates, ensure_ascii=False, indent=2) + "\\n", encoding="utf-8")
print(f"Refreshed sidebar index entries for {{len(rows)}} active threads.")
print(f"Saved real timestamps to {{real_dates_path}}")
PY
fi

if command -v zoxide >/dev/null 2>&1; then
  zoxide remove "$old" >/dev/null 2>&1 || true
  zoxide add "$new" >/dev/null 2>&1 || true
fi

echo
echo "Remaining references in primary Codex files:"
rg -n "$old" \\
  "$codex_dir/config.toml" \\
  "$codex_dir/.codex-global-state.json" \\
  "$codex_dir/session_index.jsonl" \\
  >/dev/null 2>&1 && echo "  Some text references remain." || echo "  None in config/global-state/session-index."

remaining_threads="$(python3 - "$codex_dir/state_5.sqlite" "$old" <<'PY'
import sqlite3
import sys

sqlite_path, old = sys.argv[1:]
with sqlite3.connect(sqlite_path) as db:
    print(db.execute("select count(*) from threads where cwd like ?", (f"%{old}%",)).fetchone()[0])
PY
)"
active_threads="$(python3 - "$codex_dir/state_5.sqlite" "$new" <<'PY'
import sqlite3
import sys

sqlite_path, new = sys.argv[1:]
with sqlite3.connect(sqlite_path) as db:
    print(db.execute("select count(*) from threads where cwd = ? and archived = 0", (new,)).fetchone()[0])
PY
)"
echo "  Threads with old cwd: $remaining_threads"
echo "  Active threads at new cwd: $active_threads"

echo
echo "Updated Codex environment path to $new"
echo "Restart Codex and check the project chat list."
"""


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate a backup-first Codex project path repair script.")
    parser.add_argument("--name", required=True, help="Short project label, e.g. bubbles-verse")
    parser.add_argument("--old", required=True, help="Old absolute workspace path")
    parser.add_argument("--new", required=True, help="New absolute workspace path")
    parser.add_argument("--output", required=True, help="Output shell script path")
    parser.add_argument(
        "--refresh-sidebar-index",
        action="store_true",
        help="Also refresh session_index/SQLite timestamps to force old moved threads into the sidebar",
    )
    args = parser.parse_args()

    output = Path(args.output).expanduser()
    output.write_text(build_script(args.name, args.old, args.new, args.refresh_sidebar_index), encoding="utf-8")
    output.chmod(output.stat().st_mode | stat.S_IXUSR)
    print(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
