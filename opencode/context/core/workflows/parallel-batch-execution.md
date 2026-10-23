<!-- Context: workflows/parallel-batch-execution | Priority: high | Version: 1.0 | Updated: 2026-10-23 -->

# Parallel Batch Execution

> **Scope**: The authoritative algorithm for executing a `TaskManager`-produced task set in
> dependency-ordered batches, with parallel delegation inside each batch. This is the single source
> of truth — `OpenAgent`, `OpenCoder`, and `BatchExecutor` all reference this file rather than
> restating the algorithm.
>
> **Use this when**: `.tmp/tasks/{feature}/` exists (i.e. `TaskManager` has produced
> `task.json` + `subtask_NN.json` files) and the work will be delegated to subagents.
>
> **Do NOT use this when**: You are executing work directly without delegation, or no
> `task.json` exists. See [`feature-breakdown.md`](./feature-breakdown.md) for the lightweight
> manual alternative.
>
> **Related**: [`task-delegation-basics.md`](./task-delegation-basics.md) — how to construct an
> individual delegation prompt.

---

## Why batches

Subtasks declare dependencies via `depends_on`. Running a subtask before its dependencies are
complete produces work built on absent or wrong foundations, and the resulting state is not
detectable by validation — `router.sh validate` checks file structure, not ordering history.
Batching is what makes `depends_on` actually enforced at execution time.

Within a batch, tasks are independent by construction, so they can run simultaneously. Between
batches they cannot. This is the entire rule.

---

## Algorithm

### 1. Read the task structure

```bash
bash .opencode/skills/task-management/router.sh status {feature}
bash .opencode/skills/task-management/router.sh next {feature}
bash .opencode/skills/task-management/router.sh parallel {feature}
```

Read `task.json` and every `subtask_NN.json` in `.tmp/tasks/{feature}/`. Build the dependency
graph from each subtask's `depends_on` array.

### 2. Group into dependency-ordered batches

- **Batch 1** — every subtask with an empty `depends_on`.
- **Batch N** — every subtask whose dependencies are all satisfied by batches 1..N-1.

Repeat until all subtasks are assigned.

```
Execution Plan:
  Batch 1: [01, 02, 03]   no dependencies
  Batch 2: [04]           depends on 01+02+03
  Batch 3: [05]           depends on 04
```

A subtask only runs in parallel with its batch peers if it carries `parallel: true`. A batch may
legitimately contain a single task, or sequential-only tasks — that is not an error.

### 3. Execute the batch

Delegate every task in the batch **in the same message**, so they start simultaneously:

```javascript
task(subagent_type="CoderAgent", description="Task 01",
     prompt="Load context from .tmp/sessions/{session-id}/context.md
             Execute subtask: .tmp/tasks/{feature}/subtask_01.json
             Mark complete via router.sh when done.")

task(subagent_type="CoderAgent", description="Task 02",
     prompt="Load context from .tmp/sessions/{session-id}/context.md
             Execute subtask: .tmp/tasks/{feature}/subtask_02.json
             Mark complete via router.sh when done.")
```

Issuing these in separate turns serialises them and forfeits the point of batching.

### 4. Verify before advancing

```bash
bash .opencode/skills/task-management/router.sh status {feature}
```

Every subtask in the batch must report `status: "completed"`. Confirm declared deliverables exist.
Do not infer completion from a subagent's narrative reply — read the status.

### 5. Advance

Only once step 4 passes, proceed to the next batch. Repeat from step 3.

---

## Rules

| Rule | Detail |
|---|---|
| Within a batch | All tasks start together, in one message |
| Between batches | Batch N must be 100% complete and verified before N+1 starts |
| Parallel eligibility | `parallel: true` **and** no dependency on a batch peer |
| Completion source of truth | `router.sh status`, never a subagent's self-report |
| Partial batch | Treat as failure — do not advance |

`router.sh complete` refuses to mark a subtask done while its dependencies are unmet, so a
mis-ordered delegation surfaces as an error rather than silent corruption. Do not reach for
`--force` to work around a batching mistake; fix the batch order instead.

---

## Failure handling

If any task in a batch fails:

1. **Stop.** Do not start the next batch.
2. Record which tasks in the batch succeeded — completed work is preserved and must not be redone.
3. Report the failure, the batch state (`X/Y completed`), and the proposed fix.
4. Request approval before remediating.

This follows the standard stop-on-failure and report-first rules; a failed batch is never
auto-repaired.

---

## Related

- [`feature-breakdown.md`](./feature-breakdown.md) — manual breakdown when not delegating
- [`component-planning.md`](./component-planning.md) — architecture roadmap above the JSON layer
- [`task-delegation-basics.md`](./task-delegation-basics.md) — single-delegation prompt structure
- `.opencode/skills/task-management/SKILL.md` — `router.sh` command reference
