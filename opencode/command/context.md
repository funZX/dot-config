---
description: Context system manager - harvest summaries, extract knowledge, organize context
tags:
  - context
  - knowledge-management
  - harvest
dependencies:
  - subagent:context-organizer
  - subagent:contextscout
---

# Context Manager

<critical_rules priority="absolute" enforcement="strict">
  <rule id="mvi_strict">
    Files MUST be <200 lines. Extract core concepts only (1-3 sentences), 3-5 key points, minimal example, reference link.
  </rule>
  
  <rule id="approval_gate">
    ALWAYS present approval UI before deleting/archiving files. Letter-based selection (A B C or 'all'). NEVER auto-delete.
  </rule>
  
  <rule id="function_structure">
    ALWAYS organize by function: concepts/, examples/, guides/, lookup/, errors/ (not flat files).
  </rule>
  
  <rule id="lazy_load">
    ALWAYS read required context files from .opencode/context/core/context-system/ BEFORE executing operations.
  </rule>
</critical_rules>

<execution_priority>
  <tier level="1" desc="Safety & MVI">
    - Files <200 lines (@critical_rules.mvi_strict)
    - Show approval before cleanup (@critical_rules.approval_gate)
    - Function-based structure (@critical_rules.function_structure)
    - Load context before operations (@critical_rules.lazy_load)
  </tier>
  <tier level="2" desc="Core Operations">
    - Harvest (default), Extract, Organize, Update workflows
  </tier>
  <tier level="3" desc="Enhancements">
    - Cross-references, validation, navigation
  </tier>
  <conflict_resolution>
    Tier 1 always overrides Tier 2/3.
  </conflict_resolution>
</execution_priority>

**Arguments**: `$ARGUMENTS`

---

## Default Behavior (No Arguments)

When invoked without arguments: `/context`

<workflow id="default_scan_harvest">
  <stage id="1" name="QuickScan">
    Scan workspace for summary files:
    - *OVERVIEW.md, *SUMMARY.md, SESSION-*.md, CONTEXT-*.md
    - Files in .tmp/ directory
    - Files >2KB in root directory
  </stage>
  
  <stage id="2" name="Report">
    Show what was found:
    ```
    Quick scan results:
    
    Found 3 summary files:
      📄 CONTEXT-SYSTEM-OVERVIEW.md (4.2 KB)
      📄 SESSION-auth-work.md (1.8 KB)
      📄 .tmp/NOTES.md (800 bytes)
    
    Recommended action:
      /context harvest  - Clean up summaries → permanent context
    
    Other options:
      /context extract {source}  - Extract from docs/code
      /context organize {category}  - Restructure existing files
      /context help  - Show all operations
    ```
  </stage>
</workflow>

**Purpose**: Quick tidy-up. Default assumes you want to harvest summaries and compact workspace.

---

### Execution: Default Scan

**When operation="default"**, execute this workflow:

#### Step 1: Scan for Summary Files

**Run bash commands** to find candidate files:

```bash
# Pattern 1: Find summary files by naming pattern
find . -maxdepth 3 -type f \( \
  -name "*OVERVIEW.md" -o \
  -name "*SUMMARY.md" -o \
  -name "SESSION-*.md" -o \
  -name "CONTEXT-*.md" -o \
  -name "*NOTES.md" \
\) ! -path "./.git/*" ! -path "./node_modules/*" 2>/dev/null

# Pattern 2: Scan .tmp/ directory
find .tmp/ -type f -name "*.md" 2>/dev/null || echo "(.tmp/ not found)"

# Pattern 3: Find large files (>2KB) in root directory
find . -maxdepth 1 -type f -name "*.md" -size +2k ! -name "README.md" 2>/dev/null
```

**Collect results**:
- File path
- File size (in KB or bytes)
- Last modified date (for sorting)

#### Step 2: Analyze and Sort

**Process** the scan results:

1. **Filter** out false positives:
   - Exclude README.md, CHANGELOG.md (these are permanent docs)
   - Exclude files in .git/, node_modules/, vendor/

2. **Sort** by relevance:
   - Primary: Recency (newest first)
   - Secondary: Size (larger = more content)

3. **Categorize**:
   - High priority: SESSION-*.md, CONTEXT-*.md (AI session summaries)
   - Medium priority: *OVERVIEW.md, *SUMMARY.md (intentional summaries)
   - Low priority: Large files in root (may be intentional)

#### Step 3: Display Results

**Format** the output:

```
Quick scan results:

Found {N} summary files:
  📄 {filename1} ({size})
  📄 {filename2} ({size})
  📄 {filename3} ({size})

Recommended action:
  /context harvest  - Clean up summaries → permanent context

Other options:
  /context extract {source}  - Extract from docs/code
  /context organize {category}  - Restructure existing files
  /context help  - Show all operations

Type: /context harvest   (or choose another operation)
```

**If no files found**:

```
Quick scan complete.

No summary files found in workspace. ✅

Your workspace is clean! Context system is ready.

Next actions:
  /context help  - Show all context operations
  /context extract from {source}  - Extract from docs/URLs
  /context create {category}  - Create new context category
```

#### Step 4: Wait for User Action

**After showing results**:
- Do NOT auto-execute harvest
- Wait for user to run `/context harvest` or another operation
- This is a **suggestion** mode, not auto-execution (@approval_gate)

---

---

## Operations

### Primary: Harvest & Compact (Default Focus)

**`/context harvest [path]`** ⭐ Most Common
- Extract knowledge from AI summaries → permanent context
- Clean workspace (archive/delete summaries)
- **Reads**: `operations/harvest.md` + `standards/mvi.md`

**`/context compact {file}`**
- Minimize verbose file to MVI format
- **Reads**: `guides/compact.md` + `standards/mvi.md`

---

### Secondary: Custom Context Creation

**`/context extract from {source}`**
- Extract context from docs/code/URLs
- **Reads**: `operations/extract.md` + `standards/mvi.md` + `guides/compact.md`

**`/context organize {category}`**
- Restructure flat files → function-based folders
- **Reads**: `operations/organize.md` + `standards/structure.md`

**`/context update for {topic}`**
- Update context when APIs/frameworks change
- **Reads**: `operations/update.md`

**`/context error for {error}`**
- Add recurring error to knowledge base
- **Reads**: `operations/error.md` + `standards/templates.md`

**`/context create {category}`**
- Create new context category with structure
- **Reads**: `guides/creation.md` + `standards/structure.md` + `standards/templates.md`

---

### Migration

**`/context migrate`**
- Copy project-intelligence from global (`~/.config/opencode/context/`) to local (`.opencode/context/`)
- For users who installed globally but want project-specific, git-committed context
- Shows diff if local files already exist, asks before overwriting
- Optionally cleans up global project-intelligence after migration
- **Reads**: `standards/mvi.md`

---

### Utility Operations

**`/context map [category]`**
- View current context structure, file counts

**`/context validate`**
- Check integrity, references, file sizes

**`/context help`**
- Show all operations with examples

---

## Lazy Loading Strategy

<lazy_load_map>
  <operation name="default">
    Read: operations/harvest.md, standards/mvi.md
  </operation>
  
  <operation name="harvest">
    Read: operations/harvest.md, standards/mvi.md
  </operation>
  
  <operation name="compact">
    Read: guides/compact.md, standards/mvi.md
  </operation>
  
  <operation name="extract">
    Read: operations/extract.md, standards/mvi.md, guides/compact.md
  </operation>
  
  <operation name="organize">
    Read: operations/organize.md, standards/structure.md
  </operation>
  
  <operation name="update">
    Read: operations/update.md, standards/mvi.md
  </operation>
  
  <operation name="error">
    Read: operations/error.md, standards/templates.md
  </operation>
  
  <operation name="create">
    Read: guides/creation.md, standards/structure.md, standards/templates.md
  </operation>
  
  <operation name="migrate">
    Read: standards/mvi.md
  </operation>
  
  <operation name="map">
    Read: (none - read-only analysis)
  </operation>
  
  <operation name="validate">
    Read: standards/mvi.md, standards/frontmatter.md, standards/structure.md
  </operation>
</lazy_load_map>

**All files located in**: `.opencode/context/core/context-system/`

---

### Execution: Help Operation

**When operation="help"**, display all operations with examples:

**Purpose**: Show user all available `/context` operations with usage examples.

**No subagent needed** - execute directly.

---

#### Step 1: Display Operations List

**Format** the output as follows:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/context - Context Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

12 operations available:

PRIMARY OPERATIONS (Harvest & Compact)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  harvest [path]          Extract AI summaries → permanent context
  compact {file}          Minimize verbose file to MVI format

SECONDARY OPERATIONS (Custom Context Creation)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  extract from {source}   Extract context from docs/code/URLs
  organize {category}     Restructure flat files → function folders
  update for {topic}      Update context when APIs/frameworks change
  error for {error}       Add recurring error to knowledge base
  create {category}       Create new context category with structure

MIGRATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  migrate                 Copy project-intelligence: global → local

UTILITY OPERATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  map [category]          View context structure, file counts
  validate                Check integrity, references, file sizes
  help                    Show this help message

DEFAULT BEHAVIOR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  (no arguments)          Quick scan → suggests harvest

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

#### Step 2: Display Usage Examples

**Show common examples**:

```
EXAMPLES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /context                      # Quick scan (no arguments)
  /context harvest              # Harvest AI summaries from workspace
  /context harvest .tmp/        # Harvest from specific directory
  /context compact file.md      # Minimize verbose file
  /context extract from docs/   # Extract from documentation
  /context organize core/       # Organize context category
  /context update for React 18  # Update for framework changes
  /context migrate              # Migrate global → local context
  /context map                  # View structure
  /context validate             # Check integrity

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Most common: /context harvest
Start here:  /context (no arguments) - quick scan suggests action

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

#### Step 3: Display Context System Info

**Show context system location**:

```
CONTEXT SYSTEM:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Location: .opencode/context/core/context-system/

Structure:
  ├── operations/     # Operation workflows (harvest, extract, organize...)
  ├── standards/      # MVI, structure, templates
  └── guides/         # Compaction, creation standards

Read first: standards/mvi.md (Minimal Viable Information principle)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

#### Step 4: Offer Next Action

**End with interactive prompt**:

```
What would you like to do?
  /context harvest              # Most common - tidy up summaries
  /context {operation} {args}   # Run specific operation
  /context help                 # Show this help again
```

---

**Implementation Notes**:

- **Source**: Operation descriptions from "Operations" section above (lines 91-150)
- **Format**: Use boxes (━━━) for visual separation
- **Examples**: Show 1-2 examples per operation where applicable
- **Tone**: Helpful, scannable, actionable
- **Length**: ~80 lines total (fits on one screen)
```

---

## Execution Instructions

**When the user runs `/context`**, execute this workflow:

### 1. Parse Operation from Arguments

**Analyze** `$ARGUMENTS`:

#### Pattern Recognition

Some operations use **special keywords** (`from`, `for`) as part of their syntax:

| Pattern | Example | Operation | Arguments |
|---------|---------|-----------|-----------|
| `{op} from {source}` | `extract from docs/api.md` | `extract` | `from docs/api.md` |
| `{op} for {topic}` | `update for React 18` | `update` | `for React 18` |
| `{op} for {error}` | `error for TypeError` | `error` | `for TypeError` |
| `{op} {arg}` | `organize development/` | `organize` | `development/` |
| `{op}` | `harvest` | `harvest` | (empty) |

#### Parsing Algorithm

```bash
Arguments: "$ARGUMENTS"

Step 1: Split by first space
  - First word = candidate operation name
  - Rest = candidate arguments

Step 2: Check for special patterns
  IF first word is "extract" AND rest starts with "from":
    → operation = "extract"
    → args = rest (includes "from")
  
  ELSE IF first word is "update" AND rest starts with "for":
    → operation = "update"
    → args = rest (includes "for")
  
  ELSE IF first word is "error" AND rest starts with "for":
    → operation = "error"
    → args = rest (includes "for")
  
  ELSE:
    → operation = first word
    → args = rest (standard parsing)
```

#### Examples

```
Input: ""
  → operation: "default", args: ""

Input: "harvest"
  → operation: "harvest", args: ""

Input: "harvest .tmp/"
  → operation: "harvest", args: ".tmp/"

Input: "extract from docs/api.md"
  → operation: "extract", args: "from docs/api.md"  ✓ (keeps "from")

Input: "update for React 18 breaking changes"
  → operation: "update", args: "for React 18 breaking changes"  ✓ (keeps "for")

Input: "error for TypeError: Cannot read property"
  → operation: "error", args: "for TypeError: Cannot read property"  ✓ (keeps "for")

Input: "organize development/"
  → operation: "organize", args: "development/"

Input: "help"
  → operation: "help", args: ""
```

**Store**: `{operation}` and `{args}` for use in subsequent steps.

#### Operation Mapping to Subagents

**Map** the parsed operation to the appropriate handler:

| Operation | Handler | Notes |
|-----------|---------|-------|
| (empty) | `default` | Execute quick scan directly |
| `harvest`, `compact`, `extract`, `organize`, `update`, `error`, `create`, `migrate` | **ContextOrganizer** | Delegate with workflow |
| `map`, `validate` | **ContextScout** | Delegate for analysis |
| `help` | (direct) | Display help directly (no subagent) |

---

### 2. Load Context Files (Lazy Loading) ⛔ CRITICAL

**Look up** `{operation}` in the `<lazy_load_map>` above.

**For each file listed** (e.g., `operations/harvest.md, standards/mvi.md`):

```bash
# Read each context file BEFORE proceeding
# Path: .opencode/context/core/context-system/{path}
```

**Action**: Use the **Read tool** to load each file:
- `.opencode/context/core/context-system/operations/harvest.md`
- `.opencode/context/core/context-system/standards/mvi.md`

**Why**: These files contain the workflow definitions and standards the subagent needs.

**Checkpoint**: All required context files loaded → proceed to Step 3.

---

### 3. Extract Workflow Definition

**Map operation name** to workflow tag:

| Operation | Workflow Tag | Source File |
|-----------|-------------|-------------|
| harvest | `<harvest_workflow>` | context-organizer.md |
| extract | `<extract_workflow>` | context-organizer.md |
| organize | `<organize_workflow>` | context-organizer.md |
| update | `<update_workflow>` | context-organizer.md |
| error | `<error_workflow>` | context-organizer.md |
| create | `<create_workflow>` | context-organizer.md |
| compact | `<compact_workflow>` | context-organizer.md |
| migrate | `<migrate_workflow>` | context-organizer.md |
| map | `<map_workflow>` | contextscout.md |
| validate | `<validate_workflow>` | contextscout.md |

**Extract the workflow section**:

From the loaded context file, extract content between the workflow tags:

```
Search for: <operation_name>_workflow>
Extract: Everything from <operation_name>_workflow> to </operation_name>_workflow>
```

**Example** (for "harvest" operation):

```
Found in context-organizer.md:

<harvest_workflow>
  <!-- 6-stage harvest workflow per operations/harvest.md -->

  <stage id="1" name="Scan">
    **Purpose**: Find all summary files in workspace
    ...
  </stage>

  <stage id="2" name="Analyze">
    ...
  </stage>

</harvest_workflow>
```

**Keep the full section** including:
- Opening tag: `<harvest_workflow>`
- All content (stages, instructions, validation)
- Closing tag: `</harvest_workflow>`

**Store** this for the subagent prompt.

---

### 4. Route to Subagent

**Select subagent** based on operation:

| Operation | Subagent | Context Bundle |
|-----------|----------|----------------|
| harvest, extract, organize, update, error, create, migrate | **ContextOrganizer** | Loaded context files + workflow to execute |
| map, validate | **ContextScout** | Operation name + arguments |
| default | (execute directly) | N/A |
| help | (execute directly) | N/A |

**If ContextOrganizer or ContextScout**:

Invoke subagent using the `task` tool:

```
task(
  subagent_type="ContextOrganizer",  // or "ContextScout"
  description="/context {operation} operation",
  prompt="=== CONTEXT LOADED ===
          The following context files were loaded per lazy_load_map:
          
          1. {filename1} - {brief summary of content}
          2. {filename2} - {brief summary}
          
          === OPERATION ===
          Name: {operation}
          Arguments: {args}
          
          === WORKFLOW TO EXECUTE ===
          [Insert the extracted <operation>_workflow section from Step 3]
          
          Example format (for 'harvest'):
          <harvest_workflow>
            <stage id=\"1\" name=\"Scan\">
              **Purpose**: Find all summary files in workspace
              ...
            </stage>
            ...
          </harvest_workflow>
          
          === REQUIREMENTS ===
          - Execute workflow stages in order
          - Enforce @approval_gate before destructive operations (show approval UI, wait for input)
          - Enforce @mvi_compliance (files <200 lines, 1-3 sentences, 3-5 bullets, <10 line examples)
          - Enforce @function_structure (concepts/, examples/, guides/, lookup/, errors/)
          - Report errors and stop (@report_first, @stop_on_failure)
          
          Begin execution."
)
```

**If operation="default"**:
- Execute the QuickScan workflow from the "Default Behavior" section above
- Show scan results with suggested actions

**If operation="help"**:
- Display all operations with examples (from "Operations" section above)

---

### 4. Monitor Completion

**Wait** for subagent task to complete.

**On successful completion**:
- Show subagent's output to user
- Ask: "Complete & satisfactory? Cleanup temp files?" (@confirm_cleanup rule)

**On error or failure**:
- Report error to user
- Propose fix based on error
- Ask: "Approve fix and retry?" (@report_first rule)
- Do NOT auto-fix without approval
```

---

## Subagent Routing

<subagent_routing>
  <!-- Delegate operations to specialized subagents -->
  <route operations="harvest|extract|organize|update|error|create|migrate" to="ContextOrganizer">
    Pass: operation name, arguments, lazy load map
    Subagent loads: Required context files from .opencode/context/core/context-system/
    Subagent executes: Multi-stage workflow per operation
  </route>
  
  <route operations="map|validate" to="ContextScout">
    Pass: operation name, arguments
    Subagent executes: Read-only analysis and reporting
  </route>
</subagent_routing>

---

## Quick Reference

### Structure
```
.opencode/context/core/context-system/
├── operations/     # How to do things (harvest, extract, organize, update)
├── standards/      # What to follow (mvi, structure, templates)
└── guides/         # Step-by-step (workflows, compact, creation)
```

### MVI Principle (Quick)
- Core concept: 1-3 sentences
- Key points: 3-5 bullets
- Minimal example: <10 lines
- Reference link: to full docs
- File size: <200 lines

### Function-Based Structure (Quick)
```
{category}/
├── navigation.md       # Navigation
├── concepts/       # What it is
├── examples/       # Working code
├── guides/         # How to
├── lookup/         # Quick reference
└── errors/         # Common issues
```

---

## Examples

### Default (Quick Scan)
```bash
/context
# Scans workspace, suggests harvest if summaries found
```

### Harvest Summaries
```bash
/context harvest
/context harvest .tmp/
/context harvest OVERVIEW.md
```

### Extract from Docs
```bash
/context extract from docs/api.md
/context extract from https://react.dev/hooks
```

### Organize Existing
```bash
/context organize development/
/context organize development/ --dry-run
```

### Update for Changes
```bash
/context update for [framework] [version]
/context update for [library] [version] breaking changes
```

### Migrate Global to Local
```bash
/context migrate
# Copies project-intelligence from ~/.config/opencode/context/ to .opencode/context/
# Shows what will be copied, asks for approval before proceeding
```

---

## Success Criteria

After any operation:
- [ ] All files <200 lines? (@critical_rules.mvi_strict)
- [ ] Function-based structure used? (@critical_rules.function_structure)
- [ ] Approval UI shown for destructive ops? (@critical_rules.approval_gate)
- [ ] Required context loaded? (@critical_rules.lazy_load)
- [ ] navigation.md updated?
- [ ] Files scannable in <30 seconds?

---

## Full Documentation

**Context System Location**: `.opencode/context/core/context-system/`

**Structure**:
- `operations/` - Detailed operation workflows
- `standards/` - MVI, structure, templates
- `guides/` - Interactive examples, creation standards

**Read before using**: `standards/mvi.md` (understand Minimal Viable Information principle)
