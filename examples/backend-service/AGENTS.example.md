# Backend Service AGENTS Example

## What This Example Repository Should Customize

This example repository should keep the generic strict-mode and skill-usage policy, then add its repo-specific rules:

- mission: maintain a reliable backend API and service layer for application features
- non-goal: placing domain logic directly into transport or storage layers
- architecture boundaries:
  - controllers accept requests, perform input shaping, and return responses
  - services own business logic and orchestration
  - repositories handle persistence and query concerns
  - validation logic is explicit and shared where appropriate
- data and correctness rules:
  - no business logic in controllers
  - data integrity checks must happen before state-changing writes
  - request and response validation should remain explicit
  - transaction boundaries should be deliberate and consistent
- error handling rules:
  - errors should be normalized before reaching transport boundaries
  - failure responses should be consistent across endpoints
  - low-level persistence errors should not leak raw internal details to API consumers

## What This Example Should Not Keep Generic

Do not place these into the reusable framework core:

- references to concrete framework files or endpoint paths
- references to repo-specific controller or repository names
- references to database tables, migrations, or tenant rules
- references to transport-specific command names
- API conventions that are only true for one service
