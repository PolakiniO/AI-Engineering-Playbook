# Marketplace Submission Plan

The GitHub repository is the canonical public source:

<https://github.com/PolakiniO/AI-Engineering-Playbook>

Run the exporter before submitting or sharing a release:

```bash
python3 scripts/export-codex-skills.py
python3 scripts/validate-skill-distribution.py
```

## Free discovery listings

- **SkillsMP**: submit or wait for the public GitHub source to be indexed; use
  the repository README as the primary landing page.
- **skills.sh**: use the generated frontmatter-compliant skills and the free
  install command from `products/catalog.json`.
- **AI Agents Directory**: submit the repository as an open-source skill source.
- **SkillHub**: allow the public repository to be crawled and review the listing
  after synchronization.
- **OmniSkill**: submit the GitHub repository URL and verify the generated skill
  paths appear correctly.

## Paid distribution — deferred

Do not create paid marketplace listings yet. Revisit Agensi, PromptBase, or
direct services after the free distribution has produced meaningful install,
usage, and feedback signals.

## Listing checklist

- [ ] One-sentence outcome and target buyer
- [ ] Exact skill list and compatibility notes
- [ ] Install command and source repository
- [ ] Three representative before/after examples
- [ ] Evaluation method and known limitations
- [ ] Changelog and version identifier
- [ ] No secrets, hidden network calls, or destructive defaults
- [ ] MIT license and source attribution are clear
