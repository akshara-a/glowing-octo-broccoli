Today I learned about Git cherry-pick, which is used to apply a specific commit from one branch to another.
It helps when we do not want to merge the entire branch but only need one commit.
This is useful when we fix a bug in one branch and want the same fix in another branch.
First, we need to find the commit hash using git log --oneline.
After that, we switch to the target branch using git checkout branch-name.
Then we run the command git cherry-pick <commit-hash>.
This will copy that commit and apply it to the current branch.
If there are no conflicts, a new commit will be created successfully.
If conflicts occur, Git will stop the process and ask us to fix them.
We have to resolve conflicts manually in the files.
After resolving, we use git add . to stage the changes.
Then we continue the process using git cherry-pick --continue.
If something goes wrong, we can stop it using git cherry-pick --abort.
Cherry-pick also works with multiple commit hashes.
We can cherry-pick a range of commits too.
It keeps the original author but the committer becomes the person who cherry-picked.
It is helpful when a commit is done on the wrong branch by mistake.
We can move only that commit without disturbing other work.
It is very useful for hotfixes, small changes, and selective code movement.
Overall, cherry-pick gives more control over moving commits between branches.
