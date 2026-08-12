#!/usr/bin/env python3
"""Validate canonical skill metadata, generated artifacts, and product bundles."""

from __future__ import annotations

import json
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
SKILLS_DIR = REPO_ROOT / "skills"
MANIFEST_PATH = SKILLS_DIR / "skill-manifest.json"
CATALOG_PATH = REPO_ROOT / "products" / "catalog.json"
AGENT_DIST_DIR = REPO_ROOT / "dist" / "agent-skills"
CODEX_DIST_DIR = REPO_ROOT / "dist" / "codex-skills"


def skill_names() -> set[str]:
    return {
        path.name
        for path in SKILLS_DIR.iterdir()
        if path.is_dir() and (path / "SKILL.md").is_file()
    }


def validate_frontmatter(path: Path, expected_name: str, metadata: dict) -> None:
    text = path.read_text()
    prefix = f"---\nname: {expected_name}\n"
    if not text.startswith(prefix) or "\n---\n" not in text:
        raise SystemExit(f"Invalid frontmatter: {path}")
    header = text.split("\n---\n", 1)[0].splitlines()
    description = next(
        (line.removeprefix("description: ") for line in header if line.startswith("description: ")),
        None,
    )
    short_description = next(
        (
            line.removeprefix("  short-description: ")
            for line in header
            if line.startswith("  short-description: ")
        ),
        None,
    )
    if description != metadata["description"]:
        raise SystemExit(f"Frontmatter description differs from manifest: {path}")
    if short_description != metadata["short_description"]:
        raise SystemExit(f"Frontmatter short description differs from manifest: {path}")


def main() -> int:
    manifest = json.loads(MANIFEST_PATH.read_text())
    catalog = json.loads(CATALOG_PATH.read_text())
    names = skill_names()

    if names != set(manifest):
        raise SystemExit("skill-manifest.json does not match canonical skill directories")

    for name in sorted(names):
        source = SKILLS_DIR / name / "SKILL.md"
        validate_frontmatter(source, name, manifest[name])
        for distribution in (AGENT_DIST_DIR, CODEX_DIST_DIR):
            generated = distribution / name / "SKILL.md"
            if not generated.is_file():
                raise SystemExit(f"Missing generated skill: {generated}")
            validate_frontmatter(generated, name, manifest[name])
            if generated.read_text() != source.read_text():
                raise SystemExit(f"Generated skill differs from source: {generated}")

    assigned = set()
    for bundle in catalog["bundles"]:
        members = set(bundle["skills"])
        if not members <= names:
            raise SystemExit(f"Unknown skill in bundle {bundle['id']}")
        if assigned & members:
            raise SystemExit(f"Skill appears in multiple product bundles: {assigned & members}")
        assigned |= members

    free_addons = set(catalog["free_addons"])
    if not free_addons <= names or assigned & free_addons:
        raise SystemExit("Free add-ons overlap with product bundles or contain an unknown skill")

    print(f"Validated {len(names)} canonical skills and {len(catalog['bundles'])} product bundles")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
