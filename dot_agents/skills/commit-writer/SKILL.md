---
name: commit-writer
description: Generate clear git commit messages from code changes or diffs. Use when the user commits changes, stages files, or asks for a commit message.
---

# Commit Writer

Create high-quality git commit messages that clearly describe the change.

Analyze the staged files, diff, or user description and produce a concise commit message.

---

# Workflow

1. Analyze the code changes or git diff.
2. Identify the main purpose of the change.
3. Determine the commit type.
4. Write a clear commit message.
5. Optionally add a short body explaining why the change was made.

Do not invent information not visible in the changes.

# Diff Analysis

When possible, analyze the staged git diff rather than relying only on
file names or commit summaries.

Focus on the actual code changes to determine:

- the real purpose of the change
- the dominant change type (feat, fix, refactor, etc.)
- whether multiple unrelated changes exist

---

# Commit Type Rules

Use the following conventional commit types:

feat → new feature  
fix → bug fix  
refactor → code restructuring without behavior change  
docs → documentation updates  
chore → maintenance tasks  
test → tests added or updated

---

# Commit Message Format

<type>: <short summary>

Optional body:

<type>: <short summary>

Explain why the change was made.
Mention important details if necessary.

---

# Rules

- first line max 72 characters
- imperative mood ("add validation", not "added validation")
- describe the main change
- avoid vague commits like "update stuff"

---

# Examples

feat: add JWT authentication middleware

fix: prevent duplicate user creation

refactor: extract database connection logic

docs: update installation instructions
