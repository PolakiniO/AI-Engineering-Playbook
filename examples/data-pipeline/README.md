# Data Pipeline Example

This directory shows how the generic governance framework can be adapted to a batch or asynchronous data pipeline repository.

What stays generic:

- mandatory automatic skill usage
- strict-mode review behavior
- playbook-driven skill selection
- layered review model

What becomes repository-specific:

- ingestion, processing, validation, and output stage boundaries
- idempotency and retry expectations
- schema and data quality rules
- failure handling and observability conventions
- domain-specific skills such as pipeline consistency review, data quality review, and failure mode review

Files here are examples of specialization, not the generic framework itself.
