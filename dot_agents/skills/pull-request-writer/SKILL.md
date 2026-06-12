---
name: pr-writer
description: Generate high-quality pull request titles and descriptions from code changes or commit history. Use when the user mentions PR, pull request, PR description, open PR, or summarize changes for a PR.
---

# Pull Request Writer

Create clear, professional pull request titles and descriptions by analyzing the code changes.

Do NOT rely on repository templates.  
Instead infer the context from the code changes, diff, or commit history.

---

# Workflow

Follow these steps strictly:

1. Analyze the provided changes (diff, commits, or user explanation).
2. Determine the main change type:
   - feat
   - fix
   - refactor
   - docs
   - chore
3. Identify:
   - what changed
   - why the change was made
   - important implementation details
4. Draft a pull request title.
5. Generate the PR description using the structure below.
6. Run the **PR Review Workflow** at the end.

Do not invent information that is not supported by the code changes.

# Branch Diff Analysis

When generating a pull request, treat the PR as the result of the
entire branch.

Conceptually analyze the full branch diff:

git diff dev...HEAD

The pull request description must summarize the overall change across
the branch, not only the latest commit.

---

# Title Rules

Format:

<type>: <short description>

Examples:

feat: add authentication middleware  
fix: prevent duplicate user creation  
refactor: extract database connection logic  
docs: update installation instructions

Rules:

- max 72 characters
- describe the primary change
- avoid vague titles like "updates" or "changes"

---

# PR Description Structure

You MUST follow this structure.

## What

Explain what changed.

## Why

Explain why this change was necessary.

## Changes

List the most important modifications.

- change 1
- change 2
- change 3

## Testing

Describe how the change was tested.

If no tests exist:

No tests required — explain why.

---

# Project PR Guidelines

Always enforce the following principles:

- Describe what the PR changes **and why**
- Reference issues when relevant (`Closes #123`, `Relates to #456`), if no issue is relevant, omit the issue reference.
- Keep PR scope focused (no unrelated changes)
- Include tests or explain why tests are unnecessary

---

# PR Review Workflow

After generating the PR, run the **pr-reviewer skill** internally.

Verify:

- title clarity
- missing context
- vague explanations
- scope creep
- missing testing explanation

If issues are found, rewrite the PR before returning it.
