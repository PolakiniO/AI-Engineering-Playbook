# Security Workflow AGENTS Example

## What This Example Repository Should Customize

This example repository should keep the generic strict-mode and skill-usage policy, then add its repo-specific rules:

- mission: AI-assisted security workflow and evidence review tool
- non-goal: autonomous offensive tooling
- architecture boundaries:
  - presentation logic in interface modules
  - orchestration in a single pipeline coordinator
  - service logic in domain services
  - persistence in storage modules and artifact writers
- safety rules:
  - explicit authorization checks before side-effecting work
  - conservative generated next-step guidance
  - no destructive or unbounded actions
- artifact contract rules:
  - stable persisted artifact shapes
  - downstream compatibility across discovery, analysis, validation, and reporting

## What This Example Should Not Keep Generic

Do not place these into the reusable framework core:

- references to concrete module paths
- references to repo-specific generated guidance fields
- references to repo-specific artifact directories or filenames
- repo-specific command naming conventions
- security-domain assumptions that are not portable
