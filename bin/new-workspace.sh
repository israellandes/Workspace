#!/bin/bash
# Create New Folder Directories ( )
sudo rm -dr ~/new-workspace
set -e

edit_git()
{
	echo "Directory ~/$1/configs/new-git-repo.sh exists. Creating new repo template"
	echo "#!/bin/bash" > ~/"$1"/configs/new-git-repo.sh
	echo "sudo curl -u \"USER\" https://api.github.com/user/repos -d '{\"name\":\"REPO\"}'" >> ~/"$1"/configs/new-git-repo.sh
	### Remember replace USER with your username and REPO with your repository/application name!
	echo "sudo git remote add origin git@github.com:USER/REPO.git" >> ~/"$1"/configs/new-git-repo.sh
	echo "sudo git push origin master" >> ~/"$1"/configs/new-git-repo.sh 
	sed -i "2s/USER/"$2"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "3s/USER/"$2"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "2s/REPO/"$3"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "3s/REPO/"$3"/" ~/"$1"/configs/new-git-repo.sh
	echo
	echo "Done"
	echo
	chmod 777 ~/"$1"/configs/new-git-repo.sh
	~/"$1"/configs/new-git-repo.sh

}

new_workspace()
{

# This exits script if error code:
clear
workspace=$1
user=$2
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
    edit_git "$workspace" "$user" "$workspace"
    echo "Directory ~/$1/ now exists. Done and exiting..."
    return 0
fi
}


new_git()
{
result=${PWD##*/}
sudo curl -u "$1" https://api.github.com/user/repos -d '{"name":"$2"}'
### Remember replace USER with your username and REPO with your repository/application name!
sudo git remote add origin "git@github.com:"$1"/"$2".git"
sudo git push origin master
# Pass Username, and email to connect to git
#
#git_user=$1
#git_email=$2
## sudo git config --global user.name "$1"
## sudo git config --global user.email "$2"
## sudo git commit --amend --reset-author
#
#sudo curl -u $1 https://api.github.com/user/repos -d '{"name":"$result"}'
## Remember replace USER with your username and REPO with your repository/application name!
#sudo git remote add origin git@github.com:$1/$result.git
#sudo git push origin master
#
#echo "# update" >> README.md &&\
#sudo git init . &&\
#sudo git add . &&\
#sudo git commit -m "commit" &&\
#sudo git branch -M main &&\
#sudo git remote add origin https://github.com/$git_user/$result/.git &
#sudo git push -u origin main
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

new_workspace $1 $2 $3
