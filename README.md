# Devel environment setup

## Requirements
- python3
- pipenv

```bash
pip install --upgrade pip
pip install pipenv
```

## Deploy changes
```bash
pipenv install
pipenv run ansible-playbook setup_env.yaml
```


# Change Java Version
```
sudo alternatives --config java
```
