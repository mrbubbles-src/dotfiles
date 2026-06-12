---
name: pr-reviewer
description: Review pull request titles and descriptions for clarity, scope, and completeness. Use when reviewing or improving a pull request description.
---

# Pull Request Reviewer

Review pull request drafts and improve them if necessary.

Focus on clarity, scope, and completeness.

---

# Review Checklist

Evaluate the PR using the following rules.

## 1 Title Quality

Check:

- Is the title concise?
- Does it describe the main change?
- Does it follow the format `<type>: description`?

If unclear → rewrite it.

---

## 2 Change Explanation

Check:

- Does the PR clearly explain **what changed**?
- Does it explain **why the change was needed**?

If missing → add explanation.

---

## 3 Scope

Check that the PR contains **one logical change only**.

If multiple unrelated changes appear → highlight this.

---

## 4 Issue References

If an issue or ticket is implied, ensure references exist:

Closes #123  
Relates to #456

Do not invent issue numbers.

---

## 5 Testing

Verify:

- Tests are mentioned
- Or the PR explains why tests are unnecessary

Examples:

"No tests required — documentation change."

---

## 6 Branch Scope

Check whether the PR description reflects the full branch changes.

If the description only explains a single commit but the diff shows
multiple changes, improve the explanation.

---

# Rewrite Rules

If improvements are required:

- keep the structure
- improve clarity
- remove vague wording
- ensure all sections are filled

Return the improved PR draft.
