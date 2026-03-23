# AI Engineering Governance Framework

Make AI coding agents behave like senior engineers.

AI-Engineering-Playbook is a governance framework for Codex and similar AI coding agents. It is designed around Codex-first workflows today, while keeping the core portable, reusable, and ready for future agent-specific overlays. The goal is simple: make AI-assisted implementation, refactoring, and review behave more like disciplined senior engineering.

## What This Repository Provides

- a reusable [`AGENTS.md`](./AGENTS.md) for repository-level governance
- a portable skill system under [`skills/`](./skills)
- a generic workflow playbook in [`skills/PLAYBOOK.md`](./skills/PLAYBOOK.md)
- templates in [`templates/`](./templates) for adapting the framework safely
- an example overlay in [`examples/huntr/`](./examples/huntr) showing how one repo specializes the generic core

## Why This Exists

AI coding tools often produce inconsistent review quality. They can be vague, overly permissive, or disconnected from repository boundaries. This framework enforces structure, discipline, and review quality without coupling governance into runtime code.

## Who This Is For

- engineers using AI coding tools in real repositories
- teams doing PR reviews with AI assistance
- people building internal AI development workflows
- advanced users who want governance, not beginner tutorials

## What This Repository Is Not

- not runtime code
- not an SDK
- not a beginner tutorial
- not a deployable service, library, or CI integration

## Quickstart

1. Copy [`AGENTS.md`](./AGENTS.md) into the target repository root.
2. Copy [`skills/`](./skills) into the target repository, or start with a subset of the included skills.
3. Copy the templates from [`templates/`](./templates) and customize them for the target repository.
4. Add repository-specific architecture boundaries, safety rules, and contract expectations to the target repo’s `AGENTS.md`.
5. Keep the generic core generic. Put domain-specific rules and examples in repo-specific overlays or extra skills.
6. Run one test review in the target repository using the adopted `AGENTS.md` and `skills/PLAYBOOK.md`.
7. Refine the overlay only after seeing how the agent behaves on a real PR or refactor.

Versioning note: this framework is versionless by design, but you can pin a snapshot by copying it into your repo.

## Conceptual Flow

```text
User Repo
  -> AGENTS.md
  -> skills/
  -> PLAYBOOK.md
  -> Codex and similar AI coding agents
  -> more consistent implementation and review behavior
```

## Before Vs After

Without this framework:

```text
Looks fine overall. Maybe add a test.
```

With this framework:

```text
Summary
- The change is directionally correct, but it shifts ownership into the CLI layer and weakens the existing contract boundary.

Key Findings
- Business logic moved into presentation code, which creates a second orchestration path.
- The payload shape changed without updating downstream consumers.

Risks
- Hidden regression risk in production paths that still expect the previous contract.

Suggested Improvements
- Move orchestration back into the service layer.
- Restore contract compatibility or update all consumers in the same change.

Suggested Tests
- Add one regression test for the old contract and one integration test for the new path.

Skills applied
- primary: architecture-guardian
- secondary: artifact-contract-reviewer, test-strategy-reviewer
```

## Open Source Design Principles

- generic core
  - the framework defines portable governance, playbook rules, and reusable skills that can travel across repositories
- repo-specific overlays
  - each repository adds its own mission, architecture boundaries, safety policy, and domain-specific skills
- no runtime coupling
  - none of these files should become imports, dependencies, or product-facing features
- structured outputs
  - implementation and review responses should follow explicit sections so findings are easy to inspect and reuse
- strict mode by default
  - the default posture is to surface risks, required improvements, and applied skills rather than produce permissive summaries

## Repository Layout

- [`AGENTS.md`](./AGENTS.md): governance rules for coding agents in a repository
- [`skills/README.md`](./skills/README.md): overview of the skill system
- [`skills/PLAYBOOK.md`](./skills/PLAYBOOK.md): workflow-driven skill routing
- [`skills/*/SKILL.md`](./skills): reusable review and implementation skills
- [`templates/`](./templates): starter files for adoption
- [`examples/huntr/`](./examples/huntr): example adaptation only, not part of the generic core

## GitHub Metadata Suggestions

- Description: Reusable AI engineering governance framework for Codex and similar AI coding agents.
- Tagline: Make AI coding agents behave like senior engineers.
- Topics: `ai`, `codex`, `llm`, `code-review`, `governance`, `developer-tools`, `prompt-engineering`, `ai-agents`

## Community

- [`LICENSE`](./LICENSE)
- [`CONTRIBUTING.md`](./CONTRIBUTING.md)
- [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md)
