```text
    ___    ____     ______            _                      _                   ____  __            __                __  
   /   |  /  _/    / ____/___  ____ _(_)___  ___  ___  _____(_)___  ____ _      / __ \/ /___ ___  __/ /_  ____  ____  / /__
  / /| |  / /_____/ __/ / __ \/ __ `/ / __ \/ _ \/ _ \/ ___/ / __ \/ __ `/_____/ /_/ / / __ `/ / / / __ \/ __ \/ __ \/ //_/
 / ___ |_/ /_____/ /___/ / / / /_/ / / / / /  __/  __/ /  / / / / / /_/ /_____/ ____/ / /_/ / /_/ / /_/ / /_/ / /_/ / ,<   
/_/  |_/___/    /_____/_/ /_/\__, /_/_/ /_/\___/\___/_/  /_/_/ /_/\__, /     /_/   /_/\__,_/\__, /_.___/\____/\____/_/|_|  
                            /____/                               /____/                    /____/                          
```

# AI-Engineering-Playbook

![Open Source](https://img.shields.io/badge/open%20source-yes-2ea44f)
[![MIT License](https://img.shields.io/badge/MIT-license-2563eb)](./LICENSE)
![AI Agents](https://img.shields.io/badge/AI-agents-7c3aed)
![Code Review](https://img.shields.io/badge/code-review-f59e0b)
![Developer Tools](https://img.shields.io/badge/developer-tools-ef4444)

AI can write code.  

This makes it behave like an engineer.

AI-Engineering-Playbook is a governance framework for Codex and similar AI coding agents.

It makes AI-assisted implementation, refactoring, and review behave more like disciplined senior engineering - structured, consistent, and risk-aware.

It is not a tool you run. It is a layer you add.

---

## Demo

This is what a structured, senior-level AI code review should look like.

![AI Code Review Example](./Assets/Demo_Screenshot.png)

> Example output using presentation-optimized mode with enforced structure and readability.

---

## What This Repository Provides

- a reusable [`AGENTS.md`](./AGENTS.md) for repository-level governance  
- a portable skill system under [`skills/`](./skills)  
- a generic workflow playbook in [`skills/PLAYBOOK.md`](./skills/PLAYBOOK.md)  
- templates in [`templates/`](./templates) for adapting the framework safely  
- example overlays in:
  - [`examples/security-workflow/`](./examples/security-workflow)  
  - [`examples/backend-service/`](./examples/backend-service)  
  - [`examples/data-pipeline/`](./examples/data-pipeline)  

---

## Why This Exists

AI coding tools often produce inconsistent results.

They can be:
- vague  
- overly permissive  
- disconnected from repository boundaries  

This framework enforces structure, discipline, and review quality without coupling governance into runtime code.

---

## Who This Is For

- engineers using AI coding tools in real repositories  
- teams doing PR reviews with AI assistance  
- people building internal AI development workflows  
- advanced users who want governance, not beginner tutorials  

---

## What This Repository Is Not

- not runtime code  
- not an SDK  
- not a beginner tutorial  
- not a deployable service, library, or CI integration  

---

## Quickstart

1. Copy [`AGENTS.md`](./AGENTS.md) into the target repository root  
2. Copy [`skills/`](./skills) into the target repository  
3. Copy and customize files from [`templates/`](./templates)  
4. Add repo-specific rules (architecture, safety, contracts) into `AGENTS.md`  
5. Keep the core generic - move domain-specific logic into overlays or custom skills  
6. Run one test review using `AGENTS.md` and `skills/PLAYBOOK.md`  
7. Refine only after observing real behavior on a PR or refactor  

### Optional: Add Portable Slash Commands

If you want shorthand commands such as `/codex-install`, define them in your repository `AGENTS.md` as explicit skill-routing aliases.

Example:

- `/codex-install` -> `skill-installer` (install a skill from curated options or from a GitHub repository path)

Keep slash aliases governance-only (agent workflow behavior), not runtime product behavior.

Important behavior note:

- Defining `/codex-install` in `AGENTS.md` does **not** by itself copy files into other repositories.
- It only tells Codex which skill to use for that turn.
- The actual cross-repo install happens when `skill-installer` pulls from a portable source (such as a public GitHub repository path).

### Optional: Publishable Skill Pattern

Yes, you can make this public-skill friendly.

This repository now includes a reusable onboarding skill:

- [`playbook-installer`](./skills/playbook-installer/SKILL.md)

From any other repository, install it with the built-in `skill-installer` skill by pointing to this public GitHub path (owner/repo/path form), then restart Codex so the new skill is loaded.

Versioning note: this framework is versionless by design, but you can pin a snapshot by copying it into your repo.

### Troubleshooting: `skill-installer` Not Working

If `skill-installer` appears to do nothing (for example after entering a partial input like `Implemen`), use this exact sequence.

#### Quick path: use the setup script

This repository includes a wrapper script so you do not have to remember installer arguments:

```bash
bash scripts/setup-codex-skill.sh
```

By default it installs `playbook-installer` from `openai/skills`.

You can override the source skill:

```bash
bash scripts/setup-codex-skill.sh \
  --repo openai/skills \
  --path skills/.curated/figma-implement-design \
  --ref main

# Optional: if your Codex install lives in a custom location
INSTALLER_SCRIPT="/custom/path/install-skill-from-github.py" bash scripts/setup-codex-skill.sh
```

The setup script auto-discovers the installer in common locations under `/opt/codex/skills` and `$CODEX_HOME/skills` before falling back to `INSTALLER_SCRIPT`.

#### 1) List available skills first (copy exact names)

```bash
python3 /opt/codex/skills/.system/skill-installer/scripts/list-skills.py
```

Then copy an exact skill name from the output (for example `figma-implement-design`).

#### 2) Install using an exact path (not a partial name)

```bash
python3 /opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo openai/skills \
  --path skills/.curated/<exact-skill-name>
```

Example:

```bash
python3 /opt/codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo openai/skills \
  --path skills/.curated/figma-implement-design
```

#### 3) If install fails, diagnose by error text

- **`403`, proxy, or tunnel error**  
  Your environment cannot currently reach GitHub API/content endpoints. Retry from a network-enabled shell or configure proxy/token access.
- **`already exists`**  
  The destination skill folder already exists. Remove/rename the existing folder, or install a different skill.
- **`not found`**  
  The skill name/path is incorrect. Re-run `list-skills.py` and retry with an exact name.

#### 4) Restart Codex after successful install

Newly installed skills are loaded on startup, so restart Codex before trying the skill.

---

## Conceptual Flow

```
User Repo
  -> AGENTS.md
  -> skills/
  -> PLAYBOOK.md
  -> AI coding agents (Codex and similar)
  -> consistent implementation and review behavior
```

---

## Before Vs After

Without this framework:

> Looks fine overall. Maybe add a test.

With this framework:

```
Summary
- The change is directionally correct, but it shifts ownership into the CLI layer and weakens the existing contract boundary.

Key Findings
- Business logic moved into presentation code, creating a second orchestration path.
- Payload shape changed without updating downstream consumers.

Risks
- Hidden regression risk in production paths expecting the previous contract.

Suggested Improvements
- Move orchestration back into the service layer.
- Restore contract compatibility or update all consumers in the same change.

Suggested Tests
- Add one regression test for the old contract and one integration test for the new path.

Skills applied
- primary: architecture-guardian
- secondary: artifact-contract-reviewer, test-strategy-reviewer
```

---

## Open Source Design Principles

- generic core  
  - portable governance, playbooks, and reusable skills  

- repo-specific overlays  
  - each repo defines its own architecture, safety rules, and domain logic  

- no runtime coupling  
  - nothing here becomes application code or dependencies  

- structured outputs  
  - reviews and implementations follow explicit, reusable formats  

- strict mode by default  
  - prioritize risk visibility, required improvements, and clarity over permissive summaries  

---

## Output Modes

- Standard structured output (default)
- Presentation-optimized output (for demos and screenshots)

---

## Repository Layout

- [`AGENTS.md`](./AGENTS.md): governance rules for coding agents  
- [`PLAYBOOK.md`](./PLAYBOOK.md): root-level pointer to the canonical playbook  
- [`skills/README.md`](./skills/README.md): skill system overview  
- [`skills/PLAYBOOK.md`](./skills/PLAYBOOK.md): workflow-driven skill routing  
- [`skills/*/SKILL.md`](./skills): reusable skills  
- [`templates/`](./templates): adoption templates  
- [`examples/security-workflow/`](./examples/security-workflow): security workflow overlay  
- [`examples/backend-service/`](./examples/backend-service): backend service overlay  
- [`examples/data-pipeline/`](./examples/data-pipeline): data pipeline overlay  


---

## Community

- [`LICENSE`](./LICENSE)  
- [`CONTRIBUTING.md`](./CONTRIBUTING.md)  
- [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md)  
