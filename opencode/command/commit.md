---
description: Create well-formatted commits with conventional commit messages
---

# Commit Command

You are an AI agent that helps create well-formatted git commits with conventional commit messages, follow these instructions exactly. Present the proposed commit message and wait for the user's confirmation before committing (@approval_gate). Never push; pushing is always a separate, explicit user decision.

## Instructions for Agent

When the user runs this command, execute the following workflow:

1. **Check command mode**:
   - If user provides $ARGUMENTS, use that as the commit message and skip step 4
     (message generation). Still run steps 2, 3 and 5, and still confirm before
     committing — skipping generation never skips the approval gate.

2. **Determine what to commit**:
   - Run `git status --porcelain` to see the working tree.
   - **If files are already staged**: commit exactly those. Do not add anything else,
     even if other files are dirty — the user staged deliberately.
   - **If nothing is staged**: do not run `git add .` silently. Show the candidate files
     and ask which to stage.
   - Stage only what the user confirms, then proceed.
   
3. **Analyze the changes**:
   - Run `git diff --cached` to see what will be committed
   - Analyze the diff to determine the primary change type (feat, fix, docs, etc.)
   - Identify the main scope and purpose of the changes
   
4. **Generate commit message**:
   - Determine the type and scope from the staged diff
   - Create message following format: `<type>(<scope>): <description>`
   - Keep description concise, clear, and in imperative mood
   - Show the proposed message to user for confirmation
   
5. **Execute the commit**:
   - Run `git commit -m "<generated message>"`
   - Display the commit hash and confirm success
   - Provide brief summary of what was committed

## Commit Message Guidelines

When generating commit messages, follow these rules:

- **Atomic commits**: Each commit should contain related changes that serve a single purpose
- **Imperative mood**: Write as commands (e.g., "add feature" not "added feature")
- **Concise first line**: Keep under 72 characters
- **Conventional format**: Use `<type>(<scope>): <description>` where type is one of:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation changes
  - `style`: Code style changes (formatting, etc.)
  - `refactor`: Code changes that neither fix bugs nor add features
  - `perf`: Performance improvements
  - `test`: Adding or fixing tests
  - `chore`: Changes to the build process, tools, etc.
- **Scope**: Optional but preferred — the area touched, e.g. `fix(command):`, `refactor(agents):`
- **Body**: Use it when the subject cannot carry the reasoning. Explain why, not just what.

## Reference: Good Commit Examples

Use these as examples when generating commit messages:
- `feat(auth): add session refresh on token expiry`
- `fix(parser): handle empty input without panicking`
- `docs: add README`
- `refactor(agents): single source of truth for parallel batch execution`
- `test(auth): cover invalid-credential paths`
- `chore: drop unused registry.json`
- `perf(index): avoid re-scanning unchanged files`

If the change needs justification, put it in the body rather than stretching the subject.

## Agent Behavior Notes

- **Never blanket-stage**: `git add .` takes every dirty and untracked file, related or not.
  That breaks the atomic-commit rule above, lets the generated message describe a mixture of
  unrelated changes, and can put secrets into history — where deleting the file later does not
  remove it. List candidates and confirm instead.
- **Respect existing staging**: If files are already staged, commit exactly those.
- **Confirm before committing**: Show the proposed message and wait for approval. This command
  honours @approval_gate like every other agent in this repo — there is no "just commit it" mode.
- **Never push**: This command stops at the commit. Pushing publishes unreviewed work and is the
  user's call, not the agent's. If the user wants it pushed, they will ask.
- **Message quality**: Ensure commit messages are clear, concise, and follow conventional format
- **Success feedback**: After successful commit, show commit hash and brief summary
