# Git Cherry-Pick (Learning Document)

## What is Git Cherry-Pick?

Git cherry-pick is a Git operation used to **selectively apply specific commits** from one branch to another. Instead of merging an entire branch, cherry-pick allows developers to transfer only the required changes.

---

## Purpose of Cherry-Pick

Cherry-pick is mainly used when:

* Only a specific change is required from another branch
* A fix needs to be applied without merging full branch history
* Work was committed to the wrong branch and needs correction

---

## How Cherry-Pick Works

* Every Git commit has a unique commit hash
* Cherry-pick uses this hash to reapply changes on a target branch
* The original author remains the same
* The person applying the cherry-pick becomes the committer

---

* Use cherry-pick for small, independent commits
* Avoid cherry-picking large or dependent commits
* Prefer merge or rebase for full feature integration
