# TypeScript Review Reference

## Check

- Avoid `any` when a local type, generic, schema, or discriminated union can express the value.
- Avoid unsafe assertions that bypass API validation.
- Confirm optional/null fields match backend or persistence contracts.
- Check enum/string union exhaustiveness.
- Prefer type guards at trust boundaries.
- Watch for `as unknown as`, non-null assertions, and suppressed errors.

## API Data

- Validate response fields used by UI.
- Preserve request IDs/correlation IDs in error helpers.
- Keep query/filter parameter names exactly aligned with backend controllers.
- Ensure export/import shapes match tests and docs.

## Tests

- Type-level safety is not a substitute for runtime tests around external data.
- Add targeted tests when a bug came from a mismatched field name, enum value, or optional field.

