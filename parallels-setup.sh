#!/bin/bash -e

echo "Get the latest version from repo"
git pull

echo "Make sure ansible is installed"
if ! ansible --version ; then
    sudo dnf install -y ansible
fi

echo "Updating system"
ansible-playbook setup_env.yaml


