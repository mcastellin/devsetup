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
devsetup-params sync
. ~/.zshrc.d/*.sh
ansible-playbook $REALPATH/playbooks/update_conf_files.yaml
