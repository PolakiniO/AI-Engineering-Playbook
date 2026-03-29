# AGENTS.md

## Repository Purpose

This repository contains governance documentation, review workflows, and reusable skills for Codex and similar AI coding agents.

It is not application runtime code.

Agents should treat this repository as a reusable framework for:

- implementation guidance
- refactoring guidance
- PR review structure
- bug investigation guidance
- performance analysis guidance
- portable repository governance

## Core Operating Principles

- Start from repository reality, not assumptions.
- Keep agent guidance separate from runtime code.
- Prefer explicit architectural boundaries over implicit conventions.
- Treat schema and interface contracts as first-class review concerns.
- Safety, correctness, and contract stability outrank convenience.
- Performance work must be evidence-based and must not weaken safety or correctness.

## Mandatory Skill Usage

The files under `skills/` are internal reasoning tools for Codex and similar AI coding agents.

Required workflow:

- For every feature implementation, refactor, bug fix, PR review, bug investigation, or code analysis request, automatically select one primary skill from `skills/`, even if the user does not mention skills explicitly.
- Add secondary skills according to [`skills/PLAYBOOK.md`](./skills/PLAYBOOK.md).
- Skill usage is mandatory for code-related work. It is not prompt-dependent.

## Optional Slash-Command Skill Routing

To support portable shorthand triggers (for example `/codex-install`) across repositories, define explicit slash-command aliases in `AGENTS.md`.

Recommended pattern:

- reserve slash commands for development-time governance actions, not runtime product behavior
- map each slash command to one concrete skill name
- document expected inputs and outputs inline so behavior is reproducible in other repositories

Example alias:

- `/codex-install` -> use `skill-installer` to install a Codex skill from the curated catalog or a GitHub repository path

Behavior clarification:

- adding this alias does not automatically copy files into other repositories by itself
- the alias only routes the current turn to `skill-installer`; that installer performs the actual install action
- to make this portable, install from a stable public source (for example, a GitHub repo path) that any target repository can access

Implementation note for adopters:

- include a trigger rule such as: "If the user invokes `/codex-install`, apply `skill-installer` for this turn."
- keep this alias block in the repository root `AGENTS.md` so it copies cleanly to other repositories

Operating constraints:

- Skills are governance artifacts, not product features.
- Skills must not be exposed through application runtime interfaces.
- Skills must not create runtime coupling to the codebase being reviewed.
- If skill guidance conflicts, safety and correctness constraints win over convenience or speed.

## Strict-Mode Review Behavior

Strict mode is mandatory by default for all skill-based code work.

Requirements:

- Responses must follow the output structure defined by the selected skill.
- Standard structured output is the default for normal reviews, PR comments, issues, and general repository work.
- Presentation-optimized output is optional for screenshots, demos, public examples, or terminal readability.
- Presentation may change formatting only. It must not change meaning, completeness, or section order.
- Syntax highlighting or visually enhanced formatting is allowed only when it improves readability and consistency.
- No required section may be omitted.
- If a section has no content, write `None`.
- Reviews must be critical by default, not permissive by default.
- Do not default to `no issues found` without explicit justification.
- Every skill-based response must include at least:
  - one risk
  - one improvement
  - one `Skills applied` section

## Required Response Shape For Code Work

Every skill-based implementation or review response must include:

- `Summary`
- `Key Findings`
- `Risks`
- `Affected Files`
- `Suggested Improvements`
- `Suggested Tests`
- `Skills applied`

When the selected skill requires extra sections, include them as well.

Plain output is preferred for routine work. Presentation-optimized output is useful for demo screenshots and public examples.

## Automatic Skill Routing Rules

- Use `architecture-guardian` when a change affects boundaries, ownership, layering, or repository structure.
- Use `scope-safety-guard` when a change affects security boundaries, permissions, external effects, or safety constraints.
- Use `performance-optimizer` when a change affects latency, throughput, duplicate work, scaling behavior, or performance claims.
- Use `artifact-contract-reviewer` when a change affects artifacts, schemas, interfaces, payloads, or downstream consumers.
- Use `llm-output-reviewer` when a change affects prompts, model output validation, fallback behavior, or model-driven decisions.
- Use `test-strategy-reviewer` when a change affects testing strategy, introduces regression risk, or lacks clear verification coverage.

Every code task must choose one primary skill. Additional skills are layered according to the playbook.

## Generic Governance Boundaries

This framework intentionally does not define:

- product runtime behavior
- repo-specific domain logic
- repo-specific file ownership
- repo-specific artifact layouts
- repo-specific safety policies

Each adopting repository must customize those areas explicitly.

## Adoption Guidance

When this framework is copied into another repository, customize:

- project mission and non-goals
- architecture layers and ownership boundaries
- safety and compliance rules
- schema or artifact contracts
- domain-specific skill set
- examples and file references
