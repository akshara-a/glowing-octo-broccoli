INTRODUCTION
Git is a distributed version control system used to track changes in source code during software development. While working with Git, one important command I learned is git cherry-pick. It helps developers apply specific changes from one branch to another without merging the entire branch.

WHAT IS GIT CHERRY-PICK?
Git cherry-pick is used to apply a particular commit from one branch to another branch. Unlike git merge or git rebase, cherry-pick allows us to select only the required commit. This makes it useful when we want a single change instead of full branch history.

USE CASES OF GIT CHERRY-PICK
Git cherry-pick is commonly used in the following situations:

 Fixing the same bug in multiple branches
 Moving a single feature commit to another branch
 Recovering work committed to the wrong branch
 Applying a hotfix quickly without merging full history

HOW GIT CHERRY-PICK WORKS
Every commit in Git has a unique commit hash called SHA. When cherry-pick is used, Git copies the changes from the selected commit and applies them as a new commit on the current branch.
The code changes remain the same, but the commit ID becomes different. The branch structure or graph symbols may also change.

BASIC COMMANDS USED
->git log
->git checkout <target-branch>
->git cherry-pick <commit-id>

HANDLING CONFLICTS
Sometimes conflicts occur while cherry-picking. In such cases, conflicts should be resolved manually. After fixing conflicts, the changes are added and cherry-pick is continued using the appropriate commands. Cherry-pick can also be aborted if needed.

AUTHOR AND COMMITTER DETAILS
Each Git commit stores two identities:
Author - the person who originally wrote the code
Committer - the person who applied the commit

When a commit is cherry-picked, the author name remains unchanged, and the committer becomes the person who performed the cherry-pick. This helps maintain proper credit and accountability.

EFFECT ON GIT HISTORY
Cherry-pick creates a new commit, so the commit hash changes and the branch graph symbols may look different. However, the commit message, author name, and code changes remain the same.

BEST PRACTICES
Cherry-pick should be used for small and meaningful commits. Merge commits should be avoided unless required. It should be used carefully to prevent duplicate changes in history.

CONCLUSION
Git cherry-pick is a powerful command that allows selective application of commits across branches. It helps maintain clean version history while preserving original author information. When used properly, it improves flexibility and control in collaborative development.
