# artifact-contract-reviewer

Reviews schemas, payloads, serialized artifacts, event contracts, and downstream compatibility.

## Install

```bash
bash scripts/setup-codex-skill.sh --skill artifact-contract-reviewer
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/artifact-contract-reviewer
```

Add `--force` to the local installer if the skill is already installed.

## Use

```text
Use $artifact-contract-reviewer to review this change for schema, payload, and downstream contract risk.
```
