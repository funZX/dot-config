# Context File Templates

Core concept: Standard templates for all context file types ensure consistency and MVI compliance across the context system.

## Template Quick Reference

| Type | Max Lines | Key Sections |
|------|-----------|--------------|
| **Concept** | 100 | Purpose, Core Idea (1-3 sentences), Key Points (3-5), Example (<10 lines), References |
| **Example** | 80 | Purpose, Use Case, Code (10-30 lines), Explanation, References |
| **Guide** | 150 | Purpose, Prerequisites, Steps (4-7), Verification, References |
| **Lookup** | 100 | Purpose, Tables/Lists, Commands, References |
| **Error** | 150 | Symptom, Cause, Solution, Prevention, References |
| **Navigation** | 100 | Structure tree, Quick Routes table, By Type sections |

## All Templates Require

• Frontmatter: `<!-- Context: {category} | Priority: {level} | Updated: YYYY-MM-DD -->`
• **Purpose** field (1 sentence)
• **Last Updated** field (YYYY-MM-DD)
• **Related** section (cross-references)
• Codebase references where applicable

## Template Files

Full templates: `core/context-system/standards/templates.md` (this file)  
Usage guide: `core/context-system/guides/creation.md`  
MVI format: `core/context-system/standards/mvi.md`
