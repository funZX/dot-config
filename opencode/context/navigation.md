<!-- Context: core/navigation | Priority: critical | Version: 1.1 | Updated: 2026-10-23 -->

# Context Navigation

**Purpose**: Top-level index for the context library — routes to the right category

---

## Structure

```
.opencode/context/
├── navigation.md           # This file — top-level router
└── core/                   # Universal standards & workflows
    ├── navigation.md       # Full core index
    ├── standards/          # Code quality, tests, docs, security, analysis
    ├── workflows/          # Review, delegation, breakdown, sessions
    ├── system/             # Context management guide
    ├── config/             # paths.json
    └── context-system/     # Self-management of the context library
```

---

## Quick Routes

| Task | Path |
|------|------|
| **Write code** | `core/standards/code-quality.md` |
| **Write tests** | `core/standards/test-coverage.md` |
| **Write docs** | `core/standards/documentation.md` |
| **Security patterns** | `core/standards/security-patterns.md` |
| **Review code** | `core/workflows/code-review.md` |
| **Delegate task** | `core/workflows/task-delegation-basics.md` |
| **Break down feature** | `core/workflows/feature-breakdown.md` |
| **Run parallel batches** | `core/workflows/parallel-batch-execution.md` |
| **Manage sessions** | `core/workflows/session-management.md` |

---

## By Category

**core/** — Standards, workflows, patterns, and the context system itself.
Full index: `core/navigation.md`

> `core/` is currently the only category. When adding a new category, create
> `{category}/navigation.md` and register it in the table above.
