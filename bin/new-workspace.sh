#!/bin/bash
# Create New Folder Directories ( )
set -e
# $1 = your_workspace
# $2 = git_username
# $3 = your_workspace

create_new_workspace()
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
    echo "Directory ~/$1/ now exists. Done and exiting..."
    return 0
fi
}

create_and_add_new_git_repo()
{
	create_and_add_new_git_repo "$1" "$2" "$3"

	echo "Directory ~/$1/configs/new-git-repo.sh exists. Creating new repo template"
	echo "#!/bin/bash" > ~/"$1"/configs/new-git-repo.sh
	echo "sudo curl -u \"USER\" https://api.github.com/user/repos -d '{\"name\":\"REPO\"}'" >> ~/"$1"/configs/new-git-repo.sh
	### Remember replace USER with your username and REPO with your repository/application name!
        echo "cd ~/$3 && sudo git init && echo \"# new-workspace\" >> README.md && sudo git add . && sudo git commit -m \"first commit\" && sudo git remote add origin https://github.com/$2/$3.git" >> ~/"$1"/configs/new-git-repo.sh
        echo "sudo git config --global --add safe.directory '~/$3' && sudo git push --set-upstream origin master" >> ~/"$1"/configs/new-git-repo.sh 
	sed -i "2s/USER/"$2"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "3s/USER/"$2"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "4s/USER/"$2"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "3s/$3/"$3"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "2s/REPO/"$3"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "3s/REPO/"$3"/" ~/"$1"/configs/new-git-repo.sh
	sed -i "4s/REPO/"$3"/" ~/"$1"/configs/new-git-repo.sh
	echo
	echo "Done"
	echo
	chmod 777 ~/"$1"/configs/new-git-repo.sh
	~/"$1"/configs/new-git-repo.sh

}

# Pass in your directory, must be in user home.
save_workspace_to_git()
{
result=$1
cd ~/$1
sudo git add .

# date command, current date and time
DATE=$(date)
sudo git commit -m "changes made on $DATE"
sudo git push

# MAC AUtotmation - Notifications
osascript -e "display notification 'pushed to remote' with title 'SUCESS'"
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
save_workspace_to_git $1 $2 $3
