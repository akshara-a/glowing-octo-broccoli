# Git Cherry-Pick – Learning Document

**Name:** Kartik Agashe  
**Task:** Learning Git Cherry-Pick

---

## What I Learned Today

Today I understood how **Git cherry-pick** works and why it is useful. Cherry-pick allows us to take a single commit from one branch and apply it to another branch without merging all the changes. This is especially helpful when we need to move a bug fix or small update to another branch. To use cherry-pick, we first identify the required commit using `git log --oneline`. Then we switch to the branch where the change is needed using `git checkout`. After that, we apply the commit using `git cherry-pick`. If there are no conflicts, the commit is added successfully. If conflicts occur, Git pauses the process and asks us to resolve them manually. Once the conflicts are fixed, we stage the changes with `git add .` and continue using `git cherry-pick --continue`. If needed, the process can be canceled using `git cherry-pick --abort`. Cherry-pick can also be used for multiple commits or a range of commits. The original author remains the same, while the person performing the cherry-pick becomes the committer. Overall, cherry-pick is very useful for hotfixes, small changes, and correcting mistakes made on the wrong branch.


---

## Why Cherry-Pick is Useful
- It allows us to move **only required changes**
- Useful when a **bug is fixed in one branch** and the same fix is needed in another branch
- Helps when a commit is made on the **wrong branch by mistake**
- Ideal for **hotfixes, small changes, and selective code movement**

---

