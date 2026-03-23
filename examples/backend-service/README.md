# Backend Service Example

This directory shows how the generic governance framework can be adapted to a typical backend API or service repository.

What stays generic:

- mandatory automatic skill usage
- strict-mode review behavior
- playbook-driven skill selection
- layered review model

What becomes repository-specific:

- controller, service, and repository boundaries
- API contract and validation rules
- persistence and transaction behavior
- error handling conventions
- domain-specific skills such as API contract review, data integrity review, and error handling review

Files here are examples of specialization, not the generic framework itself.
