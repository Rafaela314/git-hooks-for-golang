# Git Hooks


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

### Suggested interesting Hooks to help developers team

1. Pre commit hooks:

- process: allow only staged files to be commited
- check: Run lint
- check: Run imports
- check: Run Vet(examines Go source code and reports suspicious constructs, such as Printf calls whose arguments do not align with the format string)

2. Prepare commit message hook
- style: Ask for tag in commit naming to better organize code submission(exp. [tag]:[commit title])
- style: Limit the subject line to 50 characters

3. Post-commit hooks:
- commit notification

4. Pre push:
- check: go tests
- check: general lint

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
If you want to totally remove It, just erase It from .git/hooks folder

## Journal
To complete the task, I first had to familiarize myself at a minimum level with shell script then a had to figure out a way to better organize and implement the hooks. Tried to organize the scripts in a pre-commit.d folder but soon realized It would not be very easy for the team to use It because of repetitive tasks to activate each one of scripts individually. I then tried to install all at once using a pre-commit-hooks.yalm and a hooks-config.yalm. I got a autonomous installation using the pre-commit lib in python, however, had some break in scripts. This method had the pitfail installing the file in the root directory and adding at to .gitignore so It would not be commited to the remote repo. However, that could work and It may be a possibility in the future if I dig further and fix whatever is breaking the scripts. Another point of attention is that the lib is specific to pre coommit hooks... I wonder if is there a more generic lib that can be use for many types of hooks, because installing a lib to each type of hooks does not look something that would please the team and might becoem a barrier to adoption. For now, I decided to put the pre-commit hooks all togheter, since there are not that much of necessary hooks nowadays, and activate all at once with a single chmod +x [script name] command.

## Some data sources:
- https://www.atlassian.com/git/tutorials/git-hooks
- https://githooks.com/
- Git Hooks-Keep the Code Quality: https://medium.com/@suthagar23/git-hooks-keep-the-code-quality-119e6feb511e
- https://tutorialedge.net/golang/improving-go-workflow-with-git-hooks/
