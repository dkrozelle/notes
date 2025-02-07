
# merge file from another branch
git checkout --patch branch2 file.py

# Merge to master
git checkout -b 2020-01-01_new_branch
git add ...
git commit -m 'commit comment'
git checkout master
git merge 2020-01-01_new_branch -m 'optional merge comment'
git branch -d 2020-01-01_new_branch
git push origin --delete 2020-01-01_new_branch
git push

#  to perform a commit of all changed files
cd /Users/danrozelle/ex
git add file1.sh file2.sh
git commit -m "new analysis scripts"
git tag v0.1.4 -a -m 'Release with function x fixed'
git push --tags origin master

# create a new branch and push it to origin (remote server)
# you only need to push alternative branches to girhub (origin) if others will be collaborating
git checkout -b new_branch
git push -u origin new_branch

# you can also just list differences between
git diff --name-only branch1..branch2

# add a new named remote
git remote add bms git@biogit.pri.bms.com:rozelled/repo.git


# if master branch is protected, and you want to merge only some of
# the files in your feature-branch
git checkout -b partial-commit-branch feature-branch
# checkout the files from feature-branch to your new partial-commit-branch
git checkout feature-branch file-we-want-to-merge.sh another-dir/
git add file-we-want-to-merge.sh another-dir/
git commit -m 'add some files'
git push -u origin
# then you can create a pull request on GitHub to pull into master


# Checkout a previous version (commit 1234) of one file
git checkout 1234 -- path/file.sh
git commit -m 'revert script to previous version'

##########################################################
# install github on your computer
# https://help.github.com/articles/set-up-git
git config --global user.name "Dan Rozelle"
git config --global user.email "dan.rozelle@ranchobiosciences.com"


# change a remote url
git remote set-url origin git@github.com:ranchobiosciences/foo.git

##########################################################
# stage removed and moved files
git add -u

##########################################################
# remove unimportant previously tracked with github
# this example will remove prog.conf files:
# 		rm 'prog.conf-project'
# 		rm 'prog.conf-workspace'
git rm --cached prog.conf-*
#add this info to the global gitignore file so it they aren't added again
nano ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

#files to globally ignore when adding to github repos


##########################################################
# now I'll do the same but add a local .gitignore
# and remove sensitive data
# https://help.github.com/articles/remove-sensitive-data
#
git rm --cached './perl/bibtex/*'
git filter-branch --force --index-filter   'git rm --cached --ignore-unmatch ./perl/bibtex/*'  --prune-empty --tag-name-filter cat -- --all
# add the bibtex directory to a new local .gitignore
echo '*' >> ./perl/bibtex/.gitignore

git add ./*
git commit -m 'ignore bibtex'
git push origin master --force


# Split a subdirectory into it's own repo
http://alyssafrazee.com/2014/05/01/popping-a-subdirectory.html

# Copy a subdirectory into another existing repo
https://medium.com/@ayushya/move-directory-from-one-repository-to-another-preserving-git-history-d210fa049d4b



## Datalad version controlled data

datalad clone /data/another/existing/dataset here
cd here

# get and unlock files before editing
datalad get phenotypic-metadata-dictionary.json
datalad unlock phenotypic-metadata-dictionary.json
find . -name "*phenotypic-metadata.json" -type l | xargs -I{} datalad get {}
find . -name "*phenotypic-metadata.json" -type l | xargs -I{} datalad unlock {}
# edit any files and confirm these are the changes to save
datalad status
datalad save -m 'commit message'

# list changed files from a branch
git diff --name-only branch

# move all uncommitted changes to a new branch
git switch -c <new-branch>

# undo a changed file that hadn't been committed/saved yet
git stash push -- path/to/file 