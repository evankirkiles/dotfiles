---
allowed-tools: mcp__atlassian__*, Read, Glob, Grep, Task, WebFetch
description: Draft a well-structured AGILE story with subtasks for a given feature or migration
---

You are drafting an AGILE user story and its subtasks. The input is: **$ARGUMENTS**

Follow these rules exactly.

---

## Step 1: Clarify scope (if needed)

If `$ARGUMENTS` is vague, ask only what's blocking you — no more than 2 questions:
- Who is the user and what are they trying to accomplish?
- What is in scope vs. out of scope for this story?

Do not ask for things you can infer from context.

---

## Step 2: Write the Story

A story captures a single, deliverable unit of user value. Use only the sections that apply.

### User Story

One or two sentences:

> As a **[role]**, I want **[capability]** so that **[benefit]**.

Or for migrations/replacements:

> As a **[role]**, I rely on **[existing thing]** to **[do what]**. To support **[goal]**,
> I would like **[desired outcome]** so that **[benefit]**.

### Background *(if helpful)*

What exists today, why it's changing, and any context a developer needs to understand the problem.
Use a list or table if the current flow has multiple steps. Keep it factual, not prescriptive.

### Proposed Solution *(if the approach is defined)*

The design, interface, or plan — whatever the story's primary output artifact is. Include rationale
for non-obvious decisions. This is the right place for implementation details; keep them out of AC.

### Behavioral Changes *(for migrations or replacements only)*

| Current behavior | New behavior | In scope? |
| --- | --- | --- |
| ... | ... | Yes / No / Deferred |

### Risks & Open Questions *(omit if none)*

Numbered list. Each item: a one-sentence description, a severity (low / medium / high), and a
recommended approach or owner.

### Acceptance Criteria

**Observable outcomes only. Confirmed by using the system, not by reading the code.**

Use a table with Given/When/Then language:

| **Criteria** | **Acceptance Conditions** |
| --- | --- |
| Short label | **When** I do X **Then** I observe Y |
| Short label | **Given** some context **When** I do X **Then** Y **And** Z |

Cover: the core happy path, each significant input or configuration variant, key error/edge cases,
and parity with any system being replaced. Every row should be verifiable by a non-author.

### Subtasks

List each subtask title in dependency order — each one should unblock the next, and be
independently completable and reviewable.

---

## Step 3: Write Each Subtask

Use this structure for every subtask:

```
### Subtask N: [Verb] [artifact]

[One paragraph: what needs to be built or done, and why. Give enough context for someone
to start work without asking questions. Reference existing patterns, files, or prior art
where useful.]

[Supporting detail: pseudocode, data shapes, steps, or examples — only what's genuinely
clarifying. Don't repeat what's obvious from the codebase or the story above.]

---

## Acceptance Criteria

[2–4 bullets: outcomes a reviewer can verify without reading source code or asking the author]

## How to Test

[1–3 concrete steps: what to run, click, query, or compare to confirm the work is done]
```

### The AC / Body / How to Test split

| Section | What goes here |
| --- | --- |
| **Body** | Implementation details — how to build it, what patterns to follow, data shapes, pseudocode |
| **Acceptance Criteria** | Observable outcomes — what is true when the work is done, verifiable from the outside |
| **How to Test** | Verification steps — commands to run, pages to visit, comparisons to make |

**AC must be outcomes, not a checklist of implementation tasks.** If verifying the bullet
requires reading source code, it belongs in the body instead.

Common AC patterns by subtask type:

- **New capability or feature:** Using the feature produces the expected result end-to-end
- **Integration with an external system:** The integration works against the real system in a real environment
- **Shared interface or contract:** The artifact exists, is usable, and has been reviewed by affected stakeholders
- **Refactor or internal change:** Existing behavior is unchanged (tests pass; no regression in staging)
- **Test coverage:** The test suite passes; specified scenarios are covered
- **Documentation:** The document exists, is accurate, and has been shared with affected parties

**Never put these in AC:**
- Internal implementation details (function signatures, field names, data structures)
- Steps the developer must perform to complete the work
- Anything requiring source code access to verify

---

## Step 4: Output

Produce the story and all subtasks as clean markdown, ready to paste into Jira or a planning doc.

Output only the ticket content. No preamble, no explanation, no commentary.
