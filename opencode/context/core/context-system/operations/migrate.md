<!-- Context: core/migrate | Priority: medium | Version: 1.0 | Updated: 2026-02-15 -->

# Context Migrate Operation

**Purpose**: Copy project-intelligence from global (`~/.config/opencode/context/`) to local (`.opencode/context/`) for git version control and team sharing.

**Last Updated**: 2026-02-06

---

## 4-Stage Workflow

### Stage 1: Detect Sources

```
Scanning global context...

Global: ~/.config/opencode/context/project-intelligence/
  technical-domain.md (1.2 KB, v1.3)
  navigation.md (800 bytes, v1.0)
  business-domain.md (1.5 KB, v1.1)

Local: .opencode/context/project-intelligence/
Status: No local project-intelligence/ found
```

**Exit conditions:**
- No global context → "Use `/add-context` to create project intelligence"
- No `project-intelligence/` → "Only project-specific files migrate, not core standards"

---

### Stage 2: Check Conflicts

If local `project-intelligence/` exists:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Conflict: Local project-intelligence already exists
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Global files:                              Local files:
  technical-domain.md (v1.3)                technical-domain.md (v1.0)
  navigation.md (v1.0)                      navigation.md (v1.0)
  business-domain.md (v1.1)                 (not present)

Options:
  1. Skip existing — copy only missing files
  2. Overwrite all — replace local with global (backup first)
  3. Cancel

Choose [1/2/3]: _
```

**If overwrite chosen**: Show version diff, ask about backup

---

### Stage 3: Approval & Copy

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Migration Plan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

From: ~/.config/opencode/context/project-intelligence/
To:   .opencode/context/project-intelligence/

Files to copy:
  ✓ technical-domain.md (1.2 KB)
  ✓ navigation.md (800 bytes)
  ✓ business-domain.md (1.5 KB)

After migration:
  → Local files committed to git = team gets your patterns
  → Agents load local (overrides global)
  → Global files remain as fallback for other projects

Proceed? [y/n]: _
```

**Actions on approval:**
1. Create directory if needed
2. Copy files
3. Validate frontmatter and MVI compliance

---

### Stage 4: Cleanup & Confirmation

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Migration Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Copied 3 files to .opencode/context/project-intelligence/

Clean up global project-intelligence?

Global files no longer needed for THIS project (local takes priority).
Keeping them means they still apply as fallback to other projects.

  1. Keep global files (safe default)
  2. Remove global project-intelligence/ (only affects this user)

Choose [1/2] (default: 1): _
```

**If remove chosen**: Delete `~/.config/opencode/context/project-intelligence/` only

---

## Migration Scope

| Migrated (project-specific) | NOT Migrated (universal) |
|---|---|
| `project-intelligence/*` | `core/standards/` |
| business-domain.md | `core/context-system/` |
| technical-domain.md | `core/workflows/` |
| navigation.md | `core/guides/` |
| decisions-log.md | Any `core/` files |

**Rationale**: Project intelligence = YOUR patterns (git-committed, team-shared). Core standards = universal (stay global).

---

## Errors

**Permission denied:**
```
Error: Cannot write to .opencode/context/project-intelligence/
Check directory permissions and try again.
```

**Global path not found:**
```
No global OpenCode config found at ~/.config/opencode/

If custom location, set OPENCODE_INSTALL_DIR:
  export OPENCODE_INSTALL_DIR=/your/custom/path
  /context migrate
```

---

## Related

- `/add-context` — Create new project intelligence (interactive wizard)
- `/context harvest` — Extract knowledge from summaries
- `.opencode/context/core/navigation.md` — Core navigation
