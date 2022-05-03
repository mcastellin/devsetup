#!/bin/bash -e

echo "Get the latest version from repo"
git pull

echo "Install requirements"
pip install --upgrade pip
pip install --upgrade ansible

echo "Updating system"
ansible-playbook setup_env.yaml


