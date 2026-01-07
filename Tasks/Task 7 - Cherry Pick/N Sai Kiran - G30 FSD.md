# Git Cherry-Pick Explained

## What is `git cherry-pick`?

`git cherry-pick` is a powerful Git command used to apply a specific
commit from one branch onto another. Unlike merging or rebasing, which
bring a series of commits or entire branch history, cherry-pick lets you
selectively copy individual changes.

## When to Use It?

-   Fix a bug on multiple branches\
-   Move a feature commit without merging entire history\
-   Rescue accidentally committed work

## How It Works

Each commit in Git has a unique hash (SHA). Cherry-pick lets you pick
that commit and replay it on another branch.

## Basic Usage

1.  Note the commit hash:

    ``` bash
    git log
    ```

2.  Switch to the branch where you want the change:

    ``` bash
    git checkout main
    ```

3.  Apply the commit:

    ``` bash
    git cherry-pick <commit-id>
    ```

### Example

``` bash
git checkout <branch-name>
git cherry-pick a3f42e9
```

This applies commit `a3f42e9` to `main`.

## Handling Conflicts

Sometimes cherry-picking causes merge conflicts. Resolve them manually,
then run:

``` bash
git add .
git cherry-pick --continue
```

To abort:

``` bash
git cherry-pick --abort
```

## Multiple Commits

``` bash
git cherry-pick <commit1> <commit2> <commit3>
```

Range:

``` bash
git cherry-pick <start-commit>^..<end-commit>
```

## Best Practices

-   Cherry-pick small, isolated commits\
-   Avoid cherry-picking merge commits unless necessary\
-   Remember it creates new commit IDs, not the original ones

------------------------------------------------------------------------

# What Happens to Author Name During Cherry-Pick?

## How Git Records Identity

Each Git commit stores: - **Author** -- the person who originally wrote
the code\
- **Committer** -- the person who applied or recorded the commit

## Behavior During Cherry-Pick

When you cherry-pick a commit:

-   **Original author name & email remain unchanged**\
-   **You become the committer**, since you applied it

Even if conflicts arise and you resolve them, Git still keeps:

-   **Author = original developer**\
-   **Committer = you**

## Why This Matters

This keeps historical accuracy intact---credit stays with the original
developer while acknowledging who integrated the change.

## Changing the Author (Optional)

``` bash
git commit --amend --author="Name <email@address.com>"
```

*Use this sparingly and only when necessary.*

------------------------------------------------------------------------

Cherry-picking retains the original author's identity while recording
you as the committer, ensuring clear version history and proper
attribution.

