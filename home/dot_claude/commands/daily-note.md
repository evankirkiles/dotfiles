---
allowed-tools: Bash(*), mcp__github__*, mcp__jira__*
description:
  Populate today's daily note with current GitHub PRs and Jira tickets
---

## Context

- Today's note path:
  !`bash -c 'YEAR=$(date +%Y); MONTH=$(date +%m); DATE=$(date +%Y-%m-%d); DOW=$(date +%a); NOTE_DIR="$HOME/Notes/$YEAR/$MONTH"; NOTE_FILE="$NOTE_DIR/$DATE-$DOW.md"; mkdir -p "$NOTE_DIR"; if [ ! -f "$NOTE_FILE" ]; then printf "# %s\n\n## Notes\n\n" "$DATE" > "$NOTE_FILE"; fi; echo "$NOTE_FILE"'`
- Yesterday's note contents:
  !`bash -c 'f=$(ls "$HOME/Notes/$(date -v-1d +%Y)/$(date -v-1d +%m)/$(date -v-1d +%Y-%m-%d)"*.md 2>/dev/null | head -1); [ -n "$f" ] && cat "$f" || echo "No previous note found."'`

## Your task

1. Read the daily note at today's note path above.
2. If a "## Yesterday's Summary" section is missing, write a brief summary of
   what was worked on based on yesterday's note contents above. If no previous
   note was found, skip this section.
3. Using the GitHub MCP, fetch:
   - My open pull requests (author: me)
   - Pull requests I have been requested to review
4. Using the Jira MCP, fetch Jira issues currently assigned to me that are In
   Progress or To Do.
5. If a "## Pull Requests" section is missing from the note, append it with the
   PR list.
6. If a "## Jira Tickets" section is missing, append it with the ticket list.
7. Do not modify any existing content — only add missing sections.
8. Confirm what was added and remind the user to run `:e` in nvim to reload.
