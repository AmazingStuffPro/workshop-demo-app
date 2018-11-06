#!/bin/bash

PYENV="venv"
APP_DIR="flask-app"
EC2_HOME="/home/ec2-user"

yum install -y git python3-pip
pip3 install virtualenv --user
git clone -b ${git_branch} ${git_repo} $${APP_DIR}

~/.local/bin/virtualenv -p python3 $${PYENV}
source "$${EC2_HOME}/$${PYENV}/bin/activate"
pip3 install -r "$${EC2_HOME}/$${APP_DIR}/requirements.txt"
nohup python3 "$${EC2_HOME}/$${APP_DIR}/app.py" &
sleep 1
