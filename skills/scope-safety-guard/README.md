# scope-safety-guard

Reviews permissions, security boundaries, sensitive operations, external effects, and safety constraints.

## Install

```bash
bash scripts/setup-codex-skill.sh --skill scope-safety-guard
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/scope-safety-guard
```

Add `--force` to the local installer if the skill is already installed.

## Use

```text
Use $scope-safety-guard to review this change for permission, side-effect, and safety-boundary risks.
```
