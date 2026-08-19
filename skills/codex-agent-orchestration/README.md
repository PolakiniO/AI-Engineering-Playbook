# codex-agent-orchestration

Sets up project-local Codex subagent teams and reusable orchestration workflows.

Generated agents use clear names that combine project, role, and job, such as `companyos_architect_plan_mapper`, `companyos_backend_api_service_builder`, and `companyos_tester_regression_checker`.

## Install

Use the dedicated installer when you only want this skill:

```bash
bash scripts/setup-codex-agent-orchestration-skill.sh
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/codex-agent-orchestration
```

Add `--force` to the local installer if the skill is already installed.

## Use

```text
Use $codex-agent-orchestration to set up and run a project Codex subagent team.
```

To run the generator directly after installation:

```bash
python ~/.codex/skills/codex-agent-orchestration/scripts/generate_project_agents.py --project .
```

Add `--generic-names` when you want portable role/job names without the project prefix, such as `architect_plan_mapper`.
