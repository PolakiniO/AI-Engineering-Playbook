#!/usr/bin/env python3
"""Generate Codex-compatible skill artifacts from vendor-neutral source skills."""

from __future__ import annotations

import json
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
SOURCE_DIR = REPO_ROOT / "skills"
MANIFEST_PATH = SOURCE_DIR / "skill-manifest.json"
DIST_DIR = REPO_ROOT / "dist" / "codex-skills"


def frontmatter(name: str, description: str, short_description: str) -> str:
    return "\n".join(
        [
            "---",
            f"name: {name}",
            f"description: {description}",
            "metadata:",
            f"  short-description: {short_description}",
            "---",
            "",
        ]
    )


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


def main() -> int:
    manifest = json.loads(MANIFEST_PATH.read_text())

    if DIST_DIR.exists():
        shutil.rmtree(DIST_DIR)
    DIST_DIR.mkdir(parents=True, exist_ok=True)

    for skill_dir in sorted(path for path in SOURCE_DIR.iterdir() if path.is_dir()):
        skill_file = skill_dir / "SKILL.md"
        if not skill_file.is_file():
            continue

        metadata = manifest.get(skill_dir.name)
        if metadata is None:
            raise SystemExit(f"Missing metadata for skill: {skill_dir.name}")

        out_dir = DIST_DIR / skill_dir.name
        out_dir.mkdir(parents=True, exist_ok=True)

        body = skill_file.read_text()
        out_file = out_dir / "SKILL.md"
        out_file.write_text(
            frontmatter(
                name=skill_dir.name,
                description=metadata["description"],
                short_description=metadata["short_description"],
            )
            + body
        )

        agents_dir = out_dir / "agents"
        agents_dir.mkdir(parents=True, exist_ok=True)
        (agents_dir / "openai.yaml").write_text(
            openai_yaml(
                display_name=metadata["display_name"],
                short_description=metadata["short_description"],
                default_prompt=metadata["default_prompt"],
            )
        )

    print(f"Exported Codex skill artifacts to {DIST_DIR}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
