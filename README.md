# Devsetup

**Quick oneliner for OrbStack VMs**:
```bash
orb create -a amd64 <distro> <name> \
&& ssh ubuntu@orb 'sudo apt-get update \
&& sudo apt-get install -y ansible git \
&& git clone https://github.com/mcastellin/devsetup.git \
&& ansible-playbook devsetup/playbooks/linux.yaml -e "user_name=$(whoami) user_home=$HOME"'
```

