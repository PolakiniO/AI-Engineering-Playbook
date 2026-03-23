# Data Pipeline AGENTS Example

## What This Example Repository Should Customize

This example repository should keep the generic strict-mode and skill-usage policy, then add its repo-specific rules:

- mission: ingest, process, validate, and publish data reliably across pipeline stages
- non-goal: hiding pipeline semantics behind ad hoc scripts or one-off operators
- architecture boundaries:
  - ingestion reads from approved inputs and produces normalized stage inputs
  - processing applies deterministic transformations
  - validation enforces schema and quality expectations
  - output stages publish durable results and status signals
- pipeline correctness rules:
  - stage boundaries must remain explicit
  - idempotency should be preserved for retried or replayed work
  - schema validation must happen before downstream publication
  - partial failures should not silently corrupt outputs
- failure handling rules:
  - retries must be deliberate and bounded
  - failed records or batches should be inspectable
  - state transitions should remain observable and auditable

## What This Example Should Not Keep Generic

Do not place these into the reusable framework core:

- references to concrete job names, queue topics, or schedule names
- references to repo-specific stage directories or task runners
- references to storage bucket names, warehouse tables, or internal schemas
- references to operational thresholds that only fit one pipeline
- data-domain assumptions that are not portable
