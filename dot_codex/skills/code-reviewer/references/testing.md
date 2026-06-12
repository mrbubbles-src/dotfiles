# Testing Review Reference

## What To Check

- New behavior has tests at the right level: unit, integration, e2e, or contract.
- Tests assert behavior, not implementation details, unless testing a utility.
- Updated API contracts have fixtures/mocks updated.
- Error, empty, loading, and permission-denied paths are covered when user-facing.
- Regression tests exist for fixed bugs.

## Test Smells

- Mocks that do not match real API shapes.
- Tests passing because assertions are too broad.
- Snapshot churn hiding real behavior changes.
- Async tests that do not wait for the actual condition.
- Local-only tests mixed into production source folders when repo rules forbid it.

## Reporting

- Missing tests are findings when the untested behavior is risky or recently changed.
- Include the smallest useful test suggestion.

