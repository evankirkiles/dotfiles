---
allowed-tools: Bash(*), mcp__atlassian__*, Read, Glob, Grep, Edit, Write, Task
description: Fetch a Jira ticket and implement it in the current codebase
---

## Task

Implement Jira ticket **$ARGUMENTS** in the current working directory.

### Step 1: Fetch ticket details

1. Call `getAccessibleAtlassianResources` to get the cloud ID.
2. Call `getJiraIssue` with the ticket key `$ARGUMENTS` to get the full issue.
3. If the issue has a parent, fetch the parent issue too for broader context.

### Step 2: Understand requirements

From the ticket(s), extract:
- **Goal**: What needs to be built or fixed
- **Acceptance criteria**: What done looks like
- **Constraints**: Any technical notes, links, or referenced files

### Step 3: Explore the codebase

Use Glob and Grep to find relevant files. Look at:
- Existing resolvers, datasources, or handlers related to the feature
- Type definitions and schemas touched by this ticket
- Tests for similar features to understand expected patterns

Read only what you need. Be targeted.

### Step 4: Implement

Write the code. Follow these rules strictly:
- Match the style and patterns of the surrounding code exactly
- No extra abstractions, no speculative features — only what the ticket requires
- All TypeScript must compile (`npx tsc --noEmit` or equivalent)
- After writing, run the project's type-check and lint commands to verify correctness
- Fix any type errors before finishing

### Step 5: Report

Summarize what you implemented in 3–5 bullet points. Do not repeat the ticket description back — only describe what changed in the code.
