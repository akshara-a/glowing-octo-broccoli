Git Cherry-Pick – Learning Document

*Name:* Sree Surya Prabha

*Task:* Understanding Git Cherry-Pick

 What I Learned Today

Today, I learned about the *Git cherry-pick* command and its importance in version control. Cherry-pick helps us apply a specific commit from one branch to another branch without merging all the commits. This is very useful when only a single change, such as a bug fix or minor update, is required in another branch.

To perform a cherry-pick, we first identify the required commit hash using the `git log --oneline` command. Then, we switch to the target branch using `git checkout`. After that, we apply the selected commit using the `git cherry-pick` command. If there are no conflicts, the commit is successfully added to the branch.

In case conflicts occur, Git stops the process and asks us to resolve them manually. Once the conflicts are fixed, we stage the files using `git add .` and continue the cherry-pick process using `git cherry-pick --continue`. If we decide not to proceed, the cherry-pick operation can be canceled using `git cherry-pick --abort`.

Cherry-pick can also be used to apply multiple commits or a sequence of commits. During this process, the original author of the commit remains unchanged, while the person applying the cherry-pick becomes the committer. Overall, cherry-pick is an effective feature for handling hotfixes, small updates, and correcting commits made on the wrong branch.

 Cherry-Pick is Useful - Why

* It allows applying *only selected commits* instead of merging entire branches
* Helpful when a *bug fix needs to be copied* to another branch
* Useful when a commit is *accidentally made on the wrong branch*
* Best suited for *hotfixes, small updates, and controlled code changes*
