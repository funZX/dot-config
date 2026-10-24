# Feature Breakdown

Core concept: Lightweight manual breakdown technique for complex features (4+ files, >60 min) when NOT delegating to subagents. Creates markdown checklists for planning work executed directly.

## Key Points

• **When to use**: 4+ files, >60 min effort, complex dependencies, multi-step coordination — without TaskManager delegation
• **NOT for subagents**: Use `TaskManager` for JSON task files (`task.json`, `subtask_NN.json`) with parallel batch execution
• **Process**: Scope → Phases → Small Tasks (1-2h) → Dependencies → Estimates
• **Task size**: Each task 1-2 hours max, independently completable, easy to verify
• **Template sections**: Overview, Prerequisites, Tasks by Phase, Testing Strategy, Total Estimate, Notes

## Breakdown Template

```markdown
# Task Breakdown: {Task Name}

## Overview
{1-2 sentence description}

## Prerequisites
- [ ] {Prerequisite 1}

## Tasks

### Phase 1: {Phase Name}
**Goal:** {What this phase accomplishes}

- [ ] **Task 1.1:** {Description}
  - **Files:** {files to create/modify}
  - **Estimate:** {time}
  - **Dependencies:** {none / task X}
  - **Verification:** {how to verify}
```

## Best Practices

| Practice | Guideline |
|----------|-----------|
| Task size | 1-2 hours maximum per task |
| Dependencies | Explicitly state what must be done first |
| Verification | Define how to know task is complete |
| Estimates | Include testing time, add buffer for complexity |
| Grouping | Organize by feature or component |

## Common Patterns

• **Database-First**: Schema → Migrations → Models → Business logic → API → Tests  
• **Feature-First**: Requirements → Interface → Core logic → Error handling → Tests → Docs  
• **Refactoring**: Tests → Refactor section → Verify → Repeat → Cleanup → Update docs

## Related

• Component planning: `component-planning.md` (for multi-layer architecture)  
• TaskManager: `workflows/task-delegation-basics.md` (for subagent delegation)  
• Testing: `../standards/test-coverage.md`
