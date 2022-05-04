# Devel environment setup

## Install the environment on a scratch system

- Update `/etc/sudoers` file to allow wheel users to use sudo without password
- Copy a valid GitHub ssh private key into `~/.ssh`
- Checkout this repo `git clone git@github.com:mcastellin/devel.git`
- Run the installation script for Parallels

```bash
./parallels-setup.sh
```

## Post installation 

After the initial setup we need to pull user environment variables stored in AWS
and regenerate files that contain access tokens

### Authenticate awscli and run setup script

```bash
# configure aws cli "pat-parameters" profile
aws configure --profile pat-parameters

# update configuration files
./update-conf.sh
```

## Maintain user variables in AWS

We maintain user variables in AWS using the following commands:

```bash
# to create or update a new variable into aws
devsetup-params put

# to list all available variables in AWS
devsetup-params ls

# to sync cloud-hosted variables with local ~/.zshrc.d/user_env.sh file
devsetup-params sync
```
