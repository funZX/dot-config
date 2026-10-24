<!-- Context: core/error | Priority: medium | Version: 1.0 | Updated: 2026-02-15 -->

# Error Operation

**Purpose**: Add recurring errors to knowledge base with deduplication

---

## 6-Stage Workflow

### Stage 1: Search Existing
Search error message across errors/ files for similar/related errors

```
Searching: "Cannot read property 'map' of undefined"

✓ Similar: react-errors.md:45 ("Cannot read property 'X'", common)
✓ Related: react-errors.md ("length", "Undefined is not an object")
```

---

### Stage 2: Check Duplication {@approval_gate}

```
[A] Add new  [B] Update existing  [C] Skip
Category: [1] React  [2] JavaScript  [3] General  [4] New: ___

Select (e.g., 'B 1'): _
```

**Rule**: MUST wait for user input

---

### Stage 3: Preview {@approval_gate}

```
Update react-errors.md:45

Current:
┌─────────────────────────────────────────────────────────┐
│ ## Error: Cannot read property 'X' of undefined         │
│ **Symptom**: TypeError...  **Cause**: undefined access   │
│ **Solution**: Null check, Optional chaining, Default    │
│ **Code**: obj?.property ?? 'default'                    │
└─────────────────────────────────────────────────────────┘

Proposed: Add 'map'/'length' examples
File: 98 → 105 lines (✓)

Preview next? (y/n/all)  Approve? (y/n/edit): _
```

**Rule**: MUST get approval before proceeding

---

### Stage 4: Add/Update

**Template**:
```
## Error: {Name}
**Symptom**: [Error message]
**Cause**: [1-2 sentences]
**Solution**: [Steps]
**Code**: [Before/After <10 lines]
**Prevention**: [How to avoid]
**Frequency**: common/occasional/rare
**Reference**: [Link]
```

**Rules**: Follow template, maintain <150 lines, update date

---

### Stage 5: Update Navigation
1. Update navigation.md if new file
2. Cross-reference related errors
3. Link from concepts/examples

---

### Stage 6: Report

```
✅ Added: {category}/errors/{file}.md
🔗 Cross-referenced: X errors
📊 Updated navigation.md

File: {N} lines (under 150 ✓)
```

---

## Deduplication

| Type | Action |
|------|--------|
| Similar (same cause) | Update existing |
| Related (same category) | Cross-reference |
| Duplicate | Skip |
| New | Add entry |

---

## Grouping

One file per topic (not per error):

| File | Purpose |
|------|---------|
| react-errors.md | React errors |
| nextjs-errors.md | Next.js errors |
| auth-errors.md | Auth errors |

---

## Examples

```bash
/context error for "hooks can only be called inside components"
/context error for "Cannot read property 'map' of undefined"
/context error for "Hydration failed in Next.js"
```

---

## Checklist

- [ ] Searched similar errors
- [ ] Deduplication presented
- [ ] Preview approved
- [ ] Template followed
- [ ] File <150 lines
- [ ] Cross-references added
- [ ] navigation.md updated

---

## Related

- standards/templates.md
- guides/compact.md
