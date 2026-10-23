---
name: Tool Usage
description: Required tool usage rules for agent interactions
---

# Tool Usage Rules

> **Purpose**: Define mandatory tool usage patterns for agent interactions with users.

<critical_rules priority="absolute" enforcement="strict">
  <rule id="question_tool" scope="all_user_questions">
    ALWAYS use the `question` tool when asking questions to the user.
    
    **When to use:**
    - Gathering user preferences or requirements
    - Clarifying ambiguous instructions
    - Getting decisions on implementation choices
    - Offering choices about what direction to take
    - Any situation requiring user input/confirmation
    
    **Never:**
    - Ask questions directly in chat when the `question` tool is available
    - Make assumptions without confirming with the user first
  </rule>
  
  <rule id="todowrite_tool" scope="task_tracking">
    Use the `todowrite` tool for tracking task progress and maintaining visibility.
    
    **When to use:**
    - Starting multi-step tasks
    - Tracking progress through complex workflows
    - Maintaining visibility of what's been completed
    - Managing task lists for features or fixes
    
    **Format:**
    - Break tasks into clear, atomic steps
    - Mark items as completed as you finish them
    - Keep descriptions concise but specific
  </rule>
</critical_rules>

<principles>
  <interactive>Use `question` tool for all user interactions requiring input</interactive>
  <transparent>Use `todowrite` to maintain visibility into task progress</transparent>
  <efficient>Choose the right tool for the interaction type</efficient>
</principles>

<examples>
  <!-- Question Tool -->
  ```
  Use `question` when:
  - "Which approach do you prefer: A or B?"
  - "What would you like to name this component?"
  - "Should I include tests for this feature?"
  ```
  
  <!-- TodoWrite Tool -->
  ```
  Use `todowrite` for:
  - Multi-step features (4+ files)
  - Complex refactoring tasks
  - Bug fixes with multiple validation steps
  - Any task where progress tracking adds value
  ```
</examples>
