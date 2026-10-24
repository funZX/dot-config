<!-- Context: core/harvest | Priority: medium | Version: 1.0 | Updated: 2026-02-15 -->

# Context Harvest Operation

**Purpose**: Extract knowledge from AI summaries → permanent context, then clean workspace

**Last Updated**: 2026-01-06

**Core Problem**: AI agents create summary files that contain valuable knowledge but clutter the workspace.

**Solution**: Harvest the knowledge → permanent context, then delete the summaries.

---

## Auto-Detection Patterns

<rule id="summary_patterns" enforcement="strict">
  Filename patterns: *OVERVIEW.md, *SUMMARY.md, SESSION-*.md, CONTEXT-*.md, *NOTES.md
  Location patterns: .tmp/ directory, files >2KB in root, "Summary/Overview/Session" in title
</rule>

---

## 6-Stage Workflow

<workflow id="harvest" enforce="@critical_rules">

### Stage 1: Scan
**Action**: Find all summary files
**Process**: Search patterns → Check .tmp/ → List with sizes → Sort by date
**Output**: Candidate files list

---

### Stage 2: Analyze
**Action**: Categorize by function

| Content | Target | Identify By |
|---------|--------|-------------|
| Design decisions | `concepts/` | "We decided", "Architecture" |
| Code solutions | `examples/` | Code snippets, "Here's how" |
| Workflows | `guides/` | Numbered steps, "How to" |
| Errors | `errors/` | Error messages, "Fixed" |
| Reference | `lookup/` | Tables, lists, commands |

**Process**: Read → Extract → Categorize → Target path → 60-char preview
**Output**: Letter-tagged items (A, B, C...)

---

### Stage 3: Approve (CRITICAL)
**Action**: Present approval UI

<rule id="approval_gate" enforcement="strict">
  ALWAYS show approval UI. NEVER auto-harvest.
</rule>

**Format**:
```
### CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)

✓ [A] Design: Function-based context
    → core/concepts/context-organization.md

✗ [B] Skip: Planning discussion

---
Type 'A C' | 'all' | 'none' | 'cancel': _
```

**Validation**: MUST wait for input. 'cancel' stops immediately.

---

### Stage 4: Extract
**Action**: Extract and minimize

<rule id="extraction" enforce="@mvi_principle">
  MVI: 1-3 sentences + 3-5 bullets + <10 line example + link
</rule>

**Process**: Extract → MVI (compact.md) → Preview → Write + cross-refs + nav

**Preview**:
```
[A] → core/concepts/context-organization.md (CREATE, 45 lines)
[E] → development/errors/auth-errors.md (ADD, 98 → 112 lines)
Show all? [y/n] | Approve? [y/n/edit]: _
```

---

### Stage 5: Cleanup (APPROVAL REQUIRED)
**Action**: Archive or delete sources

**Format**:
```
Harvested: CONTEXT-SYSTEM-OVERVIEW.md, SESSION-auth-work.md

  1. Archive → .tmp/archive/harvested/{date}/
  2. Delete → permanent
  3. Keep → no cleanup

Choose [1/2/3] (default: 1): _
```

<rule id="cleanup_safety" enforcement="strict">
  ONLY cleanup files with successful harvest.
</rule>

---

### Stage 6: Report
**Action**: Show results

**Format**:
```
✅ Harvested 5 items: core/concepts/context-organization.md...
🗑️ Cleaned: CONTEXT-SYSTEM-OVERVIEW.md, SESSION-auth-work.md
📊 Updated: core/nav.md, development/nav.md
💾 Freed: 6.8 KB
```

</workflow>

---

## Smart Content Detection

| Extract ✅ | Skip ❌ |
|-----------|--------|
| Design decisions, patterns | Planning discussions |
| Errors + solutions | Conversational notes |
| API changes, performance | Duplicate info, TODOs |
| Core concepts | Timestamps, metadata |

---

## Safety Features

Approval gate • Archive by default • Validation • Rollback • Dry run

---

## Related

compact.md • mvi-principle.md • structure.md • creation.md