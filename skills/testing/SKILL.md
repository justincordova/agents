---
name: testing
description: Use when writing tests, deciding what to test, or choosing testing approaches. Practical guidance for test design and strategy.
---

# Testing

## Overview

Practical testing guidance: what to test, how to test it, and when tests matter. Not dogmatic TDD — just enough testing to give you confidence.

**Core principle:** Tests should give you confidence to ship and refactor without fear.

## What to Test

### Always Test
- Public APIs and interfaces
- Bug fixes (reproduce the bug first)
- Critical paths: auth, payments, data integrity, security
- Business logic and state transitions
- Edge cases: empty input, null, zero, max values, unicode

### Usually Test
- Shared utilities and libraries
- Data transformations and parsers
- Error handling paths

### Skip Testing
- Prototypes and spikes (throwaway code)
- One-off scripts
- Pure UI layout tweaks with no logic
- Third-party library behavior (that's their tests)
- Config changes

## Test Design

### Test Behavior, Not Implementation

```python
# BAD: Tests implementation details
def test_user_service_calls_repository():
    mock_repo.get.assert_called_once_with(user_id=1)

# GOOD: Tests observable behavior
def test_get_user_returns_user_when_exists():
    result = user_service.get_user(user_id=1)
    assert result.name == "Justin"
```

### One Concept Per Test

```python
# BAD: One giant test
def test_checkout():
    # tests empty cart
    # tests invalid item
    # tests successful checkout
    # tests total calculation
    pass

# GOOD: Separate tests
def test_checkout_empty_cart_returns_error():
    ...

def test_checkout_invalid_item_returns_error():
    ...

def test_checkout_successful_returns_order():
    ...
```

### Test Naming

Follow the project's existing convention. If no precedent:

```
test_[unit]_[scenario]_[expected]
```

Examples:
- `test_login_invalidPassword_returns401`
- `test_checkout_emptyCart_returnsError`
- `test_parse_validJson_returnsObject`

## Test Types — When to Use What

| Type | When | Speed |
|------|------|-------|
| **Unit** | Pure logic, utilities, edge cases | Fast |
| **Integration** | API endpoints, database operations, service interactions | Medium |
| **E2E** | Critical user flows, cross-service behavior | Slow |

**Default to integration tests** for application code. Unit tests for pure logic.

Most bugs happen at integration boundaries, not inside pure functions.

## Mocking Guidelines

- Don't mock what you don't own. Use real dependencies or fakes.
- Prefer fakes (in-memory implementations) over mocks when possible.
- Mock external services (APIs, queues) — you don't control them.
- If you're mocking more than 2-3 things in one test, test at a different level.

## Coverage Philosophy

Aim for confidence, not a number.

**You have enough coverage when:**
- Every public API has at least one test
- Error paths are tested
- Edge cases are covered
- You can refactor without fear

**You don't have enough when:**
- You're afraid to change code because tests might break
- You can't answer "what happens if this fails?"
- Bug fixes keep appearing in the same area

## Test Organization

Mirror the source structure:
```
src/
  auth/
    login.ts
    logout.ts
tests/
  auth/
    login.test.ts
    logout.test.ts
```

Co-locate when the project prefers it:
```
src/
  auth/
    login.ts
    login.test.ts
```

Follow the project's existing pattern.

## Common Mistakes

| Don't | Do Instead |
|-------|-----------|
| Test implementation details | Test observable behavior |
| Write tests after "just to have them" | Write tests that verify something specific |
| Mock everything | Use real deps when practical |
| Chase 100% coverage | Cover what matters |
| Write brittle tests (tight coupling) | Test the contract, not the internals |
| Skip testing error paths | Test what happens when things fail |
