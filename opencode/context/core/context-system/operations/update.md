# Update Operation

Core concept: Update context when APIs, frameworks, or contracts change — identifies affected files, previews changes, backs up, updates, adds migration notes.

## When to Use

• Framework version updates (Next.js 14 → 15)
• API changes (breaking changes, deprecations)
• New features added to existing topics
• Migration guides needed

## 8-Stage Workflow

| Stage | Action | Approval |
|-------|--------|----------|
| 1. Identify Changes | User describes what changed | ✅ Required |
| 2. Find Affected Files | Grep references, count impact | - |
| 3. Preview Changes | Show line-by-line diff | ✅ Required |
| 4. Backup | Create `.tmp/backup/update-{topic}-{timestamp}/` | - |
| 5. Update Files | Apply changes, maintain MVI (<200 lines) | - |
| 6. Add Migration Notes | Add to `errors/{topic}-errors.md` | - |
| 7. Validate | Check references, links, line counts | - |
| 8. Report | Show results, backup location | - |

## Change Types

| Type | Description |
|------|-------------|
| API Changes | Method signatures, parameters, return types |
| Deprecations | Features marked deprecated, replacement APIs |
| New Features | New capabilities, APIs, patterns |
| Breaking Changes | Incompatible changes requiring migration |

## Examples

```bash
/context update for Next.js 15
/context update for React 19 breaking changes
/context update for Stripe API v2024
```

## Related

• MVI standard: `mvi.md` (maintain format during updates)  
• Error docs: `error.md` (adding migration notes)
