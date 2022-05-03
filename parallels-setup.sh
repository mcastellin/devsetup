#!/bin/bash -e

echo "Get the latest version from repo"
git pull

VAR_NAMES="VFUK_USER_EMAIL #VFUK_PAT_TOKEN ADO_USER_EMAIL #ADO_PAT_TOKEN"

if [[ ! -f .env ]] ; then
    echo ".env file not found in current path."
    echo "" > .env

    for name in $VAR_NAMES; do
        if [[ "$name" == \#* ]]; then
            name="$(echo "$name" | cut -c 2-)"
            read -sp "Insert value for variable $name: *** " value
            echo "export ${name}=\"${value}\"" >> .env
            echo
        else
            read -p "Insert value for variable $name: " value
            echo "export ${name}=\"${value}\"" >> .env
        fi

    done
    echo
fi

echo "Make sure ansible is installed"
if ! ansible --version ; then
    sudo dnf install -y ansible
fi

echo "Updating system"
. ./.env
ansible-playbook setup_env.yaml
