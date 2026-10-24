# Context System

Core concept: Minimal, concern-based knowledge organization for AI agents. Organize by what you're doing (concern), then by approach/tech for token-efficient, scannable context.

## Key Points

• **MVI Principle**: Core concepts (1-3 sentences), 3-5 bullets, minimal example, reference link — scannable in <30 seconds
• **Two Patterns**: Function-based (repository-specific) OR Concern-based (multi-tech development)
• **Navigation**: Every category has `navigation.md` with ASCII tree + quick routes table (~200-300 tokens)
• **Specialized Navigation**: Cross-cutting concerns get dedicated navigation files (e.g., `ui-navigation.md`)
• **Self-Describing Names**: `code-quality.md` not `code.md` — filenames tell you what's inside

## Function-Based Pattern (Repository-Specific)

```
category/
├── navigation.md
├── concepts/     # What it is
├── examples/     # Working code
├── guides/       # How to
├── lookup/       # Reference
└── errors/       # Common issues
```

## Concern-Based Pattern (Development Context)

```
development/
├── navigation.md
├── frontend/react/    # Concern + tech
├── backend/api/       # Concern + approach
└── data/sql-patterns/ # Concern + approach
```

## Operations

| Command | Purpose |
|---------|---------|
| `/context harvest` | Extract AI summaries → permanent context |
| `/context extract from {source}` | Extract from docs/code/URLs |
| `/context organize {category}` | Restructure to function folders |
| `/context update for {topic}` | Update when APIs change |
| `/context migrate` | Global → local context |
| `/context validate` | Check integrity, MVI compliance |

## Reference

• Navigation design: `context-system/guides/navigation-design-basics.md`  
• Organizing patterns: `context-system/guides/organizing-context.md`  
• Examples: `context-system/examples/navigation-examples.md`  
• Templates: `context-system/standards/templates.md`
