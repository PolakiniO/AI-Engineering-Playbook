# HuntR Example

This directory shows how the generic governance framework can be adapted to the HuntR repository.

What stays generic:

- mandatory automatic skill usage
- strict-mode review behavior
- playbook-driven skill selection
- layered review model

What becomes HuntR-specific:

- bug bounty safety posture
- local-first workflow constraints
- `huntr/` module ownership and CLI/service boundaries
- JSON artifact paths under `data/artifacts/`
- domain-specific skills such as recon, hypothesis generation, and header validation

Files here are examples of specialization, not the generic framework itself.
