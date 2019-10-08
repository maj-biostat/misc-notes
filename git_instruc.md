
## Git squashing commits (especially for forked repositories)

The mantra seems to be not to push until you are happy. Well, I pushed. The following will squash all the commits but is considered somewhat bad form.

Imagine you have pushed to your repository with a whole bunch of inconsequential commits. Bummer. Here is a way to get rid of them, but be very careful.

```
git clone https://github.com/maj-tki/automatic_test.git
```

The first utility CLI command you need is:

```
git config --global alias.lg "log --graph --decorate -30 --all --date-order --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%C(cyan)%h%Creset %C(black bold)%ad%Creset%C(auto)%d %s' --graph"
```

Now issue the alias:

```
git lg
```

to get 

```
* c11122f 2019-07-26 13:49:37 (HEAD -> master, origin/master, origin/HEAD) Finished off edits
* a7094ed 2019-07-26 13:45:20 Removed tmp R file
* 5816588 2019-07-26 13:44:02 Removed test model
* 1ca249e 2019-07-26 13:41:11 Remove redundant tests
* 2c2d49f 2019-07-26 13:40:40 Code review
* 88c4ad2 2019-07-25 21:32:57 More twiddling
* a430af9 2019-07-25 08:39:13 review edits
* cd1b3a0 2019-07-24 15:12:51 Review, introducing unit tests
* 18c20ba 2019-07-20 14:21:37 Add model
* b7c1269 2019-07-19 10:12:18 Remove dup line
* 38dd155 2019-07-19 09:53:38 Add modelling and folders
* cff8727 2019-07-19 09:44:59 Update
* 86020b0 2019-07-17 14:47:18 Init
* 59caa08 2019-07-17 14:46:23 Init
```

(but with colour).

Nb. Other history commands can be found here:
https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
https://stackoverflow.com/questions/7853332/how-to-change-git-log-date-formats

You can squash all these into one commit by doing:

```
git rebase -i HEAD~13
```

where the 13 is one less than the total number of commits of 14. Typically we wouldn't want to get rid of all the commits. We would just get rid of the irrelevant ones. Anyway.

Aside - you could also do `git rebase -i 59caa08`

An interactive panel will open up and you basically just replace `pick` with `squash` for the 13 commit points that you want to combine into one. If nothing goes wrong you will get something like:

```
C:\Users\mjones\Documents\automatic_test>git rebase -i HEAD~13
[detached HEAD e3ea213] Code review changes and comments.
 Author: James Totterdell <jatotterdell@gmail.com>
 Date: Wed Jul 17 14:47:18 2019 +0800
 15 files changed, 468 insertions(+), 3304 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 automatic_test.Rproj
 create mode 100644 input_files/.gitignore
 delete mode 100644 input_files/Original/accumulated_data.csv
 delete mode 100644 input_files/Original/logfile.csv
 create mode 100644 interim_data/.gitignore
 create mode 100644 output_files/.gitignore
 mode change 100644 => 100755 run_main.sh
 create mode 100644 stan/automatic_model.stan
 create mode 100644 stan/automatic_model_ran.stan
Successfully rebased and updated refs/heads/master.
```

```
git lg
* e3ea213 2019-07-17 14:47:18 (HEAD -> master) Code review changes and comments.
| * c11122f 2019-07-26 13:49:37 (origin/master, origin/HEAD) Finished off edits
| * a7094ed 2019-07-26 13:45:20 Removed tmp R file
| * 5816588 2019-07-26 13:44:02 Removed test model
| * 1ca249e 2019-07-26 13:41:11 Remove redundant tests
| * 2c2d49f 2019-07-26 13:40:40 Code review
| * 88c4ad2 2019-07-25 21:32:57 More twiddling
| * a430af9 2019-07-25 08:39:13 review edits
| * cd1b3a0 2019-07-24 15:12:51 Review, introducing unit tests
| * 18c20ba 2019-07-20 14:21:37 Add model
| * b7c1269 2019-07-19 10:12:18 Remove dup line
| * 38dd155 2019-07-19 09:53:38 Add modelling and folders
| * cff8727 2019-07-19 09:44:59 Update
| * 86020b0 2019-07-17 14:47:18 Init
|/
* 59caa08 2019-07-17 14:46:23 Init
```

but:

```
git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 13 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

nothing to commit, working tree clean
```

so (scarily):

```
git push -f
```

resulting in:

```
git lg
* e3ea213 2019-07-17 14:47:18 (HEAD -> master, origin/master, origin/HEAD) Code review changes and comments.
* 59caa08 2019-07-17 14:46:23 Init
```

As I said, in this example all of the commits were removed but typically you would just want to do this for a few.


## Git - Merging pull requests from forks

The other way around -- you are on the receiving end of a pull request.

Scenario: You have had a pull request for some new feature from a forked version of your repository. However, since the time of the fork, you have made some changes to your master and therefore there may be some merge conflicts that you want to assess piece by piece.

Assuming we added the alias (see above) do:

```
git lg
```
 to get (but with colour):

```
* 47f86ca 2019-07-26 17:21:14 (HEAD -> master, origin/master, origin/HEAD) Testing
* 42ef659 2019-07-26 16:48:03 Testing
* 53303d2 2019-07-25 10:43:39 Refined install script
* 3dc85af 2019-07-25 09:03:59 install script
*   59fcc58 2019-07-24 13:07:42 Merge branch 'master' of https://github.com/maj-tki/linux
|\
* | e9353b9 2019-07-24 13:07:07 Install R package script
| * 18631cc 2019-07-24 13:06:15 Update README.md
|/
* 8a6bc66 2019-07-23 15:52:00 Update README.md
* 140ba46 2019-07-12 18:18:08 Update README.md
* ea18233 2019-07-12 18:14:57 Update README.md
* 8289826 2019-07-12 18:01:13 Update README.md
* 9d1bb4a 2019-06-24 10:48:31 Update README.md
* 167371f 2019-06-22 21:59:57 Update README.md
* ee1afd8 2019-06-21 13:06:08 Update README.md
* 9eb656c 2019-06-21 13:01:27 Update README.md
* 13edbd5 2019-06-04 12:11:21 Update README.md
* fc4bb06 2019-04-22 19:45:16 Update README.md
* 6eab05d 2019-04-22 19:38:19 Update README.md
* e233304 2019-04-12 22:48:18 Update README.md
* bc52c8d 2019-04-11 12:20:20 Create vim.md
* 14c7ea8 2019-04-11 12:18:20 Update README.md
* 925e7bf 2019-04-01 14:27:15 Update README.md
* 45f1f0c 2019-04-01 11:14:22 Update README.md
* c054f9e 2019-03-31 18:51:18 Update README.md
* a404403 2019-03-28 17:41:12 Update README.md
* 3faa921 2019-03-28 13:12:45 Update README.md
* 6436e15 2019-03-28 12:30:22 Update README.md
* 1c3cf5b 2019-03-28 12:26:50 Update README.md
* ec5aa0a 2019-03-28 09:58:23 Update README.md
* 8685be8 2019-03-20 12:54:22 Added screen commands
```

Now.


`cd` to the local repository folder, check the current remote repo:

```
cd linux
git remote -v
```

The above should report the current remote repository, e.g. 

```
origin  https://github.com/maj-tki/linux.git (fetch)
origin  https://github.com/maj-tki/linux.git (push)
```

To add a new repository do something along the lines of:

```
git remote add ts https://github.com/t-student/linux.git
```

Now you should have the following remotes:

```
git remote –v
origin  https://github.com/maj-tki/linux.git (fetch)
origin  https://github.com/maj-tki/linux.git (push)
ts      https://github.com/t-student/linux.git (fetch)
ts      https://github.com/t-student/linux.git (push)
```
However, you have not yet got access to the alt codebase. Do a fetch and then checkout the pull request. Following on from the example commands above, you would do something along the lines of:

```
git fetch ts
```

which gives:

```
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 11 (delta 7), reused 9 (delta 5), pack-reused 0
Unpacking objects: 100% (11/11), done.
From https://github.com/t-student/linux
 * [new branch]      master     -> ts/master
```

now checkout the branch

```
git checkout -b test2 ts/master
Switched to a new branch 'test2'
Branch 'test2' set up to track remote branch 'master' from 'ts'.
```

```
git status
On branch test2
Your branch is up to date with 'ts/master'.

nothing to commit, working tree clean
```

so now the files that we are looking at are from the pull request.

```
head README.md
This is just some change to make sure I am out of whack with the pull request from james.


# Manjaro

banan jit wrebbly.


more commitment damn you
```

```
# Vim

# hi, i had forgotten about you

another change

## Visual Mode, Block select

http://vimcasts.org/transcripts/22/en/
```

we can get back to the HEAD of my master with:

```
git checkout master
head README.md
This is just some change to make sure I am out of whack with the pull request from james.


# Manjaro

ban

changes like this
```

```
# Vim

## Visual Mode, Block select

http://vimcasts.org/transcripts/22/en/
```

and back to ts with

```
git checkout test2
Switched to branch 'test2'
Your branch is up to date with 'ts/master'.
```

to diff between two branches first set up an external difftool like winmerge with:

```
git config diff.tool winmerge
```

then you can diff between two branches with:

```
git difftool master test2
```
which will give you a visual diff between each file.

Alternatively, just show the files that have differences:

```
git diff --name-only master test2
```

which shows 

```
README.md
install_R_pkgs.R
vim.md
```

Anyway to merge (properly) do:

```
git checkout master
git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

now merge:

```
git merge --no-ff test2
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

Ok, we got a merge conflict. Good, nice to know git notices. If we do:

```
git status
```

we get:

```
On branch master
Your branch is up to date with 'origin/master'.

You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:

        modified:   install_R_pkgs.R
        modified:   vim.md

Unmerged paths:
  (use "git add <file>..." to mark resolution)

        both modified:   README.md
```

So now we can review all the changes, accept those that we care about and fix any conflicts. Conflicts are marked by <<<<<<<, for example, looking in README.md I see:

```
<<<<<<< HEAD
ban

changes like this
=======
banan jit wrebbly.


more commitment damn you
>>>>>>> test2
```
which is the bit we need to fix up. For the other files (that merged with no conflicts) all we need to do is review the changes then commit and push.

Finally, you can delete a local branch and remove remotes with:

```
git branch -d test2
Deleted branch test2 (was c3aa2e0).
```

```
git remote rm ts
```

then `git remote -v` should only return:

```
origin  https://github.com/maj-tki/linux.git (fetch)
origin  https://github.com/maj-tki/linux.git (push)
```