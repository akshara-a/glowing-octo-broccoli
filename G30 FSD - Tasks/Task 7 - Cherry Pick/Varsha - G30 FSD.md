# Git Cherry-Pick – Learning Document 

## Overview

While learning this topic, my main understanding is that **git cherry-pick helps us take only one specific commit from any branch and apply it to another branch.**

Normally when we merge branches, we bring all commits together. But cherry-pick is more selective — like picking only one fruit from a tree instead of carrying the whole tree.

This is useful when we don’t want the entire branch history, only one particular change.

## When Cherry-Pick Is Actually Useful
While going through examples, I understood these real situations:
- When a bug is fixed in one branch, and the same fix is needed in another branch
- When a small piece of work from another branch is good, but the rest of the branch is not ready
- When we commit to the wrong branch by mistake and need to move the commit to the correct branch

So cherry-pick is like rescuing useful commits.

## How Cherry-Pick Basically Works

Every commit in Git has a long unique ID.

Cherry-pick simply takes that commit ID, copies the change, and pastes it onto the branch where we currently are.

But it does not bring other commits before or after it — only the chosen one.

**Steps I understood**

1. First, find the commit ID using : ```git log```
2. Go to the branch where we want to add that commit : ```git checkout main```
3. Apply the selected commit : ```git cherry-pick <commit-id>```

After running this, Git adds a new commit with the same content but a different commit ID.

## Handling Conflicts
Just like merging, cherry-picking can also create conflicts.

**If that happens**
- Fix the conflicts manually
- Then continue cherry-pick
```
git cherry-pick --continue
```

**If I want to cancel everything**
```
git cherry-pick --abort
```
This takes the project back to how it was before trying cherry-pick.

## Picking More Than One Commit

I learned that cherry-pick is not limited to one commit. 

- We can pick several: ``` git cherry-pick <id1> <id2> <id3> ```

- Or even pick a whole range: ``` git cherry-pick <start>^..<end> ```

## Who Becomes the Author When Cherry-Picking?

This part was interesting.

Each commit in Git has two identities:
1. **Author** → who originally wrote the change
2. **Committer** → who actually applied it

After cherry-pick:

- **The original author remains the same**
- **I become the committer**, because I applied the commit to another branch

So credit is preserved properly.

## Changing the Author

If needed, the author can be changed manually:
```
git commit --amend --author="Name <email>"
```
But this should be done only when there is a valid reason.

## Summary in Simple Words

To me, Cherry-Pick feels like:
- Copying a single meaningful commit
- Pasting it exactly where I want
- Without touching other commits
- While still keeping the original author’s name

It gives more control, especially in real projects where we don’t want to merge everything — only what’s needed.