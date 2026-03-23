# HuntR AGENTS Example

## What HuntR Should Customize

HuntR should keep the generic strict-mode and skill-usage policy, then add its repo-specific rules:

- mission: local-first AI-assisted bug bounty workflow tool
- non-goal: exploitation framework
- architecture boundaries:
  - Rich rendering in `huntr/cli/app.py`
  - orchestration in `huntr/analysis/service.py`
  - service logic in domain services
  - persistence in `huntr/storage/` and `huntr/*/artifacts.py`
- safety rules:
  - scope enforcement before live requests and after redirects
  - conservative `safe_next_step` behavior
  - no brute force, destructive testing, or off-scope behavior
- artifact contract rules:
  - JSON artifact stability under `data/artifacts/`
  - downstream compatibility across recon, hypotheses, validation, and analysis

## What HuntR Should Not Keep Generic

Do not place these into the reusable framework core:

- references to `huntr/analysis/service.py`
- references to `safe_next_step`
- references to `data/artifacts/recon/`, `hypotheses/`, `validation/`, or `analysis/`
- repo-specific command naming conventions
- bug bounty domain assumptions
