#!/bin/bash -e

echo "Get the latest version from repo"
git pull

echo "Install requirements"
pip install --upgrade pip
pip install pipenv
pipenv install

echo "Updating system"
pipenv run ansible-playbook setup_env.yaml


