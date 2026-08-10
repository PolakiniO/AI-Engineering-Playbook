# llm-output-reviewer

Reviews prompts, model output validation, fallback behavior, and LLM-driven decisions.

## Install

```bash
bash scripts/setup-codex-skill.sh --skill llm-output-reviewer
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/llm-output-reviewer
```

Add `--force` to the local installer if the skill is already installed.

## Use

```text
Use $llm-output-reviewer to review this change for prompt behavior, output validation, and fallback risks.
```
