# Skills System

This directory contains reusable development-time reasoning skills for Codex and similar AI coding agents.

These files are not runtime code. They are governance artifacts that shape implementation and review behavior inside another repository.

The files in this directory are the canonical Agent Skills-compatible source
format. Each `SKILL.md` includes standard YAML frontmatter so the same source
can be discovered by agent-skill registries and transformed into tool-specific
packages.

If a specific tool needs extra packaging metadata, generate a derived
distribution from this source rather than editing these files to match one
tool's loader requirements. Run `python3 scripts/export-codex-skills.py` to
refresh `dist/agent-skills/` and `dist/codex-skills/`.

## Rules

- Always choose one primary skill for code-related work.
- Add secondary skills using [`PLAYBOOK.md`](./PLAYBOOK.md).
- Use strict mode by default.
- End every skill-based response with `Skills applied`.
- Keep reusable skills generic.
- Put repo-specific skills alongside these only when the adopting repository needs domain-specific review lenses.

## Included Reusable Skills

- [`architecture-guardian`](./architecture-guardian/SKILL.md) ([install/use](./architecture-guardian/README.md))
- [`codex-agent-orchestration`](./codex-agent-orchestration/SKILL.md) ([install/use](./codex-agent-orchestration/README.md))
- [`project-engineer`](./project-engineer/SKILL.md) ([install/use](./project-engineer/README.md))
- [`product-designer`](./product-designer/SKILL.md) ([install/use](./product-designer/README.md))
- [`deployment-engineer`](./deployment-engineer/SKILL.md) ([install/use](./deployment-engineer/README.md))
- [`security-engineer`](./security-engineer/SKILL.md) ([install/use](./security-engineer/README.md))
- [`operations-engineer`](./operations-engineer/SKILL.md) ([install/use](./operations-engineer/README.md))
- [`finance-engineer`](./finance-engineer/SKILL.md) ([install/use](./finance-engineer/README.md))
- [`playbook-installer`](./playbook-installer/SKILL.md) ([install/use](./playbook-installer/README.md))
- [`scope-safety-guard`](./scope-safety-guard/SKILL.md) ([install/use](./scope-safety-guard/README.md))
- [`performance-optimizer`](./performance-optimizer/SKILL.md) ([install/use](./performance-optimizer/README.md))
- [`artifact-contract-reviewer`](./artifact-contract-reviewer/SKILL.md) ([install/use](./artifact-contract-reviewer/README.md))
- [`llm-output-reviewer`](./llm-output-reviewer/SKILL.md) ([install/use](./llm-output-reviewer/README.md))
- [`test-strategy-reviewer`](./test-strategy-reviewer/SKILL.md) ([install/use](./test-strategy-reviewer/README.md))

## Customization Guidance

Keep generic:

- skill purpose
- trigger conditions
- review structure
- anti-patterns
- risk framing

Customize per repo:

- file references
- architecture boundaries
- data contract names
- safety semantics
- examples tied to the actual codebase
