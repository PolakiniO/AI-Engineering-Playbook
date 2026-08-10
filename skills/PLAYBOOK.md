# Generic Skills Playbook

This playbook explains how Codex and similar AI coding agents should apply reusable skills during work in an adopting repository.

It does not define product behavior. It defines how agent review and implementation guidance should be combined.

## Core Operating Rules

- Start from the current codebase and docs, not assumptions.
- Select one primary skill for every code-related task.
- Add secondary skills automatically based on the change surface and risk profile.
- Use strict mode by default.
- Keep findings ordered by severity, not by skill source.
- If skills conflict, safety and correctness win over convenience or speed.

## Strict Mode

Strict mode is mandatory for implementation guidance, refactors, bug investigations, and PR reviews.

Required response behavior:

- use the selected skill output structure
- use standard structured output by default
- presentation-optimized output is optional for screenshots, demos, public examples, or terminal readability
- presentation may improve readability, but it must preserve the same required sections, ordering, and substance
- syntax highlighting is allowed only when it helps readability and consistency
- include at least one risk
- include at least one improvement
- include `Skills applied`
- avoid empty permissive summaries
- write `None` explicitly when a required section has no content

Plain output is preferred for routine work. Presentation-optimized output is useful for demo screenshots and public examples.

## Skill Selection Matrix

- `playbook-installer`
  - primary for repository onboarding, initial framework adoption, and governance-file migration planning
- `codex-agent-orchestration`
  - primary for project-local `.codex/agents/*.toml` teams, software-factory workflows, parallel Codex subagents, and reusable agent chains
- `project-engineer`
  - primary for turning an idea, design, sketch, brief, or prototype into the simplest feasible project plan
- `product-designer`
  - primary for product design, UX, frontend visual direction, design quality, and avoiding generic AI-looking interfaces
- `deployment-engineer`
  - primary for hosting, CI/CD, release, rollback, environments, and deployment readiness
- `security-engineer`
  - primary for security planning, tool reuse decisions, dependency/service review, secrets, permissions, and scan requirements
- `operations-engineer`
  - primary for observability, reliability, runbooks, backups, recovery, support, and operational readiness
- `finance-engineer`
  - primary for cost estimation, FinOps, budgets, usage controls, cleanup, and lowest-feasible-cost planning
- `architecture-guardian`
  - primary for layering, ownership, module boundaries, service boundaries, or repository structure changes
- `scope-safety-guard`
  - required when changes affect security boundaries, permission checks, side effects, external calls, sensitive operations, or safety language
- `performance-optimizer`
  - required when changes affect performance, duplicate work, caching, batching, scaling, or performance claims
- `artifact-contract-reviewer`
  - required when changes affect schemas, serialized artifacts, API payloads, event contracts, or downstream consumers
- `llm-output-reviewer`
  - required when changes affect prompts, inference flow, output validation, fallback behavior, or LLM-driven actions
- `test-strategy-reviewer`
  - required when testing coverage is missing, unclear, or risky

## 1. Feature Implementation

### Skill Selection

- Primary skill:
  - `architecture-guardian` for most code features unless a narrower primary concern dominates
  - `artifact-contract-reviewer` if the feature is centered on a new or changed contract
  - `llm-output-reviewer` if the feature is centered on model-driven behavior
- Add `scope-safety-guard` for externally visible effects, security-sensitive paths, or safety constraints.
- Add `performance-optimizer` if the feature claims efficiency gains or changes high-cost paths.
- Add `test-strategy-reviewer` when verification is non-trivial or risk is high.

### Invocation Order

1. `scope-safety-guard` if safety boundaries are touched
2. one primary skill
3. `artifact-contract-reviewer` if contracts change
4. `performance-optimizer` if performance is material
5. `test-strategy-reviewer`

### Combination Rules

- Use the primary skill to define implementation boundaries.
- Treat `scope-safety-guard` constraints as non-negotiable.
- Treat `artifact-contract-reviewer` findings as blocking when downstream compatibility is at risk.
- Use `performance-optimizer` to shape implementation details, not to justify unsafe shortcuts.
- Use `test-strategy-reviewer` to define the minimum verification bar before completion.

## 2. Refactoring

### Skill Selection

- Primary skill: `architecture-guardian`
- Add `artifact-contract-reviewer` if any public or persisted contract might shift.
- Add `scope-safety-guard` if permissions, side effects, or safety checks are touched.
- Add `performance-optimizer` if the refactor is partly justified by efficiency.
- Add `test-strategy-reviewer` when behavior-preservation risk is material.

### Invocation Order

1. `architecture-guardian`
2. `scope-safety-guard` if relevant
3. `artifact-contract-reviewer` if relevant
4. `performance-optimizer` if relevant
5. `test-strategy-reviewer`

### Conflict Resolution

- preserve behavior first
- preserve safety second
- optimize last

## 3. PR Review

### Skill Selection

- Choose one primary skill based on the PR’s dominant risk.
- Add all secondary skills triggered by the diff surface.
- Add `test-strategy-reviewer` unless verification is already complete and low-risk.

### Invocation Order

1. `scope-safety-guard` if relevant
2. one primary skill
3. `artifact-contract-reviewer` if relevant
4. `performance-optimizer` if relevant
5. `llm-output-reviewer` if relevant
6. `test-strategy-reviewer`

### Review Rules

- merge findings into one report
- order by severity
- call out blocking contract or safety issues clearly
- include at least one improvement even when the code is acceptable

## 4. Bug Investigation

### Skill Selection

- Primary skill:
  - `architecture-guardian` for ownership and control-flow issues
  - `artifact-contract-reviewer` for format, persistence, interface, or consumer breakage
  - `llm-output-reviewer` for model-output or fallback bugs
  - `performance-optimizer` for latency, timeout, or duplicate-work bugs
- Add `scope-safety-guard` if the bug affects side effects or safety controls.
- Add `test-strategy-reviewer` when the bug lacks a clear reproducible guard against recurrence.

### Combination Rules

- establish root-cause candidates first
- validate contract and safety impacts second
- define regression-proof tests before closing the investigation

## 5. Performance Analysis

### Skill Selection

- Primary skill: `performance-optimizer`
- Add `architecture-guardian` if fixing performance requires boundary changes.
- Add `scope-safety-guard` if optimization alters security or operational constraints.
- Add `artifact-contract-reviewer` if reuse, caching, or batching changes externally visible behavior.
- Add `test-strategy-reviewer` for benchmarking or regression verification expectations.

### Combination Rules

- use evidence before proposing optimization
- prefer removal of duplicate work before speculative micro-optimization
- reject improvements that hide stale state, weaken safety, or obscure ownership

## 6. Idea-To-Project Delivery

### Skill Selection

- Primary skill: `project-engineer`
- Add `product-designer` when the request includes UI, UX, brand, screenshots, product experience, frontend implementation, or "make it look real" expectations.
- Add `security-engineer` when adopting tools, dependencies, services, integrations, deployment platforms, auth, secrets, or network exposure.
- Add `deployment-engineer` when the project needs local preview, staging, production, CI/CD, hosting, rollback, or environment guidance.
- Add `operations-engineer` when the project needs monitoring, logging, support, runbooks, backups, recovery, or production readiness.
- Add `finance-engineer` when cloud services, SaaS tools, AI APIs, usage-based pricing, paid seats, or cost minimization matter.
- Add existing review skills when implementation changes architecture, safety, contracts, performance, LLM behavior, or test strategy.

### Invocation Order

1. `project-engineer`
2. `product-designer` if product or frontend experience matters
3. `security-engineer` before approving any new or reused third-party tool
4. `deployment-engineer` before implementation hardens around hosting assumptions
5. `operations-engineer` before launch, handoff, or production use
6. `finance-engineer` before committing to paid or usage-based resources
7. existing review skills from this playbook for implementation risk

### Combination Rules

- simplest feasible path wins unless it violates security, operability, or user needs
- existing tools should be reused only after a security review confirms they are fit for purpose
- deployment should be planned early enough to shape implementation, not patched on at the end
- cost controls should be explicit for paid, usage-based, preview, staging, and demo resources
- design quality is part of project delivery and should be checked before final implementation acceptance

## 7. Agent Orchestration

### Skill Selection

- Primary skill: `codex-agent-orchestration`
- Add `architecture-guardian` when generated agents change repository instructions, ownership boundaries, or work delegation structure.
- Add `scope-safety-guard` when orchestration could trigger external effects, deployment, credential access, permissions, or security-sensitive work.
- Add `test-strategy-reviewer` when generated agent workflows need validation, regression protection, or dry-run coverage.

### Combination Rules

- generate project-local agents only after inspecting existing `AGENTS.md` and `.codex/` files
- run the generator with `--dry-run` before overwriting hand-written orchestration files
- keep the parent session responsible for approvals, commits, pushes, deployments, and final synthesis
- never run write-capable subagents concurrently against overlapping file scopes

## Standard Review Flow

1. Read the repository `AGENTS.md`.
2. Identify the files and contracts touched by the task.
3. Select one primary skill.
4. Add secondary skills from the matrix above.
5. Produce a strict-mode output.
6. End with `Skills applied`.
