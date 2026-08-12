# Free Distribution Status

Last verified: **2026-08-12**

Current focus: **free discovery and installation**
Release commit: **5b0dd88** (`Prepare free agent skills distribution`)

## Overall status

**Free distribution is validated on GitHub and skills.sh.** The repository is
public, the skills are frontmatter-compliant, the required GitHub topics were
added, and the generated distribution artifacts pass local validation.

This does not yet mean every registry has indexed the repository. Registry
crawlers and sync schedules are external and must be checked after their next
refresh.

## Prerequisites

| Check | Status | Evidence |
| --- | --- | --- |
| Public GitHub repository | Done | `PolakiniO/AI-Engineering-Playbook` |
| `SKILL.md` files under `skills/` | Done | 14 canonical skills |
| YAML frontmatter | Done | `name`, `description`, and metadata validated |
| GitHub topics | Done | `claude-skills` and `claude-code-skill` added by maintainer |
| Changes pushed to `main` | Done | Commit `5b0dd88` |
| Neutral generated distribution | Done | `dist/agent-skills/` |
| Codex generated distribution | Done | `dist/codex-skills/` |
| Local artifact validation | Pass | `scripts/validate-skill-distribution.py` |

## Registry status

| Registry | Current status | Next action |
| --- | --- | --- |
| SkillsMP | Awaiting next sync | Search for the repository and record the creator/skill URL |
| skills.sh | Confirmed | `npx skills add PolakiniO/AI-Engineering-Playbook --list` found all 14 skills |
| AI Agents Directory | Ready for free submission | Submit the public GitHub repository if not auto-discovered |
| SkillHub | Awaiting crawl | Check the repository and individual skill pages after refresh |
| OmniSkill | Ready for free submission | Submit the public GitHub repository URL and verify paths |

As of the last check, a SkillsMP search did not yet show this repository. This is
not a failure signal before the next scheduled sync. The skills.sh check is now
confirmed independently from the web leaderboard.

## Local validation

Run from the repository root:

```bash
python3 scripts/export-codex-skills.py
python3 scripts/validate-skill-distribution.py
git diff --check
```

Expected validation output:

```text
Validated 14 canonical skills and 2 product bundles
```

## Discovery checklist

- [x] Repository is public
- [x] Canonical skills contain standard frontmatter
- [x] `claude-skills` topic added
- [x] `claude-code-skill` topic added
- [x] Free bundle catalog is present
- [x] Starter evaluation pack is present
- [ ] SkillsMP indexing confirmed
- [x] skills.sh indexing confirmed
- [ ] AI Agents Directory listing confirmed
- [ ] SkillHub indexing confirmed
- [ ] OmniSkill listing confirmed

## Maintenance rule

When a skill, frontmatter field, bundle assignment, or generated artifact changes:

1. Run the three local validation commands above.
2. Update the release commit and date in this file after pushing.
3. Recheck registry pages after the next crawler refresh.

Paid listings and monetization are intentionally deferred.
