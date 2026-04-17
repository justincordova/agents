# Code Quality

## Testing Philosophy

Tests are required when:
- Building new features or APIs
- Fixing bugs (write a test that reproduces the bug first)
- Writing libraries or shared utilities
- Touching critical paths (auth, payments, data integrity)

Tests are optional when:
- Prototyping or spiking (throwaway code)
- One-off scripts
- Pure UI tweaks with no logic
- Config changes

## Test Style

- Test behavior, not implementation. Name tests after what they verify.
- One assertion per concept. Group related assertions in one test.
- Don't mock what you don't own. Prefer real dependencies or fakes over mocks.
- Integration tests > unit tests for most application code.
- Unit tests for pure logic, utilities, and edge cases.

## Test Naming

Follow the pattern of the project's existing tests. If no precedent:
```
test_[unit]_[scenario]_[expected]
```
Example: `test_checkout_emptyCart_returns400`

## Coverage

Aim for confidence, not a percentage. Key questions:
- Does every public API have at least one test?
- Are error paths tested?
- Are edge cases covered (empty input, null, overflow)?
- Can I refactor without fear?

If you can't answer yes, write more tests. If you can, you have enough.

## Code Review Standards

Before submitting for review:
- Does it build clean? No warnings.
- Do tests pass?
- Is the diff small enough to review in one sitting?
- Would you be proud to explain this code to a senior engineer?

During review, look for:
- Correctness under edge cases
- Error handling (no silent failures)
- Security (input validation, auth checks)
- Naming (does the code explain itself?)
- Duplication (is there a shared abstraction missing?)

## Error Handling

- Every operation that can fail must handle the failure, propagate it, or explicitly document why it's safe to ignore.
- No silent failures. No swallowed exceptions.
- Errors should be actionable: include context, not just "something went wrong."

## Logging

- Log at appropriate levels: error (something broke), warn (degraded), info (notable events), debug (tracing).
- Never log secrets, tokens, passwords, or PII.
- Include enough context to diagnose: request ID, user ID, relevant identifiers.
