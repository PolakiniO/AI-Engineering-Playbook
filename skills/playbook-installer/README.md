# playbook-installer

Onboards repositories to AI-Engineering-Playbook governance safely and incrementally.

## Install

Default local install:

```bash
bash scripts/setup-codex-skill.sh
```

Explicit local install:

```bash
bash scripts/setup-codex-skill.sh --skill playbook-installer
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/playbook-installer
```

Add `--force` to the local installer if the skill is already installed.

## Use

```text
Use $playbook-installer to onboard this repository to the AI-Engineering-Playbook safely and incrementally.
```
