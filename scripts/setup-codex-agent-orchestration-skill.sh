#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo=""
ref=""
force_args=()

usage() {
  cat <<'EOF'
Usage:
  scripts/setup-codex-agent-orchestration-skill.sh [options]

Installs only the generated codex-agent-orchestration Codex skill.

Options:
  --repo <owner/repo>       GitHub repo containing the skill
                            (default: setup-codex-skill.sh default)
  --ref <git-ref>           Git ref/branch/tag
                            (default: setup-codex-skill.sh default)
  --force, --reinstall      Replace an existing installed copy
  -h, --help                Show this help message

Environment overrides are inherited by scripts/setup-codex-skill.sh:
  INSTALLER_SCRIPT, DEFAULT_REPO, DEFAULT_REF, CODEX_HOME
EOF
}

args=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      repo="${2:-}"
      shift 2
      ;;
    --ref)
      ref="${2:-}"
      shift 2
      ;;
    --force|--reinstall)
      force_args+=("$1")
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --path|--skill|--all-project-engineering|--all-skills|--list-skills)
      echo "Error: this helper installs only codex-agent-orchestration." >&2
      exit 1
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -n "$repo" ]]; then
  args+=(--repo "$repo")
fi

if [[ -n "$ref" ]]; then
  args+=(--ref "$ref")
fi

bash "$SCRIPT_DIR/setup-codex-skill.sh" \
  --skill codex-agent-orchestration \
  "${args[@]}" \
  "${force_args[@]}"
