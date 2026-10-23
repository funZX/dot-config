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
  
</critical_rules>

<principles>
  <interactive>Use `question` tool for all user interactions requiring input</interactive>
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
</examples>
