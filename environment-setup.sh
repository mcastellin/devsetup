#!/bin/bash -e

DIRNAME="$(dirname $0)"
REALPATH="$(realpath $DIRNAME)"

echo "Get the latest version from repo"
git pull

echo "Make sure ansible is installed"
if ! ansible --version ; then
    sudo dnf install -y ansible
fi

echo "Updating system"
ansible-playbook $REALPATH/playbooks/install_env.yaml \
    --extra-vars "{\"modules_dir\": \"${REALPATH}/modules\", \"user_name\": \"$(whoami)\", \"user_home\": \"$HOME\"}"
