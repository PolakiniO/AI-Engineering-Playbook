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

## Skill Invocation Compatibility Note

- Do not define custom `/` commands in `AGENTS.md`; Codex slash commands are built-in product commands.
- For portable workflows, invoke skills by name (example: `$skill-installer`) or direct plain-language instruction.
- Clarify that installation/copying is performed by the installer workflow, not by invocation text alone.

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
