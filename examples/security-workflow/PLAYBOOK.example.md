# Security Workflow Playbook Example

## Generic Rules This Example Should Reuse

- one primary skill per code task
- automatic secondary skill selection
- strict-mode review output
- severity-ordered findings
- required `Skills applied` section

## Example-Specific Primary Skills

This example can layer the reusable framework with domain skills such as:

- `discovery-analyst`
- `evidence-triage-reviewer`
- `validation-reviewer`

## Example-Specific Trigger Examples

- add `scope-safety-guard` when side effects, authorization checks, or generated next-step guidance change
- add `performance-optimizer` when the pipeline coordinator changes or duplicate work is introduced
- add `artifact-contract-reviewer` when persisted artifact shapes change
- add `llm-output-reviewer` when prompt or output-validation logic changes
- add `test-strategy-reviewer` for artifact, safety, or fallback regressions

## Example-Specific Review Priorities

- safety and scope first
- artifact compatibility second
- performance after correctness
