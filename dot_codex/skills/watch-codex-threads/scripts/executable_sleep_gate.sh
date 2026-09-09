#!/bin/zsh

set -eu

SLEEP_GATE_STATE_DIR=""

usage() {
  print -u2 -- "usage: sleep_gate.sh --check | --arm STATE_DIR [TTL_SECONDS] | --status STATE_DIR | --trigger STATE_DIR | --cancel STATE_DIR | --cleanup-confirmed STATE_DIR session-ended"
  exit 64
}

validate_state_dir() {
  local state_dir="$1"
  local state_pattern='^/private/tmp/watch-codex-threads-[A-Za-z0-9-]+$'
  if [[ ! "$state_dir" =~ $state_pattern ]]; then
    print -u2 -- "invalid state directory"
    exit 65
  fi
}

check_platform() {
  if [[ "$(/usr/bin/uname -s)" != "Darwin" ]]; then
    print -u2 -- "sleep gate supports macOS only"
    exit 69
  fi
  if [[ ! -x /usr/bin/pmset ]]; then
    print -u2 -- "/usr/bin/pmset is unavailable"
    exit 69
  fi
}

cleanup_gate() {
  local state_dir="${SLEEP_GATE_STATE_DIR:-}"
  if [[ -z "$state_dir" ]]; then
    return
  fi
  /bin/rm -f -- "$state_dir/pid" "$state_dir/alive" "$state_dir/expires_at" "$state_dir/trigger" "$state_dir/cancel"
  /bin/rmdir -- "$state_dir" 2>/dev/null || true
  SLEEP_GATE_STATE_DIR=""
}

verify_existing_state_dir() {
  local state_dir="$1"
  validate_state_dir "$state_dir"
  if [[ ! -d "$state_dir" || -L "$state_dir" ]]; then
    print -u2 -- "sleep gate is not armed"
    exit 66
  fi
  if [[ "$(/usr/bin/stat -f '%u' "$state_dir")" != "$EUID" ]]; then
    print -u2 -- "sleep gate owner mismatch"
    exit 77
  fi
}

arm_gate() {
  local state_dir="$1"
  local ttl_seconds="${2:-86400}"
  if [[ "$ttl_seconds" != <-> ]] || (( ttl_seconds < 300 || ttl_seconds > 172800 )); then
    print -u2 -- "TTL must be between 300 and 172800 seconds"
    exit 65
  fi
  validate_state_dir "$state_dir"
  check_platform
  /bin/mkdir -m 700 "$state_dir"
  SLEEP_GATE_STATE_DIR="$state_dir"
  trap cleanup_gate EXIT HUP INT TERM

  print -r -- "$$" > "$state_dir/pid"
  /usr/bin/touch "$state_dir/alive"
  local expires_at="$(( $(/bin/date +%s) + ttl_seconds ))"
  print -r -- "$expires_at" > "$state_dir/expires_at"
  print -r -- "armed:$state_dir"

  while true; do
    if (( $(/bin/date +%s) >= expires_at )); then
      print -r -- "expired:$state_dir"
      exit 75
    fi
    if [[ -e "$state_dir/cancel" ]]; then
      print -r -- "cancelled:$state_dir"
      exit 0
    fi
    if [[ -e "$state_dir/trigger" ]]; then
      cleanup_gate
      trap - EXIT HUP INT TERM
      print -r -- "sleeping"
      exec /usr/bin/pmset sleepnow
    fi
    /usr/bin/touch "$state_dir/alive"
    /bin/sleep 1
  done
}

ensure_not_expired() {
  local state_dir="$1"
  if [[ ! -f "$state_dir/expires_at" ]]; then
    print -u2 -- "sleep gate expiry is missing"
    exit 75
  fi
  local expires_at="$(<"$state_dir/expires_at")"
  if [[ "$expires_at" != <-> ]] || (( $(/bin/date +%s) >= expires_at )); then
    print -u2 -- "sleep gate is expired"
    exit 75
  fi
}

status_gate() {
  local state_dir="$1"
  verify_existing_state_dir "$state_dir"
  ensure_not_expired "$state_dir"
  if [[ ! -f "$state_dir/alive" ]]; then
    print -u2 -- "sleep gate heartbeat is missing"
    exit 75
  fi

  local now="$(/bin/date +%s)"
  local updated="$(/usr/bin/stat -f '%m' "$state_dir/alive")"
  if (( now - updated > 5 )); then
    print -u2 -- "sleep gate is stale"
    exit 75
  fi
  print -r -- "active:$state_dir"
}

signal_gate() {
  local signal_name="$1"
  local state_dir="$2"
  verify_existing_state_dir "$state_dir"
  if [[ "$signal_name" == "trigger" ]]; then
    ensure_not_expired "$state_dir"
  fi
  /usr/bin/touch "$state_dir/$signal_name"
  print -r -- "$signal_name:$state_dir"
}

cleanup_confirmed_orphan() {
  local state_dir="$1"
  local confirmation="$2"
  if [[ "$confirmation" != "session-ended" ]]; then
    print -u2 -- "confirmed session end is required"
    exit 77
  fi
  verify_existing_state_dir "$state_dir"
  /bin/rm -f -- "$state_dir/pid" "$state_dir/alive" "$state_dir/expires_at" "$state_dir/trigger" "$state_dir/cancel"
  /bin/rmdir -- "$state_dir"
  print -r -- "cleaned:$state_dir"
}

case "${1:-}" in
  --check)
    [[ "$#" -eq 1 ]] || usage
    check_platform
    print -r -- "sleep-gate-ready"
    ;;
  --arm)
    [[ "$#" -eq 2 || "$#" -eq 3 ]] || usage
    arm_gate "$2" "${3:-86400}"
    ;;
  --status)
    [[ "$#" -eq 2 ]] || usage
    status_gate "$2"
    ;;
  --trigger)
    [[ "$#" -eq 2 ]] || usage
    signal_gate trigger "$2"
    ;;
  --cancel)
    [[ "$#" -eq 2 ]] || usage
    signal_gate cancel "$2"
    ;;
  --cleanup-confirmed)
    [[ "$#" -eq 3 ]] || usage
    cleanup_confirmed_orphan "$2" "$3"
    ;;
  *)
    usage
    ;;
esac
