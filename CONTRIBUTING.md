# Contributing

Contributions are welcome.

This repository is a documentation and governance framework for coding-agent workflows. Please keep changes focused on reusable process guidance rather than runtime code or product-specific automation.

## What To Contribute

- improvements to generic governance guidance
- clearer skill definitions and review structure
- better adoption templates
- example overlays for real repositories
- wording and documentation fixes that make the framework easier to adopt

## What To Avoid

- runtime libraries or application code
- repository-specific assumptions in the generic core
- hard-coded local paths or environment-specific instructions
- changes that couple skills to product runtime behavior

## Contribution Guidelines

1. Keep the generic core reusable across repositories.
2. Put project-specific examples under `examples/`.
3. Do not add runtime code, build tooling, or deployment logic.
4. Preserve strict-mode review behavior unless the change clearly improves it.
5. When adding or editing a skill, keep its trigger conditions, anti-patterns, and output structure explicit.
6. Do not introduce repo-specific logic into the framework core.

## Proposing A New Skill

Use a new skill only when the behavior cannot be expressed cleanly through the existing playbook and skills.

When proposing a new skill:

1. explain the repository problem it solves
2. define clear trigger conditions
3. define what the skill should inspect
4. define the output structure the agent must follow
5. keep it generic unless it belongs under an example or repo-specific overlay

Start from [`templates/SKILL.template.md`](./templates/SKILL.template.md).

## Modifying `AGENTS.md` Safely

Treat [`AGENTS.md`](./AGENTS.md) as the framework’s governance contract.

When editing it:

- preserve the distinction between generic framework rules and repo-specific overlays
- keep guidance usable by Codex and similar AI coding agents
- avoid adding assumptions about a particular repository structure unless the change belongs in `examples/`
- keep strict-mode review behavior explicit

If a rule is only true for one project, it does not belong in the framework core.

## Pull Request Expectations

- explain whether the change affects the generic core, templates, or examples
- note any compatibility or migration implications for adopters
- keep wording friendly for external users and maintainers
- update related templates or examples when the change would otherwise create drift

## Development Notes

- prefer repo-relative links
- keep examples illustrative, not normative
- avoid assuming a specific repository architecture unless the file is under `examples/`
- keep project-specific or example-specific logic inside `examples/` or repository-specific overlays. Do not introduce it into the generic framework core.

## Questions

Open an issue or pull request with the proposed change and the adoption problem it solves.
