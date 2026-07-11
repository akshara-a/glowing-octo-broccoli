# GIT CHERRY-PICK 

1. Git cherry-pick is used to copy a specific commit from one branch to another.  
2. It does not merge the full branch, only selected changes.  
3. Each commit in Git has a unique ID called a hash.  
4. Cherry-pick uses this commit ID to apply the changes.  
5. The code remains the same, but a new commit ID is created.  
6. It is mainly used to fix bugs or add small changes.  
7. Cherry-pick helps avoid unwanted code from other branches.  
8. If conflicts occur, they must be resolved manually.  
9. The original author name stays the same after cherry-pick.  
10. Cherry-pick should be used carefully to keep Git history clean.  

---

#  Some Commands 

* git checkout main
* git cherry-pick <commit-id>
* git cherry-pick <commit1> <commit2>
* git status
* git add .
* git cherry-pick --abort

