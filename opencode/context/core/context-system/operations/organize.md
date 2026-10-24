<!-- Context: core/organize | Priority: medium | Version: 1.0 | Updated: 2026-02-15 -->

# Organize Operation

**Purpose**: Restructure flat context files into function-based folders (concepts/examples/guides/lookup/errors)

**Last Updated**: 2026-01-06

---

## When to Use

- Migrating from flat to function-based structure
- Cleaning up disorganized context directories
- Splitting ambiguous files into proper categories
- Resolving duplicate/conflicting files

---

## 8-Stage Workflow

### Stage 1: Scan
**Action**: Scan category for all files and detect structure

**Output**: File list with structure type (flat vs organized)

---

### Stage 2: Categorize
**Action**: Categorize each file by function

| Content Type | Target |
|--------------|--------|
| Explains concept | concepts/ |
| Shows working code | examples/ |
| Step-by-step | guides/ |
| Reference data | lookup/ |
| Errors/issues | errors/ |

**Output**: Categorization plan with flagged ambiguous files

---

### Stage 3: Resolve Conflicts (APPROVAL REQUIRED)
**Action**: Present categorization plan and handle conflicts

**Format**:
```
Organizing {category}/ (23 files, flat structure)

Clear categorization (18 files):
  ✓ authentication.md → concepts/authentication.md
  ✓ jwt-example.md → examples/jwt-example.md

Ambiguous files (5):
  [?] api-design.md → [A] Split [B] Keep as concepts [C] Keep as guides

Conflicts (2):
  [!] auth.md exists → [J] Merge [K] Rename [L] Skip

Select resolutions (A J or 'auto'): _
```

**Validation**: MUST wait for user input

---

### Stage 4: Preview (APPROVAL REQUIRED)
**Action**: Show preview of all changes

**Format**:
```
CREATE directories: concepts/ examples/ guides/ lookup/ errors/
MOVE files (18): auth.md → concepts/auth.md
SPLIT files (3): api-design.md → concepts/ + guides/
MERGE files (2): auth.md → existing (merge)
UPDATE: navigation.md, fix 47 references

Dry-run? (yes/no/show-diff): _
Approve? [y/n]: _
```

**Validation**: MUST get approval before proceeding

---

### Stage 5: Backup
**Action**: Create backup before making changes

**Location**: `.tmp/backup/organize-{category}-{timestamp}/`

---

### Stage 6: Execute
**Action**: Perform the reorganization

**Process**:
1. Create function folders
2. Move files to correct locations
3. Split ambiguous files if requested
4. Merge conflicts if requested

---

### Stage 7: Update
**Action**: Update navigation and fix references

**Process**:
1. Update navigation.md with navigation tables
2. Fix all internal references to moved files
3. Validate all links work
4. Update "Last Updated" dates

---

### Stage 8: Report
**Action**: Show comprehensive results

**Format**:
```
✅ Organized {X} files into function folders
📁 Created {Y} new folders
🔀 Split {Z} ambiguous files
🔗 Fixed {N} references
💾 Backup: .tmp/backup/organize-{category}-{timestamp}/
```

---

## Conflict Resolution

### Ambiguous Files
File fits multiple categories (e.g., has concepts AND steps)

**Options**: Split (recommended) | Keep primary category | User decides

### Duplicate Targets
Target file already exists

**Options**: Merge | Rename (e.g., -v2) | Skip (keep flat)

### Auto-Resolution
Agent suggests best option based on file size, content, existing structure

---

## Examples

**Organize Flat Directory**: `/context organize development/`

**Dry-Run First**: `/context organize development/ --dry-run`

**Organize Multiple**: `/context organize development/` then `/context organize core/`

---

## Success Criteria

- [ ] All files in function folders?
- [ ] Ambiguous files resolved?
- [ ] Conflicts handled?
- [ ] navigation.md created/updated?
- [ ] All references fixed?
- [ ] Backup created?
- [ ] User approved changes?

---

## Related

- standards/structure.md - Folder organization rules
