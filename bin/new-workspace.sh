#!/bin/bash
# Create New Folder Directories ( )

set -e

new_workspace()
{

# This exits script if error code:
clear

if [ -d ~/"$1"/ ]
then
    echo "Directory ~/$1/ exists."
    return 1
else
    echo "Directory ~/$1/ does not exists. Creating new workspace..."
    echo
    cd ~ && pwd
    ls ~/
    echo
    workspace_name=$1
    echo
    mkdir ~/"$1"
    echo
    ls ~/$1/
    echo
    echo "This is an example README.md" > ~/"$1"/README.md
    cd ~/"$1" && mkdir bin docker configs stats > /dev/null 2>&1
    echo
    cd ~/$1 && pwd
    ls ~/"$1"/
    echo
    echo "Directory ~/$1/ now exists. Done and exiting..."

    return 0
fi

}


new_git()
{
# Pass Username, and email to connect to git

git_user=$1
git_email=$2
# sudo git config --global user.name "$1"
# sudo git config --global user.email "$2"
# sudo git commit --amend --reset-author
result=${PWD##*/} 
echo "# update" >> README.md
sudo git init .
sudo git add .
sudo git commit -m "commit"
sudo git branch -M main
sudo git remote add origin https://github.com/$git_user/$result/.git
sudo git push -u origin main
}

new_git_repo()
{
if [ -d ./ ]
then
    echo "Directory ~/. exists."
    sudo git add .
    sudo git commit -m "overwrite"
    sudo git push
    return 0
else
    echo "Directory does not exits."
    return 1

fi

}

new_git $1 $2
