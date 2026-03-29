# Skills System

This directory contains reusable development-time reasoning skills for Codex and similar AI coding agents.

These files are not runtime code. They are governance artifacts that shape implementation and review behavior inside another repository.

## Rules

- Always choose one primary skill for code-related work.
- Add secondary skills using [`PLAYBOOK.md`](./PLAYBOOK.md).
- Use strict mode by default.
- End every skill-based response with `Skills applied`.
- Keep reusable skills generic.
- Put repo-specific skills alongside these only when the adopting repository needs domain-specific review lenses.

## Included Reusable Skills

- [`architecture-guardian`](./architecture-guardian/SKILL.md)
- [`playbook-installer`](./playbook-installer/SKILL.md)
- [`scope-safety-guard`](./scope-safety-guard/SKILL.md)
- [`performance-optimizer`](./performance-optimizer/SKILL.md)
- [`artifact-contract-reviewer`](./artifact-contract-reviewer/SKILL.md)
- [`llm-output-reviewer`](./llm-output-reviewer/SKILL.md)
- [`test-strategy-reviewer`](./test-strategy-reviewer/SKILL.md)

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
