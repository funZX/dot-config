<!-- Context: context-system/manager | Priority: critical | Version: 1.0 | Updated: 2026-10-23 -->

# Context Manager

**Purpose**: Command-line interface for managing AI context files—harvest knowledge, extract from sources, organize by function, and keep workspace tidy.

**Last Updated**: 2026-10-23

---

## Quick Start

**What it does**: The `/context` command manages context files that teach AI agents your project's patterns, standards, and workflows.

**Most common use**:
```bash
/context              # Quick scan → suggests harvest
/context harvest      # Extract AI summaries → permanent context
```

**Takes**: ~2 minutes for typical cleanup

---

## What Is Context?

Context files are **minimal, function-organized knowledge files** that ensure AI agents produce output matching your project's standards.

| Type | Location | Purpose |
|------|----------|---------|
| **Core Standards** | `.opencode/context/core/standards/` | Universal quality rules |
| **Workflows** | `.opencode/context/core/workflows/` | Process templates |
| **Project Intelligence** | `.opencode/context/project-intelligence/` | Your project's patterns |
| **Session Context** | `.tmp/sessions/{id}/context.md` | Temporary task bundles |

**Why manage it**: AI sessions create summary files that clutter workspaces. Context Manager extracts knowledge → permanent context, then cleans up.

---

## Command Reference

### Default Behavior (No Arguments)

```bash
/context
```

**Workflow**:
```
┌─────────────────────────────────────────────────────────┐
│  Stage 1: QuickScan                                     │
│  ─────────────────                                      │
│  Scan workspace for:                                    │
│  • *OVERVIEW.md, *SUMMARY.md                            │
│  • SESSION-*.md, CONTEXT-*.md                           │
│  • Files in .tmp/ directory                             │
│  • Files >2KB in root directory                         │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 2: Report                                        │
│  ─────────────                                          │
│  Quick scan results:                                    │
│                                                         │
│  Found 3 summary files:                                 │
│    📄 CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)               │
│    📄 SESSION-auth-work.md (1.8 KB)                     │
│    📄 .tmp/NOTES.md (800 bytes)                         │
│                                                         │
│  Recommended action:                                    │
│    /context harvest  - Clean up summaries → context     │
│                                                         │
│  Other options:                                         │
│    /context extract from docs/api.md                    │
│    /context organize development/                       │
│    /context help                                        │
└─────────────────────────────────────────────────────────┘
```

---

## Primary Operations

### 1. Harvest ⭐ (Most Common)

```bash
/context harvest [path]
/context harvest .tmp/
/context harvest OVERVIEW.md
```

**Purpose**: Extract knowledge from AI summaries → permanent context, clean workspace.

**Full Workflow**:
```
┌─────────────────────────────────────────────────────────┐
│  Stage 1: Scan                                          │
│  ─────────────                                          │
│  Find all summary files:                                │
│  • *OVERVIEW.md, *SUMMARY.md                            │
│  • SESSION-*.md, CONTEXT-*.md, *NOTES.md                │
│  • Files in .tmp/                                       │
│                                                         │
│  Output: CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)            │
│          SESSION-auth-work.md (1.8 KB)                  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 2: Analyze                                       │
│  ───────────—                                           │
│  Categorize content by function:                        │
│                                                         │
│  Design decisions      → concepts/                      │
│  Solutions/patterns    → examples/                      │
│  Workflows             → guides/                        │
│  Errors encountered    → errors/                        │
│  Reference data        → lookup/                        │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 3: Approve (CRITICAL)                            │
│  ─────────────────———                                   │
│  ### CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)                │
│                                                         │
│  ✓ [A] Design: Function-based context organization      │
│    → Would add to: core/concepts/context-org.md         │
│    Preview: "Organize by function (concepts/, exam..."  │
│                                                         │
│  ✓ [B] Pattern: Minimal Viable Information              │
│    → Would add to: core/concepts/mvi-principle.md       │
│    Preview: "Extract core only (1-3 sentences)..."      │
│                                                         │
│  ✓ [C] Workflow: Harvesting summary documents           │
│    → Would create: core/guides/harvesting.md            │
│    Preview: "Scan for summaries → Extract → Approv..."  │
│                                                         │
│  ### SESSION-auth-work.md (1.8 KB)                      │
│                                                         │
│  ✓ [D] Error: JWT token expiration not handled          │
│    → Would add to: development/errors/auth-errors.md    │
│    Preview: "Symptom: 401 after 1 hour. Cause: No..."   │
│                                                         │
│  ✗ [E] Skip: Planning discussion notes                  │
│                                                         │
│  ──────────────────────────────────────────────────     │
│  Quick options:                                         │
│  • Type 'A B C D' - Approve specific items              │
│  • Type 'all' - Approve all ✓ items                     │
│  • Type 'none' - Skip harvesting, delete files anyway   │
│  • Type 'cancel' - Keep files, don't harvest            │
│                                                         │
│  Choose [A B C / all / none / cancel]: _                │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 4: Extract                                       │
│  ─────────———                                           │
│  Apply MVI minimization:                                │
│  • Core concept: 1-3 sentences                          │
│  • Key points: 3-5 bullets                              │
│  • Minimal example: <10 lines                           │
│  • Reference link to full docs                          │
│                                                         │
│  Extraction Preview (APPROVAL REQUIRED):                │
│  ┌──────────────────────────────────────────────────┐  │
│  │ [A] → core/concepts/context-org.md (CREATE, 45L) │  │
│  │ # Concept: Context Organization                  │  │
│  │ **Purpose**: Function-based knowledge org        │  │
│  │ **Core Idea**: Organize by function: concepts/   │  │
│  │ ...                                              │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  Show all? [y/n] | Approve? [y/n/edit]: _               │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 5: Cleanup (APPROVAL REQUIRED)                   │
│  ─────────────────———                                   │
│  Successfully harvested from:                           │
│    CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)                  │
│    SESSION-auth-work.md (1.8 KB)                        │
│                                                         │
│  How should we handle these source files?               │
│                                                         │
│    [1] Archive (safe)                                   │
│        → Move to .tmp/archive/harvested/2026-10-23/     │
│        → Can restore later if needed                    │
│                                                         │
│    [2] Delete                                           │
│        → Permanently remove harvested files             │
│        → Frees disk space, no undo                      │
│                                                         │
│    [3] Keep                                             │
│        → Leave source files in place                    │
│        → No cleanup, files remain where they are        │
│                                                         │
│  Choose [1/2/3] (default: 1): _                         │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 6: Report                                        │
│  ─────────—                                             │
│  ✅ Harvested 5 items into permanent context:           │
│     - Added to core/concepts/context-organization.md    │
│     - Added to core/concepts/mvi-principle.md           │
│     - Created core/guides/harvesting.md                 │
│     - Added to development/errors/auth-errors.md        │
│     - Created development/examples/jwt-refresh.md       │
│                                                         │
│  🗑️  Cleaned up workspace:                              │
│     - Archived: CONTEXT-SYSTEM-OVERVIEW.md              │
│     - Archived: SESSION-auth-work.md                    │
│                                                         │
│  📊 Updated navigation maps:                            │
│     - .opencode/context/core/navigation.md              │
│     - .opencode/context/development/navigation.md       │
│                                                         │
│  💾 Disk space freed: 6.8 KB                            │
└─────────────────────────────────────────────────────────┘
```

**Critical Rules**:
- ⛔ **NEVER auto-delete** without user confirmation
- ✅ **Archive by default** (safe), not permanent delete
- ✅ **Only cleanup** files that had content successfully harvested

---

### 2. Compact

```bash
/context compact {file}
```

**Purpose**: Minimize verbose file to MVI format (<200 lines, scannable <30s).

**When to use**:
- Existing context file exceeds 200 lines
- File has verbose explanations
- Need to apply MVI standard

**Example**:
```bash
/context compact development/concepts/authentication.md
```

**Workflow**:
```
┌─────────────────────────────────────────────────────────┐
│  Before: authentication.md (347 lines)                  │
│  ─────────—                                             │
│  # Authentication                                       │
│  Authentication is the process of verifying the         │
│  identity of a user, system, or entity. In modern       │
│  web applications, authentication is typically          │
│  implemented using [... verbose explanation ...]        │
│                                                         │
│  ## Types of Authentication                             │
│  There are several types of authentication methods      │
│  that can be used in web applications. Each has         │
│  its own advantages and disadvantages...                │
│  [... 300+ more lines ...]                              │
└─────────────────────────────────────────────────────────┘
                          ↓ Apply MVI
┌─────────────────────────────────────────────────────────┐
│  After: authentication.md (87 lines)                    │
│  ─────———                                               │
│  # Concept: Authentication                              │
│                                                         │
│  **Purpose**: Verify user identity before granting      │
│  access to protected resources.                         │
│                                                         │
│  **Core Idea**: Compare provided credentials (password, │
│  token, biometric) against stored values. Grant access  │
│  only if credentials match.                             │
│                                                         │
│  **Key Points**:                                        │
│  • Session-based: Server stores session ID in database  │
│  • Token-based: Client sends signed token (JWT)         │
│  • OAuth: Third-party authorization delegation          │
│  • Multi-factor: 2+ authentication methods required     │
│                                                         │
│  **Quick Example**:                                     │
│  ```js                                                  │
│  const user = await verifyPassword(input, storedHash)   │
│  if (user) {                                            │
│    const token = jwt.sign({ userId: user.id }, SECRET)  │
│    res.json({ token })                                  │
│  }                                                      │
│  ```                                                    │
│                                                         │
│  **Reference**: See implementation in src/auth/         │
│                                                         │
│  **Related**: examples/jwt-example.md, errors/auth.md   │
└─────────────────────────────────────────────────────────┘
```

---

## Secondary Operations

### 3. Extract

```bash
/context extract from {source}
/context extract from docs/api.md
/context extract from https://react.dev/hooks
/context extract from src/utils/
```

**Purpose**: Extract context from external docs, code, or URLs.

**Workflow**:
```
┌─────────────────────────────────────────────────────────┐
│  Stage 1: Read Source                                   │
│  ─────────────——                                        │
│  Reading source (8,500 lines)...                        │
│  Analyzing content for extractable items...             │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 2: Analyze & Categorize                          │
│  ─────────—–                                            │
│  Found 12 extractable items from https://react.dev/hooks│
│                                                         │
│  Concepts (8):                                          │
│    ✓ [A] useState - State management hook               │
│    ✓ [B] useEffect - Side effects hook                  │
│    ... (6 more)                                         │
│                                                         │
│  Errors (4):                                            │
│    ✓ [I] Hooks called conditionally                     │
│    ✓ [J] Hooks in loops                                 │
│    ... (2 more)                                         │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 3: Select Category (APPROVAL REQUIRED)           │
│  ─────────—–                                            │
│  Which category?                                        │
│    [1] development/                                     │
│    [2] core/                                            │
│    [3] Create new category: ___                         │
│                                                         │
│  Select items (A B I or 'all') + category (1/2/3): _    │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 4: Preview (APPROVAL REQUIRED)                   │
│  ─────────——                                            │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   │
│  Extraction Plan: development/                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   │
│                                                         │
│  CREATE (new files):                                    │
│    concepts/use-state.md (45 lines)                     │
│    concepts/use-effect.md (52 lines)                    │
│    concepts/use-context.md (38 lines)                   │
│    ... (6 more)                                         │
│    guides/custom-hooks.md (87 lines)                    │
│    guides/debugging-hooks.md (65 lines)                 │
│                                                         │
│  ADD TO (existing files):                               │
│    errors/react-hooks-errors.md (98 → 124 lines)        │
│      + 4 new error entries                              │
│                                                         │
│  ⚠️  CONFLICT: concepts/use-memo.md exists (42 lines)   │
│      Options:                                           │
│        [A] Skip — keep existing file                    │
│        [B] Overwrite — replace with extracted version   │
│        [C] Merge — add new content (42 → 58 lines)      │
│      Choose [A/B/C]: _                                  │
│                                                         │
│  Preview content? (type filename, 'all', or 'skip')     │
│  Approve? [y/n/edit]: _                                 │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 5-7: Create → Update → Report                    │
│  ─────────———                                           │
│  ✅ Extracted 12 items into development/                │
│  📄 Created 10 files                                    │
│  📊 Updated development/navigation.md                   │
└─────────────────────────────────────────────────────────┘
```

---

### 4. Organize

```bash
/context organize {category}
/context organize development/
/context organize development/ --dry-run
```

**Purpose**: Restructure flat context files into function-based folders.

**When to use**:
- Category has flat files (not organized by function)
- Migrating from old structure to new
- Cleaning up disorganized context

**Categorization Rules**:
```
Explains concept       → concepts/
Shows working code     → examples/
Step-by-step workflow  → guides/
Reference tables/lists → lookup/
Errors/gotchas         → errors/
```

**Workflow** (abbreviated):
```
Stage 1: Scan → Detect flat vs organized structure
Stage 2: Categorize → Apply function rules
Stage 3: Resolve Conflicts (APPROVAL) → Handle ambiguous files
Stage 4: Preview (APPROVAL) → Show CREATE/MOVE/SPLIT/MERGE plan
Stage 5: Backup → .tmp/backup/organize-{category}-{timestamp}/
Stage 6: Execute → Perform reorganization
Stage 7: Update → Fix references, navigation.md
Stage 8: Report → Show results with rollback info
```

---

### 5. Update

```bash
/context update for {topic}
/context update for Next.js 15
/context update for React 19 breaking changes
```

**Purpose**: Update context when APIs, frameworks, or contracts change.

**Workflow Highlights**:
```
Stage 1: Identify Changes (APPROVAL)
  • API changes, Deprecations, New features, Breaking changes
  
Stage 2: Find Affected Files
  • Grep for topic references
  • Impact analysis (refs per file)
  
Stage 3: Preview Changes (APPROVAL)
  • Line-by-line diff for each file
  • Edit mode: line-by-line approval
  
Stage 4: Backup
  • .tmp/backup/update-{topic}-{timestamp}/
  
Stage 5: Update Files
  • Apply approved changes
  • Maintain MVI format (<200 lines)
  
Stage 6: Add Migration Notes
  • Add to errors/ with migration guide
  
Stage 7: Validate
  • Check references, links, file sizes
  
Stage 8: Report
  • Summary with rollback availability
```

---

### 6. Error

```bash
/context error for "{error message}"
/context error for "Cannot read property 'map' of undefined"
/context error for "Hydration failed in Next.js"
```

**Purpose**: Add recurring errors to knowledge base with deduplication.

**Deduplication Strategy**:
| Type | Action |
|------|--------|
| Similar (same root cause) | Update existing with new examples |
| Related (different causes) | Cross-reference between errors |
| Duplicate (exact match) | Skip (already covered) |
| New (unique) | Add as new entry |

---

### 7. Create

```bash
/context create {category}
/context create development/ai/
```

**Purpose**: Create new context category with function-based structure.

**What it creates**:
```
{category}/
├── navigation.md
├── concepts/
├── examples/
├── guides/
├── lookup/
└── errors/
```

---

## Migration

### 8. Migrate

```bash
/context migrate
```

**Purpose**: Copy project-intelligence from global to local.

**When to use**:
- Installed OpenCode globally (`~/.config/opencode/`)
- Want project-specific, git-committed context
- Moving from personal defaults to team-shared patterns

**Workflow**:
```
┌─────────────────────────────────────────────────────────┐
│  Stage 1: Detect Global Files                           │
│  ─────────—–                                            │
│  Found in ~/.config/opencode/context/project-intell/    │
│    📄 technical-domain.md (Version: 1.2)                │
│    📄 business-domain.md (Version: 1.0)                 │
│    📄 navigation.md                                     │
│                                                         │
│  Checking local (.opencode/context/project-intell/)...  │
│    ⚠️  Local files already exist                        │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 2: Show Diff (if local exists)                   │
│  ─────────–                                             │
│  ━━━ technical-domain.md ━━━                            │
│                                                         │
│  Local (Version: 1.0):                                  │
│    Framework: Next.js 14                                │
│    Language: TypeScript 4.9                             │
│                                                         │
│  Global (Version: 1.2):                                 │
│    Framework: Next.js 15 ← Updated                      │
│    Language: TypeScript 5.0 ← Updated                   │
│    + New: Using App Router                              │
│                                                         │
│  Options:                                               │
│    [A] Keep local version                               │
│    [B] Overwrite with global version                    │
│    [C] Merge (manual edit after)                        │
│                                                         │
│  Choose [A/B/C]: _                                      │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 3: Preview (APPROVAL REQUIRED)                   │
│  ─────────——                                            │
│  Will copy from:                                        │
│    ~/.config/opencode/context/project-intelligence/     │
│                                                         │
│  Will copy to:                                          │
│    .opencode/context/project-intelligence/              │
│                                                         │
│  Files:                                                 │
│    CREATE technical-domain.md                           │
│    CREATE business-domain.md                            │
│    CREATE navigation.md                                 │
│                                                         │
│  After migration:                                       │
│    [ ] Clean up global project-intelligence/ (optional) │
│                                                         │
│  Proceed? [y/n]: _                                      │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  Stage 4: Execute & Report                              │
│  ─———————                                             │
│  ✅ Migrated 3 files to local project context           │
│  📁 Location: .opencode/context/project-intelligence/   │
│  🗑️  Global cleanup: [skipped / completed]              │
│                                                         │
│  Next: Commit to git to share with team!                │
└─────────────────────────────────────────────────────────┘
```

---

## Utility Operations

### 9. Map

```bash
/context map [category]
/context map development/
```

**Purpose**: View current context structure, file counts.

**Example Output**:
```
Context Structure: development/

├── navigation.md (1 file, 85 lines)
├── concepts/ (12 files, avg 67 lines)
├── examples/ (8 files, avg 52 lines)
├── guides/ (6 files, avg 103 lines)
├── lookup/ (4 files, avg 45 lines)
└── errors/ (5 files, avg 112 lines)

Total: 36 files, 2,847 lines
```

---

### 10. Validate

```bash
/context validate
/context validate development/
```

**Purpose**: Check integrity, references, file sizes.

**Checks**:
- ✅ All files <200 lines
- ✅ Function-based structure used
- ✅ Frontmatter present (Context: | Priority: | Version: | Updated:)
- ✅ Codebase references section exists
- ✅ Navigation files at every level
- ✅ No broken internal references
- ✅ No duplication across files

---

### 11. Help

```bash
/context help
```

**Purpose**: Show all operations with examples.

---

## Lazy Loading Strategy

Each operation loads specific context files before execution:

| Operation | Files Loaded |
|-----------|--------------|
| **default** | `operations/harvest.md`, `standards/mvi.md` |
| **harvest** | `operations/harvest.md`, `standards/mvi.md` |
| **compact** | `guides/compact.md`, `standards/mvi.md` |
| **extract** | `operations/extract.md`, `standards/mvi.md`, `guides/compact.md` |
| **organize** | `operations/organize.md`, `standards/structure.md` |
| **update** | `operations/update.md`, `standards/mvi.md` |
| **error** | `operations/error.md`, `standards/templates.md` |
| **create** | `guides/creation.md`, `standards/structure.md`, `standards/templates.md` |
| **migrate** | `standards/mvi.md` |

**All files located in**: `.opencode/context/core/context-system/`

---

## Critical Rules

### 1. MVI Strict (`@mvi_strict`)
> Files MUST be <200 lines. Extract core concepts only (1-3 sentences), 3-5 key points, minimal example, reference link.

**Enforcement**: All created/updated files validated against size limits.

### 2. Approval Gate (`@approval_gate`)
> ALWAYS present approval UI before deleting/archiving files. Letter-based selection (A B C or 'all'). NEVER auto-delete.

**Enforcement**: All destructive operations require explicit user confirmation.

### 3. Function Structure (`@function_structure`)
> ALWAYS organize by function: concepts/, examples/, guides/, lookup/, errors/ (not flat files).

**Enforcement**: All new context follows function-based folder structure.

### 4. Lazy Load (`@lazy_load`)
> ALWAYS read required context files from `.opencode/context/core/context-system/` BEFORE executing operations.

**Enforcement**: Context loaded automatically per lazy_load_map.

---

## Subagent Routing

| Operations | Handler | Type |
|------------|---------|------|
| `harvest`, `extract`, `organize`, `update`, `error`, `create`, `migrate` | **ContextOrganizer** | Write operations |
| `map`, `validate` | **ContextScout** | Read-only analysis |

**How it works**: When you run `/context harvest`, the command routes to ContextOrganizer, which loads required context files and executes the multi-stage workflow.

---

## Troubleshooting

### "No summary files found"
**Cause**: Workspace is already clean  
**Solution**: No action needed, or run `/context extract` to create new context

### "File exceeds 200 lines" after harvest
**Cause**: Source content too verbose  
**Solution**: Run `/context compact {file}` to minimize

### "Cannot find operation file"
**Cause**: Context system files missing  
**Solution**: Verify `.opencode/context/core/context-system/` exists with all operation files

### "Conflict: file already exists"
**Cause**: Extracting to existing category  
**Solution**: Choose Skip/Overwrite/Merge during approval stage

### "Approval UI not appearing"
**Cause**: Running in non-interactive mode  
**Solution**: Run command interactively (approval gates require user input)

---

## Quick Reference

### All Commands

| Command | Purpose | Approval Required |
|---------|---------|-------------------|
| `/context` | Quick scan → suggest harvest | ❌ No |
| `/context harvest [path]` | Extract summaries → context | ✅ Yes (3 stages) |
| `/context compact {file}` | Minimize verbose file | ✅ Yes |
| `/context extract from {source}` | Extract from docs/code/URL | ✅ Yes (2 stages) |
| `/context organize {category}` | Restructure to function folders | ✅ Yes (2 stages) |
| `/context update for {topic}` | Update for API/framework changes | ✅ Yes (2 stages) |
| `/context error for "{error}"` | Add recurring error | ✅ Yes (2 stages) |
| `/context create {category}` | Create new category | ✅ Yes |
| `/context migrate` | Copy global → local | ✅ Yes |
| `/context map [category]` | View structure | ❌ No (read-only) |
| `/context validate` | Check integrity | ❌ No (read-only) |
| `/context help` | Show all operations | ❌ No |

### File Size Limits

| Type | Max Lines |
|------|-----------|
| Concept | 100 |
| Example | 80 |
| Guide | 150 |
| Lookup | 100 |
| Error | 150 |
| Navigation | 100 |

### Function Folders

```
{category}/
├── navigation.md       # Quick routes + structure
├── concepts/           # What it is
├── examples/           # Working code
├── guides/             # How to do it
├── lookup/             # Quick reference
└── errors/             # Common issues
```

---

## Related Documentation

- **Context System**: `.opencode/context/core/context-system.md`
- **MVI Principle**: `.opencode/context/core/context-system/standards/mvi.md`
- **File Templates**: `.opencode/context/core/context-system/standards/templates.md`
- **Structure Guide**: `.opencode/context/core/context-system/standards/structure.md`
