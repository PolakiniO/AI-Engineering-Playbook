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

## Standard Review Flow

1. Read the repository `AGENTS.md`.
2. Identify the files and contracts touched by the task.
3. Select one primary skill.
4. Add secondary skills from the matrix above.
5. Produce a strict-mode output.
6. End with `Skills applied`.
