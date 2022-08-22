#!/bin/bash
sudo curl -u USER https://api.github.com/user/repos -d '{name:REPO}'
sudo git remote add origin git@github.com:USER/REPO.git
sudo git push origin master
