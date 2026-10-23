<!-- Context: core/navigation-examples | Priority: high | Version: 1.2 | Updated: 2026-10-23 -->

# Examples: Navigation Files

**Purpose**: Real-world examples of good navigation files

**Last Updated**: 2026-10-23

---

## Example 1: Category Navigation (Function-Based)

**File**: `openagents-repo/navigation.md`

**Pattern**: Function-Based (repository-specific)

**Token count**: ~250 tokens

```markdown
# OpenAgents Control Repository Navigation

**Purpose**: Navigate OpenAgents Control repository context

---

## Structure

```
openagents-repo/
├── navigation.md
├── quick-start.md
│
├── core-concepts/
│   ├── agent-architecture.md
│   ├── eval-framework.md
│   └── registry-system.md
│
├── guides/
│   ├── adding-agent.md
│   ├── testing-agent.md
│   └── debugging-issues.md
│
├── lookup/
│   ├── commands.md
│   └── file-locations.md
│
└── errors/
    └── tool-permission-errors.md
```

---

## Quick Routes

| Task | Path |
|------|------|
| **New here** | `quick-start.md` |
| **Add agent** | `guides/adding-agent.md` |
| **Test agent** | `guides/testing-agent.md` |
| **Debug issue** | `guides/debugging-issues.md` |
| **Find files** | `lookup/file-locations.md` |
| **Fix error** | `errors/tool-permission-errors.md` |

---

## By Type

**Core Concepts** → Foundational understanding (agents, evals, registry)
**Guides** → Step-by-step workflows
**Lookup** → Quick reference tables
**Errors** → Troubleshooting
```

**Why this works**:
- ✅ Token-efficient (~250 tokens)
- ✅ ASCII tree shows structure
- ✅ Quick routes for common tasks
- ✅ Organized by information type

---

## Example 2: Minimal Navigation

**File**: `content/navigation.md`

**Pattern**: Simple category (few files)

**Token count**: ~150 tokens

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

---

## Files

**copywriting-frameworks.md** → AIDA, PAS, persuasive writing
**tone-voice.md** → Brand voice, tone guidelines
```

**Why this works**:
- ✅ Token-efficient (~150 tokens)
- ✅ Simple structure (only 2 files)
- ✅ No unnecessary complexity
- ✅ Clear and scannable

---

## Anti-Patterns (What NOT to Do)

### ❌ Too Verbose

```markdown
# Development Navigation

**Purpose**: This comprehensive navigation file is designed to help you navigate the extensive collection of software development patterns, standards, and best practices that we have carefully curated across all technology stacks including frontend frameworks like React and Vue, backend technologies such as Node.js and Python, database systems both SQL and NoSQL, and infrastructure tools for deployment and operations.

## Introduction

The development category represents a significant portion of our context system...

[Continues for 800+ tokens]
```

**Problems**:
- ❌ 800+ tokens (should be 200-300)
- ❌ Verbose explanations (should be concise)
- ❌ Hard to scan (should use tables/trees)

---

### ❌ Missing Structure

```markdown
# Development Navigation

Here are the files:
- clean-code.md
- api-design.md
- react-patterns.md
- express-patterns.md
```

**Problems**:
- ❌ No ASCII tree (hard to see hierarchy)
- ❌ No quick routes (hard to find tasks)
- ❌ No organization (just a list)

---

### ❌ Too Detailed

```markdown
# Development Navigation

## React Patterns

### Hooks
React hooks allow you to use state and lifecycle features in functional components. The most common hooks are:

1. useState - For managing component state
   - Syntax: const [state, setState] = useState(initialValue)
   - Example: const [count, setCount] = useState(0)
   
2. useEffect - For side effects
   [... continues with full documentation]
```

**Problems**:
- ❌ Contains file contents (should just point to files)
- ❌ Duplicates information (should reference, not repeat)
- ❌ Too detailed (navigation, not documentation)

---

## Key Takeaways

### ✅ Good Navigation Files

1. **Token-efficient** (200-300 tokens)
2. **Scannable** (ASCII trees, tables)
3. **Task-focused** (quick routes)
4. **Organized** (by concern/type)
5. **Concise** (3-5 word descriptions)

### ❌ Bad Navigation Files

1. **Verbose** (500+ tokens)
2. **Hard to scan** (paragraphs)
3. **Unfocused** (no clear routes)
4. **Unorganized** (just lists)
5. **Detailed** (duplicates content)

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Too many tokens | Remove verbose descriptions, shorten entries |
| Hard to scan | Use tables instead of paragraphs |
| Missing files | Add to structure and quick routes |
| Unclear paths | Use relative paths, add brief descriptions |

---

## Related

- `../guides/navigation-design-basics.md` - How to create navigation files
- `../guides/organizing-context.md` - How to choose organizational pattern
- `../standards/templates.md` - Navigation file templates (sections 6-7)
- `../standards/mvi.md` - Minimal Viable Information principle
