# Git Cherry-Pick – What I Learned

Git cherry-pick is a command used to copy one specific commit from one branch and apply it to another branch without merging the whole branch. Instead of taking all changes, we select only the required commit.

Cherry-pick is useful when a commit is made in the wrong branch, when a bug fix is needed in another branch, or when we want only a single change and not the complete branch history.

Each commit in Git has a unique ID called a commit hash. Cherry-pick uses this commit ID to apply the same changes on the current branch. The commit is copied, so it gets a new commit ID.

To use cherry-pick, we first find the commit ID using git log, switch to the required branch using git checkout, and then apply the commit using git cherry-pick <commit-id>.

If conflicts occur, they must be fixed manually, added using git add ., and continued using git cherry-pick --continue. The process can be cancelled using git cherry-pick --abort.

Cherry-picking keeps the original author of the commit but records the person who applied it as the committer.

In short, Git cherry-pick helps in applying selected changes between branches in a clean and controlled way.