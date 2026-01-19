Understanding git cherry-pick:

1. What is git cherry-pick?

git cherry-pick is a Git command that allows you to apply a specific commit from one branch onto another branch.

Unlike git merge or git rebase, which move multiple commits or entire branch history, cherry-pick lets you selectively copy individual commits.

Think of it as copying one specific change without bringing everything else along.

2. When to Use git cherry-pick:

Cherry-pick is useful in situations such as:

* Fixing a bug on multiple branches
* Moving a single feature commit without merging full branch history
* Recovering or rescuing accidentally committed work
* Applying a hotfix to production while development continues elsewhere

3. How Cherry-Pick Works:

Every Git commit has a unique SHA (hash) that identifies it.

Cherry-picking:

* Takes the changes introduced by a specific commit
* Reapplies those changes on your current branch
* Creates a new commit with a new hash

Important: Cherry-picking does not reuse the original commit ID.

# Basic Usage

Step 1: Find the Commit Hash
git log

 Step 2: Switch to the Target Branch
git checkout main

 Step 3: Apply the Commit
git cherry-pick <commit-id>

 Example:

git checkout main
git cherry-pick a3f42e9

This applies the changes from commit `a3f42e9` onto the `main` branch.

 Handling Conflicts During Cherry-Pick:

Sometimes Git cannot automatically apply the commit due to conflicts.

 Resolve Conflicts Manually:

After fixing the conflicts:

git add .
git cherry-pick --continue

Abort the Cherry-Pick:

If you want to cancel the operation:

git cherry-pick --abort

Cherry-Picking Multiple Commits
Pick Multiple Specific Commits:

git cherry-pick <commit1> <commit2> <commit3>

Pick a Range of Commits:

git cherry-pick <start-commit>^..<end-commit>

Best Practices:

* Cherry-pick small, isolated commits
* Avoid cherry-picking merge commits unless absolutely necessary
* Remember that cherry-pick creates new commit IDs
* Use it intentionally to avoid duplicated or confusing history

 What Happens to Author Name When Using git cherry-pick?

Many developers wonder whether cherry-picking changes the author name. Understanding this is important for accurate contribution tracking.

 How Git Records Identity:

Every Git commit stores two identities:

 Author – The person who originally wrote the code
 Committer – The person who applied the commit to the branch

 Author and Committer During Cherry-Pick:

When you cherry-pick a commit:

Author remains the original developer
Committer becomes you (the person who cherry-picked)

Even if:

* Conflicts occur
* You manually resolve them
* You continue the cherry-pick

Git still preserves the original author information.

 Why This Matters:

This behavior ensures:

* Proper credit to the original developer
* Clear accountability for who applied the change to another branch
* Accurate and trustworthy project history

 Can You Change the Author?

Yes, but it should be done carefully.

You can amend the author using:

git commit --amend --author="Name <email@address.com>"
