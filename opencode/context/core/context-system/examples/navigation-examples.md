# Navigation Examples

Core concept: Real-world examples of token-efficient navigation files (~200-300 tokens) with ASCII trees and quick routes tables.

## Example 1: Category Navigation (Function-Based)

```markdown
# OpenAgents Control Repository Navigation

**Purpose**: Navigate OpenAgents Control repository context

---

## Structure

```
openagents-repo/
├── navigation.md
├── quick-start.md
├── core-concepts/
├── guides/
├── lookup/
└── errors/
```

---

## Quick Routes

| Task | Path |
|------|------|
| **New here** | `quick-start.md` |
| **Add agent** | `guides/adding-agent.md` |
| **Test agent** | `guides/testing-agent.md` |
| **Debug issue** | `guides/debugging-issues.md` |

---

## By Type

**Core Concepts** → Foundational understanding  
**Guides** → Step-by-step workflows  
**Lookup** → Quick reference tables  
**Errors** → Troubleshooting
```

**Why it works:** ✅ Token-efficient (~250) | ✅ ASCII tree | ✅ Quick routes | ✅ Organized by type

## Example 2: Minimal Navigation (Few Files)

```markdown
# Content Navigation

**Purpose**: Copywriting and content creation

---

## Structure

```
content/
├── navigation.md
├── copywriting-frameworks.md
└── tone-voice.md
```

---

## Quick Routes

| Task | Path |
|------|------|
| **Write copy** | `copywriting-frameworks.md` |
| **Set tone** | `tone-voice.md` |
```

**Why it works:** ✅ ~150 tokens | ✅ Simple structure | ✅ No unnecessary complexity

## Anti-Patterns

| ❌ Bad | Problem |
|--------|---------|
| Verbose (800+ tokens) | Should be 200-300 tokens |
| No structure tree | Hard to see hierarchy |
| Contains file contents | Should reference, not duplicate |
| Just lists | No organization by type/task |

## Related

• Navigation design: `../guides/navigation-design-basics.md`  
• Organizing: `../guides/organizing-context.md`  
• Templates: `../standards/templates.md` (sections 6-7)
