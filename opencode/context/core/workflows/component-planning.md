<!-- Context: workflows/component-planning | Priority: high | Version: 1.1 | Updated: 2026-10-23 -->

# Component-Based Planning Workflow

> **Scope**: This workflow adds a high-level architecture/roadmap layer (`master-plan.md` +
> `component-{name}.md`) ABOVE the actual task-tracking system. It is used by OpenCoder in
> Stage 3/4 (InitSession/Plan) for features complex enough to need an architecture narrative
> before breakdown.
>
> **This does not replace TaskManager.** Once a component is ready to execute, its atomic steps
> still go through `TaskManager` to produce `.tmp/tasks/{feature}/task.json` +
> `subtask_NN.json` — the only structure `task-cli.ts`, `CoderAgent`, and `BatchExecutor`
> understand. `master-plan.md`/`component-{name}.md` are narrative planning artifacts for human
> review and session continuity, not an alternative execution tracker.
>
> **Related**: [`feature-breakdown.md`](./feature-breakdown.md) — a simpler, single-level markdown
> breakdown for work that won't be delegated to subagents at all (no TaskManager involved). Use
> this file instead when the feature spans multiple layers/components and some parts will be
> delegated for parallel execution.

## Overview
This workflow replaces "Monolithic Planning" (planning everything at once) with "Iterative Component Planning". It is designed for complex features that require breaking down into functional units.

## Core Philosophy
**"Plan the System, Build the Component."**
Don't try to write a detailed plan for the entire system upfront. Create a high-level roadmap, then zoom in to plan one component in detail before executing it.

## The Two-Level Plan Structure

### Level 1: The Master Plan (Roadmap)
**File:** `.tmp/sessions/{id}/master-plan.md`
**Purpose:** High-level architecture and dependency graph.
**Content:**
- System Architecture Diagram (ASCII)
- List of Components (e.g., Auth, Database, API, UI)
- Dependency Order (What must be built first?)
- Global Standards/Decisions

### Level 2: The Component Plan (Active Spec)
**File:** `.tmp/sessions/{id}/component-{name}.md`
**Purpose:** Detailed execution steps for the *current* focus.
**Content:**
- **Interface Definition**: Types, function signatures, API contracts.
- **Test Strategy**: What specific cases will be tested?
- **Task List**: Atomic steps (Create file, Write test, Implement logic).
- **Verification**: How do we know this component is done?

---

## Workflow Steps

### Phase 1: System Design (The Master Plan)
1.  **Analyze**: Understand the full feature request.
2.  **Decompose**: Break the system into functional Components (e.g., "User Service", "Email Worker", "Frontend Form").
3.  **Draft Master Plan**: Create `master-plan.md`.
4.  **Approve**: Get user buy-in on the architecture and order.

### Phase 2: Component Execution Loop
*Repeat this for each component in the Master Plan:*

1.  **Select Component**: Pick the next unblocked component.
2.  **Draft Component Plan**: Create `component-{name}.md`.
    *   Define the *exact* interface/types first.
    *   List the atomic implementation steps.
3.  **Approve**: Show the detailed component plan to the user.
4.  **Execute**:
    *   If executing directly (no delegation): Load `component-{name}.md` into `TodoWrite`. Implement -> Validate -> Check off.
    *   If delegating to subagents: Hand the component's atomic steps to `TaskManager` to create `.tmp/tasks/{feature}/subtask_NN.json` files — this is what `CoderAgent`/`BatchExecutor` actually execute against.
5.  **Integrate**: Update `master-plan.md` to mark component as complete.

---

## When to Use This
- **Complex Features**: >3 files, multiple layers (DB + API + UI).
- **Unknowns**: When later parts of the system depend on earlier decisions.
- **Large Scope**: Anything taking >2 hours.

## Example Master Plan (`master-plan.md`)

```markdown
# Master Plan: E-Commerce Checkout

## Architecture
[Cart] -> [Order Service] -> [Payment Gateway]
                       -> [Inventory Service]

## Component Order
1. [ ] **Inventory Service** (Check stock)
2. [ ] **Order Service** (Create order record)
3. [ ] **Payment Integration** (Stripe)
4. [ ] **Checkout UI** (React components)
```

## Example Component Plan (`component-inventory.md`)

```markdown
# Component: Inventory Service

## Interface
```typescript
interface InventoryManager {
  checkStock(sku: string): Promise<boolean>;
  reserve(sku: string, quantity: number): Promise<void>;
}
```

## Tasks
- [ ] Define `InventoryManager` interface in `src/types.ts`
- [ ] Create mock implementation for tests
- [ ] Implement `checkStock` logic with DB query
- [ ] Add unit tests for race conditions
```
