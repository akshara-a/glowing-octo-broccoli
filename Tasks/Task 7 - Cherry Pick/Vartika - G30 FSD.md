## Git Cherry-Pick 
If you ever want to take one specific commit from a branch and apply it to another branch without merging everything,
Git’s cherry-pick is exactly what you need.
Think of a cherry tree full of cherries,  you’re not taking the whole branch,
You’re just picking one perfect cherry and placing it where you want.
That’s exactly what cherry-picking does with commits.

##  When Should You Use Cherry-Pick?
You use cherry-pick when you want only selected changes, not the whole history. For example:
-	You committed to the wrong branch by mistake
-	You fixed a bug somewhere and want the same fix on another branch
-	You don’t want to merge the entire branch,  just one commit
-	You want to rescue work you accidentally committed
Basically, if you want one specific commit to appear somewhere else, cherry-pick is the way.

##  How Cherry-Pick Works 
Every commit in Git has a unique ID (SHA).
Cherry-pick simply replays that commit on top of your current branch.
Nothing complicated,  it just copies the changes from that commit and applies them again.

##  How to Use Cherry-Pick
1. Get the commit ID
``` git log ```
2. Switch to the branch where you want to apply the commit
``` git checkout main ```
3. Apply the commit
``` git cherry-pick <commit-id> ```
That’s it  
The commit is now added to your current branch.

##  Example
git checkout feature-branch
git cherry-pick a3f42e9
This takes commit a3f42e9 and applies it to the feature-branch.

##  If Conflicts Happen
Sometimes cherry-picking causes merge conflicts (just like merging or rebasing).
Here’s what to do:
1.	Fix the conflicts manually
2.	Then run:
```
 git add. 
 ```
``` 
git cherry-pick --continue 
```
Want to cancel the cherry-pick?
``` 
git cherry-pick --abort 
```
This stops the process and resets everything.

##  Cherry-Picking Multiple Commits
Pick multiple commits at once:
1. git cherry-pick ``` <commit1> <commit2> <commit3> ```
2. Pick a range of commits:
3. git cherry-pick ``` <start-commit>^..<end-commit> ```

##  Author vs Committer — What Happens?
Each commit in Git has two identities:
-	**Author** → the person who originally wrote the code
-	**Committer** → the person who applied the commit
When you cherry-pick:
-	The original author stays unchanged
-	You become the committer, because you applied the commit to a new branch
This keeps the history accurate — credit stays with the original coder,
and Git still records who made the commit.

##  Can You Change the Author?
Yes, but only if necessary:
```
git commit --amend --author="Name <email@address.com>"
```
Avoid doing this often, rewriting commit metadata should be done carefully.

##  Best Practices
-	Cherry-pick small, focused commits
-	Avoid cherry-picking merge commits unless absolutely needed
-	Remember: cherry-picked commits get a new commit ID
- Always review conflicts properly before continuing

##  Final summary
Cherry-pick = selectively copying commits to another branch.
It’s perfect when:
-	You want only a specific change
-	You made a commit on the wrong branch
-	You want to share fixes across branches
-	You want a clean, controlled history