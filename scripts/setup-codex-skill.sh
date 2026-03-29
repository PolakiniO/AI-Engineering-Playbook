#!/usr/bin/env bash

set -euo pipefail

INSTALLER_SCRIPT="${INSTALLER_SCRIPT:-}"
DEFAULT_REPO="${DEFAULT_REPO:-}"
DEFAULT_SKILL_PATH="${DEFAULT_SKILL_PATH:-dist/codex-skills/playbook-installer}"
DEFAULT_REF="${DEFAULT_REF:-main}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CODEX_HOME_DEFAULT="${CODEX_HOME:-$HOME/.codex}"
force_reinstall=false

resolve_installer_script() {
  local candidates=()
  local codex_home="${CODEX_HOME:-}"

  if [[ -n "${INSTALLER_SCRIPT:-}" ]]; then
    candidates+=("$INSTALLER_SCRIPT")
  fi

  if [[ -n "$codex_home" ]]; then
    candidates+=("$codex_home/skills/.system/skill-installer/scripts/install-skill-from-github.py")
  fi

  candidates+=(
    "$HOME/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py"
    "/opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py"
  )

  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

resolve_default_repo() {
  if [[ -n "${DEFAULT_REPO:-}" ]]; then
    printf '%s\n' "$DEFAULT_REPO"
    return 0
  fi

  local origin_url
  origin_url="$(git config --get remote.origin.url 2>/dev/null || true)"

  case "$origin_url" in
    git@github.com:*.git)
      origin_url="${origin_url#git@github.com:}"
      origin_url="${origin_url%.git}"
      printf '%s\n' "$origin_url"
      return 0
      ;;
    git@github.com:*)
      printf '%s\n' "${origin_url#git@github.com:}"
      return 0
      ;;
    https://github.com/*)
      origin_url="${origin_url#https://github.com/}"
      origin_url="${origin_url%.git}"
      printf '%s\n' "$origin_url"
      return 0
      ;;
  esac

  printf '%s\n' "PolakiniO/AI-Engineering-Playbook"
}

install_local_skill() {
  local source_dir="$1"
  local dest_root="$2"
  local force="$3"
  local skill_name
  skill_name="$(basename "$source_dir")"
  local dest_dir="$dest_root/$skill_name"

  if [[ ! -d "$source_dir" ]]; then
    echo "Error: local skill path not found: $source_dir" >&2
    return 1
  fi

  if [[ ! -f "$source_dir/SKILL.md" ]]; then
    echo "Error: SKILL.md not found in local skill path: $source_dir" >&2
    return 1
  fi

  mkdir -p "$dest_root"

  if [[ -e "$dest_dir" ]]; then
    if [[ "$force" == "true" ]]; then
      rm -rf "$dest_dir"
    else
      echo "Error: destination already exists: $dest_dir" >&2
      echo "Re-run with --force to replace it." >&2
      return 1
    fi
  fi

  cp -R "$source_dir" "$dest_dir"
  echo "Installed $skill_name to $dest_dir"
}

usage() {
  cat <<'EOF'
Usage:
  scripts/setup-codex-skill.sh [options]

Installs a Codex skill using the system `skill-installer` helper.

Options:
  --repo <owner/repo>       GitHub repo containing the skill
                            (default: origin remote or PolakiniO/AI-Engineering-Playbook)
  --path <skills/path>      Skill path within the repo (default: dist/codex-skills/playbook-installer)
  --ref <git-ref>           Git ref/branch/tag (default: main)
  --force, --reinstall      Replace an existing installed skill with the new copy
  -h, --help                Show this help message

Environment overrides:
  INSTALLER_SCRIPT          Exact path to install-skill-from-github.py
                            If unset, the script checks:
                            1. $CODEX_HOME/skills/.system/skill-installer/scripts/...
                            2. ~/.codex/skills/.system/skill-installer/scripts/...
                            3. /opt/codex/skills/.system/skill-installer/scripts/...
  DEFAULT_REPO              Default repo value
  DEFAULT_SKILL_PATH        Default skill path value
  DEFAULT_REF               Default git ref value
EOF
}

repo="$(resolve_default_repo)"
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
    --force|--reinstall)
      force_reinstall=true
      shift
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

if ! INSTALLER_SCRIPT="$(resolve_installer_script)"; then
  echo "Error: installer script not found." >&2
  echo "Checked these locations:" >&2
  if [[ -n "${INSTALLER_SCRIPT:-}" ]]; then
    echo "  - $INSTALLER_SCRIPT" >&2
  fi
  if [[ -n "${CODEX_HOME:-}" ]]; then
    echo "  - $CODEX_HOME/skills/.system/skill-installer/scripts/install-skill-from-github.py" >&2
  fi
  echo "  - $HOME/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py" >&2
  echo "  - /opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py" >&2
  echo "Make sure Codex system skills are installed and the path is correct." >&2
  exit 1
fi

echo "Installing Codex skill..."
echo "  installer: $INSTALLER_SCRIPT"
echo "  repo: $repo"
echo "  path: $skill_path"
echo "  ref:  $ref"

local_skill_path="$REPO_ROOT/$skill_path"
dest_root="$CODEX_HOME_DEFAULT/skills"
skill_name="$(basename "$skill_path")"
dest_dir="$dest_root/$skill_name"

if [[ -d "$local_skill_path" ]]; then
  echo "  source: local workspace"
  install_local_skill "$local_skill_path" "$dest_root" "$force_reinstall"
else
  echo "  source: github"
  if [[ -e "$dest_dir" && "$force_reinstall" == "true" ]]; then
    rm -rf "$dest_dir"
  fi
  python3 "$INSTALLER_SCRIPT" --repo "$repo" --path "$skill_path" --ref "$ref"
fi

echo
echo "Install complete. Restart Codex to pick up new skills."
