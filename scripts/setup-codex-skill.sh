#!/usr/bin/env bash

set -euo pipefail

DEFAULT_REPO="${DEFAULT_REPO:-openai/skills}"
DEFAULT_SKILL_PATH="${DEFAULT_SKILL_PATH:-skills/.curated/playbook-installer}"
DEFAULT_REF="${DEFAULT_REF:-main}"

resolve_installer_script() {
  if [[ -n "${INSTALLER_SCRIPT:-}" ]]; then
    if [[ -f "$INSTALLER_SCRIPT" ]]; then
      echo "$INSTALLER_SCRIPT"
      return 0
    fi

    echo "Error: installer script not found at: $INSTALLER_SCRIPT" >&2
    return 1
  fi

  local codex_home="${CODEX_HOME:-$HOME/.codex}"
  local candidates=(
    "/opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py"
    "/opt/codex/skills/skill-installer/scripts/install-skill-from-github.py"
    "$codex_home/skills/.system/skill-installer/scripts/install-skill-from-github.py"
    "$codex_home/skills/skill-installer/scripts/install-skill-from-github.py"
  )
  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done

  return 1
}

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
  INSTALLER_SCRIPT          Explicit path to install-skill-from-github.py
  DEFAULT_REPO              Default repo value
  DEFAULT_SKILL_PATH        Default skill path value
  DEFAULT_REF               Default git ref value
  CODEX_HOME                Used for fallback installer discovery (default: ~/.codex)
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

if ! installer_script="$(resolve_installer_script)"; then
  echo "Error: installer script could not be discovered." >&2
  echo "Checked default locations under /opt/codex/skills and \$CODEX_HOME/skills." >&2
  echo "Set INSTALLER_SCRIPT to the exact path if your environment is customized." >&2
  exit 1
fi

echo "Installing Codex skill..."
echo "  repo: $repo"
echo "  path: $skill_path"
echo "  ref:  $ref"
echo "  installer: $installer_script"

python3 "$installer_script" --repo "$repo" --path "$skill_path" --ref "$ref"

echo
echo "Install complete. Restart Codex to pick up new skills."
