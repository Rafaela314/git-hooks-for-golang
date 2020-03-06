# Git Hooks
[TOC]

## Introduction

Git hooks are a built-in feature containing simple scripts which can run automatically every time particular actions(before or after) occurs in a GitHub repository (ex: commit, push and receive).


## Main benefits associated with Git Hooks:
- Keep the code quality
- Prevent errors through enforcing commits policy
- Can work for continuous deployment with diverse environment settings

### Implementation options

There are two ways:
1. Remote Hooks(Serve-side hooks) - run on the server
2. Local Hooks(Client-side hooks) - run on the developer's system

While server side can be managed in a centrilized way by using the remote repo, the client/local hooks needs to be set by each developer in his own machine. However, this little inconvenience can be overcome with a folder creation in remote with a specific script that automatically copy the files into the developer .git/hooks folder.

![](https://i.imgur.com/8gPFLc5.png)

### Proposed Hooks to be developed

1. Pre commit hooks:

- process: allow only staged files to be commited
- check: Run lint
- check: Run tests
- check: Run Vet(examines Go source code and reports suspicious constructs, such as Printf calls whose arguments do not align with the format string)

2. Prepare commit message hook
- style: Ask for tag in commit naming to better organize code submission(exp. [tag]:[commit title])
- style: Limit the subject line to 50 characters

3. Post-commit hooks:
- commit notification


4. Post checkout hooks:
- process: Indicate if the branch is up to date with remote and, if not, call git pull origin dev to update the dev branch everytime there is a git checkout directed to that specific branch

### How to use It

Once scripts are all set up, the implementation is fairly simple. 
The only actions required are: copy and paste those scripts into the .git/hooks folder and enable them. All hook are disbled by default, to activate a hook you must:

- remove .sample extension

- make It executable: 
```bash

chmod x + hook_name
```
### In case you need to skip a pre-commit hook
```
git commit --no-verify
```

## Journal
To complete the task, I first had to familiarize myself at a minimum level with shell script then a had to figure out a way to better organize and implement the hooks. Tried to organize the scripts in a pre-commit.d folder but soon realized It would not be very easy for the teamto use It because of repetitive tasks to actvate each one of scripts. I then tried to install all at once using a pre-commit-hooks.yalm. That could work and It may be a possibility in the future, if added in the .git ignore. For now, I decided to put the pre-commit hooks all togheter, since there are not that much, and activate all at once with a single chmod +x [script name] command. 
## Some data sources:
- https://www.atlassian.com/git/tutorials/git-hooks
- https://githooks.com/
- Git Hooks-Keep the Code Quality: https://medium.com/@suthagar23/git-hooks-keep-the-code-quality-119e6feb511e
- https://tutorialedge.net/golang/improving-go-workflow-with-git-hooks/
