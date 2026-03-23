# Data Pipeline Playbook Example

## Generic Rules This Example Should Reuse

- one primary skill per code task
- automatic secondary skill selection
- strict-mode review output
- severity-ordered findings
- required `Skills applied` section

## Example-Specific Primary Skills

This example can layer the reusable framework with domain skills such as:

- `pipeline-consistency-reviewer`
- `data-quality-reviewer`
- `failure-mode-reviewer`

## Example-Specific Trigger Examples

- add `artifact-contract-reviewer` when stage schemas or published outputs change
- add `scope-safety-guard` when external writes, approvals, or destructive cleanup behavior changes
- add `performance-optimizer` when batching, partitioning, concurrency, or retry behavior changes
- add `llm-output-reviewer` when model-assisted classification or transformation is introduced
- add `test-strategy-reviewer` for idempotency, schema, retry, or partial-failure regressions

## Example-Specific Review Priorities

- idempotency and schema stability first
- data quality and failure handling second
- throughput and efficiency after correctness
