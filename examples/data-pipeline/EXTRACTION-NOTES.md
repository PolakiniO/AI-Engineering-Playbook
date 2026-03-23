# Extraction Notes

## Strong Generic Ideas Preserved In This Example

- mandatory skill use for all code-related work
- one primary skill with layered secondary skills
- playbook-based routing instead of ad hoc prompting
- strict-mode output requirements
- required risk and improvement in every skill-based response
- explicit `Skills applied` section
- conflict resolution that favors correctness and contract stability over convenience

## Example-Specific Material Moved Out Of The Generic Core

- ingestion, processing, validation, and output stage boundaries
- idempotency and retry semantics
- schema and data quality rules
- failure handling and observability expectations
- domain skills tailored to pipeline consistency, data quality, and failure review
- job, schedule, storage, and threshold conventions specific to one pipeline
