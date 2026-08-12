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
| SkillHub | Awaiting crawl | Check the repository and individual skill pages after refresh |
| OmniSkill | Blocked by submission endpoint | Retry after the platform fixes its JSON response; the GitHub source is valid |

As of the last check, a SkillsMP search did not yet show this repository. This is
not a failure signal before the next scheduled sync. The skills.sh check confirms
that the GitHub source can be discovered by the CLI; it does not yet confirm a
public leaderboard resource or install counter.

## Platform badges and metrics

Only add a numeric badge when the platform documents a public per-repository
metric and its scope is clear.

| Platform | Verification state | Public metric support | Repository treatment |
| --- | --- | --- | --- |
| [skills.sh](https://www.skills.sh/docs) | CLI discovery confirmed; badge unavailable | Install-count badge is documented, but this source currently returns `resource not found` at the badge endpoint | Use a plain GitHub source link until skills.sh provisions the registry resource |
| [SkillsMP](https://skillsmp.com/) | Awaiting indexing | No public per-repository download badge documented in the API docs | Track listing status and link only after indexing |
| [SkillHub](https://skills.palebluedot.live/) | Awaiting crawl | Public docs describe crawl/API behavior, but no per-repository download badge documented | Track listing status and link only |
| [OmniSkill](https://omniskill.online/) | Submission blocked | Registry documents per-skill `download_count`, but the verify form currently returns a JSON parsing error | Retry after platform repair; do not add a badge before indexing |

Current supported badge: **None**

The documented skills.sh badge format is:

```markdown
[![skills.sh](https://skills.sh/b/owner/repo)](https://skills.sh/owner/repo)
```

For this repository, that endpoint currently returns `resource not found`.
The previous `npx skills add PolakiniO/AI-Engineering-Playbook --list` check
verified source discovery and listed all 14 skills, but did not establish that a
public install-count resource had been created.

When another platform is confirmed, add its badge only after checking the
platform's own documentation or creator dashboard. Keep the platform status and
the metric source in this file so the README does not imply cross-platform
download parity.

## OmniSkill submission diagnosis

The repository URL is valid and publicly reachable. The error shown by the
submission form — `Unexpected non-whitespace character after JSON at position 4`
— is a client-side JSON parsing failure in OmniSkill's verify request. It means
the form received a malformed or concatenated response where it expected one
JSON document; it is not evidence that the repository URL or `SKILL.md` layout
is invalid.

Use the canonical URL without a trailing slash when retrying:

```text
https://github.com/PolakiniO/AI-Engineering-Playbook
```

If the same error remains, stop retrying and report it through OmniSkill's
[issue tracker](https://github.com/diegosouzapw/awesome-omni-skill/issues). The
current registry page also reports zero indexed skills, which supports treating
this as an early-platform/backend issue rather than a repository configuration
problem.

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
- [ ] SkillHub indexing confirmed
- [ ] OmniSkill listing confirmed

## Maintenance rule

When a skill, frontmatter field, bundle assignment, or generated artifact changes:

1. Run the three local validation commands above.
2. Update the release commit and date in this file after pushing.
3. Recheck registry pages after the next crawler refresh.

Paid listings and monetization are intentionally deferred.
