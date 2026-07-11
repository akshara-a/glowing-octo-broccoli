# Git Cherry-Pick for Selective Commit Transfer

## What is `git cherry-pick`?

`git cherry-pick` is a powerful Git command used to **apply a specific commit from one branch onto another branch**.

Unlike `git merge` or `git rebase`, which bring in a series of commits or the entire branch history, **cherry-pick allows you to selectively copy individual commits**.

In simple words:
> **Cherry-pick = pick only the commit you want** 

## When Should You Use `git cherry-pick`?

You should use cherry-pick when you need **precision and control** over which changes are applied.

Common use cases:

- Fixing the **same bug on multiple branches**
- Moving a **single feature commit** without merging the full branch
- Recovering or rescuing **accidentally committed work**
- Applying a **hotfix** from `develop` to `main`

## How `git cherry-pick` Works

Each Git commit has a **unique hash (SHA)**.

When you cherry-pick:
- Git **copies the changes** from the selected commit
- Replays them on the current branch
- Creates a **new commit with a new hash**

 Important: The commit content is the same, but the commit ID is **different**.

## Basic Usage

### Step 1: Find the Commit Hash

```bash
git log
```

### Step 2: Switch to the Target Branch

```bash
git checkout main
```

### Step 3: Cherry-Pick the Commit

```bash
git cherry-pick <commit-id>
```

## Example

```bash
git checkout main
git cherry-pick a3f42e9
```

 This applies commit `a3f42e9` onto the `main` branch.

## Cherry-Picking Multiple Commits

### Pick Multiple Specific Commits

```bash
git cherry-pick <commit1> <commit2> <commit3>
```

### Pick a Range of Commits

```bash
git cherry-pick <start-commit>^..<end-commit>
```

## Handling Conflicts During Cherry-Pick

Sometimes cherry-picking results in **merge conflicts**.

### Steps to Resolve:

1. Fix the conflicts manually
2. Stage the resolved files

```bash
git add .
```

3. Continue the cherry-pick

```bash
git cherry-pick --continue
```

### To Abort Cherry-Pick

```bash
git cherry-pick --abort
```

## What Happens to Author Name During Cherry-Pick?

Each Git commit stores **two identities**:

- **Author** – the person who originally wrote the code
- **Committer** – the person who applied the commit

### Identity Behavior

- Original author is preserved
- You become the committer

## Can You Change the Author?

Yes, but it should be done **only when justified**.

```bash
git commit --amend --author="Name <email@address.com>"
```

## Best Practices

- Cherry-pick **small, isolated commits**
- Avoid cherry-picking **merge commits**
- Remember: cherry-pick creates **new commit hashes**

## Summary

`git cherry-pick` allows selective commit application while preserving original authorship and maintaining clean history.
