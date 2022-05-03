#!/bin/bash -e

echo "Get the latest version from repo"
git pull

echo "Install make sure ansible is installed"
sudo dnf install -y ansible

echo "Updating system"
ansible-playbook setup_env.yaml


