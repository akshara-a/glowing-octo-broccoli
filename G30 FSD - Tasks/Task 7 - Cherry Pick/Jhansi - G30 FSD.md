1. Introduction:

Git is a powerful version-control system used to manage code in software projects. Sometimes we need to copy only one specific commit from one branch and apply it to another branch without merging the entire branch.
For this purpose, Git provides a special command called git cherry-pick.

2. What is Git Cherry-Pick?

git cherry-pick is a Git command that allows you to take a particular commit from one branch and apply it on another branch.
Instead of merging a full branch or using rebase (which brings many commits), cherry-pick copies only the selected commit.

When do we use it?

- Fix a bug on multiple branches 
- Move a feature commit without merging entire history 
- Rescue accidentally committed work

3. How Cherry-Pick Works:

Every Git commit has a unique hash ID (SHA).
Cherry-pick takes that commit and replays the exact changes on the new branch.

4. Basic Usage of git cherry-pick:

Step 1: Get the commit hash

-- git log --

Step 2: Go to the branch where you want the change

-- git checkout main --

Step 3: Apply the commit

-- git cherry-pick <commit-id> --

Example:

git checkout main
git cherry-pick a3f42e9

This applies commit a3f42e9 onto the main branch.

5. Handling Conflicts During Cherry-Pick:

Cherry-picking may create merge conflicts

To resolve:
Fix conflicts manually, then run:

git add .
git cherry-pick --continue

To abort the cherry-pick:

-- git cherry-pick --abort --

6. Cherry-Pick Multiple Commits:
Pick several commits directly

-- git cherry-pick <commit1> <commit2> <commit3> --

            (or)

 range of commits:

-- git cherry-pick <start-commit>^..<end-commit> --

7. Best Practices:

- Choose small, clean, isolated commits for cherry-picking

- Avoid cherry-picking merge commits unless required

- Remember cherry-pick creates a new commit ID, even if the content is the same

8. What Happens to Author Name in Cherry-Pick?

Every Git commit carries two identities:

Author:

 - The original person who wrote the code.

Committer:

 - The person who applied the commit into the branch.

During Cherry-Pick:

When you cherry-pick:

Author stays the same - original developer’s name & email

Committer becomes you - because you applied the commit to a new branch

Even if conflicts occur and you manually fix them, the author remains unchanged.

Why This Matters:

Cherry-picking preserves the original author, which keeps the project history accurate and ensures proper credit. At the same time, Git records you as the committer, showing who applied the change to the new branch.

Can You Change the Author?

Yes, Git allows changing the author information, but it should be done carefully and only when necessary.

git commit --amend --author="Name <email@address.com>"

Cherry-pick keeps the original author’s identity and records you as the committer. This maintains correct attribution and a clean, trustworthy version history.