# product-designer

Turns ideas, workflows, screenshots, or briefs into specific, polished product design direction.

The reference-driven workflow is **inspect -> explore -> select -> specify -> build within scope -> verify -> reuse**. It turns concrete references into implementation-ready design recipes, rather than treating "make it beautiful" as a sufficient specification.

## Install

```bash
bash scripts/setup-codex-skill.sh --skill product-designer
```

From GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo PolakiniO/AI-Engineering-Playbook \
  --path dist/codex-skills/product-designer
```

Add `--force` to the local installer if the skill is already installed.

Copy or install the entire skill directory, not only `SKILL.md`: the workflow uses bundled `assets/` and `references/`. Existing installed copies need updating to receive these additions. Installing this skill does not install a component library, enable a remote service, or update any other project automatically.

## Use

```text
Use $product-designer to turn this idea or interface into a specific, polished, implementation-ready product design.
```

For a report or substantial redesign:

```text
Use product-designer in design mode. Inspect the existing design system and
this sanitized content, compare up to three genuinely different layouts,
recommend one, and prepare a design recipe and implementation handoff.
Keep source evidence and limitations visible. No production changes,
paid services, external uploads, or new dependencies are authorized.
```

For an implementation or review:

```text
Use product-designer in build mode to implement the selected direction in
the authorized files only. Reuse existing tokens and primitives, preserve
the data contract, and report actual verification results.
```

```text
Use product-designer in review mode. Check this interface against its
brief, source data, responsive requirements, and accessibility target.
Do not modify files. Distinguish failures from checks that were not run.
```

The plain-name examples also work as instructions to agents that read the playbook directly; native discovery and invocation depend on the host. A narrow UI repair should retain the existing direction rather than trigger an unnecessary redesign.

## Included resources

| Resource | Purpose |
| --- | --- |
| [SKILL.md](SKILL.md) | Modes, permissions, workflow, evidence-aware design, and strict output structure |
| [Design brief](assets/design-brief.template.md) | Audience, constraints, reference ledger, alternatives, and selection rationale |
| [Design recipe](assets/design-recipe.template.yaml) | Data contract, states, tokens, accessibility, provenance, and acceptance checks |
| [Implementation handoff](assets/implementation-handoff.template.md) | Exact scope, implementation mapping, bounded prompt, and verification record |
| [Quality gates](references/quality-gates.md) | Scope, content fidelity, usability concerns, functional checks, accessibility, and cost |
| [Examples and evaluations](references/examples-and-evaluations.md) | Synthetic evidence-card fixture, reusable pattern examples, and ten behavioral trials |
| [Sources](references/sources.md) | Optional inspiration, accessibility references, and reuse boundaries |

Templates are design-time documentation, not executable schemas or runtime dependencies. Load them only when the task warrants them. The behavioral trials are specifications, not a claim that evaluations or UI tests have already passed.

## Integration and boundaries

The existing `product-designer` name, manifest metadata, automatic routing, and output section order remain compatible. No second designer skill is introduced. Add complementary review skills through the existing playbook when dependencies, security, contracts, or test strategy warrant them.

The canonical source is this folder. The repository exporter copies `SKILL.md`, `assets/`, and `references/` into both `dist/agent-skills/product-designer/` and `dist/codex-skills/product-designer/`; the Codex distribution retains its generated agent metadata.

This skill requires no marketplace, paid API, cloud model, or particular UI framework. It honors local-only and read-only constraints, keeps production writes separate from design exploration, and requires evidence before marking an implementation ready or a recipe reviewed. Inspiration from 21st.dev is acknowledged without bundling its code or assets.
