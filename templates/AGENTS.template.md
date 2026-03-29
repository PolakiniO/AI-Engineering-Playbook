# AGENTS.md

## Repository Purpose

[Describe the repository mission, product type, and non-goals.]

## Core Operating Principles

- Start from repository reality, not assumptions.
- Keep agent guidance separate from runtime code.
- [Add repo-specific principles.]

## Mandatory Skill Usage

- For every code-related task, select one primary skill automatically.
- Add secondary skills according to `skills/PLAYBOOK.md`.
- Skill usage is mandatory for code-related work.

## Optional Slash-Command Skill Routing

- Define portable slash aliases for common governance workflows (example: `/codex-install`).
- Map each alias to exactly one skill and expected behavior.
- Keep aliases repository-level so they can be copied to other repos without runtime coupling.
- Example mapping:
  - `/codex-install` -> `skill-installer` (install skill from curated list or GitHub path)
- Clarify behavior:
  - slash alias selects a skill for the current turn
  - installation/copying is performed by the installer workflow, not by the alias itself

## Strict-Mode Review Behavior

- Follow the selected skill output structure.
- Include at least one risk.
- Include at least one improvement.
- End with `Skills applied`.
- Write `None` when a required section is empty.

## Automatic Skill Routing Rules

- `architecture-guardian` for boundary and layering work
- `scope-safety-guard` for safety, policy, or side-effect changes
- `performance-optimizer` for performance-sensitive work
- `artifact-contract-reviewer` for schema or payload changes
- `llm-output-reviewer` for prompt or model-output changes
- `test-strategy-reviewer` for verification planning and review

## Repo-Specific Boundaries

[Define architecture layers, ownership, safety policy, and key constraints.]

## Validation Note

After customizing this file, run one strict-mode review on a sample change or PR to validate that the framework behaves as expected.
