#!/usr/bin/env bash

set -euo pipefail

INSTALLER_SCRIPT="${INSTALLER_SCRIPT:-/opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py}"
DEFAULT_REPO="${DEFAULT_REPO:-openai/skills}"
DEFAULT_SKILL_PATH="${DEFAULT_SKILL_PATH:-skills/.curated/playbook-installer}"
DEFAULT_REF="${DEFAULT_REF:-main}"

usage() {
  cat <<'EOF'
Usage:
  scripts/setup-codex-skill.sh [options]

Installs a Codex skill using the system `skill-installer` helper.

Options:
  --repo <owner/repo>       GitHub repo containing the skill (default: openai/skills)
  --path <skills/path>      Skill path within the repo (default: skills/.curated/playbook-installer)
  --ref <git-ref>           Git ref/branch/tag (default: main)
  -h, --help                Show this help message

Environment overrides:
  INSTALLER_SCRIPT          Path to install-skill-from-github.py
  DEFAULT_REPO              Default repo value
  DEFAULT_SKILL_PATH        Default skill path value
  DEFAULT_REF               Default git ref value
EOF
}

repo="$DEFAULT_REPO"
skill_path="$DEFAULT_SKILL_PATH"
ref="$DEFAULT_REF"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      repo="${2:-}"
      shift 2
      ;;
    --path)
      skill_path="${2:-}"
      shift 2
      ;;
    --ref)
      ref="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$repo" || -z "$skill_path" || -z "$ref" ]]; then
  echo "Error: --repo, --path, and --ref must be non-empty." >&2
  usage
  exit 1
fi

if [[ ! -f "$INSTALLER_SCRIPT" ]]; then
  echo "Error: installer script not found at: $INSTALLER_SCRIPT" >&2
  echo "Make sure Codex system skills are installed and the path is correct." >&2
  exit 1
fi

echo "Installing Codex skill..."
echo "  repo: $repo"
echo "  path: $skill_path"
echo "  ref:  $ref"

python3 "$INSTALLER_SCRIPT" --repo "$repo" --path "$skill_path" --ref "$ref"

echo
echo "Install complete. Restart Codex to pick up new skills."
