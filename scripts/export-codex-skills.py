#!/usr/bin/env python3
"""Generate the public agent-skill and Codex distributions from canonical skills."""

from __future__ import annotations

import json
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
SOURCE_DIR = REPO_ROOT / "skills"
MANIFEST_PATH = SOURCE_DIR / "skill-manifest.json"
DIST_DIR = REPO_ROOT / "dist" / "codex-skills"
AGENT_DIST_DIR = REPO_ROOT / "dist" / "agent-skills"
CATALOG_PATH = REPO_ROOT / "products" / "catalog.json"


def openai_yaml(display_name: str, short_description: str, default_prompt: str) -> str:
    return "\n".join(
        [
            "interface:",
            f'  display_name: "{display_name}"',
            f'  short_description: "{short_description}"',
            f'  default_prompt: "{default_prompt}"',
            "",
        ]
    )


def validate_frontmatter(skill_file: Path, skill_name: str) -> str:
    body = skill_file.read_text()
    expected_prefix = f"---\nname: {skill_name}\n"
    if not body.startswith(expected_prefix) or "\n---\n" not in body:
        raise SystemExit(
            f"Canonical skill is missing valid frontmatter: {skill_file}"
        )
    return body


def copy_resources(source_dir: Path, output_dir: Path) -> None:
    for resource_name in ("scripts", "references", "assets"):
        resource_dir = source_dir / resource_name
        if resource_dir.is_dir():
            shutil.copytree(resource_dir, output_dir / resource_name)


def main() -> int:
    manifest = json.loads(MANIFEST_PATH.read_text())
    catalog = json.loads(CATALOG_PATH.read_text())

    if DIST_DIR.exists():
        shutil.rmtree(DIST_DIR)
    DIST_DIR.mkdir(parents=True, exist_ok=True)

    if AGENT_DIST_DIR.exists():
        shutil.rmtree(AGENT_DIST_DIR)
    AGENT_DIST_DIR.mkdir(parents=True, exist_ok=True)

    for skill_dir in sorted(path for path in SOURCE_DIR.iterdir() if path.is_dir()):
        skill_file = skill_dir / "SKILL.md"
        if not skill_file.is_file():
            continue

        metadata = manifest.get(skill_dir.name)
        if metadata is None:
            raise SystemExit(f"Missing metadata for skill: {skill_dir.name}")

        out_dir = DIST_DIR / skill_dir.name
        out_dir.mkdir(parents=True, exist_ok=True)

        body = validate_frontmatter(skill_file, skill_dir.name)
        out_file = out_dir / "SKILL.md"
        out_file.write_text(body)

        agent_out_dir = AGENT_DIST_DIR / skill_dir.name
        agent_out_dir.mkdir(parents=True, exist_ok=True)
        (agent_out_dir / "SKILL.md").write_text(body)
        copy_resources(skill_dir, agent_out_dir)

        agents_dir = out_dir / "agents"
        agents_dir.mkdir(parents=True, exist_ok=True)
        (agents_dir / "openai.yaml").write_text(
            openai_yaml(
                display_name=metadata["display_name"],
                short_description=metadata["short_description"],
                default_prompt=metadata["default_prompt"],
            )
        )

        copy_resources(skill_dir, out_dir)

    (AGENT_DIST_DIR / "catalog.json").write_text(
        json.dumps(catalog, indent=2) + "\n"
    )
    (AGENT_DIST_DIR / "README.md").write_text(
        "# AI-Engineering-Playbook Agent Skills\n\n"
        "This generated directory is the clean, frontmatter-compliant distribution "
        "surface for Claude Code, Codex, Cursor, and other Agent Skills-compatible "
        "tools. The canonical source remains `../../skills/`.\n\n"
        "See [`catalog.json`](./catalog.json) for product bundles and install metadata.\n"
    )

    print(f"Exported Codex skill artifacts to {DIST_DIR}")
    print(f"Exported neutral agent skill artifacts to {AGENT_DIST_DIR}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
