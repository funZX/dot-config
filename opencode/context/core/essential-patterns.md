# Essential Patterns

Core concept: Language-agnostic development patterns for modular, functional, maintainable code — applies across all programming languages.

## Core Philosophy

• **Modular**: Small, focused, reusable components (<100 lines each)
• **Functional**: Pure functions, immutability, composition over inheritance
• **Maintainable**: Self-documenting, testable, predictable

## Critical Patterns

| Pattern | ALWAYS | NEVER |
|---------|--------|-------|
| **Pure Functions** | Same input = same output, no side effects | Mutate external state |
| **Error Handling** | Catch specific errors, log with context | Expose internal details |
| **Input Validation** | Check null, types, ranges, sanitize | Skip validation |
| **Security** | Use env vars for secrets, parameterized queries | Hardcode credentials, log passwords |
| **Logging** | Use levels (Debug, Info, Warning, Error) | Log sensitive data |

## Code Structure

```
component/
├── index.js      # Public interface
├── core.js       # Core logic (pure functions)
├── utils.js      # Helpers
└── tests/        # Tests
```

## Anti-Patterns to Avoid

❌ Mutation/side effects | ❌ Deep nesting (>3 levels) | ❌ God modules (>200 lines)  
❌ Global state | ❌ Large functions (>50 lines) | ❌ Hardcoded credentials

## Quick Checklist

✅ Pure functions | ✅ Input validation | ✅ Error handling | ✅ No hardcoded secrets  
✅ Tests written | ✅ Documentation updated | ✅ No security vulnerabilities

## Related

• Code quality: `standards/code-quality.md`  
• Security: `standards/security-patterns.md`  
• Testing: `standards/test-coverage.md`  
• Documentation: `standards/documentation.md`
