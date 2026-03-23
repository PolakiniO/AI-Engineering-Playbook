# HuntR Playbook Example

## Generic Rules HuntR Should Reuse

- one primary skill per code task
- automatic secondary skill selection
- strict-mode review output
- severity-ordered findings
- required `Skills applied` section

## HuntR-Specific Primary Skills

HuntR can layer the reusable framework with domain skills such as:

- `recon-analyst`
- `hypothesis-generator`
- `header-validator`

## HuntR-Specific Trigger Examples

- add `scope-safety-guard` when network behavior, scope checks, redirects, or `safe_next_step` logic changes
- add `performance-optimizer` when `huntr/analysis/service.py` changes or duplicate work is introduced
- add `artifact-contract-reviewer` when JSON artifact shapes change
- add `llm-output-reviewer` when `huntr/llm/client.py` prompt or validation logic changes
- add `test-strategy-reviewer` for artifact, safety, or fallback regressions

## HuntR-Specific Review Priorities

- safety and scope first
- artifact compatibility second
- performance after correctness
