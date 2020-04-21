git checkout -b 2020-01-01_new_branch
git checkout master
git merge 2020-01-01_new_branch
git branch -d 2020-01-01_new_branch

#  to perform a normal commit of all changed files
cd /Users/danrozelle/ex 
git add -A
git commit -m "msg"
git push origin master


##########################################################
# install github on your computer
# https://help.github.com/articles/set-up-git
git config --global user.name "name"
git config --global user.email "name@gmail.com"

# how to create a new github repository and push to github

# cd to the directory you want to include in the repo
# initialize a new repo
git init

#create a README file with basic repo info and add info
touch README
nano README

# add files to your repo and commit them
git add README
git commit -m 'first commit'

# set a remote for your repository and push your commits
git remote add origin https://github.com/dkrozelle/prog.git
git push origin master


##########################################################
# stage removed and moved files
git add -u


##########################################################
# remove unimportant previously tracked with github
# this example will remove sublime text 2 project files:
# 		rm 'prog.sublime-project'
# 		rm 'prog.sublime-workspace'
git rm --cached prog.sublime-*
#add this info to the global gitignore file so it they aren't added again
nano ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

#files to globally ignore when adding to github repos

# # SublimeText project files
# ######################
#  *.sublime-workspace
#  *.sublime-project

# # OS generated files #
# ######################
# .DS_Store
# .DS_Store?
# ._*
# .Spotlight-V100
# .Trashes
# ehthumbs.db
# Thumbs.db

# now commit and push changes
git commit -m 'removed individual files and added to .gitignore_global'
git push origin master --force


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

