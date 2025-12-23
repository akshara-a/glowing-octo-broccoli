# Git Cherry-Pick – A Practical Learning Guide

## What is `git cherry-pick`?

`git cherry-pick` is a Git command used to **apply one or more specific commits from one branch onto another branch**.

Unlike `git merge` or `git rebase`, which operate on a sequence of commits or an entire branch history, **cherry-pick works at the commit level**, giving you fine-grained control over what changes are introduced.

In simple terms:

> **Cherry-pick means selecting only the exact commit(s) you need and applying them elsewhere.**

---

## When Should You Use `git cherry-pick`?

Cherry-pick is most appropriate when you want **precision without affecting unrelated changes**.

Common scenarios include:

- Applying the **same bug fix** to multiple release branches
- Moving a **single completed feature** to another branch
- Recovering work from a commit made on the **wrong branch**
- Applying an urgent **hotfix** directly to `main` or `release`
- Backporting a fix from a newer version to an older maintained version

---

## How `git cherry-pick` Works Internally

Every Git commit is identified by a **unique SHA-1 hash**.

When you cherry-pick a commit:

- Git takes the **diff (changes)** introduced by that commit
- Reapplies those changes onto the current branch
- Creates a **new commit** on the target branch

Important points to note:

- The **code changes remain the same**
- The **commit hash is always different**
- The new commit has a **different parent history**

This ensures branch histories remain independent.

---

## Basic Workflow

### Step 1: Identify the Commit

View commit history and copy the required hash:

```bash
git log --oneline
Step 2: Switch to the Target Branch
bash
Copy code
git checkout main
or (modern syntax):

bash
Copy code
git switch main
Step 3: Apply the Commit
bash
Copy code
git cherry-pick <commit-id>
Example
bash
Copy code
git checkout main
git cherry-pick a3f42e9
Result:

Changes from commit a3f42e9 are applied to main

A new commit is created on main

The original commit remains unchanged on its source branch

Cherry-Picking Multiple Commits
Pick Multiple Individual Commits
bash
Copy code
git cherry-pick <commit1> <commit2> <commit3>
Commits are applied in the order specified.

Pick a Continuous Range of Commits
bash
Copy code
git cherry-pick <start-commit>^..<end-commit>
Explanation:

<start-commit>^ includes the starting commit

All commits up to <end-commit> are applied sequentially

Handling Conflicts During Cherry-Pick
Cherry-pick may result in conflicts if the target branch has diverged.

Conflict Resolution Steps
Git pauses the operation and marks conflicted files

Open files and resolve conflicts manually

Stage the resolved files:

bash
Copy code
git add .
Continue the cherry-pick process:

bash
Copy code
git cherry-pick --continue
Abort the Cherry-Pick
If you decide not to proceed:

bash
Copy code
git cherry-pick --abort
This restores the branch to its original state before cherry-picking began.

Skipping a Commit During Cherry-Pick
If cherry-picking multiple commits and one commit fails:

bash
Copy code
git cherry-pick --skip
Git will move on to the next commit in the sequence.

Author vs Committer in Cherry-Pick
Each Git commit records two identities:

Author: Original creator of the changes

Committer: Person who applied the commit

Cherry-Pick Behavior
The author remains unchanged

You become the committer

Commit date reflects the new application time

This maintains proper attribution.

Changing the Author (If Required)
Changing the author should be done cautiously and only when necessary.

bash
Copy code
git commit --amend --author="Name <email@address.com>"
Use cases include:

Correcting incorrect author information

Applying organizational policies

Best Practices
Cherry-pick small, focused commits

Avoid cherry-picking merge commits

Do not cherry-pick commits that depend on missing context

Prefer cherry-pick for hotfixes and backports

Be mindful of duplicate commits across branches

Common Pitfalls
Cherry-picking large commits increases conflict risk

Repeated cherry-picks can complicate history

Cherry-picking from rewritten history may fail