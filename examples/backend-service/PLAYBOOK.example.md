# Backend Service Playbook Example

## Generic Rules This Example Should Reuse

- one primary skill per code task
- automatic secondary skill selection
- strict-mode review output
- severity-ordered findings
- required `Skills applied` section

## Example-Specific Primary Skills

This example can layer the reusable framework with domain skills such as:

- `api-contract-reviewer`
- `data-integrity-reviewer`
- `error-handling-reviewer`

## Example-Specific Trigger Examples

- add `artifact-contract-reviewer` when request or response contracts change
- add `scope-safety-guard` when permissions, auth checks, or side-effecting actions change
- add `performance-optimizer` when query patterns, batching, or service orchestration changes
- add `llm-output-reviewer` when model-assisted endpoint or decision logic changes
- add `test-strategy-reviewer` for contract, validation, or transaction regressions

## Example-Specific Review Priorities

- API contract stability first
- correctness and data integrity second
- error handling consistency third
- performance after correctness
