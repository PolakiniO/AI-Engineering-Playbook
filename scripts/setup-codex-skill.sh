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
explicit_selection=false
install_project_engineering=false
install_all_skills=false
list_skills=false
declare -a skill_paths=()
declare -a all_skill_names=(
  "architecture-guardian"
  "artifact-contract-reviewer"
  "codex-agent-orchestration"
  "deployment-engineer"
  "finance-engineer"
  "llm-output-reviewer"
  "operations-engineer"
  "performance-optimizer"
  "playbook-installer"
  "product-designer"
  "project-engineer"
  "scope-safety-guard"
  "security-engineer"
  "test-strategy-reviewer"
)
declare -a project_engineering_skill_names=(
  "project-engineer"
  "product-designer"
  "deployment-engineer"
  "security-engineer"
  "operations-engineer"
  "finance-engineer"
)

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

add_skill_path() {
  local path="$1"
  local existing

  if [[ -z "$path" ]]; then
    echo "Error: skill path must be non-empty." >&2
    return 1
  fi

  for existing in "${skill_paths[@]}"; do
    if [[ "$existing" == "$path" ]]; then
      return 0
    fi
  done

  skill_paths+=("$path")
}

add_skill_name() {
  local skill_name="$1"

  if [[ -z "$skill_name" ]]; then
    echo "Error: skill name must be non-empty." >&2
    return 1
  fi

  add_skill_path "dist/codex-skills/$skill_name"
}

print_available_skills() {
  local skill_name

  echo "Available generated Codex skills:"
  for skill_name in "${all_skill_names[@]}"; do
    echo "  $skill_name"
  done
}

install_skill_path() {
  local skill_path="$1"
  local repo="$2"
  local ref="$3"
  local force="$4"
  local local_skill_path
  local dest_root
  local skill_name
  local dest_dir
  local installer_script

  local_skill_path="$REPO_ROOT/$skill_path"
  dest_root="$CODEX_HOME_DEFAULT/skills"
  skill_name="$(basename "$skill_path")"
  dest_dir="$dest_root/$skill_name"

  echo "Installing Codex skill..."
  echo "  repo: $repo"
  echo "  path: $skill_path"
  echo "  ref:  $ref"

  if [[ -d "$local_skill_path" ]]; then
    echo "  source: local workspace"
    install_local_skill "$local_skill_path" "$dest_root" "$force"
    return
  fi

  if ! installer_script="$(resolve_installer_script)"; then
    echo "Error: installer script could not be discovered." >&2
    echo "Checked default locations under /opt/codex/skills and \$CODEX_HOME/skills." >&2
    echo "Set INSTALLER_SCRIPT to the exact path if your environment is customized." >&2
    exit 1
  fi

  echo "  installer: $installer_script"
  echo "  source: github"
  if [[ -e "$dest_dir" && "$force" == "true" ]]; then
    rm -rf "$dest_dir"
  fi
  python3 "$installer_script" --repo "$repo" --path "$skill_path" --ref "$ref"
}

usage() {
  cat <<'EOF'
Usage:
  scripts/setup-codex-skill.sh [options]

Installs one or more generated Codex skills.

Options:
  --repo <owner/repo>       GitHub repo containing the skill
                            (default: origin remote or PolakiniO/AI-Engineering-Playbook)
  --path <skills/path>      Skill path within the repo (default: dist/codex-skills/playbook-installer)
                            Can be repeated to install multiple explicit paths.
  --skill <skill-name>      Install one generated skill by name, such as project-engineer.
                            Can be repeated to install multiple skills independently.
  --all-project-engineering Install project-engineer, product-designer, deployment-engineer,
                            security-engineer, operations-engineer, and finance-engineer.
  --all-skills              Install every generated skill from this playbook.
                            For only codex-agent-orchestration, use:
                            scripts/setup-codex-agent-orchestration-skill.sh
  --list-skills             Print installable generated skill names and exit.
  --ref <git-ref>           Git ref/branch/tag (default: main)
  --force, --reinstall      Replace an existing installed skill with the new copy
  -h, --help                Show this help message

Environment overrides:
  INSTALLER_SCRIPT          Exact path to install-skill-from-github.py
                            If unset, the script checks:
                            1. /opt/codex/skills/.system/skill-installer/scripts/...
                            2. /opt/codex/skills/skill-installer/scripts/...
                            3. $CODEX_HOME/skills/.system/skill-installer/scripts/...
                            4. $CODEX_HOME/skills/skill-installer/scripts/...
  DEFAULT_REPO              Default repo value
  DEFAULT_SKILL_PATH        Default skill path value
  DEFAULT_REF               Default git ref value
  CODEX_HOME                Used for fallback installer discovery (default: ~/.codex)
EOF
}

repo="$(resolve_default_repo)"
ref="$DEFAULT_REF"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      repo="${2:-}"
      shift 2
      ;;
    --path)
      add_skill_path "${2:-}"
      explicit_selection=true
      shift 2
      ;;
    --skill)
      add_skill_name "${2:-}"
      explicit_selection=true
      shift 2
      ;;
    --all-project-engineering)
      install_project_engineering=true
      explicit_selection=true
      shift
      ;;
    --all-skills)
      install_all_skills=true
      explicit_selection=true
      shift
      ;;
    --list-skills)
      list_skills=true
      shift
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

if [[ "$list_skills" == "true" ]]; then
  print_available_skills
  exit 0
fi

if [[ "$install_all_skills" == "true" ]]; then
  for skill_name in "${all_skill_names[@]}"; do
    add_skill_name "$skill_name"
  done
fi

if [[ "$install_project_engineering" == "true" ]]; then
  for skill_name in "${project_engineering_skill_names[@]}"; do
    add_skill_name "$skill_name"
  done
fi

if [[ "$explicit_selection" == "false" ]]; then
  add_skill_path "$DEFAULT_SKILL_PATH"
fi

if [[ -z "$repo" || -z "$ref" ]]; then
  echo "Error: --repo and --ref must be non-empty." >&2
  usage
  exit 1
fi

if [[ "${#skill_paths[@]}" -eq 0 ]]; then
  echo "Error: no skills selected for installation." >&2
  exit 1
fi

for skill_path in "${skill_paths[@]}"; do
  install_skill_path "$skill_path" "$repo" "$ref" "$force_reinstall"
done

echo
echo "Install complete. Restart Codex to pick up new or updated skills."
