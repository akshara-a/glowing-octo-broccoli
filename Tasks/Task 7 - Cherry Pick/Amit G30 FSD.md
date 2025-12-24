Git Cherry-Pick

- git cherry-pick is used to apply a specific commit from one branch to another.
- It copies selected changes instead of merging full branch history.
- A new commit ID is generated on the target branch.

Uses
- Apply bug fixes to multiple branches.
- Move a single feature commit.
- Recover accidentally committed work.

Working
- Every Git commit has a unique SHA hash.
- Cherry-pick replays the selected commit on another branch.
- Code remains the same, commit hash changes.

Important Commands
- View commits:
  git log

- Switch branch:
  git checkout main

- Apply commit:
  git cherry-pick <commit-id>

Example
git checkout main
git cherry-pick a3f42e9

Conflict Handling
- Resolve conflicts manually.
- Stage files:
  git add .

- Continue:
  git cherry-pick --continue

- Abort:
  git cherry-pick --abort

Multiple Commits
git cherry-pick <commit1> <commit2>
git cherry-pick <start>^..<end>

Author & Committer
  Author: Original code writer (unchanged).
  Committer: Person who cherry-picks the commit.
  Maintains correct contribution history.

Best Practices
  Cherry-pick small commits.
  Avoid merge commits.
  Test after cherry-pick.
