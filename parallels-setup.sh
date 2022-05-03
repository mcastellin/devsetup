#!/bin/bash -e

echo "Get the latest version from repo"
git pull

echo "Install requirements"
pip install --upgrade pip build wheel
pip install --upgrade --user ansible

echo "Updating system"
ansible-playbook setup_env.yaml


