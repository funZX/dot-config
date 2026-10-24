<!-- Context: core/extract | Priority: medium | Version: 1.0 | Updated: 2026-02-15 -->

# Extract Operation

**Purpose**: Extract context from docs, code, or URLs into organized context files

**Last Updated**: 2026-01-06

---

## When to Use

- Extracting from documentation (React docs, API docs, etc.)
- Extracting from codebase (patterns, conventions)
- Extracting from URLs (blog posts, guides)
- Creating initial context for new topics

---

## 7-Stage Workflow

### Stage 1: Read Source
**Action**: Read and analyze source material

**Example**:
```
/context extract from https://react.dev/hooks
Agent: "Reading source (8,500 lines)...
Analyzing content for extractable items..."
```

---

### Stage 2: Analyze & Categorize
**Action**: Extract and categorize content by function

| Content Type | Target |
|--------------|--------|
| Design decisions | concepts/ |
| Working code | examples/ |
| Step-by-step workflows | guides/ |
| Reference data | lookup/ |
| Errors/gotchas | errors/ |

**Output**: List of extractable items with previews

---

### Stage 3: Select Category (APPROVAL REQUIRED)
**Action**: User chooses target category and items

**Format**:
```
Found 12 extractable items from {source}:

Concepts (8): [A] useState [B] useEffect ... (6 more)
Errors (4): [I] Hooks called conditionally [J] Hooks in loops ... (2 more)

Which category?
  [1] development/  [2] core/  [3] Create new: ___

Select items (A B I or 'all') + category (1/2/3): _
```

**Validation**: MUST wait for user input

---

### Stage 4: Preview (APPROVAL REQUIRED)
**Action**: Show what will be created, check for conflicts

**Format**:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Extraction Plan: development/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CREATE (new files):
  concepts/use-state.md (45 lines)
  concepts/use-effect.md (52 lines)
  guides/custom-hooks.md (87 lines)

ADD TO (existing files):
  errors/react-hooks-errors.md (98 → 124 lines)
    + 4 new error entries

⚠️ CONFLICT:
  concepts/use-memo.md exists (42 lines)
  Options: [A] Skip [B] Overwrite [C] Merge
  Choose [A/B/C]: _

NAVIGATION UPDATE:
  development/navigation.md (+12 entries)

Preview content? (filename/'all'/skip)
Approve? [y/n/edit]: _
```

**Validation**: MUST get approval before proceeding

---

### Stage 5: Create
**Action**: Create files in function folders

**Process**:
1. Apply MVI format (1-3 sentences, 3-5 key points, minimal example)
2. Create files in correct function folders
3. Ensure all files <200 lines
4. Add cross-references

**Enforcement**: `@critical_rules.mvi_strict` + `@critical_rules.function_structure`

---

### Stage 6: Update Navigation
**Action**: Update navigation.md and add cross-references

**Process**:
1. Update category navigation.md with new files
2. Add priority levels (critical/high/medium/low)
3. Add cross-references between related files
4. Update "Last Updated" dates

---

### Stage 7: Report
**Action**: Show comprehensive results

**Format**:
```
✅ Extracted {X} items into {category}
📄 Created {Y} files
📊 Updated {category}/navigation.md

Files created:
  - {category}/concepts/ ({N} files)
  - {category}/examples/ ({N} files)
  - {category}/errors/ ({N} files)
```

---

## Examples

**Extract from URL**: `/context extract from https://react.dev/hooks`

**Extract from Local Docs**: `/context extract from docs/api.md`

**Extract from Code**: `/context extract from src/utils/`

---

## Success Criteria

- [ ] All files <200 lines?
- [ ] MVI format applied?
- [ ] Files in correct function folders?
- [ ] navigation.md updated?
- [ ] Cross-references added?
- [ ] User approved before creation?

---

## Related

- standards/mvi.md - What to extract
- guides/compact.md - How to minimize
