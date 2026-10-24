# Context Structure

Core concept: Function-based folder organization ensures easy discovery — organize by what information DOES (function), not just by topic.

## Required Folders

| Folder | Purpose | Content |
|--------|---------|---------|
| `concepts/` | What it is | Core ideas, definitions, architecture decisions |
| `examples/` | Working code | Minimal functional snippets (<30 lines) |
| `guides/` | How to do it | Step-by-step workflows, setup, migrations |
| `lookup/` | Quick reference | Tables, commands, API endpoints, configs |
| `errors/` | Common issues | Error messages + fixes, pitfalls, troubleshooting |

## Structure

```
category/
├── navigation.md       # REQUIRED - maps all files
├── concepts/           # What
├── examples/           # Code
├── guides/             # How
├── lookup/             # Reference
└── errors/             # Issues
```

## Categorization Rules

| Ask yourself | Folder |
|--------------|--------|
| Does it explain **what** something is? | `concepts/` |
| Does it show **working code**? | `examples/` |
| Does it explain **how to do** something? | `guides/` |
| Is it **quick reference** data? | `lookup/` |
| Does it document an **error/issue**? | `errors/` |

## navigation.md Requirement

Every category MUST have `navigation.md` with:
• Purpose (1-2 sentences)
• Navigation tables for each function folder
• Priority levels (critical/high/medium/low)
• Loading strategy (what to load for common tasks)

## Related

• MVI principle: `mvi.md` (what to extract)  
• Templates: `templates.md` (file formats)  
• Creation guide: `../guides/creation.md` (how to create)
